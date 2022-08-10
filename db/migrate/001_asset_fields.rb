# asset field

class AssetFields < ActiveRecord::Migration[6.0]

  @@cissues = [
    ['MAC-Address','string', '0'],
    ['HostName','string', '0'],
    ['IP-Address','string', '0'],
    ['DeviceConfig','text', '1'],
    ['Outlook-ID','string', '0'],
  ]

  def self.createIssueField(name, ctype, seach=0)
    if IssueCustomField.find_by_name(name).nil?
      IssueCustomField.create(name: name, field_format: ctype, searchable: seach).nil?
    end
  end

  # method called when installing the plugin
  def self.up
    @@cissues.each { |ci, ctype, searchable|
      self.createIssueField(ci, ctype, searchable)
      if IssueCustomField.find_by_name(ci).nil?
        IssueCustomField.create(name: ci, field_format: ctype).nil?
      end
    }
  end

  # method called when uninstalling the plugin
  def self.down
    @@cissues.each { |ci, ctype|
      IssueCustomField.find_by_name(ci).delete unless IssueCustomField.find_by_name(ci)
    }
  end
end

