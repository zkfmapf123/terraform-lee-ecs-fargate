import express from 'express'

const app = express()

app.get("/health", (req, res) => res.status(200).send("success"))
app.listen(process.env.PORT, () => console.log(`connect to ${process.env.PORT}`))