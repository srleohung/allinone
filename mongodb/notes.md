# mongodb

## Get Collection Structure
```js
var collectionStruct = {};
db.collectionName.find().forEach(
    function (doc) {
        Object.keys(doc).forEach(function (key) {
            function subObject(masterKey, subDoc) {
                Object.keys(subDoc).forEach(function (subKey) {
                    let typeOfKey = typeof subDoc[subKey]
                    if (!collectionStruct[masterKey + "." + subKey]) {
                        collectionStruct[masterKey + "." + subKey] = []
                    }
                    if (collectionStruct[masterKey + "." + subKey].indexOf(typeOfKey) === -1) {
                        collectionStruct[masterKey + "." + subKey].push(typeOfKey)
                    }
                    if (typeOfKey === 'object') {
                        if (subDoc[subKey]) {
                            subObject(masterKey + "." + subKey, subDoc[subKey])
                        }
                    }
                })
            }
            let typeOfKey = typeof doc[key]
            if (!collectionStruct[key]) {
                collectionStruct[key] = []
            }
            if (collectionStruct[key].indexOf(typeOfKey) === -1) {
                collectionStruct[key].push(typeOfKey)
            }
            if (typeOfKey === 'object') {
                if (doc[key]) {
                    subObject(key, doc[key])
                }
            }
        })
    });
collectionStruct;
```