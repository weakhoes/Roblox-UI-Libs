local generate_guid
generate_guid = function()
  return game:GetService("HttpService"):GenerateGUID(false)
end
local assets = {
  square = syn.crypt.base64.decode("iVBORw0KGgoAAAANSUhEUgAABAAAAAJAAQAAAAA77il4AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QAAd2KE6QAAAAHdElNRQfiAQUJLCZ5Cxx3AAABOUlEQVR42u3OIQEAAAACIP+f1hkWWEB6FgEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQGBd2AcS/DDObr84wAAAEF0RVh0Y29tbWVudABDUkVBVE9SOiBnZC1qcGVnIHYxLjAgKHVzaW5nIElKRyBKUEVHIHY4MCksIHF1YWxpdHkgPSA5OQprpmfOAAAAAElFTkSuQmCC"),
  checkmark = syn.crypt.base64.decode("iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAAjklEQVRYw+2WsQ3AIAwEUcrUzMF2qZmMIZiDIT4NioBAhT9SpP/edwhsZOcURVG+DQIuLr4AiFw8RsVhhXfJefblTM4vvPDCz4s9EgITnwGUtWIPfyLX0oVi++4Rn/KJwuRp1wqzzpkrTBvzrTDv+15BGatOwZnaRsH6FAYFY19oFLR1JFLxVcHEK4ryg9x1wI9TJwSqlQAAAABJRU5ErkJggg=="),
  triangle = syn.crypt.base64.decode("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"),
  colorpicker = syn.crypt.base64.decode("iVBORw0KGgoAAAANSUhEUgAAALQAAAC0CAYAAAA9zQYyAAAABGdBTUEAANcNO+1PKAAAACBjSFJNAACHCwAAjA8AAP1RAACBQAAAfXYAAOmQAAA85QAAGc0hrlxKAAAA3WlDQ1BJQ0MgUHJvZmlsZQAAKM9jYGB8wAAETECcm1dSFOTupBARGaXAfoGBEQjBIDG5uMA32C2EASf4dg2i9rIuA+mAs7ykoARIfwBikaKQIGegm1iAbL50CFsExE6CsFVA7CKgA4FsE5D6dAjbA8ROgrBjQOzkgiKgmYwFIPNTUouTgewGIDsB5DeItZ8DwW5mFDuTXFpUBnULI+NFBgZCfIQZ+fMZGCy+MDAwT0CIJU1lYNjexsAgcRshprKQgYG/lYFh29WS1IoSZM9D3AYGbPkFwNBnoCZgYAAAb3Y5PLWbw5MAAAAJcEhZcwAADsMAAA7DAcdvqGQAAD3cSURBVHhe7Z2Lr21bUtbP6iPvp7wJDwEhgCAIdtNNv+imoUEMIhIiEiISIhJiwr+A4Q8wBEMIwRCCIQTSIRiISEQEiUQiSCS2IiJ00nTT9Pt5u+899x7rV7O+sWrUHGPOufZe58HlfvfWrq+++saYc81Va+659zl9+3TfcOfOHQKI1wAjXfHMQFPUXq5HfEsb5T3tJvxI/ai0rfqmfEsb5T2t8lGdY6tHgJFOAOU7z4v8HJ7DswLPDfRzeFbhuYF+Ds8qnJ555pn6LDIKMNIVlzwf5XrEt7RR3tN2uf0YUfUj9SUaqNru2huc15DHz0lbHs/leC0P9JUGNjhJ50FqGdgMei+S52eetrB87949vHfIH/jAB+6///3vv//ud7/7/lve/Jb7r/2fr/XeD/6LH/QMTk8//bRvvpTLyQ4CjHRFe6GDqL1cj/iWlt8c5erZ6h/lR2rXuP5VK/WulvY4srYeM/edR39PJ0vvvNWnOukrDVjWXj6k0gPea0iVDSt2H2DmkeElP/XUU/effPJJ9rvDMD/xxBP33/ue995/+9vffv+Nb3jj/de+dhno1/zcazyD5x45nsOzCqe4pWvCxWuAka5on9xB1F6uGzeIj/aqvZz3tF1ejt31NuqVNtmHAFVzX6zptBxcmKK1enC8vGenhzbjq3U0Btkj0NbzBd7dle2Gm7zccd0HuBMrE3YnfoY7su7OhO7OT35guUPzqPHe977XHzfe9ta33X/jG994/w//zx9679f/0697BicWWpYgXgOMdIUuxCi6Hq8j1ymk537VRnlTS8fr9B2uummcuHiKoRbH7LRSb+5X1jdfrKnrkBsnR30J77RR5gs5avCMrfbMl6Q7GO6gDgZaAwzIDDDZBtcHOg/zvafOz8y29x1/3LCBftc733X/bW972/0/+7M/u//H/++Pvfe7v/O7nsEpnlEkiNcAI12hi7MKzj04IGfviG9po+w8HadpEw5WOhskvevVOo7VaSlcSx4C5Hp0PAJ5T9uqMwc6j3xOzQPJ2Tr8hoDSNTJ++6erA675lBrQ4VE2brovyAOtYIgJBlrDzCDr7pwH+n3ve58/P7/rXe/yZ+g/f9Of33/d6153/2S91772f7kHnFhkWYJ4DTDSFbpoHiA46HqlHvEtzbMh19VT/R2Pc1vphXsdx2n1gHue+ZLe7R36lpb3rfsN6xGP3HjR8Tbu2QY3eT1TM4k5eyNpLhgY2qCN0yZsWPHfUa1h9oH+wHmg26NGDDR3ZtY98b64Q8dA81uO17/+9d77o//7R57BKT4BEsRrgJGu8JMPDrreRj3iK43rkuuURxq58bJ2yuP8s55r12KvThNPvW5d6KBqI99wv8RVZ59zS97LPHLj5jRuX5c7bvZE3/dqfCO3QVYGcJUMNFzBQJMZYLId544P9L2nGVwfaIY53539Dv3E+ZHjPe95jz9Dv+Pt77j/1re+1Z+j6b3uT17nGZziEyBBvAYY6R5gpEf4BZvUI64LXDXQeSJ3mqFqQx77zzxep728Fi/H6NbFvq0eabG+7tf2ilrB8urLntz3PaL2wc0e6QOu3Dg9JtAyJtd9Ig3qwRlcMhCnNRpoH2ALdmOA4WTFaqDfXx454odCnqMZ6De96U3e+9PX/6ln8Nyv7Z7DswonJt+yJly8Bhjp/skc6Sn80z6pOx57VX/WVtmWjHpVG3lXPPqzXq6zfkRDbHXwtl/quaY6+YyePav+xp04fHkPzxGgaQCeszvO3gb1yEG7OzR3ZLLCftjzWnfpenfWHVrPz/y6zh85Bnfod7/r3f6bDp6j6enRA5wwWZYgXgMMdV6AJb8Ak6i9XDvf2ENalw25rp7Ov+F1Hv2st5x6Td/QuvXVl+vqT72hr2nxQ1v0uvXhcZ771HCy9OBBz/0I4JkJxOeTGDU5Iw/xbKDZzYa1PXIoNMj22PsMw2zHuuNDbcPMUDPMGmj92i7/poPfR9PTowc48aBtWYJ4DbDSOPng/sInUXut5rUHB+LZ32nJv+ktvhWPPgFGutfiZb/ZMVZa2g/kGj7yIS+c+27RIg/r4GClQ6TDI2dO3wdW2TvRU530NrxkW+MHg2MhGGhWwxleBjp0r4k60E89uQy17tJ1oPWrO//B8B3vuP/2t73de29+85s9gxPTblmCeA3QOCefasIvxCS6nsEvANwi98SbFt7qyzUXtXrIzV/6jU90+bte9abatbTG9VwHB7rDSq/7Sev2DM3r0HLt/tC9hhPSxZmm0EBbn7NPXPDIDukMrAsGcbKWPX1v4XYc/jKRcwaXbAPqtQY65yfeFwMdjxw8arBHfuQg61d33ITfZY8d77ShpsfjBxmc3vnOd1JIEK8B/KTFS+hCj6JdyKK3XuF+dYpWa3momxZ52jcpewkw0ut6gheR685z7vGrfuM7w2vR9kvZfUUHzqO2dO5TiGMMzfXIbU0EUAZN84kLkrOQ9MVs2Qc7XBpihYaZYKCp6zAT73/i/T7QujMTvJZuoJ+wgY67tH59x2876PH4QQYnbt2WJYjXAJ458eA5/KJNwl+uZeB15CE3jPaSVj3kzh+9VT/pYKS7f+QLrfYX7fxosOXjQNlDGO001rlW9VL7XkkDnTd48yFGHnHB5s4mL8gkkxwaZM8Genmg9YjBeTC81HWYPT+VHjnSUOsurYHmV3h5oH2o7S5NL2bYcYrpliBew8GJkwbhF3MUgzXZ27hhtIc0z8mTvaNe46GDpofWPARiru0+y/slX/dMS449MvfI+yQdWX2vB5rWNk/JrlMUTurWRADpNBgw9/ik9R5pDvGcocp29sjUPtBkYjTQDK1yN8jke0ueDbSGGuSB1mPHe97tP//deaffqRfrKZ4/tFC8hoMXQRqEX6gaE3/26k0QB6O+tNzzetAj+xtR9eIVx3rW06/AlHM/uAeN4LmHnD1k0NZWH4QsLelZ0zFA6y9l84FuHYArB1wX9y8BVwKqvQFdZtp7DLLt58/K4WkDHQPrd2TVOTTM4jak/ieFGuY21DbEHAMw3Aw04b/tYKhjoOPnQMeJP3GxLEG8BbAsrPoRfrFypHW1l2u/GKl2LfPoD/cwkNVrntClOS9e7jK7nlTn8/B+9FyTL2nqZy373COt6Dn7WrIi6rwWVK+w8jgxaB+fwMgga8IzdhMm2wA2nYElY1Wgiec7NGEDyjHbH3drmInZHVp/dRTkgeYu/b73Lo8e9HiedpPh9Ja3+C+nJYjncHDypEn4BVKEF6x6uTb4i4RbSK995xFeJ53ceaJ37p8HV/6VJ+1Xa3EC5Nrf0KQ5J8ujbIHYtOBa2+1BVqBb+NqkWeo4UB+0HhOVPT5hhavvgiFxI21PtDbQmWuIbZ/2mw2CgWZo4WQGmkHGp2EmM8T2nNx+KGz5yad8qPUMDfw3HRpqG2ju0ujdQMfv8CSI53Bw8qRJ+IUjwgdWvVyHb6WTUw8N1F6rI2/dcZf+snbkUZ09tafaeWR6Tct66leNWnp3PHJopKqt+imAjgE6PUJw7lPXc4c42c6+DS3Z9udvygEkH2RltC4YVNMZWAKNv1Gnmr0YaAV3aPJooAn8IA+0foWHrjs1OMWfskgQbxonTYZuhF9QC/lHvRbJk3v5By+Q+37xUu1hoG6eoruWeeRuXeJA/trr1hVPPo60nNu5F91zcHmqNtIbB1YjtB5a1L4uPIvZkDyOxn0WO731GGgyw0u2PbjLehuNnLmGWAPM/+DV79BRM7wE+5B1h25hw8xQExpo3anJPtg20Dx6oGmwwYm/+W9ZgnjT9AKgG6ELO+stfBnYYc9w9p3DtUEv610va7UftdbrzVGtPnpbU+rGB1q3H5p0CxbII929qqXlXDkk1yDV3kNTnTJw/4D7++LCAu1B9r4NoROyNDKxN9D6X28z0AyvBlrZzpk/BewGml/laZjJePJgc4fW76XRuoGOv9ghQbxpnDwZuhnrYVW0N8+C/XLdeOig68fxu154pXuvamkdWWuaJ/riea28uUfoGFnD2/lS3e0dedgnwgPkk+7HTQHanl71PdB0nzADfnHP9o80jhHD2vpQvqSeD3T0fXhzj7BhPPMnn/I+nOFloMl5mHPkYSYzyBpq9skDTfAbEN2hlcHpDW94g7/YpfS8xDKgYN0bBBjpFn7hLNyU6sbL2tY3ZK/3wis9r2+alXBAzmtcjz5Bq+lk1TTIFvLkvdVvWvLQkkc6yDW5eWcakWrP1D415z4G1YB208Ei+5yZzu34rCsDcQ2usizUcCJzhQ2mD63zpxbOeZA10AQDrKxhbjnuzhrqOtBkDbTu0N1Ax1+OliDuNS9CPPIwkm8Ype9vSuh+4eEW0v3qBVd4L/xNj7qts0BsWvGzb/PS3NDzevHsXa2XbtHOIemHNAvfM9X0qUHzkNFtcFpGo1F1YGfZdF8cMM1/0JNmQ6b9qeXrBpsADC9cmb2cm5XaBrINMLUGWBo8BwPMb0HIGmYFe3fDbcMM10Arg+fZuXHFbhP8F0xHuoe9mKEesVobfvTWQ0v7DI9nff4rULkmd3skPtJZ7zpa6K7JkzXqrEmnjpCvW5+1FJ03axFN03FsKFYaOfS21sZ8qBNZM950GzDXswZHJ7Ku8DVP95oCf90r95/8wJP2aVteg4JznoXNbcs1rjHQW8GBRzox6+2usRfskbRuTbogK2/05HMt9E1NetGaTzp19UXtkbWkt/1SdOuk2TCs1qIlj2s2XKshwVe9I0161Qi73baB78KGOeu2vuvbXXe4H1Fez0pXL9c5rjnQbDjS94ITXOkbmk6+9n2fsm52Tt0xjbc9d9bL19bXtaH7RU918yVNnk5TVE11hK9D17CFR7EMO3fkGGSve0/Tj2p1eO3JWb2m5Tszg9v1DoY9QrTXpMj9rBN5iHOc/uSP/4TnDz2DNG6LxGuv08Lnz2wpwKwnvesd0QzdXlFXv2vBvU66fFNP9LZ8K4/qnEfaqMeXyNKA1xHtOCB7Wm2PrdLRSF4Yom4ZwEGUDhvCUM9yaC0DMmGDbuRcSzOv85wJewb2nnl4PQy9c7I9E/uv7dRbnqN5ru6foQn9jwB4htYzNT8kksEDe+SwF3OJzqeu06ov1dXrn9jsN65PcrcOrjryylM1y14nzT1wheqRBy3Xya/I/ZUnres9/OHdfXuWPPiMrH2qj3qk5XoUOq4N4a43B2v0OpzHdxNpZ8/ZS9iseuS69ohT/Ec6NOGNm1G89lqdPH6HiKhr1QO0stcj/LrLkMFIy7XWirsn6pmv8yBSJk7u1tQ6PHUN6PakVlgNWm1RPcCPQ/Yq9dDtjbYpP+9PrX7KTTcPg+ZYOq3nGeCx4XVNGWQNjw2t156NaZ3BNbLV7OsBt7us35HxouU7tHT9JSW7w3b/oRl6y116CdX5Dg1vv/WIDK59h+YTM9Xtha16A63bI/pNS/56rOm6vEZ81i/aqrY8rENzPz31I7ymH3G49v2WH/DafjYEfd9yaKtaUeuqpX07jw3Z+XVufDeQJ3My66Xn3r2n0r6WKydsPvvaviOhSRdf4uT5xgNtBx/ql8RgD0600zhJ8eR3badeaeV4037kXLf9cj3qh9b6EfC2Xv1ay6/ah3g9yForv/bu6oh8LPWHHtUcI9eEhjLrdVCJ3K971F6OmU5oYMWrfo5FO/3B//4Dpka37MZtkfiqRy59fVutukfRshdefU2Lumm5HvC8bsUHGkHB+q530zp4pxNWI+TakiOvI2x6S219e7OndQDJj+PEEDpwboPatNyXnvtwWcj2HcLrrNlAN01hjwWucR5w28cfKQh0sq3zv98hjtceGdojB6HHjMzJ+lNEanLmZHCtRw4+Nf7pL/ooht7BWveN6uxN3D+5uRaP3B3XcvZ6P9WrvWoNjzr3Gs+1RVtHRM/r5rVv5zbM8g73ybVl7SPe6uL3nmr5baD8h0HVygpqe8b182r14FFjFDaI3XHz3vEaW+DN9V7YzG7GKf5/KjThtsauaPAUoPHwrGKgI/pdKEfy+V3FgNT5wqM7WPMn3tWGtj7x7K9eggK9WzupgXPE4MC95OC+56SvvOxnn6uoQee3N7/5yFH7OalHDVTjhYOl03oOcRvMplWOZTnguYdGqJ/DBtI1jq07NGHelgn9ZSXVClvfco7Yr+fxF5dUH7pDG/gkdFqKrV6NkbdqXtsLz1qtuzX5/Oq6QWx5uWM0vlE7R0915isfYZrrEfDms0H252PV4Rnul3uFr2obDGqdR4vcy/3KVdvc5uP7WnHpNWzwujXU1Z89e2EDq/faA66wAfZ9sqY4/f7/+H2mRBPu2czSVj3yoF81IN3vOK70tfqNRz3quxZcNQLZ7yKhQ9t6cWAZn69LPPfyGvfBo0YH4k3PNSTVy772j+W6V/Pam551gOS1skSS1QyKc28Yom77AflAeJoP2JA2Dqh5VmaderFm6cVSaTacruUwX+M2kO3XdmT97busuW53YOUa+Fq2uzOcO3O+S5Ov/QzNJ2ik5xh59tbxSe/qzNWL7L0Bbzmi+rRn5vR9f/nSHs0TXL3z+nNtPOmxJvvzvvCI3COP1jQ91f5MHPrqeVfrCXqZez/9So6sPeQjbKDa+eXQMfJa+ViTvTnk4W5Mtnlchbzis57i9Hv//feYbk24ZzNJyz1Aa9Uzye8kqiOvvFH7XcBAqXXAbwGWs7/tGz1fW3TnkQH7ZF/HMS7lsk6cLxPd64B4pxG+xj4L1WtvWlvj6nqtsjjIusBWXmtfVw1w7Vl1YD2/64qTqZ2bjJc61jinlzXp4gobWO3pd2Uytbh+owEnK/CQbb3/oQs1vAY64A9hqLkr685cM7j2H6y0sBcw1C34VK3q6k81n+TGI3uUNXmf7KtctfPkzz7fR710nObPmg3y8jvjRR96IpqePRHd+ShXHnXT1bPhaHfozFVrrXRfn56Va2jfvF7rauT9CRu8pT5/hzocNpPT2OsTp9/5b7/DdGvCPdtCabkHaFUdiU9Yq4niO1L7p9TgdwXLu73QydQdj0zSuTUORp6oR3qv2bzLbxh6+BKZPqJzRGVkGxJfrxyg7Dyuntd3/tSfchu6sx53ZZB1uJaQqe0Yuru7prCh9R659sy/cNs61+QcsTd/hN2et20/75EJNJDv0NIf6h16EnzKRjpRe17bhajcI/MUqzXSk186ud2Jit72IDcPd+HznZicebcu86QNedUsnFtsrrM33u/E0qRnL32rp3uk2kNcel6vY+VernP477AH+ihsDod8FNVb4/Tb//W3mW5NuGczS8u9qgPnBv+0wonkA/6RD07OdbvLkIO3vRLvfKF3HEw0HY80XGfodL54bTNZtcRXmnLScg2aFhBvPhueTgs4p6e9ku8YT3dl9NSi5q7YBDiaPHZH5LjtTg1Hk0dhd0r3cbZwNGpb13rwHGg8Q8Ntz+aHc1emBtK4G8unfOkdWp+IUW8rDq2xF03O3uG68OWQj7x5LEO3f9qr20Pnsoy2T07TCl/d9ciZh8+9uW8x7JOT3tYUTs58eMwZT1rjNihtj+BdfxT4RnwvbADdy/uRQ/1ci7OmrRusrXH6rf/yW/H2OTzbYmnSAXLVq5ZrQOmfTDhR6uUTbYBHbpHr4J1norEnedhTDXedf5JPekBc54nPveSsHfQBmxeboKIRaPQWae1LPdB41jue7sqAntqFr2pgg+SEWlFrPGTO0+6o+VnYuXrcodUjz4K+rV3q+OulaABdQa07s2pw02doPkUjXTHtG3JPd5BhT3zDM4q852oPrV9GvO1FbnezvD5r4vTKedS1o/1We5Sc16601BvuN+rnqH2Lrp9jtL7qNmidJ9e1l8OGz3tcvxy5rzrriqzBa5x+8z//5vLWLvBsZmnSAXLWnCct12Crv9XTXSlzMpK83Z0req4ZqmbTsayRrp5qeGTQHSvXBvG21t7klSaunNeXDKYae5N1HLhArX1zb3RXDsrdruO2nrula9jwotlQNQ1Qy4smD1zBGYubb8Vzjr2cS7f9Wt36O3fomsHpN379NygkeOZFBJcO/MWRl7KrPaIGVVMg+BuxcAZzWZP0bk1wv6BG3ROa+ivN/vF3IvUB2mofQ7c+1wbxto6CnD3KOxpoOl/o2ZvZaQHn9MzTjpu8jWv/+kMf68gAboPR+plb27M06qyx1gam6+XgMQMPHJ+4fgh0TwxtzvTIo2i9wUBT10FWBocfOexEhvpW7K85vCffYka8aTHK/ITtmkE+z3Eu7dtmOrfMPQY9z9mXPcobWncukUe9UXgvebswvfsDEvmyf6TV3kyzAVr1L414L1rO+jTscXCo78Tp1/7jr8UoLLADqZbmOenAeWiAT2P1qa49/+QaKFc8crfWztRvUaHbO7xk9YF6Vcu1AU7hmvp8KZ6gjbd1FGR5yDYAzVe1yN1avqjnyrm30lmrOunLvufrwJ2r76V1oPTdQxbg8sDVy/le3IGpxblD04OjcQcVl45W79jyUeuPvqXbB7Sts30aJ1NnHcCZZoTTr/6HXyW3JidLigCekw6chwb8VQfvfAY/2eDqHeL+z6JpDx2neQ2rnrTI1Oi5DzpP6Mu7t17fagpl9fiiHBpY7eWFIXlAtx7IE7kbaGpztr4vMNib3HkFakkQPHij7jRq6cAGZdhzzr/BZ8HgkdmDgRZHJ+BoWwMtnwaYGi4dqAeu9ieFBr6NdJqdbFcfiWW0lmha7B37Zd4i91LO0fW0p2Kyvvt2nY7p/dmamvMeHLeuS3XHc9305b1e+bK2WpMi91hT++qR857Za+/NmZuukJZ7M07YULa9Z1HX7MXpV/79r8T4LLDFqqV5TjqgzH2/OsnjvVx3Pf5Z4B/7whUsYl9k15QTb2uUg2dd51b3WumGlceL5F3Kbg3w2t78lY8vydvth191ZMFr+rxL3B/tlTVdSOvbsW1IVp6qi6flzqtOzlw/AObevbiLV+5+7raF0xcnU9ffUY/u0Mp2DNdUA7Sgd06//O9+maIJnCwpAngO3SkxqRV8zbX6wK+QOF+8adfIlaQlnjOtvO/UY3Be6s4TuekUZNWzPl+iB1brlrJl99qb6PtFbj5qeXJt3ZWPWv1aC/ZmT3UyMj088uaesnrLoJ7u2NSxjPNs6+hJywOdn5kJ8+u4Wt80cffbaUiTj6yhlTcPsTzgeXa1uGC3jn58/U1oYSdYOd9GnKtncK3Eppb3GkXac5YVXZ3PRcfI50qdeq0ml3Nq9V6OY7Y6aa0mcn9Ws066sr3pzadjKeoe2Uu4v3iI6ssaa/Jx6jFzXzxrNapnFqdf+sVfihFcYItVL5pdT89nT+tlb+Ig1+Ig1x1XvqRv4N3LddYhtd/0pIHq73zkQR102ceGotMM47XmswVOA/I12Kt0Lfbkg3OoFqTbcHU6tfyGUN3vmb54l8MKzzHScth+XBuO1+qFc83u+51VOsFx8KsWr5m4N7lDn37x3/4iRRM4SdJSLRdePGXnySuf6+SoIX4RoUTolcuX9bzWr55lktY0HnBv5KkOIjc9aaD6wMrDl40auEY23YeIPhkxe7233Dha7eSMWq889qa244TkqLraWZc2zPavvGmN94iRFnrj9G0AtUfTxJt38OycvdIYZnGQ+Y1+y2EH8ch1cL49dL0LI3/7a3rWDOp1x5KuXM9JWf2q56zjlT0UnTdn/KPjlv3QW6DZKK+8USuad5bz66q6akJ11eXP2YbZfQo0G55ub/cNIq/LPnH2qf1cZ73GyKc4/cLP/wJn7WcObEGuKVvP4L2k5bppUTsnoq6cwq/KQtce5ZGWsu8RmfpQ396Q6TpD0wIrr8G12Ef7Ras7RiiO5dYXsFdGci28fgxqII0ckqPWAC17ZZFuA5T3Ddbffalbz1Lao2VFrdnjXvkth8L27nzSFs453Fv6cYdWXx6Q61Ev6J3Tz7/m5ymawImSlmp5M4KD1ss+o7wQ+Wg1TkSdvUEXXblweZumPNJyNvgxIrsQuelJq7nrBdo+1rHgbejX2ZuQPA2dzz2McfKN1qGR8zonCVXLJT1b68NtCHX8mAHEm6aUdCKtX/Vy4KnDzdCpl33o/CcOpGs4sx9Q5544yPz0mp97DUUTOEnSUi0XNDhovewz6ie00Ob3ftRNU60c0fZQXmivTbKlfk/l4M1LAbInsNoPBF+tM7iWvYapBuxsSKu97E3b1ISZZmt8QENy5FIee9ObWPot2x2yeWcZH1wDq56vH0TumXelwTXQuQ8n4EDr4bWX+dX+pPABBc9M02wYZoVdBPcqo1VP0eTN0dalXvNH7rTOx/tT/t61uM5rcHz3iZPx5Mg9+VO4v65Xf7Renq2s9dqDGGmj3tF+5tVbtVGcfvZnfpZX71cA2MJcU7aeofWyz6i/6oU2/6y3Wpd18Zq3elvZoGOQXdjyUCQdtHWgrrE3OvfPms0nevTb3oHmi3rma8heQWtyr9rs7tV5cr/zBpWW8xZXcIx0rFUv/0GLsvjsDi0OqAk4ujjI/PQzP/0zFE3gZElLtbxRwUGuq0fR7WHUT3ahix4Z5Lpm4GutnGUw6nljJzc/BVDfUPcPunjsgo61ZYjbnsnrA7W0rBmaF+n4QvYKaGTWiQNRtFlPyLUNweJPjxno4qN8Lx4z8LGXItf0c0+a1tpea58dOmvk7APUBBxdHGR++ul/89MUTeDkSEu1XNTgwPnE07TcF48M2kWJJK/3rRz2a97q5WzQfnrDSCOfeHtjEycJK83OhjTyAj++vQnTfuQO8megsZe4iwPkltbYm97E1k87SNvK4uynAa19ovaznjmDyDlULXMyQFOdPSD7dp+hDf5sMurVsIN4RH1oTYQ/o6W1uyHvXrbQebTM64m+cg5/Xks87+VaXs9HK+vkiKbjpad1dT95lLNfgVc58RZ5vfpFa16tJWe+lUecyHtLmwVe8sg/24M1WnckTj/1kz/Fq/crAGzTXA/16rm0l7ShXjJMH0d/ZblvkOYZahcga74UjnmhC8RrNvj62MeF1LOJOv8FK0vLLWqBjus8cgMt9gze7R/cC7iLBfLM+kJupzVnbo8Z9OB2d3ONHH7SqkeOPbwvnv1ZU1Q913CuEnfY3KOuHMiT/SB7Tj/5Ez9J0QSdXNCmG5pv4LmkJx3iF2qhZ29wIH6rDAaaHztzSrtQ8JDTOv5JayN3xzC0Pes+Cb4WH57gpAbpW0hrfR/KvKdQyjj6gtwT38oEx8i1OPq9nceMqpE5H+l5kJXrQFcP6Ab6J/71T1A0gRNMtOmG5ht4ap2514l3dcmQNlyh1Vw9GiJlsOrbBSC39TQKJznEzS3e9tY+QuaGqS+hHRuPK4HsV2/kq6DNv7Y8H9vf9MbTXRnN0DjZhqJpcHLsRYpjLJyehjf3cj9rs5orAWcgay/rcADX8GZdGnigv4c28FzUaXYiHkVvvtGaiJlHfNWP49Rnt85btIVzrfg3eXTOeR94eS0rn84h+uJNxxder9HTmry+i+KzLZa9pEVuXMdRf+BtWvaS1RMfeRT0z3HWq8+ub/N1+kYc8Z5+/Md+3K+GhcMWiUObbhjpnq30sy26es7Vs+TehS49FcGlD705g6xZ+JqonUu3C+o8ep5B0/hnow/EtZdFt29G8VIst68BaCefc29cgNkS/VoOnu+8mQOtn2W8WoOW+1Wjvrfx+KE7s7TsJXPHzX4yyDrcRUP2nH7sR3+Mogk6oaBNN4x0z1a2i0MOmj3yOVfPkq9baN9LvGZIXpePTXKI1wyadnCI7YK148GlC5kLxSvD8o4PUPfIa8VH2Gitjpa9mXMMhhVNx4vsfXLm9LIurQ689LyOXAd66w9dlAFDbA1fPB3oH/2RH6VoAgdPtOkG57kfIY2Ue0M9+KqODPH/HZ0VnUZe6ALxnMPgV37EzeF8Kc8fhMr5MqnFSQ21Bmh2oYd7zVD3Yb3W1r0YHtW559wqOBq1uAau8ljuEFfGIy8aUTWQe7UWb/04v6pXTrbjeAa5X/Wgd04/8q9+hKIJnIyof9muszblkcGIj7zS2kWPlLP64g7RlnfuwilD2jubvSDXWz2g2i6078fjXWzd9p+h7jVCbOv7m3+9YHAUrRHSHhzT9xgNuTJ6HWyg9aNaXHqrzTryLZxjLf9rFmmjPBvo+KHQD3qT4EF9pHdhOOQbxGhd02Jf/4FDWgteY3ld4VutVx1ctfN07q2n46lXj09N0F88ra89zj/ENE93Pv6aYt/GVeMl8BO5Z6+57UWE33mtU+7OVzz70rFdG8Wo163jh8T0g2L1ke1abR5jL04//EM/zKv3KwBsM3HPB2tF10+9oR4ZiCsDcWUnA33J/LOA0q+O69EHW9yCN5V10iDLbccwqIMtqDUYacJWT4jzacZZbclffwV6hvsWvze0Vj0ha3hGWq6BNEXWlOudWVlR9a08feT4oX/5QxRN0IlA/cu5BpSj/kwXdc9Snr2WusHLfEuLTBfqe1CF7hkkDXDROi84wsFWDxzVhK3eRVhmZwXb3x8RxF008OYL4tU788BVk9EyZw+yfOIOS6prVox0OBDXII964O7XvfrrfsAOx4ndKgx8qxj2IrxvB1/1RmtXGueMrG+p/Lv4PMe+bY10BX1pOgeD/BSrc1CAka4Y9UfatWP5uLdv684tK9AyX1375O94XCvVHvUYZLTkpe862Uh6jFj2ECcTW/2sVT3nyu+++mtffdFAxwbDXoT3d3z7e8QAt0Fe70fNp9g5htA9QlcMj4cn+bjAllrf14DQW01W1PpIXLLG0IZJtWV/Fg3d64jmI7SurbFHTLtizV/71HBivXbJWZOePdrDrphrJp5sRTvf7NGauk/ydfooV36bPylko5F+aZz3Od+FW18n3Dx96AU1jYtB1rraz0Ev94MrXEsXv9XiqrOGl8i6NEJrLOdjtche+TuPXSOi7NEdR3reYzmf8//SOvd1rrVHVi9rea19aQOYdYWd1fQHwRystceJ7rWOfHtx92te9TW3euRgE8tg2CfCA+egi56Hd3AXzpyIi0p0OoHX+kbP+8uf3gz4yiMfemTQankVtR5oOpes53P2ASha9o6DQbZsYJ32ILyOcI0ePnm05uzxa9E8tS9NOjnv1fHoE7G+28Pf2+iRM1dmkEf61ppzj+86Z9/dV331q67yDE3EgXpdbwRt0oHhzZEvXum1Oi5e4+Tql27BG7J6VEl9Rd7f0rnOofUK7VP06bkX3yoMy13ZuM45euRuX/ealnzNk87LNXLeL/dTz2v5lcXp46Pu1lsvDzoR/m4tXOcgfZSP9oi7X/3Kr77OQPeD2/7HoVbJw4HP/u2oF7TrldojXZhcK3yNeuIG7YWwtS+RX4tHrTf01d4DzyratVzW+xuGnl8bWj7HgeY1oX7WQ+v6rB3VROZaJ67adl5qZmDhbY+8NznzdV76W57K777yFa88PtD90HZ159sPTmKTx4lK73o5uECWeTG5Hq2feiPysZsubuDN0J1d0R1D3kEM965hwOfBIOt81c+RzqOtidoj77Wls4+0nLU/vNaZ489c+3nEQKJLE1/y8kPquLe1btwj7r7iq17xAxpMYjSsTQvPNUIXpfIaGz1eiJ3Ycl7h40XlWjHyUrpeo+6VNKSmWbT1Ra/R7bURDEFXJ+5hQGtvYH6d6kW4Rr/q+fUToz3Uy3XWd3m5u2aPtCO9mTbqEc/zYT03eFGeSz3Scn24Jx55xSMan/Ry7Z7wdZrloa5efiOpidRvbzyR18mnHoE3/G2PtKb1t3yjm0bus6buU/q+RvsTI13+uge98LimOq+rnKi83QxDJ4trz6M98khTFlfc/aqXf9XVfig8EpzASK9RfYN1vICuxwtK/dxbeYmZv66RjgbPukKaYbWnQp7gzTf77pc9WQtdUf3eH7zOoZ41MrW8W1z1Tb3Sam/myXzmJe6+/GUvf6ADnS9gCk5mk3NySV/VhPZWrxzLNZB78s60qMFKE2ddrOUiNj2iW0ecPeR2jqs7soG1Obp+RKdzHmld09FmemhNl0ZWlGvTeUe9xu3uDFegVZ411bVXPaPeyHP3ZS992YMYaA5m+/tBO20UukApttZ1dV5bjpf7vNhhvaN5GFb7Bla6hWug6BY2fNby/vLbi9IfX6M4jmLU2zzfqLv1+KWTk6euWdXi5Mp5XeI6hs7NaNOI0R415zjiufvSl7z0GgPN5rafH8S1fIEn0bx5nWKwnhPerBNvtTyxX1ujeuTJ2pYuTaGeodNd41/x1AcjneC4VVOE3vXQiDjflSft5z555FdNv9bkyrvjpOdmr8uape7X5qzQurx+1ht57r7kxS+51UCzyUjPkTwcdNVP0fqG1b5xAZunu6CLx7P6RF0DJ2fPlrboLD/XKUbr2jG9x7/JYxjto1j1qj/qQ1q5PrwI99Trpn6E96WRibxmtG/m9NIeys2Xa7I8Vc85x1bvan+XgxegF3phrPbJtYVOvuomLy+q6rFHe5G1T2RP0n2/9Zpn2ps4itzLx0zD7PsSeHXsI1G952Oxbf/6grfI/Xxc6fJrz6wrtK7qXaRzuU3sHudA3H3xi1580R2aRSM9hfdnPl3Uqpfo+lrDprlWv/AW4avn0vYh6t5Zg0s3jI7RrWua2atGzl7Dar8jWtSKqnW+/PpzhHe4Xp7R2uyB55602s8+9gzNc/DOQ8hH1F7WRr27X/nCr7zKD4VsNtIVo37SRmvXWgwaC6nz4EU4DzQ9vzmqtRYxfM0fyPu2PpCWPe1uHD/szXwpbqp1NXuX16fwOvcjvIeW/M7NvDnIWW9a/FZDPXQyoWMoco/I55D1XNde1shGut7dF33Fi44ONBuM9GnEQdtAlRjtx0lNtWeSbsjr67ruTZQ3tOaVrsi1vKEP/Rb6dts0Q/UQN9LqXkdqve7cg0ftWqrzYPv1VS8017WGOnIbZIW8uRbP51R7ua66zk0xW5fj9P3//Pv9SMAM4p5TLXR66o/8TQOuLGh10m+q8dWyX/ShB7h6LltPWtc0UGcpF0vHX1urnQQG9UoDA9+0ztze5MNr8ebamPHlWuV9lNf+hWcvFvZgm7PW75X3AbmWF1RttA9Z2OuDW/2nwAx8Soa9HEd9NUbrimafyv6uZi+ycfvSeNPK+ojWS33vqVbP30ur4zht7Shird9pkn8YtZ/XiBOxZ9u/1vKT1T9Hez2dzlrtrTpy80rTHgr1Z5H33Yqjvr24+4Lnv2D6yIFhpM/iqH/g42Rqr3mS1kJaevM2dXjSmy/3Brr3fIi5GSx/aNB6Ay/R7TvzZz7Tcg1XrTe/+LyGqzfxNZ6vhXqRva5a83oaP0pkv/RRrXNT1H7Vqp8YrTl93z/7vuX0DGYQH2lgpad+rcU7XRnqXwb6SPMvAVeKD7h6DZ1/Fiy1iGHEkzT1gq0emPVnHKi2N3x3zZ6Hvjg5+7u82Dqteke1ONjzA2kg87om4/S9//R7V0boMvD+ac6LVt7Ur7V4rYdrgCtJS3mkrXoArrIRgzg56HrdMsitdhJQTcq9zMGsJgd1dIUh1yPOm6caIWZqc10eElB53tOJQbo0ZQ5YNXLeY7SODLIPVK9qZTDyg7om4/Q93/09ow1GmuB11oOv1ihDI7sGVPqXqCN3XmXgYpQipMQ3vUCcDPV/IAFxclBHVxhUp0za9QmzeqYLqskQxgTKmys9ZyCuAXDRIK486ruWrhEZjI6X14uDUZ8M8j5g5AFb+2Vc/EOhbeIx6tUw8Jwz7OUoPn9eqsfInpGfLE39rKNJd26J5+JRX6FzyHr2ZV3HymtGvqrXOvussfIRpvlx+C/liqeec7K4zi33M5/18745sq61Wj+L2V43Dy7PWj999z/5bn8FwE5KfKQ5djyeUz3t1Qz1L70+0ro1VYvcOICb0unKIGnDPsg1nNK/JCw10vkuA45woDrrmQPVWRe3odnsAzg+8ZzX63mN/q/Xo3V1zegcyNJB1VSDkQa21mecvusff9fKGHC+aAz/0pp7DveaBw2o9C/netoHrpQ13jDArdM80kpuHIw4OeiuF1SushHDrbm9iZCQdteReeOr5oIBXofIGwbny+E6DYzWbA2damVQe6P1QvWC7BdO3/kd3znbZLUB2PMkfri3pytD/UvSAZwyvjbNicH16IfUeM5BHSpqBtCRDkb6iGcNHNWVhaqTeaOr5oJBHIuxcT8Ncc51qI7qoGqqQe2B3AejdWf/+Ya78wztHn82Gfc34/Aa7W8n6FH7W+GvI8Wqfz53z9TSUs8jjj3tJ609O+p80XMUv+es57703Jeu2OpbPTgf/w+wuG/ktyvV6qwvvV7fCo5XtVlc4lWwZn/d+ZxP3/GPvsNfLbAX07gh866XuOdJD2z1oSs9aV3ddHs/PS/S2IOLL4HKKf1L1DmDyin9S0B8pIERr5pKEXvTpt6cwYjPct4XiOfcHTuu77A3yOoDtOoH4tUbdHoMkNeArR44ffs//PYmZrNhutHIN+lPe0nr6qTT2fREXmkATulfos4ZZA3qXwLiNQvU3BogIQ29t9FA1ZVB1vJQAPFZHg5RXO/ZgCmDmafqYKu3pYGsg5lPOH3bt37bbPF0o5Fv1k98y7fkcneo/aorQ/1L0ckATulfos4ZVI0c9JAfzDRK/xIQ39LqG00GVVMGVcuZ/aq2ypNnZ+XROZGrzvd+jgavPZD5qC8NZB1s9cCt/nLSbcPf5hSrvl2b4O05cJTp2wttvhyXeJLXI/tzT/yoZpGP3fiWVvcj5zjSy3uqp2jrmQ/+DvcyJ6t9817kI2ErhvrDiNO3/oNv9TMGdvKNGzLvejPf0GPvp+cFztVrHkPi017SWg3Ec4b6l6LXHHTqAXAQZecJOl03yuASDUS58pBt2KDD3iyzhmxXqelAnCyPaiCu3PYxXNIDoz6Y6WCrB07f8ve/ZWbozHVxV5+Htmnqd74FnV4zNPLUowz1L+faORB3sfh2snNADcS3tJpB1VLuNL1JqslgpoEoV55RHu1vZ+AcdLph6E8ZzDxVF2ofSFMGuQ9yD4zWZ5y++e9988ywMo8uAki8WyM99cFq3SwH9jwz3TkQd3Hi38lHPF0GcImqySC1DmVQtVGeDRrZmHEvSV1/ax15axCVZ8M26gPpymC2h7DX756h/SVuRPZOwp+5tsJOqEXtGbpnt62ectpruFZ10rt6L0fAPUbHKl6PphUPOUft5aygrj2yziXn3K/Z3sHluF6e1xPU83Xn2OpdErddP4vTN/3db/KdgR2k8UBX5/6MG4Zrag40Puon3vWSPtKG3r0M9S9FP5JB1bayXXfLPqxNt+Eaeq+Wd36DoQzEZ+cExOUBo75y9gHpIPPZfmBrD+H0jX/nG6cbGDY3UF11Q6tzTzxrhpUmPtKgkV0DUY7WdXXNAA6iXNWGrvbCEGVX3yYDOIjyxnUdRLsKXV0zgI+GSRnAuQ3qV3JgdSyD+Gw4MwejPcDMJ9Q+eCS/tjP4t5ybaBadNvEoDj0ibNV5vWLmv01W3LS27MH5Zj0+/qt1OWpv5JVmX+EeOlaO0dqHGadvePU3+BkAO5nGA7XuPDMe8LrqqrOeuWHarzkw7VVNGepf1rpzEOXKczRD/UvRL826K6kGcBDldK2dwVg31H1zr2rKYHY+QRuXT5CuLGRf7hkz3lmne2acvv5rvj5tsjKsFlSP6pkeaDzrE77SUm/Ikzb1zzJIfMPLDcDvyA50IH6tDOAgyt01yqDxMsyjwZllkPnWEGdtPpxjDkZ7g1qDIwN9tUcOg3+7eRCR9945TvuWV/Sm1Vxi4xHFdQ/pa8/tcuW53lqjaJqn9W8xiK31irwOXvvXigex9+lrX/m1y8s32AtoHNQ6MPVUf6mHviPc4Fxa7m1p0MgrnzKomjKomjLUv6z16ZqaQdX2MhC3gVg0+2x5NqhXM9jS2l4GaTWDGR+tBzMOZmtArUH2g97DPN+/c3rVV71qc6NaB6ae6i/10AdfTmeti0Ye9rc05cDUD8RnGVStZlC1WQZVq9kRhTRlezXN0zSD+Ja2NcBgxLN26QBvDWPmoNZge5jPeKR/OSkHvyYd6RH+7YmAlx6vY6qVXv522vly2JeuN/Io6BnpPOJbeabVoGfdXU/le5piTxv1H+c4veKlr/AzFuwFbNaBXiumXJbWyhp5umbGDc5H/ZEGxEcaSLzzJf3GWs3gxprP+NgDxPNdbdQ/qoG9vcCMg9l6sFeDvB6MPOD08he//OLNDRetyXXpDX181PIv7/OaGTc4N8XyIo+8RzUgnjXDdE3N4IimDLY0O/JaM+jNzpr4SAPiI43r//SFAwxmvb1h3KvB4YF+2Ve+7OLNA00febJW+6We9sSzBkZ65gbjvC3+CLDpHfGbaIZdnzI4rJU/sgbiIw2M+EgDIz4bHmWQOcj11vBlLuz1weGBfskLX7JpnC00XLRup258y9dz1pwHVug9jY+0xkcaED+qAfGRBsRHGmh8cDduPcOIjzQgPtIEDczMkzmY9fYG79JaODzQL/6KFx8yDvTddVmr/Z16uK54hr2RFljps0cbZTDiW9o19tQwZ23ERxo4wvcGGMx6Mw62Bq96QdVqXfcTqk84vej5L9rcUJjou2uzVvtbPcPF64wZX8q5Z+FZM2x6wR4faUB8pIHGB3dkcFOetTwUWT/CwVZvtjfIde2Bqo2Gd7QOzPTTC//2C7vGsQ2W51N9EUZrq5brrV5g6J1xMOsd4Qbns/4eH2lgl99wmEcauHSAwaw346AO4Ja31qBqVxnoF3zZC7rGpRsYNtdfuZ72rsXBrJf4Xv8Q3xvkrN3kTngbDrZ6W8MMLq1HwwyqT5jpp+f/recPDtTuwI76XFgwWH9GrcGWp/ZA0abeXM84mPXEswZyLZ41kGvxrDl2no2B6qxnDlRnfcbBrJc5mPX27pyZg1qDPc/VBvrLv+TLNw+UMemttMV3/lCM1lXtkrr2DNNero9wUHt6JVUPOl+f7sBAeusHcn0pB7PejIOjvdveicERz96HpmLWO33Z3/yy3YMJs95AX/lGa7O21we5rj3DsFd9W/WlHEx7t/ghD8x6RzjYqmcc5MGqvVqDrO31haodvTvn54baE05f+kVf2jVmRjDrTfSVVn2jdXueC+tpb8bBjXqTuzGYcTDrZQ5u0ssc5Pq2d95ag5t4wNGBzpj1Tl/yN77k0EGFUW/Dv9aLua6tNdjybPVAqS/xdvWMOw7cjcGslzmY9TIHl9S1tzXQ1VtrsOepNRhpYDTQMy/Y6p2++Au++NabbfkNXW/mrfpeDbJW+5fWhsN73WSAwVY942Crrr3b3HlrD1RtrxaO+sBVB/qLPv+LrrLZxpqN/a/7gyPIWu1fWufBDbR6a+1WD+T6pj3wOAzvUW00tGDkBTMdbPVOX/h5X7hqbi0As/7GukP+0foj2l4Ndj0Hn4HBo6y3emCvBnueWoM9betXu9ccZrDVP33B537BqnnTDTfWHfYP9xiIVRpYOm14wTeGGDzba3ATDziqgYcx0Ppef/r8v/75q+ZNNhRmvYl+2HtEO+LZG2JQteP1clnn/QXXrsGep9bgJh4w0sBIv3SYwVYPbPVPn/fZn7dq7m0Itjw36A39I2/VRp46tGDkq9qD8lxagwflAUe0Ix5hpM8GGcz2AVs9Yctz+tzP+txV87ab3rB3+DyG+oEhHq07oj1Kz+hRqXrAEe2IB4w0MNKvfQfe6glbntPnfObnXHxCwp5n1t9cNxhMw+F9ZntX/Ta+m2pHPOCINvKAm/rAtldPqQtucgee6cJeH+x5Tp/zGZ89dBzZHGz5NvcYD+7ecVe9kX+2x1HvSANVH/muqY08YKQf1cBR70gTHsWdGez5Tp/16Z918Yll7Pomgwtma3f2PLxmts9R77U1x6Ax8l5bA5d4r30H7nv93R5src3Y853+2qf9NTfUQxw9gOMGQyts9Td6Q13+/Fpme1yiH9XAUe9IA1veh/G6wLXvvuA2azP2vKfP/NTPvPWBjvj2PFv9G/aG+sx/Df0SLxjpl3jBpfrth7W/9W2tA3t9cMQDjvhOn/EpnzE1XfNAYM+31Vdv/c3q2LoBhvrM/yD0o3fcS17zw3y23eqBvf4C/sNT88ebjCP7nT79kz/9xieccdS769swbK3d6oFZf2fdoDd/Ay49xqX6tZ9rwVb/pj2w1xeO+sAR7+nTPunTbnzSFUf81/Bs9R+X3rV08Dj1wF4fXMuTccR/+tRP+NRbn3zF0TVHfHueB9m/aQ/M+jddB27aAw+6D454wFFfxtE1p0/5+E+ZGJcnt5scHIzXrZ8Gj+x/Dc9t99hbf9O1Wz1wm7Vgz3ONPcARDzjqqzi67vTJH/fJD+xELllzxPuwPM/2PniYHuESr3DpmtMn/dVPOrTgJicDLll31HtN357nYeyx1wcPYw/h2j5wiTfj0nWnT/zYT7z6yWdcuu4S/1HvNX3X8FxjD3DEAy7zjX5JuMbRPYVL/cKl606f8DGfcHjBTU8K3GSt1hy5xEf3fxS+a3nAo/KBS7zCTdYIN1l7+viP/viLFq0PcuwTLdzkJC9Z86i9j8oHHgevcJM1GTddf/q4j/q4wwsZ3Y3/JNhh3PRkL133IP2Pn3f/xnLJ3uBSv3DTdRk33eP0sR/xsY/spIXb7PWw1z7b1ggPZu1l373Bbc4DnD7mwz/mkVyEGW6756Na/xdlnfCo149wjT1PH/1hH33rTR7EiwPX2Pdh7zG6J932HG67Hjwue4xwyb579/zTR33oRz12L/RBDEXFtfZ7tu4jXHu/Ea55jOdFfqzwwK/gQwcf0edwDLe7VqeP/JCPtPnZu5Efx8P4RAsP6ljX3ndrv5tc+cvP79hRLt/35nhQxzp9xAd/xAN7EQ/zAgkP45gP+hjPhtcwwsM45unDP+jDH8oLexQXcIRHcR5/WY45wsM+j9OH/ZUPe2Qv/PYv9nqPSiM87DdjD4/b+VTk83uw78wcpw+9+6GP7UV63N/Ao3h8Xsftxuwmr+NhD/bpQ573Ic+KoREen+F5vHGt6/So7sQzPGa/tuPyPIcHj+td50c/zP1rOX3w6YOfJXe0x+1eccZftu8aj/KdOH3QnQ/6S3Wxn014fD/C18Llr/Cx/JPCBf23kjmO+p59+Is/zHvv3aWv8M6d/w9ax9bv6W9meQAAAABJRU5ErkJggg=="),
  colorpicker_location = syn.crypt.base64.decode("iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAACJSURBVDhP5ZTRDoAgCEW1b+2z+tcSAsdl2BbmU+dBmZtn1w2sJeBsSPlIbUjZgYNAdMju2WVnrLgXTjYSebpYpbwkZQpIN6mVtzIC7lSTLiOzcFKfcBoVzqYj2LEs4Wf8WAizmWRNH/pZzvYjp4tmOfN0uLPm+1KclBiJMZXICBAqgTjEim5KuQBbMC8cbNTMvQAAAABJRU5ErkJggg=="),
  slider_location = syn.crypt.base64.decode("iVBORw0KGgoAAAANSUhEUgAAAA8AAAAFCAYAAACaTbYsAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAAiSURBVChTY/wPBAxkApjmORAuSSCFCcogC1CkmQI/MzAAAD7RDPzFGuHHAAAAAElFTkSuQmCC"),
  transparent_pattern = syn.crypt.base64.decode("iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAD1SURBVDhP7ZJZioZADIT7/grihts5XA7gLVwu4pLhy0xEflSct3mYQFGh6arO0q4oCnlCkiQyTZMQ67oq7/t+8LZtmv8b/TWjcRxVtCzLITbGnPy1EaI7I9hx8Q5pmkoQBDLPs5b/FI7X7jAMg3Lf99K2rXRdp7DcuK5rcT+Gj9E0jfi+r1VGUSRxHCsDzjzPE0d/V6B3ZkLOq7RZVdUxuzzPFWVZqqFjaFcwQwIjLpvYYKZqpDcvwgwJZkE7iLIsO9gqCsPwdxWdWzpX9ao1cio6G535mJEJPsGw7bNREdtBZGJjFkDbr9bPP2HFvPyJ7/V78gX+B0MUDN65vQAAAABJRU5ErkJggg==")
}
for id, asset in next,assets do
  local path = "ars_cache/asset_" .. tostring(id) .. ".png"
  if not isfolder("ars_cache") then
    makefolder("ars_cache")
  end
  if not isfile(path) then
    writefile(path, asset)
  end
  assets[id] = path
