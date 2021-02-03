# react

## setState not re-rendering different situation
```javascript
const [data, setData] = React.useState([1, 2, 3, 4, 5, 6, 7, 8, 9]);
let newData = data
setData(data) // not re-rendering
setData(newData) // not re-rendering
setData([1, 2, 3, 4, 5, 6, 7, 8, 9]) // will re-rendering
setData([...data]) // will re-rendering
setData([...newData]) // will re-rendering
```

## update state value different situation
```javascript
const [data, setData] = React.useState({})
data.text = "TEXT" // working, not re-rendering
data = "TEXT" // not working
data = { text: "TEXT" } // not working
setData({ text: "TEXT" }) // working, will re-rendering
setData("TEXT") // working, will re-rendering
```