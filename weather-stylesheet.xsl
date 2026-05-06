<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <title>UBakwit - XML Data View</title>
                <style>
                    body { font-family: 'Rajdhani', sans-serif; margin: 20px; background: #ffffff; color: #1e1e1e; }
                    .container { max-width: 1200px; margin: 0 auto; background: #ffffff; padding: 30px; border-radius: 8px; border: 1px solid rgba(74, 0, 0, 0.1); box-shadow: 0 4px 20px rgba(0,0,0,0.05); }
                    h1 { color: #4a0000; border-bottom: 3px solid #d4af37; padding-bottom: 15px; font-family: 'Orbitron', monospace; text-transform: uppercase; letter-spacing: 2px; }
                    .section { margin: 30px 0; padding: 20px; border: 1px solid rgba(74, 0, 0, 0.05); border-radius: 6px; background: #f8f9fa; }
                    .section h2 { color: #4a0000; margin-bottom: 15px; display: flex; align-items: center; gap: 10px; font-family: 'Orbitron', monospace; font-size: 0.9rem; letter-spacing: 2px; }
                    table { width: 100%; border-collapse: collapse; margin: 10px 0; font-family: 'Share Tech Mono', monospace; font-size: 0.85rem; }
                    th, td { padding: 12px; text-align: left; border-bottom: 1px solid rgba(74,0,0,0.05); }
                    th { background: rgba(74, 0, 0, 0.03); font-weight: 600; color: #4a0000; letter-spacing: 1px; }
                    .status-active { color: #2d6a4f; font-weight: bold; }
                    .status-caution { color: #d4af37; font-weight: bold; }
                    .metric-tag { display: inline-block; padding: 4px 10px; background: #4a0000; color: white; border-radius: 4px; font-size: 0.7rem; margin-right: 10px; }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>UBakwit XML Strategic Data Feed</h1>
                    
                    <div class="section">
                        <h2>📊 Metadata</h2>
                        <table>
                            <tr><td><strong>System ID</strong></td><td><xsl:value-of select="weather-system/metadata/system-name"/></td></tr>
                            <tr><td><strong>Operational Area</strong></td><td><xsl:value-of select="weather-system/metadata/location"/></td></tr>
                            <tr><td><strong>Sync Status</strong></td><td><span class="status-active"><xsl:value-of select="weather-system/metadata/status"/></span></td></tr>
                            <tr><td><strong>Last Signal</strong></td><td><xsl:value-of select="weather-system/metadata/last-updated"/></td></tr>
                        </table>
                    </div>

                    <div class="section">
                        <h2>🌡️ Sensor Output</h2>
                        <xsl:for-each select="weather-system/climate-data/sensor">
                            <h3>Module <xsl:value-of select="@id"/> - <xsl:value-of select="@location"/></h3>
                            <table>
                                <tr><th>Environmental Parameter</th><th>Detected Value</th><th>Metric</th></tr>
                                <tr><td>Precipitation</td><td><xsl:value-of select="rainfall"/></td><td><xsl:value-of select="rainfall/@unit"/></td></tr>
                                <tr><td>Ambient Temperature</td><td><xsl:value-of select="temperature"/></td><td><xsl:value-of select="temperature/@unit"/></td></tr>
                                <tr><td>Atmospheric Moisture</td><td><xsl:value-of select="humidity"/></td><td><xsl:value-of select="humidity/@unit"/></td></tr>
                                <tr><td>Kinetic Wind Velocity</td><td><xsl:value-of select="wind-speed"/></td><td><xsl:value-of select="wind-speed/@unit"/></td></tr>
                            </table>
                        </xsl:for-each>
                    </div>

                    <div class="section">
                        <h2>🗺️ Tactical Routes</h2>
                        <xsl:for-each select="weather-system/evacuation-routes/route">
                            <div style="margin-bottom: 20px; padding: 15px; background: rgba(0,212,255,0.05); border-radius: 4px; border-left: 4px solid #00d4ff;">
                                <h3><xsl:value-of select="name"/> - [<xsl:value-of select="@status"/>]</h3>
                                <p><strong>Vector Distance:</strong> <xsl:value-of select="distance"/> <xsl:value-of select="distance/@unit"/></p>
                                <p><strong>Estimated Transit:</strong> <xsl:value-of select="estimated-time"/> <xsl:value-of select="estimated-time/@unit"/></p>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
