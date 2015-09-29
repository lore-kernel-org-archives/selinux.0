Subject: Re: Find attributes for a type with sepol
To: William Roberts <bill.c.roberts@gmail.com>
References: <476DC76E7D1DF2438D32BFADF679FC5601077F23@ORSMSX103.amr.corp.intel.com>
 <5603EFE8.6010505@tycho.nsa.gov> <5603F39A.6060607@tycho.nsa.gov>
 <5604018A.5030805@quarksecurity.com>
 <CAFftDdrfvJVhCifZ4tpoBd89v-RSDF2v9gYm3RwbBNFZHzqFcQ@mail.gmail.com>
 <560AE27B.7070602@quarksecurity.com>
 <CAFftDdpyUtkUKeRg7d98vVeU3ZOWMq1RCr+5DHcyOur2xh_gYw@mail.gmail.com>
 <560AE7E4.4040401@quarksecurity.com>
 <CAFftDdomOar=2iq-Ur6yBSj-d7M2WwrRiFbU=VqEptAmFFkPvg@mail.gmail.com>
 <CAFftDdqt0JOCRDtW_KzVcbG_ZkX5mX3p6L5_HjE2E9Ciheu5Jg@mail.gmail.com>
 <560AF3BA.1010905@tycho.nsa.gov>
 <CAFftDdqM_FG1gmXNiuALiguMWe2fam+T03qSO=8Q67XCp+eFqg@mail.gmail.com>
Cc: Joshua Brindle <brindle@quarksecurity.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <560AFCF5.6050900@tycho.nsa.gov>
Date: Tue, 29 Sep 2015 17:04:53 -0400
MIME-Version: 1.0
In-Reply-To: <CAFftDdqM_FG1gmXNiuALiguMWe2fam+T03qSO=8Q67XCp+eFqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/29/2015 04:51 PM, William Roberts wrote:
>
>
> On Tue, Sep 29, 2015 at 1:25 PM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
>
>     On 09/29/2015 04:19 PM, William Roberts wrote:
>
>         So is this information only available at compile time? I see
>         that the
>         types field is
>         empty for both attributes and types. Perhaps my code is wrong to do
>         this, but
>         I can loop over the ebitmap entries from the attr_type and type_attr
>         maps just
>         fine.
>
>
>     Yes, it is discarded from the binary policy, which instead has
>     type_attr_map and attr_type_map.
>
> According to a comment in the struct attr_type_map is discarded as well,
> which would make sense
> given that the per-attribute type map is thrown away as well.
>
> aosp/external/selinux/libsepol/include/sepol$ grep -rn 'attr_type_map' *
> policydb/policydb.h:575:ebitmap_t *attr_type_map;/* not saved in the
> binary policy */

It is re-created on load; see policydb_read().  So it is always 
available to you.
