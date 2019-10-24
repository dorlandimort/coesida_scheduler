
Fetch = {
    get: function (url, data, dataType, callback) {
        $.ajax({
            type: 'get',
            url: url,
            data: data,
            dataType: dataType,
            success: function(result) {
                callback(null, result)
            },
            error: function (error) {
                callback(error);
            }
        })

    },
    post: function (url, data, dataType, callback) {
        $.ajax({
            type: 'post',
            url: url,
            data: data,
            dataType: dataType,
            success: function(result) {
                callback(null, result)
            },
            error: function (error) {
                callback(error);
            }
        })

    },
    put: function (url, data, dataType, callback) {
        $.ajax({
            type: 'put',
            url: url,
            data: data,
            dataType: dataType,
            success: function(result) {
                callback(null, result)
            },
            error: function (error) {
                callback(error);
            }
        })

    },
    delete: function(url, data, dataType, callback) {
        $.ajax({
            type: 'delete',
            url: url,
            data: data,
            dataType: dataType,
            success: function(result) {
                callback(null, result);
            },
            error: function (error) {
                callback(error);
            }
        })

    }
};

FetchP = {
    get: async function (url, data, dataType) {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: 'get',
                url: url,
                data: data,
                dataType: dataType,
                success: function(result) {
                    resolve(result);
                },
                error: function (error) {
                    reject(error);
                }
            });
        });


    },
    post: async function (url, data, dataType) {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: 'post',
                url: url,
                data: data,
                dataType: dataType,
                success: function(result) {
                    resolve(result);
                },
                error: function (error) {
                    reject(error);
                }
            });
        })


    },
    put: async function (url, data, dataType) {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: 'put',
                url: url,
                data: data,
                dataType: dataType,
                success: function(result) {
                    resolve(result);
                },
                error: function (error) {
                    reject(error);
                }
            });
        })


    },
    delete: async function(url, data, dataType) {
        return new Promise((resolve, reject) => {
            $.ajax({
                type: 'delete',
                url: url,
                data: data,
                dataType: dataType,
                success: function(result) {
                    resolve(result);
                },
                error: function (error) {
                    reject(error);
                }
            });
        })


    }
}