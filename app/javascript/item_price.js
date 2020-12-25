
window.addEventListener("load", ()=>{
  const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    
    const addTaxDom = document.getElementById("add-tax-price");
    //消費税が出る値を出力 Math.floorは小数点切り捨て
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1)

    const profitNumber = document.getElementById("profit")
    const valueResult = inputValue * 0.1;
    profitNumber.innerHTML = Math.floor(inputValue - valueResult);
    })
  })
