require 'rails_helper'

describe '投稿に関するテスト' do
  let!(:list){ create(:list,title:'test',body:'check') }
  describe 'トップ画面のテスト' do
    before do
      visit top_path
    end
    context '表示の確認' do
      it 'トップ画面(top_path)に「ここはTopページです」が表示されているか' do
        expect(page).to have_content "ここはTopページです"
      end
      it 'top_pathが"/top"であるか' do
        expect(current_path).to eq('/top')
      end
    end
  end
  describe '投稿画面のテスト' do
    before do
      visit new_list_path
    end
    context '表示の確認' do
      it "投稿ボタンが表示されているか" do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'list[:title]', with: Faker::Lorem.characters(number:10)
        fill_in 'list[:body]', with: Faker::Lorem.characters(number:30)
        click_button '投稿'
        expect(page).to have_current_path list_path(List.last)
      end
    end
    describe "一覧画面のテスト" do
      before do
        visit lists_path
      end
      context '一覧の表示とリンクの確認' do
        it "一覧表示画面に投稿されたものが表示されているか" do
          expect(page).to have_content list.title
          expect(page).to have_content list.body
        end
      end
    end
    describe '詳細画面のテスト' do
      bofore do
        visit list_path
      end
      context '表示の確認' do
        it '削除リンクが存在しているか' do
          show_link = find_all('a')[0]
          expect(show_link.native.inner_text).to match(/destroy/i) 
        end
        it '編集リンクが存在しているか' do
          edit_link = find_all('a')[0]
          expect(edit_link.native.inner_text).to match(/edit/i) 
        end
      end
      context 'リンクの遷移先の確認'
