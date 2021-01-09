class JournalEntriesController < ApplicationController
    #render form for new entries
    get '/journal_entries_new' do
        erb :'/journal_entries/new'
    end

    #post entries
    post '/journal_entries' do
        if !logged_in?
            redirect '/'
        end

        if params[:content] != ""
            @journal_entries = JournalEntry.create(content: params[:content], user_id: current_user.id)
            redirect "/journal_entries/#{journal_entry.id}"
        else
            redirect '/journal_entries/new'
        end
    end
    #show page for entries

    #index route for all entries
end