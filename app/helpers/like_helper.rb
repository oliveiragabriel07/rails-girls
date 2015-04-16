module LikeHelper

def like_link_for(likeable)
  link_to 'Like', likes_path(likeable_type: likeable.class.to_s, likeable_id: likeable.id), method: :post, remote: true
end

def unlike_link_for(like)
  link_to 'Unlike', like, method: :delete, remote: true
end

end