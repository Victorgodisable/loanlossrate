# PDF Presentation Generation Guide

This guide will help you generate a professional PDF presentation from the LLR Pricing Estimation System project documentation.

## Quick Start (Windows)

1. **Double-click** `generate_pdf.bat`
2. Wait for the process to complete
3. Find your PDF at `LLR_Pricing_Estimation_System_Presentation.pdf`

## Manual Installation

### Prerequisites

1. **Python 3.8+** installed on your system
2. **wkhtmltopdf** binary installed

### Step 1: Install Python Dependencies

```bash
pip install -r requirements_pdf.txt
```

### Step 2: Install wkhtmltopdf

#### Windows
1. Download from: https://wkhtmltopdf.org/downloads.html
2. Install the executable
3. Add to your system PATH

#### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install wkhtmltopdf
```

#### macOS
```bash
brew install wkhtmltopdf
```

### Step 3: Generate PDF

```bash
python generate_pdf_presentation.py
```

## Files Generated

- `LLR_Pricing_Estimation_System_Presentation.html` - Intermediate HTML file (auto-deleted)
- `LLR_Pricing_Estimation_System_Presentation.pdf` - Final PDF presentation

## Troubleshooting

### Common Issues

#### 1. "wkhtmltopdf not found" Error
**Solution**: Install wkhtmltopdf and ensure it's in your system PATH

#### 2. "Permission denied" Error
**Solution**: Run as administrator or check file permissions

#### 3. "Module not found" Error
**Solution**: Install requirements with `pip install -r requirements_pdf.txt`

#### 4. PDF Generation Fails
**Solution**: 
- Check if wkhtmltopdf is properly installed
- Verify HTML file is generated correctly
- Check system memory (large PDFs require more RAM)

### Alternative Methods

#### Method 1: Use Online Converter
1. Open `LLR_Pricing_Estimation_System_Presentation.html` in browser
2. Print to PDF using browser's print function
3. Save as PDF

#### Method 2: Use Pandoc
```bash
pandoc LLR_Pricing_Estimation_System_Presentation.md -o presentation.pdf --pdf-engine=wkhtmltopdf
```

#### Method 3: Use Browser Print
1. Open the HTML file in Chrome/Firefox
2. Press Ctrl+P (Print)
3. Select "Save as PDF"
4. Choose "More settings" → "Background graphics"

## Customization

### Modifying the Presentation

1. Edit `LLR_Pricing_Estimation_System_Presentation.md`
2. Run the generation script again
3. New PDF will be created with your changes

### Styling Options

Edit the CSS in `generate_pdf_presentation.py` to customize:
- Colors and fonts
- Page layout and margins
- Header and footer design
- Table and chart styling

### Adding Images

1. Place images in the project directory
2. Reference them in the markdown: `![Alt text](image.png)`
3. Ensure proper file paths for PDF generation

## File Structure

```
Project/
├── LLR_Pricing_Estimation_System_Presentation.md    # Source markdown
├── generate_pdf_presentation.py                     # PDF generator script
├── requirements_pdf.txt                             # Python dependencies
├── generate_pdf.bat                                 # Windows batch script
├── PDF_GENERATION_README.md                         # This guide
└── LLR_Pricing_Estimation_System_Presentation.pdf   # Generated PDF
```

## Support

If you encounter issues:

1. Check the troubleshooting section above
2. Verify all prerequisites are installed
3. Check the console output for specific error messages
4. Ensure sufficient disk space and memory

## Features of the Generated PDF

- **Professional Layout**: Clean, corporate-style design
- **Table of Contents**: Automatic navigation
- **Syntax Highlighting**: Code blocks with proper formatting
- **Responsive Tables**: Well-formatted data tables
- **Color Coding**: Visual hierarchy and emphasis
- **Page Breaks**: Proper section separation
- **Print Optimized**: A4 size with proper margins

---

*This guide ensures you can successfully generate a professional PDF presentation for your LLR Pricing Estimation System project.*

