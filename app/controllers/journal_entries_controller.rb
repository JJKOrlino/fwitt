class JournalEntriesController < ApplicationController

    get '/journal_entries' do
      @journal_entries = JournalEntry.all
      erb :'journal_entries/index'
    end
  
    get '/journal_entries/new' do
      redirect_if_not_logged_in
      erb :'/journal_entries/new'
      flash[:message] = "You must be logged in."
    end
  
    post '/journal_entries' do
      if params[:content] != ""
        @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
        redirect "/journal_entries/#{@journal_entry.id}"
      else
        redirect '/journal_entries/new'
      end
    end
  
    get '/journal_entries/:id' do
      set_journal_entry
      erb :'/journal_entries/show'
    end
  
    
    get '/journal_entries/:id/edit' do
      redirect_if_not_logged_in
      set_journal_entry
      if authorized_to_edit?(@journal_entry)
        erb :'/journal_entries/edit'
      else
        redirect "users/#{current_user.id}"
      end
    end
  
    patch '/journal_entries/:id' do
      redirect_if_not_logged_in
      set_journal_entry
      if @journal_entry.user == current_user && params[:content] != ""
        @journal_entry.update(content: params[:content])
        redirect "/journal_entries/#{@journal_entry.id}"
      else
        redirect "users/#{current_user.id}"
      end
    end
  
    delete '/journal_entries/:id' do
      set_journal_entry
      if authorized_to_edit?(@journal_entry)
        @journal_entry.destroy
        flash[:message] = "FWITT deleted."
        redirect '/journal_entries'
      else
        redirect '/journal_entries'
      end
    end
  
    private
  
    def set_journal_entry
      @journal_entry = JournalEntry.find(params[:id])
    end
  end

# class JournalEntriesController < ApplicationController

    #     get '/journal_entries' do
    #         @journal_entries = JournalEntry.all
    #         erb :'journal_entries/index'
    #     end
    
    #     get '/journal_entries_new' do
    #         redirect_if_not_logged_in
    #         erb :'/journal_entries/new'
    #     end
    
    #     #post entries
    #     post '/journal_entries' do
    #         if !logged_in?
    #             redirect '/'
    #         end
    
    #         if params[:content] != ""
    #             @journal_entry = JournalEntry.create(content: params[:content], user_id: current_user.id)
    #             redirect "/journal_entries/#{@journal_entry.id}"
    #         else
    #             redirect '/journal_entries/new'
    #         end
    #     end
    
    #     #show page for entries
    
    #     get '/journal_entries/:id' do
    #         set_journal_entry
    #         erb :'/journal_entries/show'
    #     end
    # end