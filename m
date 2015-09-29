Subject: Re: Find attributes for a type with sepol
To: William Roberts <bill.c.roberts@gmail.com>,
 Joshua Brindle <brindle@quarksecurity.com>
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov> <5603F39A.6060607@tycho.nsa.gov>
 <5604018A.5030805@quarksecurity.com>
 <CAFftDdrfvJVhCifZ4tpoBd89v-RSDF2v9gYm3RwbBNFZHzqFcQ@mail.gmail.com>
 <560AE27B.7070602@quarksecurity.com>
 <CAFftDdpyUtkUKeRg7d98vVeU3ZOWMq1RCr+5DHcyOur2xh_gYw@mail.gmail.com>
 <560AE7E4.4040401@quarksecurity.com>
 <CAFftDdomOar=2iq-Ur6yBSj-d7M2WwrRiFbU=VqEptAmFFkPvg@mail.gmail.com>
 <CAFftDdqt0JOCRDtW_KzVcbG_ZkX5mX3p6L5_HjE2E9Ciheu5Jg@mail.gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AF3BA.1010905@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 16:25:30 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdqt0JOCRDtW_KzVcbG_ZkX5mX3p6L5_HjE2E9Ciheu5Jg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/29/2015 04:19 PM, William Roberts wrote:
> So is this information only available at compile time? I see that the
> types field is
> empty for both attributes and types. Perhaps my code is wrong to do
> this, but
> I can loop over the ebitmap entries from the attr_type and type_attr
> maps just
> fine.

Yes, it is discarded from the binary policy, which instead has 
type_attr_map and attr_type_map.
