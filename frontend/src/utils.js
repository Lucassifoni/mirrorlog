import qs from "qs";

const get_csrf_token = () => document.querySelector('meta[name="csrf-token"]').getAttribute('content');

export const api_get = async (url, params = {}, headers = {}) => {
    const f = await fetch(`${url}?${qs.stringify(params)}`, {
        method: 'GET',
        headers: {
            'Accept': 'application/json',
            ...headers,
            'x-csrf-token': get_csrf_token(),
        },
    });
    return f.json();
};

export const api_post = async (url, body, params = {}, headers = {}) => {
    const f = await fetch(`${url}?${qs.stringify(params)}`, {
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            ...headers,
            'x-csrf-token': get_csrf_token(),
        },
        body: JSON.stringify(body)
    });
    return f.json();
};