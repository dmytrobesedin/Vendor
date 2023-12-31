//
//  JSONData.swift
//  Vendor
//
//  Created by Dmytro Besedin on 10.12.2023.
//

import Foundation

func jsonDataExample() -> Data {
"""
{
  "vendors": [
    {
      "id": 99,
      "company_name": "Florists + Fashion",
      "area_served": "Newry",
      "shop_type": "Bike Shop",
      "favorited": false,
      "follow": false,
      "business_type": "virtual",
      "cover_photo": {
        "id": 984,
        "media_url": "https://cdn-staging.chatsumer.app/eyJidWNrZXQiOiJjaGF0c3VtZXItZ2VuZXJhbC1zdGFnaW5nLXN0b3JhZ2UiLCJrZXkiOiIxMy84ZjMzZTgyNy0yNzIxLTQ3ZjctYjViNS0zM2Q5Y2E2MTM1OGQuanBlZyJ9",
        "media_type": "image"
      },
      "categories": [
        {
          "id": 40,
          "name": "Florists",
          "image": {
            "id": 1348,
            "media_url": "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
            "media_type": "image"
          }
        },
        {
          "id": 41,
          "name": "Fashion Accessories",
          "image": {
            "id": 1366,
            "media_url": "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
            "media_type": "image"
          }
        },
        {
          "id": 42,
          "name": "Garden",
          "image": {
            "id": 1348,
            "media_url": "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
            "media_type": "image"
          }
        },
        {
          "id": 43,
          "name": "Home",
          "image": {
            "id": 1366,
            "media_url": "https://media-staging.chatsumer.app/48/1830f855-6315-4d3c-a5dc-088ea826aef2.svg",
            "media_type": "image"
          }
        }
      ],
      "tags": [
        {
          "id": 99,
          "name": "BMX",
          "purpose": "shop"
        },
        {
          "id": 100,
          "name": "Giant",
          "purpose": "shop"
        },
        {
          "id": 101,
          "name": "Cycle",
          "purpose": "shop"
        },
        {
          "id": 102,
          "name": "BMX",
          "purpose": "shop"
        },
        {
          "id": 103,
          "name": "Giant",
          "purpose": "shop"
        },
        {
          "id": 104,
          "name": "Cycle",
          "purpose": "shop"
        }
      ]
    }
  ]
}
""" .data(using: .utf8)!
}
