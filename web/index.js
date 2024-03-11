const express = require('express')
const cors = require('cors')
const app = express()
app.use(cors())
app.listen(3000,()=>{
    console.log('server started')
})

let counter = []
app.post('',(req,res)=>{
    let date = new Date()
    counter.push(date.toLocaleString())
    res.send(`Данные получены`)
})

app.get('/checkstatus', (req,res)=>{
    res.send({counter})
})