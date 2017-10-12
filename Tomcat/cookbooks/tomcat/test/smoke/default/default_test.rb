# # encoding: utf-8

# Inspec test for recipe tomcat::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

# This is an example test, replace it with your own test.
describe 'tomcat_default' do
	describe command('curl http://localhost:8080') do
		its( :stdout ) { should match /Tomcat/ }
	end
end
