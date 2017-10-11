class CreateSalesReports < ActiveRecord::Migration[5.0]
  def change
    create_table :sales_reports do |t|
      t.datetime :date
      t.integer :net_sales
      t.integer :open_ticket_sales
      t.integer :closed_ticket_sales
      t.integer :deposit
      t.integer :tickets_created

      t.timestamps
    end
  end
end
