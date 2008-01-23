%w(rubygems cgi hpricot net/http open-uri).each { |f| require f } 
# => chris[at]ozmm[dot]org

##
# Finds all zip codes for a single city and state.
#
# >> Zippy.find('Cincinnati', 'OH')
# => ["45201", "45202", "45203", "45204", ... ]
#
class Zippy
  Host = 'zip4.usps.com'
  Page = '/zip4/zcl_1_results.jsp'

  attr_accessor :zips, :city, :state

  def self.find(city, state)
    new(city, state).zips
  end

  def initialize(city, state)
    @city, @state = city, state
    find
  end

  def find
    doc   = Hpricot(post_body || '')
    cells = Array(doc.search(:td))

    @zips = cells.map do |td|
      next unless td['headers'] == 'units'
      td.innerText[/(\d){5}/] if td.respond_to?(:innerText)
    end

    @zips.compact!
  end

private
  def post_body
    Net::HTTP.new(Host, 80).post(Page, post_params, headers).body rescue nil
  end

  def post_params
    params = "city=#{CGI.escape(@city.to_s.upcase)}&state=#{CGI.escape(@state.to_s.upcase)}"
    params << "&visited=1&pagenumber=all"
  end

  def headers
    { 'Content-Type' => 'application/x-www-form-urlencoded' }
  end
end

if $0 == __FILE__
  %w(test/spec mocha zlib base64).each { |f| require f }

  html = Zlib::Inflate.new.inflate(Base64.decode64(DATA.read))

  context "Searching on a valid city and state" do
    setup do
      Zippy.any_instance.stubs(:post_body).returns(html)
    end

    specify "should return an array of zipcodes" do
      zips = Zippy.find('Cincinnati', 'OH')
      zips.should.be.an.instance_of Array
      zips.size.should.be > 0
      zips.first.should.match /(\d){5}/
    end
  end

  context "Searching on an invalid city and state" do
    setup do
      Zippy.any_instance.stubs(:post_body).returns(nil)
    end

    specify "should return an empty array" do
      zips = Zippy.find('Dogtown', 'OH')
      zips.should.be.an.instance_of Array
      zips.should.be.empty
    end
  end
end

__END__
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
AJkPkM0CyHyAbBVA5gNkuwAyHyAPCyDzAbJTAJkLkJpWAJkPkEVCnhOQRUKe
E5BFQp4TkEVCnhOQRUKeE5BFQp4TkEVCnhOQRUKeD5B6bduBRM/g8ZP+0OOn
j2en//54Ujx+yunxk17brudPem3dA6jIgzdOrwdj1DNglv4As4oHu/kya8ue
7OrFo92vzQCKAkhOQBYFkJyALAogOQFZFEByArIogOQEZFEAyQnIogCSD5D1
rS+APBcgi0e7OQFZPNrNCcjt39nsfFcMBYiN+KwowGygAFOvb1cBpl7f3gLM
M2BXs2DXRtnV2DJ2NbaXXc8kCShqIDkBWdRAcgKyqIHkBGRRA8kHyEZRA8kJ
yKIGkhOQRQ0kJyC3vwbyTIAsnu7mBGTxdDcnIIudTU5AFjubnIAsdjY5Abn9
O5ud74ohB7FZi8+K2uoGaquNznbVVhudorb6dWGqWWx3cwJy+7e7CTu+W7yv
F/F+k/G+qW9XvG/q2xvvnwG7ivdANsuuLXsPpLnF74E8kyRg+wtjzyBMHRZh
aqNhqrllYaq5vWHq+7OrVfzfuJtlV2vL2NXaWnY9h6+RaD20gy2+RiJferW3
jF7trfwaiWdBrYe2rwW18qXW4ZZR67Cg1lOp1S6otVFqbdlztuba52wFtdZR
66FqRkGtXKnV2rLvFWtt5/eKPQtqdQpqbZRaW/bFYq21XyxWUGsNtdoPvXhV
UCtfam3Zg/jW2gfxBbXWUav4otnNUmvLnsK31j6FL6i1jlpF8X2z1Nqyr2Jo
rf0qhoJa66hVFN83S60teymjtfaljGdLrefArOL7gzbLrC17IaNVvJDxVfQq
Hm1tll5b9kJGaztfyHgGzDos/ufMzTJry97HaK19H6NYuB6gV6dVLFwbpdeW
vZPRKt7JeDK1incyNkqt9pa9k9Eu3sl4MrWKdzI2S60teyejXbyT8URqdQpq
bZhaW/ZORvt5v5NR6qsj6k8Hpf6LSgX948k/qFLhMvqSTzCcatk3g1KpDx8R
AU2HYL87pGzSk9p3WzVOMDQF97bdikNGrFtv8itySl2tzU9WE9fD0Ef43TUM
yej0mtkOESRGPvEIZhXgLsy0L1SK8AKRGXxM4jgcVqB8fB6GAHEezKag3txQ
ribgHXIoOAD/tBCjiIMHjsMmBCUKIZO6DDw+qIpYEVWGeJQKtahzLSK7ae3Y
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
E6KVM/gflyMWTg==
