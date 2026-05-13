-- ============================================================
-- SEED DATA — 15 reviews across languages and sentiments
-- ============================================================

USE DATABASE REVIEW_INTELLIGENCE_DB;
USE SCHEMA RAW;

INSERT INTO product_reviews VALUES
-- English positive reviews
(1,  'Laptop Pro 15',  'Electronics', 'Rahul Sharma',  'en',
 'This laptop is absolutely amazing. The battery lasts 12 hours, the display is crystal clear, and it handles all my data science workloads without any lag. Best purchase I have made this year. Highly recommend to students and professionals alike.',
 5, '2026-01-10'),

(2,  'Laptop Pro 15',  'Electronics', 'Priya Nair',    'en',
 'Decent laptop but the fan gets very loud when running heavy tasks. The keyboard feels cheap compared to the price. Display is good though. Would not buy again at this price point. Customer service was unhelpful when I reported the issue.',
 2, '2026-01-15'),

(3,  'Noise Cancelling Headphones', 'Electronics', 'Arjun Mehta', 'en',
 'Outstanding noise cancellation. I use these for 8 hours a day in a noisy office and they work perfectly. The sound quality is rich and balanced. Battery life is excellent at around 30 hours. Worth every rupee.',
 5, '2026-01-20'),

(4,  'Standing Desk',  'Furniture',   'Sneha Patel',   'en',
 'The desk arrived with a scratch on the surface and one of the legs was slightly bent. Assembly instructions were confusing. I expected better quality for this price. Returning it.',
 1, '2026-02-01'),

(5,  'Office Chair',   'Furniture',   'Vikram Reddy',  'en',
 'Comfortable chair for long work sessions. Lumbar support is adequate. Armrests are a bit wobbly after two months of use. Overall satisfied but not blown away. Good value for the price.',
 3, '2026-02-05'),

-- Hindi reviews (will be translated)
(6,  'Laptop Pro 15',  'Electronics', 'Amit Verma',    'hi',
 'यह लैपटॉप बहुत अच्छा है। बैटरी बहुत लंबे समय तक चलती है और स्क्रीन बहुत साफ है। मैं इसे सभी को सुझाता हूं। कीमत थोड़ी ज्यादा है लेकिन गुणवत्ता बेहतरीन है।',
 4, '2026-02-10'),

(7,  'Office Chair',   'Furniture',   'Neha Joshi',    'hi',
 'कुर्सी बहुत आरामदायक नहीं है। मेरी पीठ में दर्द हो रहा है। पैसे बर्बाद हुए। वापस करना चाहती हूं लेकिन रिटर्न पॉलिसी बहुत खराब है।',
 1, '2026-02-12'),

-- Spanish reviews
(8,  'Webcam HD',      'Electronics', 'Carlos Rivera', 'es',
 'La cámara web tiene una calidad de imagen excelente. Las videollamadas se ven muy profesionales. La instalación fue fácil y funciona perfectamente con Zoom y Teams. Muy recomendada.',
 5, '2026-02-15'),

(9,  'Mechanical Keyboard', 'Electronics', 'Maria Lopez', 'es',
 'El teclado mecánico es ruidoso, lo cual es un problema en oficinas compartidas. Las teclas responden bien pero el ruido es molesto. El diseño es atractivo. Precio razonable.',
 3, '2026-02-18'),

-- French reviews
(10, 'Monitor 27 inch', 'Electronics', 'Pierre Dubois', 'fr',
 'Excellent moniteur. Les couleurs sont vives et précises. Idéal pour le travail créatif et le gaming. La résolution 4K est impressionnante. Je le recommande vivement.',
 5, '2026-02-20'),

-- More English reviews with specific extractable information
(11, 'Laptop Pro 15',  'Electronics', 'Divya Kumar',   'en',
 'The laptop runs hot after 2 hours of use. I contacted support on January 5th and they suggested updating the drivers. After the update, the temperature reduced but battery life dropped from 10 hours to 7 hours. The processor speed is 3.2GHz which handles my coding tasks. Still waiting for a permanent fix from the team.',
 3, '2026-03-01'),

(12, 'USB-C Hub',      'Electronics', 'Rohan Gupta',   'en',
 'This hub stopped working after exactly 3 weeks. All 4 USB ports failed simultaneously. The HDMI port never worked from day one. I paid Rs 2100 for essentially nothing. Complete waste of money. Avoid this product.',
 1, '2026-03-05'),

(13, 'Noise Cancelling Headphones', 'Electronics', 'Aisha Khan', 'en',
 'Perfect for studying. I am a BBA student and these headphones have genuinely improved my focus during exam preparation. The noise cancellation blocks out everything. Paid Rs 8500 and it is worth it. The ear cushions are very comfortable for long sessions.',
 5, '2026-03-10'),

(14, 'Standing Desk',  'Furniture',   'Suresh Iyer',   'en',
 'Good quality desk overall. The height adjustment mechanism works smoothly. I switch between sitting and standing every hour as recommended by my physiotherapist. Only complaint is delivery took 12 days instead of the promised 5. The surface is spacious enough for two monitors.',
 4, '2026-03-15'),

(15, 'Bookshelf',      'Furniture',   'Pooja Singh',   'en',
 'Solid bookshelf, easy to assemble. Holds all my books without any bending. The wood finish looks premium. Assembled in 20 minutes with the included tools. Would buy again and recommend to friends.',
 5, '2026-03-20');
