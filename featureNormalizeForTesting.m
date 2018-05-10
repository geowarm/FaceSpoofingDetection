function XNorm = featureNormalizeForTesting( X, mu, stddev )

% Calculates mean and std dev for each feature
for i=1:size(mu,2)    
    XNorm(:,i) = (X(:,i)-mu(1,i))/stddev(1,i);
end

end

