function [ Vq] = interp2_multi( V,Xq,Yq, method)
%INTERP2_MULTI Summary of this function goes here
%   Detailed explanation goes here
    [h, w, ~] = size(Xq);
    [~, ~, c] = size(V);
    Vq = zeros(h, w, c);
    for k = 1:c
        Vq(:,:,k) = interp2(V(:,:,k), Xq, Yq, method);
    end
end

