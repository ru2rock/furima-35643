const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //後で環境変数に設定すること！
  const form = document.getElementById("charge-form"); //変数formはイベント発火の役割
  form.addEventListener("submit", (e) =>{
    e.preventDefault();

    const formResult = document.getElementById("charge-form"); //"charge-form"というidでフォームの情報を取得し、それをFormDataオブジェクトとして生成
    const formData = new FormData(formResult);  //変数formResultはフォームに記入されている値参照の役割

    const card = {
      number: formData.get("purchase_address[number]"),
      cvc: formData.get("purchase_address[cvc]"),
      exp_month: formData.get("purchase_address[exp_month]"),
      exp_year: `20${formData.get("purchase_address[exp_year]")}`,
    };
    console.log(card) 
    Payjp.createToken(card, (status,response) => {
       console.log(response) 
      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);

