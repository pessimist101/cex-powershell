function cexSearch {
    param($searchTerm)
    $url = 'https://wss2.cex.uk.webuy.io/v3/boxes?q={0}&firstRecord=1&count=50&sortOrder=desc' -f $searchTerm
    $cex = Invoke-WebRequest -uri $url
    $boxes = $cex.content | ConvertFrom-Json | select -expand response | select -expand data | select -expand boxes |
    select boxId, boxName, categoryFriendlyName, sellPrice, cashPrice, exchangePrice, outOfStock, outOfEcomStock, ecomQuantityOnHand
    return $boxes;
}

$searchTerm = Read-Host -Prompt 'Search'
$boxes = cexSearch -searchTerm $searchTerm
$boxes[0..4]
