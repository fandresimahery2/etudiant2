<script>
export default {
  name: 'TableMoyennes',
  props: ['moyennes']
}
</script>
<template>
  <table>
    <thead>
      <tr>
        <th>S1</th>
        <th>S2</th>
        <th>S3</th>
        <th>S4</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>{{ moyennes.S1 ?? '-' }}</td>
        <td>{{ moyennes.S2 ?? '-' }}</td>
        <td>{{ moyennes.S3 ?? '-' }}</td>
        <td>{{ moyennes.S4 ?? '-' }}</td>
      </tr>
    </tbody>
  </table>
</template>
<style scoped>
table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
  background: #e8fbe6;
  box-shadow: 0 2px 8px rgba(76, 175, 80, 0.08);
  border-radius: 12px;
  overflow: hidden;
}

th, td {
  padding: 1rem;
  text-align: center;
  border-bottom: 1px solid #c8e6c9;
  font-size: 1.1rem;
}

tr:last-child td {
  border-bottom: none;
}

tr:hover td {
  background: #d0f5d6;
  transition: background 0.2s;
}
</style>