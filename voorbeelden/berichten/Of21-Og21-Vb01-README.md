# Notitie 26-03-2026

De routeringsvoorziening maakt gebruik van Of21 en Og21 berichten. Deze berichten worden enkel ondersteund binnen de BRP-Berichten-API aangezien ze afwijken van de klassieke rubriekstructuur. Ze hebben om die reden dan ook geen GBA/NIC-variant. Een voorbeeld van de JSON variant is toegevoegd als `Og21.json`.

Og21 heeft wel een Vb01 variant, deze is als voorbeeld `Vb01-Og21.GBA`.

# Huidige situatie

Momenteel zijn nog niet alle gemeenten aangesloten op de BRP-Berichten-API
waardoor zij nog geen Og21-berichten kunnen ontvangen in JSON-formaat.
Daarom worden voorlopig alleen Vb01-berichten verstuurd in plaats van Og21-berichten.

Of21 berichten gaan direct naar de RvdR, deze kunnen de Of21.json gewoon lezen.
Er is daarom geen vrije bericht nodig voor de Of21-bericht.

# Toekomstige situatie

In de toekomst zullen alle gemeenten aangesloten zijn op de BRP-Berichten-API waardoor zij ook Og21-berichten kunnen ontvangen in JSON-formaat. De Vb01 variant van de Og21 is dan niet meer nodig.

