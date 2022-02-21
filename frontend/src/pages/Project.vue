<template>
    <div>
    
    </div>
</template>

<script>
export default {
    data() {
        return {
            project: null,
        };
    },
    props: {
        id: {},
    },
    async mounted() {
        this.project = await (await (fetch(`/api/project/${this.id}`))).json();
    }
};
</script>

<style></style>