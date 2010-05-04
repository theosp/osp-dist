#!/bin/bash
sites=(
    'http://lasvegas.caesars.com/'
    'http://www.harrahs.com/destinations/atlantic-city/hotel-casinos/market-home.shtml'
    'http://www.harrahs.com/destinations/reno--tahoe/hotel-casinos/market-home.shtml'
    'http://www.harrahs.com/destinations/new-orleans-biloxi/hotel-casinos/market-home.shtml'
    'http://www.harrahs.com/destinations/tunica/hotel-casinos/market-home.shtml'
)

anchor_texts_to_extract=(
    "Events/Entertainment"
    "Gaming"
    "Dining"
    "Things To Do"
    "Stay & Play Packages"
    "Stay &amp; Play Packages"
    "Hot Deals"
    "Groups & Meetings"
    "Groups &amp; Meetings"
    "Weddings"
)

grep_command_for_anchors_extraction=""
for anchor_text_to_extract in "${anchor_texts_to_extract[@]}"
do
    grep_command_for_anchors_extraction+="$anchor_text_to_extract<\|"
done
grep_command_for_anchors_extraction=${grep_command_for_anchors_extraction:0:$(( ${#grep_command_for_anchors_extraction} - 2 ))}

for site in ${sites[@]}
do
    echo '******************************************************'
    echo $site
    echo '******************************************************'
    curl $site 2>/dev/null | grep 'id' | grep "$grep_command_for_anchors_extraction" | sed -r -e 's|.*href="(.*)".*> ([^<]*)<.*|\2,\1|g'
done
