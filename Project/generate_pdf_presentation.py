#!/usr/bin/env python3
"""
PDF Presentation Generator for LLR Pricing Estimation System
Converts Markdown presentation to professional PDF format
"""

import markdown
import pdfkit
from pathlib import Path
import os
import sys

def create_html_from_markdown(md_file_path, output_html_path):
    """Convert Markdown to HTML with professional styling"""
    
    # Read the markdown file
    with open(md_file_path, 'r', encoding='utf-8') as f:
        md_content = f.read()
    
    # Convert markdown to HTML
    html_content = markdown.markdown(md_content, extensions=['tables', 'toc', 'codehilite'])
    
    # Create professional HTML template
    html_template = f"""
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>LLR Pricing Estimation System - Presentation</title>
        <style>
            @page {{
                size: A4;
                margin: 2cm;
            }}
            
            body {{
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                line-height: 1.6;
                color: #333;
                max-width: 100%;
                margin: 0;
                padding: 0;
            }}
            
            .header {{
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 30px;
                text-align: center;
                margin-bottom: 30px;
                border-radius: 10px;
            }}
            
            .header h1 {{
                margin: 0;
                font-size: 2.5em;
                font-weight: 300;
            }}
            
            .header p {{
                margin: 10px 0 0 0;
                font-size: 1.2em;
                opacity: 0.9;
            }}
            
            h1 {{
                color: #2c3e50;
                border-bottom: 3px solid #3498db;
                padding-bottom: 10px;
                margin-top: 40px;
                margin-bottom: 20px;
                font-size: 2em;
            }}
            
            h2 {{
                color: #34495e;
                border-left: 4px solid #3498db;
                padding-left: 15px;
                margin-top: 30px;
                margin-bottom: 15px;
                font-size: 1.5em;
            }}
            
            h3 {{
                color: #2c3e50;
                margin-top: 25px;
                margin-bottom: 10px;
                font-size: 1.3em;
            }}
            
            h4 {{
                color: #34495e;
                margin-top: 20px;
                margin-bottom: 8px;
                font-size: 1.1em;
            }}
            
            p {{
                margin-bottom: 15px;
                text-align: justify;
            }}
            
            ul, ol {{
                margin-bottom: 15px;
                padding-left: 25px;
            }}
            
            li {{
                margin-bottom: 5px;
            }}
            
            table {{
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }}
            
            th, td {{
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }}
            
            th {{
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                font-weight: 600;
            }}
            
            tr:nth-child(even) {{
                background-color: #f8f9fa;
            }}
            
            tr:hover {{
                background-color: #e8f4f8;
            }}
            
            .code-block {{
                background-color: #f4f4f4;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 15px;
                margin: 15px 0;
                font-family: 'Courier New', monospace;
                overflow-x: auto;
            }}
            
            .highlight {{
                background-color: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 5px;
                padding: 15px;
                margin: 15px 0;
            }}
            
            .success {{
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
                border-radius: 5px;
                padding: 15px;
                margin: 15px 0;
            }}
            
            .warning {{
                background-color: #fff3cd;
                border: 1px solid #ffeaa7;
                border-radius: 5px;
                padding: 15px;
                margin: 15px 0;
            }}
            
            .info {{
                background-color: #d1ecf1;
                border: 1px solid #bee5eb;
                border-radius: 5px;
                padding: 15px;
                margin: 15px 0;
            }}
            
            .page-break {{
                page-break-before: always;
            }}
            
            .toc {{
                background-color: #f8f9fa;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                padding: 20px;
                margin: 20px 0;
            }}
            
            .toc h2 {{
                margin-top: 0;
                color: #495057;
            }}
            
            .toc ul {{
                list-style-type: none;
                padding-left: 0;
            }}
            
            .toc li {{
                margin: 8px 0;
            }}
            
            .toc a {{
                text-decoration: none;
                color: #007bff;
            }}
            
            .toc a:hover {{
                text-decoration: underline;
            }}
            
            .footer {{
                margin-top: 50px;
                padding: 20px;
                background-color: #f8f9fa;
                border-top: 3px solid #3498db;
                text-align: center;
                font-size: 0.9em;
                color: #6c757d;
            }}
            
            .architecture-diagram {{
                text-align: center;
                margin: 30px 0;
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 10px;
            }}
            
            .feature-grid {{
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                margin: 20px 0;
            }}
            
            .feature-card {{
                background: white;
                border: 1px solid #ddd;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }}
            
            .feature-card h4 {{
                color: #3498db;
                margin-top: 0;
            }}
            
            .metrics {{
                display: flex;
                justify-content: space-around;
                margin: 20px 0;
                flex-wrap: wrap;
            }}
            
            .metric {{
                text-align: center;
                padding: 15px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-radius: 10px;
                margin: 5px;
                min-width: 150px;
            }}
            
            .metric h3 {{
                margin: 0;
                font-size: 2em;
            }}
            
            .metric p {{
                margin: 5px 0 0 0;
                font-size: 0.9em;
                opacity: 0.9;
            }}
        </style>
    </head>
    <body>
        <div class="header">
            <h1>LLR Pricing Estimation System</h1>
            <p>A Machine Learning-Powered Financial Decision Support Tool</p>
        </div>
        
        {html_content}
        
        <div class="footer">
            <p>Generated for LLR Pricing Estimation System Project | {Path(md_file_path).parent.name}</p>
        </div>
    </body>
    </html>
    """
    
    # Write HTML file
    with open(output_html_path, 'w', encoding='utf-8') as f:
        f.write(html_template)
    
    print(f"✅ HTML file created: {output_html_path}")

