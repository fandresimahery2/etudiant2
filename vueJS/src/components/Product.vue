<script >
export default {
  data(){
    return{
      products: [
        {id:1, name: 'Produit A', unit_price: 10, quantity: 5, description: '<b> genial </b>'},
        {id:2, name: 'Produit B', unit_price: 140, quantity: 4, description: '<b style="color:green"> On valide </b>'},
        {id:3, name: 'Produit C', unit_price: 15, quantity: 5, description: null},
        {id:4, name: 'Produit D', unit_price: 12, quantity: 8, description: 'sans commentaire'},
        {id:5, name: 'Produit E', unit_price: 4, quantity: 5, description: '<b> ok </b>'},
        {id:6, name: 'Produit F', unit_price: 160, quantity: 6, description: '<b> cool </b>'},
        {id:7, name: 'Produit G', unit_price: 105, quantity: 5, description: '<b> bof </b>'},
        {id:8, name: 'Produit H', unit_price: 50, quantity: 8, description: '<b> incroyable </b>'},
        {id:9, name: 'Produit I', unit_price: 40, quantity: 5, description: '<b> super </b>'},
        {id:10, name: 'Produit J', unit_price: 80, quantity: 5, description: '<b> genial </b>'},
        
      ]
    }
  }
}
</script>
<template>
    <div>
        <h1>Nos produits</h1>  
        <div v-if="products.length > 0" class="product" v-for="product in products" :key="product.id" > 
            <h3> {{ product.name }}</h3>    
            <div>
                <p>
                    <b>Prix unitaire:</b> {{ product.unit_price }} €<br>
                    <b>Quantité:</b>{{ product.quantity }}
                </p>
            </div>
            <div>
                description: <p v-html="product.description"></p>
            </div>
        </div>
        <div v-else>
            <p>Aucun produit disponible.</p>
        </div>
        
    </div>

  <!-- <ul>
      <li v-for="(product,index) in products" :key="index" >{{ product.id }} {{ product.name }} {{ product.unit_price }} - {{ product.quantity }} - {{ product.description}}</li>    
  </ul> -->

</template>
