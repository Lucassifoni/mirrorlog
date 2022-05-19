export const surface = () => ({
    conic: 0,
    radius: 100,
    status: 0,
    type: 0,
});

export const optic = () => ({
    name: '',
    diameter: 1,
    glass: '',
    thickness: 1,
    type: 0,
    surfaces: [surface()],
});