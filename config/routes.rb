Rails.application.routes.draw do
  root to: redirect('/sectors', status: 302)

  resources :sectors, only: [:index] do
    put :publish

    resources :lists, only: [:index, :edit, :create, :update, :destroy] do
      resources :list_items, only: [:create, :update, :destroy]
    end
  end

  resources :mainstream_browse_pages, path: 'mainstream-browse-pages',
                                      except: :destroy do
    member do
      post :publish
    end
  end

  resources :topics, except: :destroy do
    member do
      post :publish
    end
  end

  mount GovukAdminTemplate::Engine, at: "/style-guide"
end
