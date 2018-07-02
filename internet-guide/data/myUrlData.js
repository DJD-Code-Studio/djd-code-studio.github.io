// the code block below will reprent the function call
// for the function myUrlData to be called from the main page
// myUrlData([{.....}, {.....}, {.....}, {.....}]);
// //

//   {
//     "id": "some alphanumeric string",
//     "url": "the actual url will go here",
//     "title": "RedHat Corporate Account",
//     "topic": "tbd",
//     "tagGroup1": "P PYTHON", //this is where the main keywords will go. ALPHABET should be SINGLELETTER. First letter of SUBJECT should be in sync with ALPHABET.
//     "tagGroup2": "OFFICE LEARNING CODING", //this is where the main keywords will go. ALPHABET should be SINGLELETTER. First letter of SUBJECT should be in sync with ALPHABET.
//     "favorites": "see GUIDE below",
//     "usage": "see GUIDE below",
//     "pagerank": "see GUIDE below",
//     "siterank": "see GUIDE below",
//     "label": "any descriptive text will go here (optional)",
//     "imgLocation": "./snapshots/",
//     "imgAlt": "alternate text if image cannot be loaded",
//     "domaiName": "short form of the domain name",
//     "fqdn": "the correct FQDN of the domain",
//     "login": "see GUIDE below",
//   }
// GUIDE
//=======
// favorites
// This key can have values set to Y or N and will be used to auto-populate pre-built searches.
// usage
// This key's values set to daily/weekly/monthly/yearly/occasionally/frequently/never and will be used to auto-populate pre-built searches.
// pagerank
// This key can have values set to a numerical value and will be used to sort search results for all types of page searches. For doamins the value will be set to 0.
// siterank
// This key can have values set to a numerical value and will be used to sort search results for all types of domain or site searches. For pages the value will be set to 0.
// login
// This key lets us know whether the sites needs user credentials to allow entry - it can have 3 values - y, n, opt
// //


myUrlData([

  {
    "id": "7R4R4F1212hwdhdh",
    "url": "https://access.redhat.com/management/",
    "title": "RedHat Corporate Account",
    "topic": "tbd",
    "tagGroup1": "D DXC", //this is where the main keywords will go. ALPHABET should be SINGLELETTER. First letter of SUBJECT should be in sync with ALPHABET.
    "tagGroup2": "OFFICE LEARNING REDHAT", //this is where the main keywords will go. ALPHABET should be SINGLELETTER. First letter of SUBJECT should be in sync with ALPHABET.
    "favorites": "y",
    "usage": "frequently",
    "pagerank": "1",
    "siterank": "0",
    "label": "This is the RedHat Account (Corporate))",
    "imgLocation": "./snapshots/",
    "imgAlt": "RedHat Account",
    "domaiName": "access.redhat.com",
    "fqdn": "access.redhat.com",
    "login": "opt",
  }
]);



  


//https://training-lms.redhat.com/lmt/lmtLogin.prEnc?site=rhls

  // {
  //   "tagGroup1": "D DXC", //this is where the main keywords will go. ALPHABET should be SINGLELETTER. First letter of SUBJECT should be in sync with ALPHABET.
  //   "tagGroup2": "OFFICE LEARNING REDHAT", //this is where the main keywords will go. ALPHABET should be SINGLELETTER. First letter of SUBJECT should be in sync with ALPHABET.
  //   "id": "jefi347R4R4F1212hwdhdh",
  //   "url": "https://training-lms.redhat.com/lmt/lmtLogin.prEnc?site=rhls",
  //   "title": "RedHat LMS",
  //   "classForEachDiv": "ForEachDiv",
  //   "classTextDiv": "TextDiv",
  //   "classRankingValues": "1",
  //   "favorites": "y",
  //   "usage": "frequently",
  //   "pagerank": "1",
  //   "siterank": "0",
  //   "label": "This is the RedHat Learning Management System",
  //   "classImageDiv": "ImageDiv",
  //   "imgLocation": "./snapshots/",
  //   "imgAlt": "RedHat lMS",
  //   "abbr": "training-lms.redhat.com",
  //   "classAbbrDomainname": "redhat.com",
  //   "abbrTitle": "www.satraining-lms.redhat.com"
  // },