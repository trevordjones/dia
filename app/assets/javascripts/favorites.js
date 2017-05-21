(function() {
  $(document).ready(function() {
    $('.favorite').click(function(e) {
      e.preventDefault();
      if ($(this).data().favorite) {
        removeFavorite($(this))
      } else {
        addFavorite($(this))
      }
    })

    function addFavorite(review) {
      $.ajax({
        url: '/favorites',
        method: 'POST',
        review: review,
        data: { yelp_id: review.data().id }
      })
        .success(function(data) {
          review.data().favorite = true;
          review.text('Unfavorite');
          // In case an error was previously given, hide alert
          $('.error-' + this.review.data().id).addClass('hidden');
        }).error(function(data) {
          var className = '.error-' + this.review.data().id
          $(className).removeClass('hidden');
          $(className).text(data.responseJSON.error);
        });
    }

    function removeFavorite(review) {
      $.ajax({
        url: '/favorites/' + review.data().id,
        method: 'DELETE',
        review: review
      }).success(function(data) {
          review.data().favorite = false;
          review.text('Favorite');
          $('.error-' + this.review.data().id).addClass('hidden');
        }).error(function(data) {
          var className = '.error-' + this.review.data().id
          $(className).removeClass('hidden');
          $(className).text(data.responseJSON.error);
        })
    }
  });
})();
