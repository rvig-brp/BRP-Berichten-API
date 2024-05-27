document.getElementById("pldc1").value = plData; // haal de JSON op naar eerste textbox

const checkbox = document.getElementById('mooiLelijk')

function updatePL() {
  displayPL(checkbox.checked)
}

function displayPL(isMooi) {
  const gewijzigdePL = JSON.parse(pldc1.value);
  gewijzigdePL.c01[0].e0213 = "later toegevoegd element!";
  if (isMooi)  {
    const jsonGewijzigd = JSON.stringify(gewijzigdePL, null, 1);
    document.getElementById("pldc2").value = jsonGewijzigd;
  } else
  {
  const jsonGewijzigd = JSON.stringify(gewijzigdePL, null, 0);
  document.getElementById("pldc2").value = jsonGewijzigd;
} 
  kinderen.textContent = gewijzigdePL.c09.length;
  naamKind2.textContent = gewijzigdePL.c09[1].e0210;
  stapels12.textContent = gewijzigdePL.c12.length;
  voornamen.textContent = gewijzigdePL.c01[0].e0210;

  aanschrijfnaam.textContent = getAanschrijfnaam(
    gewijzigdePL.c01[0].e0210,
    gewijzigdePL.c01[0].e0240,
    gewijzigdePL.c01[0].e0410
  );

  catsInPL.textContent = getCategorieen(gewijzigdePL);
}

function getAanschrijfnaam(voornamen, achternaam, geslacht) {
  const matches = voornamen.match(/\b(\w)/g);
  const voorletters = matches.join(".");

  let aanhef = "";
  
  if (geslacht == "M" || geslacht == "m") {
    aanhef = "dhr";
  } else if (geslacht == "V" || geslacht == "v") {
    aanhef = "mevr";
  }

  let aanSchrijfnaam = `${aanhef} ${voorletters}. ${achternaam}`;
  return aanSchrijfnaam;
}

function getCategorieen(berichtObject) {
  const aanwezigeCats = Object.keys(berichtObject);
  return aanwezigeCats;
}

document.getElementById("toonWijzigingen").onclick = function() {updatePL()};
updatePL(); // update om eerste invulling te krijgen van de tweede textbox en de gegevens rechts :)


checkbox.addEventListener('change', (event) => {
  if (event.currentTarget.checked) {
    displayPL(true);
  } else {
    displayPL(false);
  }
})