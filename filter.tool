<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Denmara Image Filter Wizard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <script src="https://cdn.lordicon.com/bhenfmcm.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/typed.js@2.0.12"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #0f172a;
            color: #e2e8f0;
        }
        .gradient-bg {
            background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
        }
        .hover-scale {
            transition: transform 0.3s ease-in-out;
        }
        .hover-scale:hover {
            transform: scale(1.05);
        }
        .loader {
            border-top-color: #a855f7;
            -webkit-animation: spinner 1.5s linear infinite;
            animation: spinner 1.5s linear infinite;
        }
        @-webkit-keyframes spinner {
            0% { -webkit-transform: rotate(0deg); }
            100% { -webkit-transform: rotate(360deg); }
        }
        @keyframes spinner {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .blob {
            border-radius: 30% 70% 70% 30% / 30% 30% 70% 70%;
            background: linear-gradient(45deg, #6366f1 0%, #a855f7 100%);
            filter: blur(40px);
        }
        .image-preview-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .overlay {
            background-color: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
        }
        .scrollbar-hide::-webkit-scrollbar {
            display: none;
        }
        .scrollbar-hide {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
        .drag-drop-area {
            border: 2px dashed #a855f7;
            transition: all 0.3s ease;
        }
        .drag-drop-area.dragover {
            background-color: rgba(168, 85, 247, 0.1);
            border-color: #6366f1;
        }
        .filter-preview {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .filter-preview:hover {
            transform: scale(1.1);
        }
        .filter-option {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }
        .filter-option:hover {
            background: rgba(255, 255, 255, 0.2);
        }
        .header {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }
        .footer {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(10px);
        }
        .footer a {
            transition: color 0.3s ease;
        }
        .footer a:hover {
            color: #a855f7;
        }
    </style>
</head>
<body class="min-h-screen p-4 relative overflow-x-hidden scrollbar-hide flex flex-col">
    <header class="header fixed top-0 left-0 right-0 z-50 py-4 px-6">
        <div class="max-w-6xl mx-auto flex justify-between items-center">
            <a href="/" class="flex items-center">
                <img src="Denmara__1_-removebg-preview.png" alt="Denmara Logo" style="width:70px; height:70px;">
                <span class="ml-2 text-2xl font-bold text-white">Denmara</span>
            </a>
            <a href="/login.html" class="text-white hover:text-purple-400 transition duration-300">Login</a>
        </div>
    </header>

    <main class="flex-grow mt-20">
        <div class="blob fixed top-0 left-0 w-64 h-64 opacity-50 -translate-x-1/2 -translate-y-1/2"></div>
        <div class="blob fixed bottom-0 right-0 w-96 h-96 opacity-50 translate-x-1/2 translate-y-1/2"></div>
        
        <div class="bg-gray-800 rounded-3xl shadow-2xl w-full max-w-4xl mx-auto my-8 animate__animated animate__fadeIn relative z-10">
            <div class="gradient-bg p-8 rounded-t-3xl">
                <h1 class="text-4xl font-bold text-white text-center">Image Filter Wizard</h1>
                <p class="text-gray-200 text-center mt-2">Add stunning filters to your images</p>
            </div>
            
            <div class="p-8">
                <div id="dragDropArea" class="mb-8 flex flex-col items-center justify-center h-40 drag-drop-area rounded-lg cursor-pointer">
                    <input type="file" id="fileInput" accept="image/*" class="hidden">
                    <lord-icon
                        src="https://cdn.lordicon.com/nxooksci.json"
                        trigger="hover"
                        colors="primary:#a855f7,secondary:#6366f1"
                        style="width:64px;height:64px;">
                    </lord-icon>
                    <p class="mt-2 text-sm text-gray-400 text-center">Choose files or<br>Drag and Drop here!</p>
                </div>

                <div id="imagePreview" class="mb-8 hidden animate__animated animate__fadeIn">
                    <div class="image-preview-container p-2 rounded-2xl cursor-pointer relative" id="previewContainer">
                        <img id="preview" src="" alt="Preview" class="w-full h-64 object-cover rounded-xl">
                        <button id="deleteImage" class="absolute top-4 right-4 bg-red-500 text-white rounded-full p-2 hover:bg-red-600 focus:outline-none">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
                            </svg>
                        </button>
                    </div>
                </div>

                <div id="filterOptions" class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4 mb-8 hidden">
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="none">
                        <img src="/api/placeholder/100/100" alt="No Filter" class="filter-preview mb-2">
                        <span>No Filter</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="grayscale">
                        <img src="/api/placeholder/100/100" alt="Grayscale" class="filter-preview mb-2 grayscale">
                        <span>Grayscale</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="sepia">
                        <img src="/api/placeholder/100/100" alt="Sepia" class="filter-preview mb-2 sepia">
                        <span>Sepia</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="invert">
                        <img src="/api/placeholder/100/100" alt="Invert" class="filter-preview mb-2 invert">
                        <span>Invert</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="blur">
                        <img src="/api/placeholder/100/100" alt="Blur" class="filter-preview mb-2 blur-sm">
                        <span>Blur</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="brightness">
                        <img src="/api/placeholder/100/100" alt="Brightness" class="filter-preview mb-2 brightness-150">
                        <span>Brightness</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="contrast">
                        <img src="/api/placeholder/100/100" alt="Contrast" class="filter-preview mb-2 contrast-150">
                        <span>Contrast</span>
                    </div>
                    <div class="filter-option p-4 rounded-lg text-center cursor-pointer" data-filter="saturate">
                        <img src="/api/placeholder/100/100" alt="Saturate" class="filter-preview mb-2 saturate-150">
                        <span>Saturate</span>
                    </div>
                </div>

                <button id="downloadBtn" class="w-full bg-gradient-to-r from-purple-500 to-indigo-500 text-white py-3 rounded-lg hover:from-purple-600 hover:to-indigo-600 transition duration-300 transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-purple-600 focus:ring-opacity-50 flex items-center justify-center">
                    <lord-icon
                        src="https://cdn.lordicon.com/xsdtfyne.json"
                        trigger="hover"
                        colors="primary:#ffffff"
                        style="width:32px;height:32px;">
                    </lord-icon>
                    <span class="ml-2">Download Filtered Image</span>
                </button>
            </div>
        </div>

        <!-- Add the benefits section here -->

        <!-- Add the FAQ section here -->

        <!-- Add the "More Tools" section here -->

    </main>

    <footer class="footer mt-16 py-6 px-6">
        <div class="max-w-6xl mx-auto flex flex-col items-center">
            <div class="mb-4">
                <a href="/terms" class="text-gray-300 hover:text-white mx-2">Terms and Conditions</a>
                <a href="/privacy" class="text-gray-300 hover:text-white mx-2">Privacy Policy</a>
            </div>
            <div class="text-gray-400 text-sm">
                &copy;2024 denmara.com
            </div>
        </div>
    </footer>

    <div id="overlay" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50 overlay">
        <div class="relative">
            <img id="fullSizeImage" src="" alt="Full size preview" class="max-w-full max-h-[80vh] rounded-lg">
            <button id="closeOverlay" class="absolute top-2 right-2 text-white bg-red-500 rounded-full w-8 h-8 flex items-center justify-center hover:bg-red-600 focus:outline-none">
                &times;
            </button>
        </div>
    </div>

    <div id="loader" class="fixed top-0 left-0 right-0 bottom-0 w-full h-screen z-50 overflow-hidden bg-gray-900 opacity-75 flex flex-col items-center justify-center hidden">
        <div class="loader ease-linear rounded-full border-4 border-t-4 border-gray-200 h-12 w-12 mb-4"></div>
        <h2 class="text-center text-white text-xl font-semibold">Processing...</h2>
        <p class="w-1/3 text-center text-white">This may take a few seconds, please don't close this page.</p>
    </div>

    <script>
        const fileInput = document.getElementById('fileInput');
        const dragDropArea = document.getElementById('dragDropArea');
        const imagePreview = document.getElementById('imagePreview');
        const preview = document.getElementById('preview');
        const filterOptions = document.getElementById('filterOptions');
        const downloadBtn = document.getElementById('downloadBtn');
        const loader = document.getElementById('loader');
        const overlay = document.getElementById('overlay');
        const fullSizeImage = document.getElementById('fullSizeImage');
        const previewContainer = document.getElementById('previewContainer');
        const closeOverlay = document.getElementById('closeOverlay');
        const deleteImage = document.getElementById('deleteImage');

        let uploadedImage = null;
        let selectedFilter = 'none';

        // File input change event
        fileInput.addEventListener('change', handleFileSelect);

       // Drag and drop events
        dragDropArea.addEventListener('click', () => fileInput.click());
        dragDropArea.addEventListener('dragover', (e) => {
            e.preventDefault();
            dragDropArea.classList.add('dragover');
        });
        dragDropArea.addEventListener('dragleave', () => {
            dragDropArea.classList.remove('dragover');
        });
        dragDropArea.addEventListener('drop', (e) => {
            e.preventDefault();
            dragDropArea.classList.remove('dragover');
            handleFileSelect({ target: { files: e.dataTransfer.files } });
        });

        // Preview and overlay events
        previewContainer.addEventListener('click', showOverlay);
        closeOverlay.addEventListener('click', hideOverlay);
        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) hideOverlay();
        });

        // Delete image event
        deleteImage.addEventListener('click', (e) => {
            e.stopPropagation();
            uploadedImage = null;
            imagePreview.classList.add('hidden');
            filterOptions.classList.add('hidden');
            dragDropArea.classList.remove('hidden');
            fileInput.value = '';
            preview.style.filter = 'none';
            selectedFilter = 'none';
        });

        function handleFileSelect(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (e) => {
                    preview.src = e.target.result;
                    fullSizeImage.src = e.target.result;
                    imagePreview.classList.remove('hidden');
                    filterOptions.classList.remove('hidden');
                    dragDropArea.classList.add('hidden');
                    uploadedImage = file;
                    imagePreview.scrollIntoView({ behavior: 'smooth', block: 'start' });
                    updateFilterPreviews(e.target.result);
                };
                reader.readAsDataURL(file);
            }
        }

        function showOverlay() {
            overlay.classList.remove('hidden');
            overlay.classList.add('flex');
        }

        function hideOverlay() {
            overlay.classList.add('hidden');
            overlay.classList.remove('flex');
        }

        function updateFilterPreviews(imageSrc) {
            const filterPreviews = document.querySelectorAll('.filter-preview');
            filterPreviews.forEach(preview => {
                preview.src = imageSrc;
            });
        }

        // Filter selection
        filterOptions.addEventListener('click', (e) => {
            const filterOption = e.target.closest('.filter-option');
            if (filterOption) {
                selectedFilter = filterOption.dataset.filter;
                applyFilter();
                highlightSelectedFilter();
            }
        });

        function applyFilter() {
            switch (selectedFilter) {
                case 'grayscale':
                    preview.style.filter = 'grayscale(100%)';
                    break;
                case 'sepia':
                    preview.style.filter = 'sepia(100%)';
                    break;
                case 'invert':
                    preview.style.filter = 'invert(100%)';
                    break;
                case 'blur':
                    preview.style.filter = 'blur(5px)';
                    break;
                case 'brightness':
                    preview.style.filter = 'brightness(150%)';
                    break;
                case 'contrast':
                    preview.style.filter = 'contrast(150%)';
                    break;
                case 'saturate':
                    preview.style.filter = 'saturate(150%)';
                    break;
                default:
                    preview.style.filter = 'none';
            }
        }

        function highlightSelectedFilter() {
            const filterOptions = document.querySelectorAll('.filter-option');
            filterOptions.forEach(option => {
                if (option.dataset.filter === selectedFilter) {
                    option.classList.add('ring-2', 'ring-purple-500');
                } else {
                    option.classList.remove('ring-2', 'ring-purple-500');
                }
            });
        }

        downloadBtn.addEventListener('click', () => {
            if (!uploadedImage) {
                swal("Oops!", "Please upload an image first!", "warning");
                return;
            }

            showLoader();

            setTimeout(() => {
                const canvas = document.createElement('canvas');
                const ctx = canvas.getContext('2d');
                const img = new Image();
                img.onload = () => {
                    canvas.width = img.width;
                    canvas.height = img.height;
                    ctx.filter = preview.style.filter;
                    ctx.drawImage(img, 0, 0, img.width, img.height);
                    
                    canvas.toBlob((blob) => {
                        const url = URL.createObjectURL(blob);
                        const a = document.createElement('a');
                        a.href = url;
                        a.download = `filtered_image.png`;
                        a.click();
                        URL.revokeObjectURL(url);
                        hideLoader();
                        swal("Success!", "Your filtered image has been downloaded.", "success");
                    }, 'image/png', 1.0);
                };
                img.src = preview.src;
            }, 1000);
        });

        function showLoader() {
            loader.classList.remove('hidden');
        }

        function hideLoader() {
            loader.classList.add('hidden');
        }

        // Initialize AOS
        AOS.init({
            duration: 1000,
            once: true,
            offset: 100
        });

        // Add header behavior
        window.addEventListener('scroll', () => {
            const header = document.querySelector('.header');
            if (window.scrollY > 50) {
                header.classList.add('shadow-md');
            } else {
                header.classList.remove('shadow-md');
            }
        });
    </script>
</body>
</html>