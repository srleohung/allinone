# react

## update object with string value on key
```javascript
const key = "OBJECT_KEY"
const [data, setData] = useState({});
setData({ ...data, [key]: value });
```

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
data.text = "TEXT" // working, not re-rendering (If the top component is re-rendered, the value will be lost.)
data = "TEXT" // not working
data = { text: "TEXT" } // not working
setData({ text: "TEXT" }) // working, will re-rendering
setData("TEXT") // working, will re-rendering
```

## When the component is initialized, the correct state value is not displayed on the UI. 
```javascript
const [data, setData] = React.useState({})
useEffect(() => {
    setData({isBoolean: true});
}, []);
<Checkbox
    checked={data?.isBoolean} // not working (Because the data is "undefined", react will show error and stop re-rendering the component.)
    onChange={e => {
        setData({...data, isBoolean: e.target.checked})
    }}
/>
<Checkbox
    checked={data?.isBoolean || false} // working
    onChange={e => {
        setData({...data, isBoolean: e.target.checked})
    }}
/>
```