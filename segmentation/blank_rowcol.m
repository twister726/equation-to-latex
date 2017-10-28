function [ br ] = blank_rowcol( im, alongRows )
% Gives center of consecutive blank rows/cols
% alongRows - whether to find blank rows (bool)

if alongRows
    dim = 2;
    threshold = 0.05;
else
    dim = 1;
    threshold = 0.1;
end

r = sum(im, dim);
r = r(:);
rmax = max(r);
brl = r > threshold*rmax;

last = 0;
br = [];
for i = 1:size(brl)
    if brl(i)
        if last ~= i - 1
            temp = ceil( (i + last)/2 );
            br = [ br; temp ];
        end
        last = i;
    end
end

end