def convert_html_to_pdf(html_file_path, output_pdf_path):
    """Convert HTML to PDF using wkhtmltopdf"""
    
    try:
        # Configure PDF options
        options = {
            'page-size': 'A4',
            'margin-top': '0.75in',
            'margin-right': '0.75in',
            'margin-bottom': '0.75in',
            'margin-left': '0.75in',
            'encoding': "UTF-8",
            'no-outline': None,
            'enable-local-file-access': None,
            'print-media-type': None,
            'disable-smart-shrinking': None,
            'zoom': '1.2'
        }
        
        # Convert HTML to PDF
        pdfkit.from_file(html_file_path, output_pdf_path, options=options)
        print(f"✅ PDF file created: {output_pdf_path}")
        
    except Exception as e:
        print(f"❌ Error creating PDF: {e}")
        print("Please ensure wkhtmltopdf is installed and in your PATH")
        print("Download from: https://wkhtmltopdf.org/downloads.html")
        return False
    
    return True

def main():
    """Main function to generate PDF presentation"""
    
    # File paths
    current_dir = Path(__file__).parent
    md_file = current_dir / "LLR_Pricing_Estimation_System_Presentation.md"
    html_file = current_dir / "LLR_Pricing_Estimation_System_Presentation.html"
    pdf_file = current_dir / "LLR_Pricing_Estimation_System_Presentation.pdf"
    
    print("🚀 Starting PDF Presentation Generation...")
    print(f"📁 Working directory: {current_dir}")
    
    # Check if markdown file exists
    if not md_file.exists():
        print(f"❌ Markdown file not found: {md_file}")
        return
    
    try:
        # Step 1: Convert Markdown to HTML
        print("\n📝 Converting Markdown to HTML...")
        create_html_from_markdown(md_file, html_file)
        
        # Step 2: Convert HTML to PDF
        print("\n📄 Converting HTML to PDF...")
        success = convert_html_to_pdf(html_file, pdf_file)
        
        if success:
            print(f"\n🎉 Success! PDF presentation created: {pdf_file}")
            print(f"📊 File size: {pdf_file.stat().st_size / 1024 / 1024:.2f} MB")
            
            # Clean up HTML file (optional)
            if html_file.exists():
                html_file.unlink()
                print("🧹 Cleaned up temporary HTML file")
        else:
            print("\n❌ PDF generation failed. Please check the error messages above.")
            
    except Exception as e:
        print(f"\n❌ An error occurred: {e}")
        import traceback
        traceback.print_exc()

if __name__ == "__main__":
    main()

