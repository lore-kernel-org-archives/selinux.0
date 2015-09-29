MIME-Version: 1.0
In-Reply-To: <560AF3BA.1010905@tycho.nsa.gov>
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
Date: Tue, 29 Sep 2015 13:51:02 -0700
Message-ID: <CAFftDdqM_FG1gmXNiuALiguMWe2fam+T03qSO=8Q67XCp+eFqg@mail.gmail.com>
Subject: Re: Find attributes for a type with sepol
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <brindle@quarksecurity.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=f46d04462e54cdb96d0520e8f862
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d04462e54cdb96d0520e8f862
Content-Type: text/plain; charset=UTF-8

On Tue, Sep 29, 2015 at 1:25 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/29/2015 04:19 PM, William Roberts wrote:
>
>> So is this information only available at compile time? I see that the
>> types field is
>> empty for both attributes and types. Perhaps my code is wrong to do
>> this, but
>> I can loop over the ebitmap entries from the attr_type and type_attr
>> maps just
>> fine.
>>
>
> Yes, it is discarded from the binary policy, which instead has
> type_attr_map and attr_type_map.
>
> According to a comment in the struct attr_type_map is discarded as well,
which would make sense
given that the per-attribute type map is thrown away as well.

aosp/external/selinux/libsepol/include/sepol$ grep -rn 'attr_type_map' *
policydb/policydb.h:575: ebitmap_t *attr_type_map; /* not saved in the
binary policy */


-- 
Respectfully,

William C Roberts

--f46d04462e54cdb96d0520e8f862
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Sep 29, 2015 at 1:25 PM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><span class=3D"">On 09/29/2015 04:1=
9 PM, William Roberts wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
So is this information only available at compile time? I see that the<br>
types field is<br>
empty for both attributes and types. Perhaps my code is wrong to do<br>
this, but<br>
I can loop over the ebitmap entries from the attr_type and type_attr<br>
maps just<br>
fine.<br>
</blockquote>
<br></span>
Yes, it is discarded from the binary policy, which instead has type_attr_ma=
p and attr_type_map.<br><br>
</blockquote></div>According to a comment in the struct attr_type_map is di=
scarded as well, which would make sense</div><div class=3D"gmail_extra">giv=
en that the per-attribute type map is thrown away as well.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><div class=3D"gmail_e=
xtra">aosp/external/selinux/libsepol/include/sepol$ grep -rn &#39;attr_type=
_map&#39; *</div><div class=3D"gmail_extra">policydb/policydb.h:575:<span c=
lass=3D"" style=3D"white-space:pre">	</span>ebitmap_t *attr_type_map;<span =
class=3D"" style=3D"white-space:pre">	</span>/* not saved in the binary pol=
icy */</div></div><div><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div></div>

--f46d04462e54cdb96d0520e8f862--
