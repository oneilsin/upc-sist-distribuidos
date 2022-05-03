package com.upc.bakery.biscuits.models;

public class EntityResponse {
    private boolean IsSuccess;
    private String ErrorCode;
    private String ErrorMessage;
    private Object Data;

    public EntityResponse() {
        this.IsSuccess = false;
        this.ErrorCode="";
        this.ErrorMessage="";
        this.Data=null;
    }

    public boolean isSuccess() {
        return IsSuccess;
    }

    public void setSuccess(boolean success) {
        IsSuccess = success;
    }

    public String getErrorCode() {
        return ErrorCode;
    }

    public void setErrorCode(String errorCode) {
        ErrorCode = errorCode;
    }

    public String getErrorMessage() {
        return ErrorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        ErrorMessage = errorMessage;
    }

    public Object getData() {
        return Data;
    }

    public void setData(Object data) {
        Data = data;
    }
}