end
local library
do
  local _class_0
  local window
  local _base_0 = {
    new_window = function(self, title, position, size)
      if title == nil then
        title = "ars.red"
      end
      if position == nil then
        position = UDim2.new(0.5, -250, 0.5, -300)
      end
      if size == nil then
        size = UDim2.new(0, 500, 0, 600)
      end
      if (getgenv().window) then
        getgenv().window:destroy()
      end
      getgenv().window = window(title, position, size)
      return getgenv().window
    end,
    apply_settings = function(self, tab)
      local menu_group = tab:new_group("Menu", false)
      local config_group = tab:new_group("Config", true)
      menu_group:new_label({
        text = "Menu Key"
      }):add_keybind("menu_key", {
        default = Enum.KeyCode.End,
        mode = "Toggle",
        state = true,
        ignore = true,
        callback = function(state)
          getgenv().window.window.Enabled = state
        end
      })
      menu_group:new_button({
        text = "Copy JobId",
        callback = function()
          return setclipboard("Roblox.GameLauncher.joinGameInstance(" .. tostring(game.PlaceId) .. ", \"" .. tostring(game.JobId) .. "\")")
        end
      })
      menu_group:new_button({
        text = "Unload",
        callback = function()
          getgenv().window:destroy()
          getgenv().library = nil
          getgenv().window = nil
        end
      })
      config_group:new_textbox("config_name", {
        text = "Config Name",
        default = "",
        ignore = true
      })
      config_group:new_button({
        text = "Save",
        callback = function()
          local config_name = "ars/" .. tostring(getgenv().window.flags["config_name"]) .. ".json"
          if (not isfolder("ars")) then
            makefolder("ars")
          end
          local fixed_config = { }
          for key, value in next,getgenv().window.flags do
            if (not getgenv().window.ignore[key]) then
              local fixed_value = value
              if (typeof(value) == "table" and value.color) then
                fixed_value = {
                  color = value.color:ToHex(),
                  transparency = value.transparency
                }
              end
              fixed_config[key] = fixed_value
            end
          end
          return writefile(config_name, game:GetService("HttpService"):JSONEncode(fixed_config))
        end
      })
      return config_group:new_button({
        text = "Load",
        callback = function()
          local config_name = "ars/" .. tostring(getgenv().window.flags["config_name"]) .. ".json"
          if (not isfolder("ars")) then
            makefolder("ars")
          end
          if (isfile(config_name)) then
            for flag, value in next,game:GetService("HttpService"):JSONDecode(readfile(config_name)) do
              if (getgenv().window.options[flag] and not getgenv().window.ignore[flag]) then
                local fixed_value = value
                if (typeof(value) == "table" and value.color) then
                  fixed_value = {
                    color = Color3.fromHex(value.color),
                    transparency = value.transparency
                  }
                end
                getgenv().window.options[flag]:set_value(fixed_value)
              end
            end
          end
        end
      })
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "library"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  do
    local _class_1
    local _base_1 = {
      update = function(self)
        self.background_objects[1].Size = self.size
        self.background_objects[1].Position = self.position
        self.background_objects[2].Size = self.size - UDim2.new(0, 2, 0, 2)
        self.background_objects[2].Position = self.position + UDim2.new(0, 1, 0, 1)
        self.background_objects[3].Size = self.size - UDim2.new(0, 4, 0, 4)
        self.background_objects[3].Position = self.position + UDim2.new(0, 2, 0, 2)
      end,
      new_tab = function(self, name)
        if name == nil then
          name = ""
        end
        if not (self.active_tab) then
          self.active_tab = #self.tab_objects + 1
        end
        if self.tabs[name] then
          return self.tabs[name]
        end
        self.tab_objects[#self.tab_objects + 1] = self:add_object("TextButton", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          Text = name,
          Font = Enum.Font.GothamSemibold,
          Size = UDim2.new(0, 100, 0, 18),
          Parent = self.tab_bar_objects[2],
          ZIndex = 8
        })
        local current_tab_index = #self.tab_objects
        local mouse_button_click
        mouse_button_click = function()
          return self:set_active_tab(current_tab_index)
        end
        self.connections[#self.connections + 1] = self.tab_objects[current_tab_index].MouseButton1Click:Connect(mouse_button_click)
        self.tab_groups[current_tab_index] = self:add_object("Frame", {
          Name = generate_guid(),
          BackgroundColor3 = Color3.fromRGB(12, 12, 12),
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.group_objects[1],
          Visible = self.active_tab == current_tab_index,
          ZIndex = 9
        })
        local distance_per_column = self.tab_bar_objects[2].AbsoluteSize.X / current_tab_index
        for idx, tab in next,self.tab_objects do
          local column_center = distance_per_column * idx - distance_per_column
          tab.Position = UDim2.new(0, column_center, 0, 0)
          tab.Size = UDim2.new(0, distance_per_column, 0, 18)
          if idx == self.active_tab then
            tab.TextColor3 = Color3.fromRGB(255, 0, 0)
          end
        end
        local tab
        do
          local _class_2
          local _base_2 = {
            new_group = function(self, name, right)
              if right == nil then
                right = false
              end
              local current_group = right and self.right_group_objects or self.left_group_objects
              local current_group_index = #current_group + 1
              current_group[current_group_index] = self.parent:add_object("Frame", {
                Name = generate_guid(),
                BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                BorderSizePixel = 1,
                BorderColor3 = Color3.fromRGB(30, 30, 30),
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Parent = right and self.right_group or self.left_group,
                AutomaticSize = Enum.AutomaticSize.XY,
                ClipsDescendants = true,
                ZIndex = 11
              })
              self.parent:add_object("TextLabel", {
                Name = generate_guid(),
                BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 18),
                Position = UDim2.new(0, 0, 0, 0),
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextSize = 12,
                Text = name,
                Font = Enum.Font.GothamSemibold,
                Parent = current_group[current_group_index],
                ZIndex = 12
              })
              current_group[current_group_index + 1] = self.parent:add_object("Frame", {
                Name = generate_guid(),
                BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                BorderSizePixel = 0,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 18),
                Parent = current_group[current_group_index],
                AutomaticSize = Enum.AutomaticSize.XY,
                ClipsDescendants = true,
                ZIndex = 12
              })
              current_group[current_group_index + 2] = self.parent:add_object("UIListLayout", {
                Name = generate_guid(),
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Padding = UDim.new(0, 4),
                Parent = current_group[current_group_index + 1]
              })
              local group
              do
                local _class_3
                local item
                local _base_3 = {
                  new_checkbox = function(self, flag, options)
                    if options == nil then
                      options = { }
                    end
                    local checkbox
                    do
                      local _class_4
                      local _parent_0 = item
                      local _base_4 = {
                        set_value = function(self, value)
                          if value == nil then
                            value = false
                          end
                          self.window.flags[self.flag] = value
                          self.check.Visible = value
                          return options.callback(value)
                        end
                      }
                      _base_4.__index = _base_4
                      setmetatable(_base_4, _parent_0.__base)
                      _class_4 = setmetatable({
                        __init = function(self, parent, flag, options)
                          if options == nil then
                            options = { }
                          end
                          self.parent = parent
                          self.window = self.parent.parent.parent
                          self.group_objects = { }
                          self.flag = flag
                          options.callback = options.callback or function() end
                          self.window.flags[flag] = options.default or false
                          self.group_objects[#self.group_objects + 1] = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 18),
                            Position = UDim2.new(0, 0, 0, 0),
                            Parent = current_group[current_group_index + 1],
                            AutomaticSize = Enum.AutomaticSize.XY,
                            ClipsDescendants = true,
                            ZIndex = 13
                          })
                          self.window:add_object("TextLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, -65, 0, 18),
                            Position = UDim2.new(0, 25, 0, 0),
                            TextColor3 = options.unsafe and Color3.fromRGB(182, 182, 101) or Color3.fromRGB(255, 255, 255),
                            TextSize = 12,
                            Text = options.text,
                            Font = Enum.Font.Gotham,
                            Parent = self.group_objects[#self.group_objects],
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 14
                          })
                          local button = self.window:add_object("TextButton", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                            BorderSizePixel = 1,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(0, 14, 0, 14),
                            Position = UDim2.new(0, 3, 0, 1),
                            Text = "",
                            Parent = self.group_objects[#self.group_objects],
                            AutoButtonColor = false,
                            ZIndex = 14
                          })
                          self.check = self.window:add_object("ImageLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 14, 0, 14),
                            Position = UDim2.new(0, 0, 0, 0),
                            Image = getsynasset(assets.checkmark),
                            ImageColor3 = Color3.fromRGB(255, 0, 0),
                            ScaleType = Enum.ScaleType.Fit,
                            Visible = self.window.flags[flag],
                            Parent = button,
                            ZIndex = 15
                          })
                          mouse_button_click = function()
                            self.window.flags[flag] = not self.window.flags[flag]
                            self.check.Visible = self.window.flags[flag]
                            return options.callback(self.window.flags[flag])
                          end
                          self.window.connections[#self.window.connections + 1] = button.MouseButton1Click:Connect(mouse_button_click)
                        end,
                        __base = _base_4,
                        __name = "checkbox",
                        __parent = _parent_0
                      }, {
                        __index = function(cls, name)
                          local val = rawget(_base_4, name)
                          if val == nil then
                            local parent = rawget(cls, "__parent")
                            if parent then
                              return parent[name]
                            end
                          else
                            return val
                          end
                        end,
                        __call = function(cls, ...)
                          local _self_0 = setmetatable({}, _base_4)
                          cls.__init(_self_0, ...)
                          return _self_0
                        end
                      })
                      _base_4.__class = _class_4
                      if _parent_0.__inherited then
                        _parent_0.__inherited(_parent_0, _class_4)
                      end
                      checkbox = _class_4
                    end
                    self.parent.parent.options[flag] = checkbox(self, flag, options)
                    if (options.ignore) then
                      self.parent.parent.ignore[flag] = true
                    end
                    return self.parent.parent.options[flag]
                  end,
                  new_list = function(self, flag, options)
                    if options == nil then
                      options = { }
                    end
                    local list
                    do
                      local _class_4
                      local _parent_0 = item
                      local _base_4 = {
                        set_values = function(self, values)
                          if values == nil then
                            values = { }
                          end
                          self.values = values
                          if self.window.drop_flag == self.flag then
                            for _, object in next,self.window.drop_container:GetChildren() do
                              if object:IsA("TextButton") then
                                object:Destroy()
                              end
                            end
                            local _list_0 = self.values
                            for _index_0 = 1, #_list_0 do
                              local value = _list_0[_index_0]
                              local is_active = options.multi and table.find(self.window.flags[flag], value) or self.window.flags[flag] == value
                              local drop = self.window:add_object("TextButton", {
                                Name = generate_guid(),
                                BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                                BackgroundTransparency = 0,
                                BorderSizePixel = 1,
                                BorderColor3 = Color3.fromRGB(30, 30, 30),
                                Size = UDim2.new(1, 1, 0, 20),
                                Position = UDim2.new(0, 0, 0, 0),
                                Text = tostring(value),
                                Parent = self.window.drop_container,
                                AutoButtonColor = false,
                                Font = Enum.Font.Gotham,
                                TextSize = 12,
                                TextXAlignment = Enum.TextXAlignment.Left,
                                TextColor3 = is_active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255),
                                Visible = true,
                                ZIndex = 10000
                              })
                              mouse_button_click = function()
                                self.window.flags[flag] = (function()
                                  if options.multi then
                                    if table.find(self.window.flags[flag], value) then
                                      table.remove(self.window.flags[flag], table.find(self.window.flags[flag], value))
                                    else
                                      table.insert(self.window.flags[flag], value)
                                    end
                                    return self.window.flags[flag]
                                  else
                                    return value
                                  end
                                end)()
                                for _, object in next,self.window.drop_container:GetChildren() do
                                  if object:IsA("TextButton") then
                                    is_active = options.multi and table.find(self.window.flags[flag], object.Text) or self.window.flags[flag] == object.Text
                                    object.TextColor3 = is_active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
                                    if not options.multi then
                                      object.Visible = false
                                    end
                                  end
                                end
                                self.button.Text = (function()
                                  local buffer = ""
                                  if options.multi then
                                    local _list_1 = self.window.flags[flag]
                                    for _index_1 = 1, #_list_1 do
                                      local value = _list_1[_index_1]
                                      buffer = tostring(buffer) .. " " .. tostring(value) .. ","
                                    end
                                  else
                                    buffer = tostring(self.window.flags[flag])
                                  end
                                  return buffer
                                end)()
                                if not options.multi then
                                  self.window.drop_container.Visible = false
                                  self.arrow.Rotation = -90
                                end
                                return options.callback(self.window.flags[flag])
                              end
                              self.window.connections[#self.window.connections + 1] = drop.MouseButton1Click:Connect(mouse_button_click)
                            end
                          end
                        end,
                        set_value = function(self, value)
                          if value == nil then
                            value = { }
                          end
                          self.window.flags[self.flag] = value
                          if self.window.drop_flag == self.flag then
                            for _, object in next,self.window.drop_container:GetChildren() do
                              if object:IsA("TextButton") then
                                local is_active = options.multi and table.find(self.window.flags[self.flag], object.Text) or self.window.flags[self.flag] == object.Text
                                object.TextColor3 = is_active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
                                if not options.multi then
                                  object.Visible = false
                                end
                              end
                            end
                            self.button.Text = (function()
                              local buffer = ""
                              if options.multi then
                                local _list_0 = self.window.flags[self.flag]
                                for _index_0 = 1, #_list_0 do
                                  local value = _list_0[_index_0]
                                  buffer = tostring(buffer) .. " " .. tostring(value) .. ","
                                end
                              else
                                buffer = tostring(self.window.flags[self.flag])
                              end
                              return buffer
                            end)()
                            return options.callback(self.window.flags[self.flag])
                          end
                        end
                      }
                      _base_4.__index = _base_4
                      setmetatable(_base_4, _parent_0.__base)
                      _class_4 = setmetatable({
                        __init = function(self, parent, flag, options)
                          if options == nil then
                            options = { }
                          end
                          self.parent = parent
                          self.window = self.parent.parent.parent
                          self.group_objects = { }
                          self.flag = flag
                          self.values = options.values or { }
                          options.callback = options.callback or function() end
                          self.window.flags[flag] = options.default or { }
                          self.group_objects[#self.group_objects + 1] = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 39),
                            Position = UDim2.new(0, 0, 0, 0),
                            Parent = current_group[current_group_index + 1],
                            AutomaticSize = Enum.AutomaticSize.XY,
                            ClipsDescendants = true,
                            ZIndex = 13
                          })
                          self.window:add_object("TextLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 1,
                            Size = UDim2.new(1, -65, 0, 16),
                            Position = UDim2.new(0, 2, 0, 0),
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 12,
                            Text = options.text,
                            Font = Enum.Font.Gotham,
                            Parent = self.group_objects[#self.group_objects],
                            TextXAlignment = Enum.TextXAlignment.Left,
                            ZIndex = 14
                          })
                          self.button = self.window:add_object("TextButton", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                            BorderSizePixel = 1,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(1, -65, 0, 20),
                            Position = UDim2.new(0, 3, 0, 16),
                            Text = tostring((function()
                              local buffer = ""
                              if options.multi then
                                local _list_0 = options.default
                                for _index_0 = 1, #_list_0 do
                                  local value = _list_0[_index_0]
                                  buffer = tostring(buffer) .. " " .. tostring(value) .. ","
                                end
                              else
                                buffer = tostring(options.default)
                              end
                              return buffer
                            end)()) or " None",
                            Parent = self.group_objects[#self.group_objects],
                            AutoButtonColor = false,
                            Font = Enum.Font.Gotham,
                            TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            ZIndex = 14
                          })
                          self.arrow = self.window:add_object("ImageLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 1,
                            Size = UDim2.new(0, 10, 0, 10),
                            Position = UDim2.new(1, -13, 0, 5),
                            Image = getsynasset(assets.triangle),
                            ImageColor3 = Color3.fromRGB(255, 255, 255),
                            ScaleType = Enum.ScaleType.Fit,
                            Parent = self.button,
                            Rotation = -90,
                            ZIndex = 15
                          })
                          mouse_button_click = function()
                            self.window.drop_container.Visible = not self.window.drop_container.Visible
                            self.window.drop_container.Position = UDim2.new(0, self.button.AbsolutePosition.X, 0, self.button.AbsolutePosition.Y + self.button.AbsoluteSize.Y)
                            self.arrow.Rotation = self.window.drop_container.Visible and -180 or -90
                            if (self.window.drop_container.Visible) then
                              self.window.drop_flag = self.flag
                              for _, object in next,self.window.drop_container:GetChildren() do
                                if object:IsA("TextButton") then
                                  object:Destroy()
                                end
                              end
                              local _list_0 = self.values
                              for _index_0 = 1, #_list_0 do
                                local value = _list_0[_index_0]
                                local is_active = options.multi and table.find(self.window.flags[flag], value) or self.window.flags[flag] == value
                                local drop = self.window:add_object("TextButton", {
                                  Name = generate_guid(),
                                  BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                                  BackgroundTransparency = 0,
                                  BorderSizePixel = 1,
                                  BorderColor3 = Color3.fromRGB(30, 30, 30),
                                  Size = UDim2.new(1, 1, 0, 20),
                                  Position = UDim2.new(0, 0, 0, 0),
                                  Text = tostring(value),
                                  Parent = self.window.drop_container,
                                  AutoButtonColor = false,
                                  Font = Enum.Font.Gotham,
                                  TextSize = 12,
                                  TextXAlignment = Enum.TextXAlignment.Left,
                                  TextColor3 = is_active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255),
                                  Visible = true,
                                  ZIndex = 10000
                                })
                                mouse_button_click = function()
                                  self.window.flags[flag] = (function()
                                    if options.multi then
                                      if table.find(self.window.flags[flag], value) then
                                        table.remove(self.window.flags[flag], table.find(self.window.flags[flag], value))
                                      else
                                        table.insert(self.window.flags[flag], value)
                                      end
                                      return self.window.flags[flag]
                                    else
                                      return value
                                    end
                                  end)()
                                  for _, object in next,self.window.drop_container:GetChildren() do
                                    if object:IsA("TextButton") then
                                      is_active = options.multi and table.find(self.window.flags[flag], object.Text) or self.window.flags[flag] == object.Text
                                      object.TextColor3 = is_active and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
                                      if not options.multi then
                                        object.Visible = false
                                      end
                                    end
                                  end
                                  self.button.Text = (function()
                                    local buffer = ""
                                    if options.multi then
                                      local _list_1 = self.window.flags[flag]
                                      for _index_1 = 1, #_list_1 do
                                        local value = _list_1[_index_1]
                                        buffer = tostring(buffer) .. " " .. tostring(value) .. ","
                                      end
                                    else
                                      buffer = tostring(self.window.flags[flag])
                                    end
                                    return buffer
                                  end)()
                                  if not options.multi then
                                    self.window.drop_container.Visible = false
                                    self.arrow.Rotation = -90
                                  end
                                  return options.callback(self.window.flags[flag])
                                end
                                self.window.connections[#self.window.connections + 1] = drop.MouseButton1Click:Connect(mouse_button_click)
                              end
                            end
                          end
                          local input_began
                          input_began = function(input)
                            if not self.window.drop_container.Visible then
                              return 
                            end
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                              local fix_position = self.window.drop_container.AbsolutePosition - Vector2.new(0, self.button.AbsoluteSize.Y)
                              local fix_size = self.window.drop_container.AbsoluteSize + Vector2.new(0, self.button.AbsoluteSize.Y)
                              if fix_position.X > input.Position.X or fix_position.Y > input.Position.Y or fix_position.X + fix_size.X < input.Position.X or fix_position.Y + fix_size.Y < input.Position.Y then
                                self.window.drop_container.Visible = false
                                self.arrow.Rotation = -90
                              end
                            end
                          end
                          self.window.connections[#self.window.connections + 1] = self.button.MouseButton1Click:Connect(mouse_button_click)
                          self.window.connections[#self.window.connections + 1] = game:GetService("UserInputService").InputBegan:Connect(input_began)
                        end,
                        __base = _base_4,
                        __name = "list",
                        __parent = _parent_0
                      }, {
                        __index = function(cls, name)
                          local val = rawget(_base_4, name)
                          if val == nil then
                            local parent = rawget(cls, "__parent")
                            if parent then
                              return parent[name]
                            end
                          else
                            return val
                          end
                        end,
                        __call = function(cls, ...)
                          local _self_0 = setmetatable({}, _base_4)
                          cls.__init(_self_0, ...)
                          return _self_0
                        end
                      })
                      _base_4.__class = _class_4
                      if _parent_0.__inherited then
                        _parent_0.__inherited(_parent_0, _class_4)
                      end
                      list = _class_4
                    end
                    self.parent.parent.options[flag] = list(self, flag, options)
                    if (options.ignore) then
                      self.parent.parent.ignore[flag] = true
                    end
                    return self.parent.parent.options[flag]
                  end,
                  new_button = function(self, options)
                    if options == nil then
                      options = { }
                    end
                    local button
                    do
                      local _class_4
                      local _parent_0 = item
                      local _base_4 = { }
                      _base_4.__index = _base_4
                      setmetatable(_base_4, _parent_0.__base)
                      _class_4 = setmetatable({
                        __init = function(self, parent, options)
                          if options == nil then
                            options = { }
                          end
                          self.parent = parent
                          self.window = self.parent.parent.parent
                          self.group_objects = { }
                          self.group_objects[#self.group_objects + 1] = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 20),
                            Position = UDim2.new(0, 0, 0, 0),
                            Parent = current_group[current_group_index + 1],
                            ClipsDescendants = true,
                            ZIndex = 13
                          })
                          self.button = self.window:add_object("TextButton", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 1,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(1, -65, 1, -5),
                            Position = UDim2.new(0, 3, 0, 2),
                            Text = options.text,
                            Parent = self.group_objects[#self.group_objects],
                            AutoButtonColor = false,
                            Font = Enum.Font.Gotham,
                            TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Center,
                            TextColor3 = options.unsafe and Color3.fromRGB(182, 182, 101) or Color3.fromRGB(255, 255, 255),
                            ZIndex = 14
                          })
                          mouse_button_click = function()
                            return options.callback()
                          end
                          self.window.connections[#self.window.connections + 1] = self.button.MouseButton1Click:Connect(mouse_button_click)
                        end,
                        __base = _base_4,
                        __name = "button",
                        __parent = _parent_0
                      }, {
                        __index = function(cls, name)
                          local val = rawget(_base_4, name)
                          if val == nil then
                            local parent = rawget(cls, "__parent")
                            if parent then
                              return parent[name]
                            end
                          else
                            return val
                          end
                        end,
                        __call = function(cls, ...)
                          local _self_0 = setmetatable({}, _base_4)
                          cls.__init(_self_0, ...)
                          return _self_0
                        end
                      })
                      _base_4.__class = _class_4
                      if _parent_0.__inherited then
                        _parent_0.__inherited(_parent_0, _class_4)
                      end
                      button = _class_4
                    end
                    return button(self, options)
                  end,
                  new_slider = function(self, flag, options)
                    if options == nil then
                      options = { }
                    end
                    local slider
                    do
                      local _class_4
                      local _parent_0 = item
                      local _base_4 = {
                        set_value = function(self, value)
                          self.window.flags[flag] = math.clamp(value, options.min, options.max)
                          self.entry.Text = tostring(self.window.flags[flag]) .. tostring(options.suffix or "")
                          value = self.window.flags[flag] / (options.max - options.min)
                          self.slider_value.Size = UDim2.new(value, 0, 1, 0)
                          self.slider_value.Position = UDim2.new(0, 0, 0, 0)
                          if (self.window.flags[flag] ~= self.last_value) then
                            self.last_value = self.window.flags[flag]
                            return options.callback(self.window.flags[flag])
                          end
                        end
                      }
                      _base_4.__index = _base_4
                      setmetatable(_base_4, _parent_0.__base)
                      _class_4 = setmetatable({
                        __init = function(self, parent, flag, options)
                          if options == nil then
                            options = { }
                          end
                          self.parent = parent
                          self.window = self.parent.parent.parent
                          self.group_objects = { }
                          self.window.flags[flag] = options.default or 0
                          options.callback = options.callback or function() end
                          self.group_objects[#self.group_objects + 1] = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 34),
                            Position = UDim2.new(0, 3, 0, 0),
                            Parent = current_group[current_group_index + 1],
                            AutomaticSize = Enum.AutomaticSize.XY,
                            ClipsDescendants = true,
                            ZIndex = 13
                          })
                          name = self.window:add_object("TextLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, -65, 0, 20),
                            Position = UDim2.new(0, 2, 0, 0),
                            Text = tostring(options.text) .. ": ",
                            Parent = self.group_objects[#self.group_objects],
                            Font = Enum.Font.Gotham,
                            TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextColor3 = options.unsafe and Color3.fromRGB(182, 182, 101) or Color3.fromRGB(255, 255, 255),
                            ZIndex = 14
                          })
                          local text_size = game:GetService("TextService"):GetTextSize(name.ContentText, name.TextSize, name.Font, name.AbsoluteSize)
                          self.entry = self.window:add_object("TextBox", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(1, -65 - text_size.X, 0, 20),
                            Position = UDim2.new(0, 0 + text_size.X, 0, 0),
                            Text = tostring(self.window.flags[flag]) .. tostring(options.suffix or ""),
                            Parent = self.group_objects[#self.group_objects],
                            Font = Enum.Font.Gotham,
                            TextSize = 12,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            ZIndex = 14
                          })
                          slider = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(10, 10, 10),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 1,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(1, -65, 0, 12),
                            Position = UDim2.new(0, 3, 0, 20),
                            Parent = self.group_objects[#self.group_objects],
                            ZIndex = 14
                          })
                          self.button = self.window:add_object("TextButton", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(1, 0, 1, 0),
                            Position = UDim2.new(0, 0, 0, 0),
                            Text = "",
                            Parent = slider,
                            AutoButtonColor = false,
                            ZIndex = 15
                          })
                          local value = (self.window.flags[flag] / (options.max - options.min)) - (options.min / (options.max - options.min))
                          self.slider_value = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 0,
                            Size = UDim2.new(value, 0, 1, 0),
                            Position = UDim2.new(0, 0, 0, 0),
                            Parent = self.button,
                            ZIndex = 16
                          })
                          local is_mouse_down = false
                          self.last_value = self.window.flags[flag]
                          local mouse_down
                          mouse_down = function(x)
                            is_mouse_down = true
                            local distance = self.button.AbsoluteSize.X
                            local decimals = options.decimals > 0 and 10 * options.decimals or 1
                            local mouse_distance = math.clamp((x - self.button.AbsolutePosition.X) / distance, 0, 1)
                            value = math.round(((options.max - options.min) * mouse_distance + options.min) * decimals) / decimals
                            self.window.flags[flag] = value
                            self.entry.Text = tostring(self.window.flags[flag]) .. tostring(options.suffix or "")
                            self.slider_value.Size = UDim2.new((value / (options.max - options.min)) - (options.min / (options.max - options.min)), 0, 1, 0)
                          end
                          local mouse_move
                          mouse_move = function(x)
                            if is_mouse_down then
                              return mouse_down(x)
                            end
                          end
                          local mouse_button_up
                          mouse_button_up = function()
                            is_mouse_down = false
                            if (self.window.flags[flag] ~= self.last_value) then
                              self.last_value = self.window.flags[flag]
                              return options.callback(self.window.flags[flag])
                            end
                          end
                          local mouse_leave
                          mouse_leave = function()
                            is_mouse_down = false
                            if (self.window.flags[flag] ~= self.last_value) then
                              self.last_value = self.window.flags[flag]
                              return options.callback(self.window.flags[flag])
                            end
                          end
                          local on_focus_lost
                          on_focus_lost = function(enter_pressed)
                            if enter_pressed then
                              value = tonumber(self.entry.Text)
                              if value then
                                self.window.flags[flag] = math.clamp(value, options.min, options.max)
                                self.entry.Text = tostring(self.window.flags[flag]) .. tostring(options.suffix or "")
                                value = self.window.flags[flag] / (options.max - options.min)
                                self.slider_value.Size = UDim2.new(value, 0, 1, 0)
                                self.slider_value.Position = UDim2.new(0, 0, 0, 0)
                                if (self.window.flags[flag] ~= self.last_value) then
                                  self.last_value = self.window.flags[flag]
                                  return options.callback(self.window.flags[flag])
                                end
                              else
                                self.entry.Text = tostring(self.window.flags[flag]) .. tostring(options.suffix or "")
                              end
                            else
                              self.entry.Text = tostring(self.window.flags[flag]) .. tostring(options.suffix or "")
                            end
                          end
                          self.window.connections[#self.window.connections + 1] = self.button.MouseButton1Down:Connect(mouse_down)
                          self.window.connections[#self.window.connections + 1] = self.button.MouseMoved:Connect(mouse_move)
                          self.window.connections[#self.window.connections + 1] = self.button.MouseButton1Up:Connect(mouse_button_up)
                          self.window.connections[#self.window.connections + 1] = self.button.MouseLeave:Connect(mouse_leave)
                          self.window.connections[#self.window.connections + 1] = self.entry.FocusLost:Connect(on_focus_lost)
                        end,
                        __base = _base_4,
                        __name = "slider",
                        __parent = _parent_0
                      }, {
                        __index = function(cls, name)
                          local val = rawget(_base_4, name)
                          if val == nil then
                            local parent = rawget(cls, "__parent")
                            if parent then
                              return parent[name]
                            end
                          else
                            return val
                          end
                        end,
                        __call = function(cls, ...)
                          local _self_0 = setmetatable({}, _base_4)
                          cls.__init(_self_0, ...)
                          return _self_0
                        end
                      })
                      _base_4.__class = _class_4
                      if _parent_0.__inherited then
                        _parent_0.__inherited(_parent_0, _class_4)
                      end
                      slider = _class_4
                    end
                    self.parent.parent.options[flag] = slider(self, flag, options)
                    if (options.ignore) then
                      self.parent.parent.ignore[flag] = true
                    end
                    return self.parent.parent.options[flag]
                  end,
                  new_textbox = function(self, flag, options)
                    if options == nil then
                      options = { }
                    end
                    local textbox
                    do
                      local _class_4
                      local _parent_0 = item
                      local _base_4 = {
                        set_value = function(self, value)
                          self.window.flags[flag] = value
                          self.entry.Text = self.window.flags[flag]
                          if (self.window.flags[flag] ~= self.last_value) then
                            self.last_value = self.window.flags[flag]
                            return options.callback(self.window.flags[flag])
                          end
                        end
                      }
                      _base_4.__index = _base_4
                      setmetatable(_base_4, _parent_0.__base)
                      _class_4 = setmetatable({
                        __init = function(self, parent, flag, options)
                          self.parent = parent
                          self.window = self.parent.parent.parent
                          self.group_objects = { }
                          options.callback = options.callback or function() end
                          self.window.flags[flag] = options.default or ""
                          self.group_objects[#self.group_objects + 1] = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 30),
                            Position = UDim2.new(0, 0, 0, 0),
                            Parent = current_group[current_group_index + 1],
                            ZIndex = 13
                          })
                          self.label = self.window:add_object("TextLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, -65, 0, 10),
                            Position = UDim2.new(0, 2, 0, 1),
                            Text = options.text or flag,
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 12,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = self.group_objects[#self.group_objects],
                            ZIndex = 14
                          })
                          self.entry = self.window:add_object("TextBox", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                            BackgroundTransparency = 0,
                            BorderSizePixel = 1,
                            BorderColor3 = Color3.fromRGB(30, 30, 30),
                            Size = UDim2.new(1, -65, 0, 14),
                            Position = UDim2.new(0, 3, 0, 13),
                            Text = self.window.flags[flag],
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 12,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = self.group_objects[#self.group_objects],
                            ClipsDescendants = true,
                            ClearTextOnFocus = false,
                            ZIndex = 14
                          })
                          local on_focus_lost
                          on_focus_lost = function(enter_pressed)
                            if enter_pressed then
                              self.window.flags[flag] = self.entry.Text
                              if (self.window.flags[flag] ~= self.last_value) then
                                self.last_value = self.window.flags[flag]
                                return options.callback(self.window.flags[flag])
                              end
                            else
                              self.entry.Text = self.window.flags[flag]
                            end
                          end
                          self.window.connections[#self.window.connections + 1] = self.entry.FocusLost:Connect(on_focus_lost)
                        end,
                        __base = _base_4,
                        __name = "textbox",
                        __parent = _parent_0
                      }, {
                        __index = function(cls, name)
                          local val = rawget(_base_4, name)
                          if val == nil then
                            local parent = rawget(cls, "__parent")
                            if parent then
                              return parent[name]
                            end
                          else
                            return val
                          end
                        end,
                        __call = function(cls, ...)
                          local _self_0 = setmetatable({}, _base_4)
                          cls.__init(_self_0, ...)
                          return _self_0
                        end
                      })
                      _base_4.__class = _class_4
                      if _parent_0.__inherited then
                        _parent_0.__inherited(_parent_0, _class_4)
                      end
                      textbox = _class_4
                    end
                    self.parent.parent.options[flag] = textbox(self, flag, options)
                    if (options.ignore) then
                      self.parent.parent.ignore[flag] = true
                    end
                    return self.parent.parent.options[flag]
                  end,
                  new_label = function(self, options)
                    if options == nil then
                      options = { }
                    end
                    local label
                    do
                      local _class_4
                      local _parent_0 = item
                      local _base_4 = { }
                      _base_4.__index = _base_4
                      setmetatable(_base_4, _parent_0.__base)
                      _class_4 = setmetatable({
                        __init = function(self, parent, options)
                          self.parent = parent
                          self.window = self.parent.parent.parent
                          self.group_objects = { }
                          self.group_objects[#self.group_objects + 1] = self.window:add_object("Frame", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 10),
                            Position = UDim2.new(0, 0, 0, 0),
                            Parent = current_group[current_group_index + 1],
                            ZIndex = 13
                          })
                          self.label = self.window:add_object("TextLabel", {
                            Name = generate_guid(),
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BackgroundTransparency = 1,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, -65, 0, 10),
                            Position = UDim2.new(0, 2, 0, 1),
                            Text = options.text,
                            TextColor3 = options.unsafe and Color3.fromRGB(182, 182, 101) or Color3.fromRGB(255, 255, 255),
                            TextSize = 12,
                            Font = Enum.Font.Gotham,
                            TextXAlignment = Enum.TextXAlignment.Left,
                            Parent = self.group_objects[#self.group_objects],
                            ZIndex = 14
                          })
                        end,
                        __base = _base_4,
                        __name = "label",
                        __parent = _parent_0
                      }, {
                        __index = function(cls, name)
                          local val = rawget(_base_4, name)
                          if val == nil then
                            local parent = rawget(cls, "__parent")
                            if parent then
                              return parent[name]
                            end
                          else
                            return val
                          end
                        end,
                        __call = function(cls, ...)
                          local _self_0 = setmetatable({}, _base_4)
                          cls.__init(_self_0, ...)
                          return _self_0
                        end
                      })
                      _base_4.__class = _class_4
                      if _parent_0.__inherited then
                        _parent_0.__inherited(_parent_0, _class_4)
                      end
                      label = _class_4
                    end
                    self.parent.parent.options[options.text] = label(self, options)
                    return self.parent.parent.options[options.text]
                  end
                }
                _base_3.__index = _base_3
                _class_3 = setmetatable({
                  __init = function(self, parent)
                    self.parent = parent
                    self.group_objects = { }
                  end,
                  __base = _base_3,
                  __name = "group"
                }, {
                  __index = _base_3,
                  __call = function(cls, ...)
                    local _self_0 = setmetatable({}, _base_3)
                    cls.__init(_self_0, ...)
                    return _self_0
                  end
                })
                _base_3.__class = _class_3
                local self = _class_3
                do
                  local _class_4
                  local _base_4 = {
                    add_keybind = function(self, flag, options)
                      if options == nil then
                        options = { }
                      end
                      local keybind
                      do
                        local _class_5
                        local _base_5 = {
                          set_value = function(self, value)
                            if value == nil then
                              value = { }
                            end
                            if value.keycode then
                              self.window.flags[self.flag].keycode = value.keycode
                              self.window.flags[self.flag].mode = value.mode
                              if value.keycode == "MouseButton1" then
                                keybind.Text = "[MB1]"
                              else
                                if value.keycode == "MouseButton2" then
                                  keybind.Text = "[MB2]"
                                else
                                  keybind.Text = "[" .. tostring(value.keycode) .. "]"
                                end
                              end
                            else
                              self.window.flags[self.flag].keycode = nil
                              self.window.flags[self.flag].mode = "Hold"
                              keybind.Text = "[None]"
                            end
                          end
                        }
                        _base_5.__index = _base_5
                        _class_5 = setmetatable({
                          __init = function(self, parent, flag, options)
                            self.window = parent.window
                            self.flag = flag
                            self.awaiting_input = false
                            self.window.flags[flag] = {
                              state = options.state or false,
                              keycode = options.default and options.default.Name or nil,
                              mode = options.mode or "Hold"
                            }
                            options.callback = options.callback or function() end
                            keybind = self.window:add_object("TextButton", {
                              Name = generate_guid(),
                              BackgroundColor3 = Color3.fromRGB(60, 60, 60),
                              BackgroundTransparency = 1,
                              BorderSizePixel = 0,
                              Size = UDim2.new(0, 60, 1, 0),
                              Position = UDim2.new(1, -62, 0, 0),
                              TextColor3 = Color3.fromRGB(100, 100, 100),
                              TextSize = 12,
                              Text = options.default == "MouseButton1" and "[MB1]" or options.default == "MouseButton2" and "[MB2]" or options.default and "[" .. tostring(options.default.Name) .. "]" or "[None]",
                              Font = Enum.Font.GothamSemibold,
                              Parent = parent.group_objects[#parent.group_objects],
                              ZIndex = 13
                            })
                            local mouse_button_right_click
                            mouse_button_right_click = function()
                              self.window.current_keybind = flag
                              self.window.keybind_objects[1].Visible = true
                              self.window.keybind_objects[1].Position = UDim2.new(0, keybind.AbsolutePosition.X + keybind.AbsoluteSize.X, 0, keybind.AbsolutePosition.Y)
                            end
                            mouse_button_click = function()
                              self.window.current_keybind = flag
                              self.awaiting_input = true
                              keybind.Text = "[...]"
                            end
                            local input_began
                            input_began = function(input)
                              if input.UserInputType == Enum.UserInputType.Keyboard then
                                if self.awaiting_input then
                                  if input.KeyCode == Enum.KeyCode.Backspace or input.KeyCode == Enum.KeyCode.Escape then
                                    self.awaiting_input = false
                                    keybind.Text = "[None]"
                                    self.window.flags[flag].keycode = nil
                                    self.window.flags[flag].state = false
                                    return 
                                  end
                                  keybind.Text = "[" .. tostring(input.KeyCode.Name) .. "]"
                                  self.window.flags[flag].keycode = input.KeyCode.Name
                                  self.awaiting_input = false
                                else
                                  if input.KeyCode.Name == self.window.flags[flag].keycode and self.window.flags[flag].mode == "Hold" then
                                    self.window.flags[flag].state = true
                                    return options.callback(self.window.flags[flag].state)
                                  else
                                    if input.KeyCode.Name == self.window.flags[flag].keycode and self.window.flags[flag].mode == "Toggle" then
                                      self.window.flags[flag].state = not self.window.flags[flag].state
                                      return options.callback(self.window.flags[flag].state)
                                    end
                                  end
                                end
                              else
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                  if self.awaiting_input then
                                    self.awaiting_input = false
                                    keybind.Text = "[MB1]"
                                    self.window.flags[flag].keycode = "MouseButton1"
                                    return 
                                  end
                                  if self.window.flags[flag].keycode == "MouseButton1" and self.window.flags[flag].mode == "Hold" then
                                    self.window.flags[flag].state = true
                                    return options.callback(self.window.flags[flag].state)
                                  else
                                    if self.window.flags[flag].keycode == "MouseButton1" and self.window.flags[flag].mode == "Toggle" then
                                      self.window.flags[flag].state = not self.window.flags[flag].state
                                      return options.callback(self.window.flags[flag].state)
                                    end
                                  end
                                else
                                  if input.UserInputType == Enum.UserInputType.MouseButton2 then
                                    if self.awaiting_input then
                                      self.awaiting_input = false
                                      keybind.Text = "[MB2]"
                                      self.window.flags[flag].keycode = "MouseButton2"
                                      return 
                                    end
                                    if self.window.flags[flag].keycode == "MouseButton2" and self.window.flags[flag].mode == "Hold" then
                                      self.window.flags[flag].state = true
                                      return options.callback(self.window.flags[flag].state)
                                    else
                                      if self.window.flags[flag].keycode == "MouseButton2" and self.window.flags[flag].mode == "Toggle" then
                                        self.window.flags[flag].state = not self.window.flags[flag].state
                                        return options.callback(self.window.flags[flag].state)
                                      end
                                    end
                                  end
                                end
                              end
                            end
                            local input_ended
                            input_ended = function(input)
                              if input.UserInputType == Enum.UserInputType.Keyboard then
                                if input.KeyCode.Name == self.window.flags[flag].keycode and self.window.flags[flag].mode == "Hold" then
                                  self.window.flags[flag].state = false
                                  options.callback(self.window.flags[flag].state)
                                end
                              end
                              if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if self.window.keybind_objects[1].Visible then
                                  self.window.keybind_objects[1].Visible = false
                                end
                                if self.window.flags[flag].keycode == "MouseButton1" and self.window.flags[flag].mode == "Hold" then
                                  self.window.flags[flag].state = false
                                  options.callback(self.window.flags[flag].state)
                                end
                              end
                              if input.UserInputType == Enum.UserInputType.MouseButton2 then
                                if self.window.flags[flag].keycode == "MouseButton2" and self.window.flags[flag].mode == "Hold" then
                                  self.window.flags[flag].state = false
                                  return options.callback(self.window.flags[flag].state)
                                end
                              end
                            end
                            self.window.connections[#self.window.connections + 1] = keybind.MouseButton2Click:Connect(mouse_button_right_click)
                            self.window.connections[#self.window.connections + 1] = keybind.MouseButton1Click:Connect(mouse_button_click)
                            self.window.connections[#self.window.connections + 1] = game:GetService("UserInputService").InputBegan:Connect(input_began)
                            self.window.connections[#self.window.connections + 1] = game:GetService("UserInputService").InputEnded:Connect(input_ended)
                          end,
                          __base = _base_5,
                          __name = "keybind"
                        }, {
                          __index = _base_5,
                          __call = function(cls, ...)
                            local _self_0 = setmetatable({}, _base_5)
                            cls.__init(_self_0, ...)
                            return _self_0
                          end
                        })
                        _base_5.__class = _class_5
                        keybind = _class_5
                      end
                      self.window.options[flag] = keybind(self, flag, options)
                      if (options.ignore) then
                        self.window.ignore[flag] = true
                      end
                      return self.window.options[flag]
                    end,
                    add_colorpicker = function(self, flag, options)
                      if options == nil then
                        options = { }
                      end
                      local colorpicker
                      do
                        local _class_5
                        local _base_5 = {
                          set_value = function(self, value)
                            self.window.flags[self.flag] = {
                              color = value.color or Color3.fromRGB(255, 255, 255),
                              transparency = value.transparency or 0
                            }
                            self.container.BackgroundColor3 = value.color or Color3.fromRGB(255, 255, 255)
                          end
                        }
                        _base_5.__index = _base_5
                        _class_5 = setmetatable({
                          __init = function(self, parent, flag, options)
                            self.window = parent.window
                            self.flag = flag
                            self.options = options
                            options.default = options.default or { }
                            self.window.flags[flag] = {
                              color = options.default.color or Color3.fromRGB(255, 255, 255),
                              transparency = options.default.transparency or 0
                            }
                            self.container = self.window:add_object("TextButton", {
                              Name = generate_guid(),
                              Size = UDim2.new(0, 35, 0, 10),
                              Position = UDim2.new(1, -48, 0, 1),
                              BackgroundTransparency = 0,
                              Text = "",
                              BackgroundColor3 = self.window.flags[flag].color,
                              BorderSizePixel = 1,
                              BorderColor3 = Color3.fromRGB(80, 80, 80),
                              AutoButtonColor = false,
                              Parent = parent.group_objects[#parent.group_objects],
                              ZIndex = 14
                            })
                            mouse_button_click = function()
                              self.window.current_colorpicker = self.window.flags[flag]
                              self.window.current_colorbox = self.container
                              local hue, saturation, value = self.window.flags[flag].color:ToHSV()
                              self.window.colorpicker_objects[1].Position = UDim2.new(0, self.container.AbsolutePosition.X + self.container.AbsoluteSize.X + 15, 0, self.container.AbsolutePosition.Y)
                              self.window.colorpicker.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
                              self.window.opacity_slider.BackgroundColor3 = self.window.flags[flag].color
                              self.window.location.Position = UDim2.new(0, math.clamp(saturation * self.window.colorpicker.AbsoluteSize.X, 0, 170), 0, math.clamp((-(value) + 1) * self.window.colorpicker.AbsoluteSize.Y, 0, 170))
                              self.window.hue_slider_location.Position = UDim2.new(0, 0, 0, math.clamp(hue * self.window.hue_slider.AbsoluteSize.Y, 0, 175))
                              self.window.opacity_slider_location.Position = UDim2.new(0, 0, 0, math.clamp(self.window.flags[flag].transparency * self.window.opacity_slider.AbsoluteSize.Y, 0, 175))
                              self.window.colorpicker_objects[1].Visible = true
                            end
                            local input_began
                            input_began = function(input)
                              if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                if self.window.colorpicker_objects[1].Visible and not self.inside then
                                  if input.Position.X <= self.window.colorpicker_objects[1].AbsolutePosition.X or input.Position.X >= self.window.colorpicker_objects[1].AbsolutePosition.X + self.window.colorpicker_objects[1].AbsoluteSize.X or input.Position.Y <= self.window.colorpicker_objects[1].AbsolutePosition.Y or input.Position.Y >= self.window.colorpicker_objects[1].AbsolutePosition.Y + self.window.colorpicker_objects[1].AbsoluteSize.Y then
                                    self.window.colorpicker_objects[1].Visible = false
                                  end
                                end
                              end
                            end
                            self.window.connections[#self.window.connections + 1] = self.container.MouseButton1Click:Connect(mouse_button_click)
                            self.window.connections[#self.window.connections + 1] = game:GetService("UserInputService").InputBegan:Connect(input_began)
                          end,
                          __base = _base_5,
                          __name = "colorpicker"
                        }, {
                          __index = _base_5,
                          __call = function(cls, ...)
                            local _self_0 = setmetatable({}, _base_5)
                            cls.__init(_self_0, ...)
                            return _self_0
                          end
                        })
                        _base_5.__class = _class_5
                        colorpicker = _class_5
                      end
                      self.window.options[flag] = colorpicker(self, flag, options)
                      if (options.ignore) then
                        self.window.ignore[flag] = true
                      end
                      return self.window.options[flag]
                    end
                  }
                  _base_4.__index = _base_4
                  _class_4 = setmetatable({
                    __init = function() end,
                    __base = _base_4,
                    __name = "item"
                  }, {
                    __index = _base_4,
                    __call = function(cls, ...)
                      local _self_0 = setmetatable({}, _base_4)
                      cls.__init(_self_0, ...)
                      return _self_0
                    end
                  })
                  _base_4.__class = _class_4
                  item = _class_4
                end
                group = _class_3
              end
              return group(self)
            end
          }
          _base_2.__index = _base_2
          _class_2 = setmetatable({
            __init = function(self, parent)
              self.parent = parent
              self.parent:add_object("UIListLayout", {
                Name = generate_guid(),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                SortOrder = Enum.SortOrder.LayoutOrder,
                VerticalAlignment = Enum.VerticalAlignment.Top,
                Parent = self.parent.tab_groups[current_tab_index]
              })
              self.left_group = self.parent:add_object("ScrollingFrame", {
                Name = generate_guid(),
                BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                BorderSizePixel = 0,
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Parent = self.parent.tab_groups[current_tab_index],
                ClipsDescendants = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BottomImage = "rbxassetid://0",
                MidImage = getsynasset(assets.square),
                CanvasSize = UDim2.new(0, 0, 1, 0),
                ScrollBarThickness = 3,
                ScrollBarImageTransparency = 0,
                ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0),
                TopImage = "rbxassetid://0",
                VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
                ZIndex = 10
              })
              self.right_group = self.parent:add_object("ScrollingFrame", {
                Name = generate_guid(),
                BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                BorderSizePixel = 0,
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                Parent = self.parent.tab_groups[current_tab_index],
                ClipsDescendants = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BottomImage = "rbxassetid://0",
                MidImage = getsynasset(assets.square),
                CanvasSize = UDim2.new(0, 0, 1, 0),
                ScrollBarThickness = 3,
                ScrollBarImageTransparency = 0,
                ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0),
                TopImage = "rbxassetid://0",
                VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
                ZIndex = 10
              })
              self.left_group_objects = {
                self.parent:add_object("UIListLayout", {
                  Name = generate_guid(),
                  FillDirection = Enum.FillDirection.Vertical,
                  HorizontalAlignment = Enum.HorizontalAlignment.Left,
                  SortOrder = Enum.SortOrder.LayoutOrder,
                  VerticalAlignment = Enum.VerticalAlignment.Top,
                  Padding = UDim.new(0, 4),
                  Parent = self.left_group
                }),
                self.parent:add_object("UIPadding", {
                  Name = generate_guid(),
                  PaddingBottom = UDim.new(0, 1),
                  PaddingLeft = UDim.new(0, 1),
                  PaddingRight = UDim.new(0, 2),
                  PaddingTop = UDim.new(0, 1),
                  Parent = self.left_group
                }),
                self.parent:add_object("Frame", {
                  Name = generate_guid(),
                  BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                  BorderSizePixel = 0,
                  Size = UDim2.new(0, 0, 0, 0),
                  Position = UDim2.new(0, 0, 1, 0),
                  Parent = self.left_group,
                  LayoutOrder = 9999
                })
              }
              self.right_group_objects = {
                self.parent:add_object("UIListLayout", {
                  Name = generate_guid(),
                  FillDirection = Enum.FillDirection.Vertical,
                  HorizontalAlignment = Enum.HorizontalAlignment.Left,
                  SortOrder = Enum.SortOrder.LayoutOrder,
                  VerticalAlignment = Enum.VerticalAlignment.Top,
                  Padding = UDim.new(0, 4),
                  Parent = self.right_group
                }),
                self.parent:add_object("UIPadding", {
                  Name = generate_guid(),
                  PaddingBottom = UDim.new(0, 1),
                  PaddingLeft = UDim.new(0, 2),
                  PaddingRight = UDim.new(0, 1),
                  PaddingTop = UDim.new(0, 1),
                  Parent = self.right_group
                }),
                self.parent:add_object("Frame", {
                  Name = generate_guid(),
                  BackgroundColor3 = Color3.fromRGB(12, 12, 12),
                  BorderSizePixel = 0,
                  Size = UDim2.new(0, 0, 0, 0),
                  Position = UDim2.new(0, 0, 1, 0),
                  Parent = self.right_group,
                  LayoutOrder = 9999
                })
              }
            end,
            __base = _base_2,
            __name = "tab"
          }, {
            __index = _base_2,
            __call = function(cls, ...)
              local _self_0 = setmetatable({}, _base_2)
              cls.__init(_self_0, ...)
              return _self_0
            end
          })
          _base_2.__class = _class_2
          tab = _class_2
        end
        return tab(self)
      end,
      set_active_tab = function(self, idx)
        if idx == nil then
          idx = 1
        end
        self.active_tab = idx
        for idx, tab in next,self.tab_objects do
          tab.TextColor3 = Color3.fromRGB(255, 255, 255)
          if idx == self.active_tab then
            tab.TextColor3 = Color3.fromRGB(255, 0, 0)
          end
        end
        for idx, group in next,self.tab_groups do
          group.Visible = self.active_tab == idx
        end
      end,
      add_object = function(self, type, info)
        if type == nil then
          type = ""
        end
        if info == nil then
          info = { }
        end
        local buffer_instance = Instance.new(type)
        for key, value in next,info do
          buffer_instance[key] = value
        end
        self.objects[#self.objects + 1] = buffer_instance
        return buffer_instance
      end,
      destroy = function(self)
        for _, object in next,self.objects do
          object:Destroy()
        end
        for _, connection in next,self.connections do
          connection:Disconnect()
        end
      end
    }
    _base_1.__index = _base_1
    _class_1 = setmetatable({
      __init = function(self, title, position, size)
        if title == nil then
          title = "ars.red"
        end
        if position == nil then
          position = UDim2.new(0.5, -250, 0.5, -300)
        end
        if size == nil then
          size = UDim2.new(0, 500, 0, 600)
        end
        self.objects = { }
        self.dragging = false
        self.mouse_inside = false
        self.window_id = generate_guid()
        self.window = self:add_object("ScreenGui", {
          Name = self.window_id,
          ResetOnSpawn = false,
          DisplayOrder = 0,
          Parent = game:GetService("CoreGui")
        })
        syn.protect_gui(self.window)
        self.position = position
        self.size = size
        self.title = title
        self.connections = { }
        self.current_keybind = { }
        self.current_colorpicker = { }
        self.current_colorbox = nil
        self.colorpicker_down = false
        self.colorpicker_hue_down = false
        self.colorpicker_opacity_down = false
        self.keybind_objects = {
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 1,
            BorderColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(0, 50, 0, 40),
            Position = UDim2.new(0, 0, 0, 0),
            Parent = self.window,
            Visible = false,
            ZIndex = 9999
          }),
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 1,
            BorderColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(0, 50, 0, 40),
            Position = UDim2.new(0, 0, 0, 0)
          })
        }
        self:add_object("UIListLayout", {
          Name = generate_guid(),
          FillDirection = Enum.FillDirection.Vertical,
          SortOrder = Enum.SortOrder.LayoutOrder,
          Padding = UDim.new(0, 0),
          Parent = self.keybind_objects[1]
        })
        self.colorpicker_objects = {
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 1,
            BorderColor3 = Color3.fromRGB(30, 30, 30),
            Size = UDim2.new(0, 214, 0, 182),
            Position = UDim2.new(0, 10, 0, 10),
            Parent = self.window,
            Visible = false,
            ZIndex = 9999
          })
        }
        self.colorpicker = self:add_object("TextButton", {
          Name = generate_guid(),
          BackgroundTransparency = 0,
          BackgroundColor3 = Color3.fromRGB(255, 0, 0),
          BorderSizePixel = 0,
          Size = UDim2.new(0, 180, 0, 180),
          Position = UDim2.new(0, 1, 0, 1),
          Parent = self.colorpicker_objects[1],
          Text = "",
          Visible = true,
          AutoButtonColor = false,
          ZIndex = 9999
        })
        self:add_object("ImageLabel", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          Image = getsynasset(assets.colorpicker),
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.colorpicker,
          Visible = true,
          ZIndex = 9999
        })
        self.location = self:add_object("Frame", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BorderSizePixel = 0,
          Size = UDim2.new(0, 10, 0, 10),
          Position = UDim2.new(1, -10, 0, 0),
          Parent = self.colorpicker,
          Visible = true,
          ZIndex = 9999
        })
        self:add_object("ImageLabel", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          Image = getsynasset(assets.colorpicker_location),
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.location,
          Visible = true,
          ZIndex = 9999
        })
        self.drop_container = self:add_object("ScrollingFrame", {
          Name = generate_guid(),
          BackgroundColor3 = Color3.fromRGB(20, 20, 20),
          BackgroundTransparency = 0,
          BorderSizePixel = 1,
          BorderColor3 = Color3.fromRGB(30, 30, 30),
          Size = UDim2.new(0, 179, 0, 100),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.window,
          ClipsDescendants = true,
          Visible = false,
          ZIndex = 9999,
          CanvasSize = UDim2.new(0, 0, 0, 100),
          ScrollBarThickness = 3,
          ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0),
          ScrollBarImageTransparency = 0,
          AutomaticCanvasSize = Enum.AutomaticSize.Y,
          TopImage = "rbxassetid://0",
          BottomImage = "rbxassetid://0",
          MidImage = getsynasset(assets.square),
          VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
        })
        self:add_object("UIPadding", {
          Name = generate_guid(),
          PaddingTop = UDim.new(0, 2),
          PaddingBottom = UDim.new(0, 2),
          PaddingLeft = UDim.new(0, 2),
          PaddingRight = UDim.new(0, 3),
          Parent = self.drop_container
        })
        self:add_object("UIListLayout", {
          Name = generate_guid(),
          Padding = UDim.new(0, 3),
          Parent = self.drop_container,
          SortOrder = Enum.SortOrder.LayoutOrder
        })
        local slider_group = self:add_object("Frame", {
          Name = generate_guid(),
          BackgroundTransparency = 0,
          BackgroundColor3 = Color3.fromRGB(20, 20, 20),
          BorderSizePixel = 0,
          BorderColor3 = Color3.fromRGB(30, 30, 30),
          Size = UDim2.new(0, 32, 0, 181),
          Position = UDim2.new(0, 181, 0, 0),
          Parent = self.colorpicker_objects[1],
          Visible = true,
          ZIndex = 9999
        })
        self.hue_slider = self:add_object("TextButton", {
          Name = generate_guid(),
          BackgroundTransparency = 0,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BorderSizePixel = 0,
          BorderColor3 = Color3.fromRGB(30, 30, 30),
          Size = UDim2.new(0, 15, 0.994, 0),
          Position = UDim2.new(0, 1, 0, 1),
          Parent = slider_group,
          Visible = true,
          AutoButtonColor = false,
          Text = "",
          ZIndex = 9999
        })
        self:add_object("UIGradient", {
          Name = generate_guid(),
          Color = ColorSequence.new({
            unpack((function()
              local temp_values = { }
              for i = 0, 360, 360 / 10 do
                table.insert(temp_values, ColorSequenceKeypoint.new((1 / 360) * (i), Color3.fromHSV(i / 360, 1, 1)))
              end
              return temp_values
            end)())
          }),
          Rotation = 90,
          Parent = self.hue_slider
        })
        self.hue_slider_location = self:add_object("ImageLabel", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          Image = getsynasset(assets.slider_location),
          BorderSizePixel = 0,
          Size = UDim2.new(0, 15, 0, 5),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.hue_slider,
          Visible = true,
          ZIndex = 9999
        })
        self.opacity_slider = self:add_object("TextButton", {
          Name = generate_guid(),
          BackgroundTransparency = 0,
          BackgroundColor3 = Color3.fromRGB(255, 0, 0),
          BorderSizePixel = 0,
          BorderColor3 = Color3.fromRGB(30, 30, 30),
          Size = UDim2.new(0, 15, 0.994, 0),
          Position = UDim2.new(0, 17, 0, 1),
          Parent = slider_group,
          Visible = true,
          AutoButtonColor = false,
          Text = "",
          ZIndex = 10000
        })
        self:add_object("UIGradient", {
          Name = generate_guid(),
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(1, 1)
          }),
          Rotation = 90,
          Parent = self.opacity_slider
        })
        local transparent_pattern = self:add_object("ImageLabel", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          Image = getsynasset(assets.transparent_pattern),
          BorderSizePixel = 0,
          Size = UDim2.new(0, 15, 0, 180),
          Position = UDim2.new(0, 17, 0, 1),
          Parent = slider_group,
          Visible = true,
          ScaleType = Enum.ScaleType.Tile,
          TileSize = UDim2.new(0, 15, 0, 18),
          ZIndex = 9999
        })
        self.opacity_slider_location = self:add_object("ImageLabel", {
          Name = generate_guid(),
          BackgroundTransparency = 1,
          Image = getsynasset(assets.slider_location),
          BorderSizePixel = 0,
          Size = UDim2.new(0, 15, 0, 5),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.opacity_slider,
          ImageColor3 = Color3.fromRGB(255, 255, 255),
          Visible = true,
          ZIndex = 10000
        })
        local mouse_button_down
        mouse_button_down = function()
          self.colorpicker_down = true
        end
        local mouse_button_up
        mouse_button_up = function()
          self.colorpicker_down = false
        end
        local mouse_moved
        mouse_moved = function(x, y)
          y = y - game:GetService("GuiService"):GetGuiInset().Y
          if self.colorpicker_down then
            local saturation = math.clamp((x - self.colorpicker.AbsolutePosition.X) / self.colorpicker.AbsoluteSize.X, 0, 1)
            local value = -(math.clamp((y - self.colorpicker.AbsolutePosition.Y) / self.colorpicker.AbsoluteSize.Y, 0, 1)) + 1
            local hue = self.current_colorpicker.color:ToHSV()
            self.location.Position = UDim2.new(0, math.clamp(saturation * self.colorpicker.AbsoluteSize.X, 0, 170), 0, math.clamp((-(value) + 1) * self.colorpicker.AbsoluteSize.Y, 0, 170))
            self.opacity_slider.BackgroundColor3 = Color3.fromHSV(hue, saturation, value)
            self.current_colorpicker.color = Color3.fromHSV(hue, saturation, value)
            self.current_colorbox.BackgroundColor3 = self.current_colorpicker.color
          end
        end
        local mouse_leave
        mouse_leave = function()
          self.colorpicker_down = false
        end
        self.connections[#self.connections + 1] = self.colorpicker.MouseButton1Down:Connect(mouse_button_down)
        self.connections[#self.connections + 1] = self.colorpicker.MouseButton1Up:Connect(mouse_button_up)
        self.connections[#self.connections + 1] = self.colorpicker.MouseMoved:Connect(mouse_moved)
        self.connections[#self.connections + 1] = self.colorpicker.MouseLeave:Connect(mouse_leave)
        mouse_button_down = function()
          self.colorpicker_hue_down = true
        end
        mouse_button_up = function()
          self.colorpicker_hue_down = false
        end
        mouse_moved = function(x, y)
          y = y - game:GetService("GuiService"):GetGuiInset().Y
          if self.colorpicker_hue_down then
            local hue = math.clamp((y - self.hue_slider.AbsolutePosition.Y) / self.hue_slider.AbsoluteSize.Y, 0, 1)
            self.hue_slider_location.Position = UDim2.new(0, 0, 0, math.clamp(hue * self.hue_slider.AbsoluteSize.Y, 0, 175))
            local _, saturation, value = self.current_colorpicker.color:ToHSV()
            self.opacity_slider.BackgroundColor3 = Color3.fromHSV(hue, saturation, value)
            self.colorpicker.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
            self.current_colorpicker.color = Color3.fromHSV(hue, saturation, value)
            self.current_colorbox.BackgroundColor3 = self.current_colorpicker.color
          end
        end
        mouse_leave = function()
          self.colorpicker_hue_down = false
        end
        self.connections[#self.connections + 1] = self.hue_slider.MouseButton1Down:Connect(mouse_button_down)
        self.connections[#self.connections + 1] = self.hue_slider.MouseButton1Up:Connect(mouse_button_up)
        self.connections[#self.connections + 1] = self.hue_slider.MouseMoved:Connect(mouse_moved)
        self.connections[#self.connections + 1] = self.hue_slider.MouseLeave:Connect(mouse_leave)
        mouse_button_down = function()
          self.colorpicker_opacity_down = true
        end
        mouse_button_up = function()
          self.colorpicker_opacity_down = false
        end
        mouse_moved = function(x, y)
          y = y - game:GetService("GuiService"):GetGuiInset().Y
          if self.colorpicker_opacity_down then
            local opacity = math.clamp((y - self.opacity_slider.AbsolutePosition.Y) / self.opacity_slider.AbsoluteSize.Y, 0, 1)
            self.opacity_slider_location.Position = UDim2.new(0, 0, 0, math.clamp(opacity * self.opacity_slider.AbsoluteSize.Y, 0, 175))
            self.current_colorpicker.transparency = opacity
          end
        end
        mouse_leave = function()
          self.colorpicker_opacity_down = false
        end
        self.connections[#self.connections + 1] = self.opacity_slider.MouseButton1Down:Connect(mouse_button_down)
        self.connections[#self.connections + 1] = self.opacity_slider.MouseButton1Up:Connect(mouse_button_up)
        self.connections[#self.connections + 1] = self.opacity_slider.MouseMoved:Connect(mouse_moved)
        self.connections[#self.connections + 1] = self.opacity_slider.MouseLeave:Connect(mouse_leave)
        local toggle_button = self:add_object("TextButton", {
          Name = generate_guid(),
          Text = "Toggle",
          TextColor3 = Color3.new(1, 1, 1),
          TextStrokeTransparency = 0,
          TextStrokeColor3 = Color3.new(0, 0, 0),
          Font = Enum.Font.Gotham,
          TextSize = 12,
          TextScaled = false,
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 0.5, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.keybind_objects[1],
          ZIndex = 9999
        })
        local hold_button = self:add_object("TextButton", {
          Name = generate_guid(),
          Text = "Hold",
          TextColor3 = Color3.new(1, 1, 1),
          TextStrokeTransparency = 0,
          TextStrokeColor3 = Color3.new(0, 0, 0),
          Font = Enum.Font.Gotham,
          TextSize = 12,
          TextScaled = false,
          BackgroundTransparency = 1,
          Size = UDim2.new(1, 0, 0.5, 0),
          Position = UDim2.new(0, 0, 0, 0),
          Parent = self.keybind_objects[1],
          ZIndex = 9999
        })
        local mouse_button_click
        mouse_button_click = function()
          self.flags[self.current_keybind].mode = "Toggle"
        end
        self.connections[#self.connections + 1] = toggle_button.MouseButton1Click:Connect(mouse_button_click)
        mouse_button_click = function()
          self.flags[self.current_keybind].mode = "Hold"
        end
        self.connections[#self.connections + 1] = hold_button.MouseButton1Click:Connect(mouse_button_click)
        self.background_objects = {
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Size = self.size,
            Position = self.position,
            Parent = self.window,
            ZIndex = 0
          }),
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BorderSizePixel = 0,
            Size = self.size - UDim2.new(0, 2, 0, 2),
            Position = self.position + UDim2.new(0, 1, 0, 1),
            Parent = self.window,
            ZIndex = 1
          }),
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Size = self.size - UDim2.new(0, 4, 0, 4),
            Position = self.position + UDim2.new(0, 2, 0, 2),
            Parent = self.window,
            ClipsDescendants = true,
            ZIndex = 2
          })
        }
        self.group_objects = {
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(12, 12, 12),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -2, 1, -44),
            Position = UDim2.new(0, 1, 0, 43),
            Parent = self.background_objects[3],
            ClipsDescendants = true,
            ZIndex = 3
          })
        }
        self.title_objects = {
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -2, 0, 20),
            Position = self.position + UDim2.new(0, 3, 0, 3),
            Parent = self.background_objects[3],
            ZIndex = 3
          }),
          self:add_object("TextLabel", {
            Name = generate_guid(),
            BackgroundTransparency = 1,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 12,
            Text = self.title,
            Font = Enum.Font.Gotham,
            Size = UDim2.new(1, -2, 0, 20),
            Position = self.position + UDim2.new(0, 3, 0, 3),
            Parent = self.background_objects[3],
            ZIndex = 4
          }),
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -2, 0, 1),
            Position = self.position + UDim2.new(0, 3, 0, 22),
            Parent = self.background_objects[3],
            ZIndex = 5
          })
        }
        self.tabs = { }
        self.tab_objects = { }
        self.tab_groups = { }
        self.flags = { }
        self.options = { }
        self.ignore = { }
        getgenv().flags = self.flags
        getgenv().options = self.options
        mouse_button_down = function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 and self.mouse_inside then
            self.dragging = true
            self.drag_start = input.Position
          end
        end
        mouse_button_up = function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 then
            self.dragging = false
          end
        end
        mouse_moved = function(input)
          if self.dragging then
            self.position = self.position + UDim2.new(0, input.Position.X - self.drag_start.X, 0, input.Position.Y - self.drag_start.Y)
            self.drag_start = input.Position
            return self:update()
          end
        end
        local mouse_entered
        mouse_entered = function(x, y)
          self.mouse_inside = true
        end
        local mouse_left
        mouse_left = function(x, y)
          self.mouse_inside = false
        end
        self.connections = {
          self.background_objects[1].InputBegan:Connect(mouse_button_down),
          self.background_objects[1].InputEnded:Connect(mouse_button_up),
          self.background_objects[1].InputChanged:Connect(mouse_moved),
          self.background_objects[1].MouseEnter:Connect(mouse_entered),
          self.background_objects[1].MouseLeave:Connect(mouse_left)
        }
        self.title_objects[#self.title_objects + 1] = self:add_object("UIGradient", {
          Name = generate_guid(),
          Color = ColorSequence.new(Color3.fromRGB(255, 0, 0)),
          Rotation = 0,
          Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0),
            NumberSequenceKeypoint.new(1, 1)
          }),
          Offset = Vector2.new(0, 0),
          Parent = self.title_objects[3]
        })
        self.tab_bar_objects = {
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(30, 30, 30),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -2, 0, 20),
            Position = self.position + UDim2.new(0, 3, 0, 24),
            Parent = self.background_objects[3],
            ZIndex = 6
          }),
          self:add_object("Frame", {
            Name = generate_guid(),
            BackgroundColor3 = Color3.fromRGB(20, 20, 20),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -4, 0, 18),
            Position = self.position + UDim2.new(0, 4, 0, 25),
            Parent = self.background_objects[3],
            ZIndex = 7,
            ClipsDescendants = true
          })
        }
        self.tab_objects = { }
      end,
      __base = _base_1,
      __name = "window"
    }, {
      __index = _base_1,
      __call = function(cls, ...)
        local _self_0 = setmetatable({}, _base_1)
        cls.__init(_self_0, ...)
        return _self_0
      end
    })
    _base_1.__class = _class_1
    window = _class_1
  end
  library = _class_0
end
local current_library = library()
return current_library