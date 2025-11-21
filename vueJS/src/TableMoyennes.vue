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