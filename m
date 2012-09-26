Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8QIf1Td028648
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2012 14:41:01 -0400
Received: by wgbdt14 with SMTP id dt14so551972wgb.30
        for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2012 11:40:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <33006C99F5A5194A9B7A7715DFA3E3836519B212@ALA-MBA.corp.ad.wrs.com>
References: <CAFftDdr2YZiyFWfiyABAD_p81Usfz8SFeqaWBR7Uz40mJMFHhg@mail.gmail.com>
	<1347627083.11029.12.camel@moss-pluto.epoch.ncsc.mil>
	<33006C99F5A5194A9B7A7715DFA3E3836519B104@ALA-MBA.corp.ad.wrs.com>
	<1347640163.11029.61.camel@moss-pluto.epoch.ncsc.mil>
	<33006C99F5A5194A9B7A7715DFA3E3836519B212@ALA-MBA.corp.ad.wrs.com>
Date: Wed, 26 Sep 2012 14:40:33 -0400
Message-ID: <CADQgGG0S9uFmjAyQK4PZO3nZROVDBGaq8T=xcD=fTa3RVP22Ag@mail.gmail.com>
Subject: Re: Update to docs
From: Robert Craig <robertpcraig@gmail.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=20cf30207fc46fcab504ca9f2885
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--20cf30207fc46fcab504ca9f2885
Content-Type: multipart/alternative; boundary=20cf30207fc46fcab004ca9f2883

--20cf30207fc46fcab004ca9f2883
Content-Type: text/plain; charset=ISO-8859-1

Attached is a patch to help address the need for better per-device
maintainability.
Here are some general notes concerning functionality.

- An 'sepolicy' subdirectory is now required under device directories.
- Two per-device product variables are now available:
PRODUCT_SEPOLICY_REPLACE and PRODUCT_SEPOLICY_UNION.
  These variables should be set somewhere within one of your device
specific makefiles.
- No longer allow an 'sepolicy.' prefix (except *te files). Under the
sepolicy directory, names revert back to their original
  forms( i.e. file_contexts, property_contexts, genfs_contexts). te files
may be named with whatever prefix is deemed
  appropriate but must end with '.te'.
- When listing a policy file in PRODUCT_SEPOLICY_REPLACE the entire
original file is replaced. This patch doesn't offer any
  type of surgical strike inside policy files. So in most case you'll have
to copy over the original file first then make your
  rule/label change(s).
- Unions work just as with the previous functionality, appended to the end.

As always, I welcome any additional ideas or comments.

On Fri, Sep 14, 2012 at 4:28 PM, Radzykewycz, T (Radzy) <radzy@windriver.com
> wrote:

> Sounds good.  I haven't thought about the implementation at all.
>
> ________________________________________
> From: Stephen Smalley [sds@tycho.nsa.gov]
> Sent: Friday, September 14, 2012 9:29 AM
> To: Radzykewycz, T (Radzy)
> Cc: William Roberts; selinux@tycho.nsa.gov; Craig, Robert P.
> Subject: Re: Update to docs
>
> On Fri, 2012-09-14 at 16:19 +0000, Radzykewycz, T (Radzy) wrote:
> > There have been a couple times when I wanted to remove a rule from the
> > system policy for a specific BSP.  So I guess I would vote for
> > override if I need to choose one or the other.  But would it be
> > reasonable to allow both overrides and concatenates ?  That would be
> > my preference.
>
> Maybe we could provide two variables definitions in the makefiles, one
> for policy files that should replace/override and one for policy files
> that should concatenate/union with the base policy files?
>
> --
> Stephen Smalley
> National Security Agency
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--20cf30207fc46fcab004ca9f2883
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Attached is a patch to help address the need for better per-device mai=
ntainability.</div><div>Here are some general notes concerning functionalit=
y.</div><div><br></div><div>- An &#39;sepolicy&#39; subdirectory is now req=
uired under device directories.</div>
<div>- Two per-device product variables are now available: PRODUCT_SEPOLICY=
_REPLACE and PRODUCT_SEPOLICY_UNION.</div><div>=A0 These variables should b=
e set somewhere within one of your device specific makefiles.</div><div>- N=
o longer allow an &#39;sepolicy.&#39; prefix (except *te files). Under the =
sepolicy directory, names revert back to their original</div>
<div>=A0 forms( i.e. file_contexts, property_contexts, genfs_contexts). te =
files may be named with whatever prefix is deemed</div><div>=A0 appropriate=
 but must end with &#39;.te&#39;.</div><div>- When listing a policy file in=
 PRODUCT_SEPOLICY_REPLACE the entire original file is replaced. This patch =
doesn&#39;t offer any</div>
<div>=A0 type of surgical strike inside policy files. So in most case you&#=
39;ll have to copy over the original file first then make your</div><div>=
=A0 rule/label change(s).</div><div>- Unions work just as with the previous=
 functionality, appended to the end.=A0</div>
<div><br></div><div>As always, I welcome any additional ideas or comments.<=
/div><br><div class=3D"gmail_quote">On Fri, Sep 14, 2012 at 4:28 PM, Radzyk=
ewycz, T (Radzy) <span dir=3D"ltr">&lt;<a href=3D"mailto:radzy@windriver.co=
m" target=3D"_blank">radzy@windriver.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Sounds good. =A0I haven&#39;t thought about =
the implementation at all.<br>
<br>
________________________________________<br>
From: Stephen Smalley [<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.g=
ov</a>]<br>
Sent: Friday, September 14, 2012 9:29 AM<br>
To: Radzykewycz, T (Radzy)<br>
Cc: William Roberts; <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho=
.nsa.gov</a>; Craig, Robert P.<br>
<div class=3D"im HOEnZb">Subject: Re: Update to docs<br>
<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">On Fri, 2012-09-14 at 16:19 +=
0000, Radzykewycz, T (Radzy) wrote:<br>
&gt; There have been a couple times when I wanted to remove a rule from the=
<br>
&gt; system policy for a specific BSP. =A0So I guess I would vote for<br>
&gt; override if I need to choose one or the other. =A0But would it be<br>
&gt; reasonable to allow both overrides and concatenates ? =A0That would be=
<br>
&gt; my preference.<br>
<br>
Maybe we could provide two variables definitions in the makefiles, one<br>
for policy files that should replace/override and one for policy files<br>
that should concatenate/union with the base policy files?<br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</div></div></blockquote></div><br>

--20cf30207fc46fcab004ca9f2883--

--20cf30207fc46fcab504ca9f2885
Content-Type: application/octet-stream; name="external_sepolicy.patch"
Content-Disposition: attachment; filename="external_sepolicy.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h7krlnnz0

ZGlmZiAtLWdpdCBhL0FuZHJvaWQubWsgYi9BbmRyb2lkLm1rCmluZGV4IGQzYjIxYmIuLjkzZTg4
OGUgMTAwNjQ0Ci0tLSBhL0FuZHJvaWQubWsKKysrIGIvQW5kcm9pZC5tawpAQCAtMTUsMTUgKzE1
LDQ4IEBAIE1MU19TRU5TPTEKIE1MU19DQVRTPTEwMjQKIAogTE9DQUxfUE9MSUNZX0RJUlMgOj0g
JChTUkNfVEFSR0VUX0RJUikvYm9hcmQvJChUQVJHRVRfREVWSUNFKS8gZGV2aWNlLyovJChUQVJH
RVRfREVWSUNFKS8gdmVuZG9yLyovJChUQVJHRVRfREVWSUNFKS8KLQotTE9DQUxfUE9MSUNZX0ZD
IDo9ICQod2lsZGNhcmQgJChhZGRzdWZmaXggc2Vwb2xpY3kuZmMsICQoTE9DQUxfUE9MSUNZX0RJ
UlMpKSkKLUxPQ0FMX1BPTElDWV9URSA6PSAkKHdpbGRjYXJkICQoYWRkc3VmZml4IHNlcG9saWN5
LnRlLCAkKExPQ0FMX1BPTElDWV9ESVJTKSkpCi1MT0NBTF9QT0xJQ1lfUEMgOj0gJCh3aWxkY2Fy
ZCAkKGFkZHN1ZmZpeCBzZXBvbGljeS5wYywgJChMT0NBTF9QT0xJQ1lfRElSUykpKQotTE9DQUxf
UE9MSUNZX0ZTX1VTRSA6PSAkKHdpbGRjYXJkICQoYWRkc3VmZml4IHNlcG9saWN5LmZzX3VzZSwg
JChMT0NBTF9QT0xJQ1lfRElSUykpKQotTE9DQUxfUE9MSUNZX1BPUlRfQ09OVEVYVFMgOj0gJCh3
aWxkY2FyZCAkKGFkZHN1ZmZpeCBzZXBvbGljeS5wb3J0X2NvbnRleHRzLCAkKExPQ0FMX1BPTElD
WV9ESVJTKSkpCi1MT0NBTF9QT0xJQ1lfR0VORlNfQ09OVEVYVFMgOj0gJCh3aWxkY2FyZCAkKGFk
ZHN1ZmZpeCBzZXBvbGljeS5nZW5mc19jb250ZXh0cywgJChMT0NBTF9QT0xJQ1lfRElSUykpKQot
TE9DQUxfUE9MSUNZX0lOSVRJQUxfU0lEX0NPTlRFWFRTIDo9ICQod2lsZGNhcmQgJChhZGRzdWZm
aXggc2Vwb2xpY3kuaW5pdGlhbF9zaWRfY29udGV4dHMsICQoTE9DQUxfUE9MSUNZX0RJUlMpKSkK
LUxPQ0FMX1BPTElDWV9TQyA6PSAkKHdpbGRjYXJkICQoYWRkc3VmZml4IHNlYXBwX2NvbnRleHRz
LCAkKExPQ0FMX1BPTElDWV9ESVJTKSkpCitMT0NBTF9TRVBPTElDWV9ESVJTIDo9ICQoYWRkc3Vm
Zml4IHNlcG9saWN5LCAkKExPQ0FMX1BPTElDWV9ESVJTKSkKKworIyBRdWljayBlZGdlIGNhc2Ug
ZXJyb3IgZGV0ZWN0aW9uIGZvciBQUk9EVUNUX1NFUE9MSUNZX1JFUExBQ0UuCisjIEJ1aWxkcyB0
aGUgc2luZ3VsYXIgcGF0aCBmb3IgZWFjaCByZXBsYWNlIGZpbGUuCitMT0NBTF9TRVBPTElDWV9S
RVBMQUNFX1BBVEhTIDo9CiskKGZvcmVhY2ggcGYsICQoUFJPRFVDVF9TRVBPTElDWV9SRVBMQUNF
KSwgXAorICAkKGlmICQoZmlsdGVyICQocGYpLCAkKFBST0RVQ1RfU0VQT0xJQ1lfVU5JT04pKSwg
XAorICAgICQoZXJyb3IgQW1iaWd1b3VzIHJlcXVlc3QgZm9yIHNlcG9saWN5ICQocGYpLiBBcHBl
YXJzIGluIGJvdGggXAorICAgICAgUFJPRFVDVF9TRVBPTElDWV9SRVBMQUNFIGFuZCBQUk9EVUNU
X1NFUE9MSUNZX1VOSU9OKSwgXAorICApIFwKKyAgJChldmFsIF9wYXRocyA6PSAkKHdpbGRjYXJk
ICQoYWRkc3VmZml4IC8kKHBmKSwgJChMT0NBTF9TRVBPTElDWV9ESVJTKSkpKSBcCisgICQoZXZh
bCBfb2NjdXJlbmNlcyA6PSAkKHdvcmRzICQoX3BhdGhzKSkpIFwKKyAgJChpZiAkKGZpbHRlciAw
LCQoX29jY3VyZW5jZXMpKSwgXAorICAgICQoZXJyb3IgTm8gc2Vwb2xpY3kgZmlsZSBmb3VuZCBm
b3IgJChwZikgaW4gJChMT0NBTF9TRVBPTElDWV9ESVJTKSksIFwKKyAgKSBcCisgICQoaWYgJChm
aWx0ZXIgMSwgJChfb2NjdXJlbmNlcykpLCBcCisgICAgJChldmFsIExPQ0FMX1NFUE9MSUNZX1JF
UExBQ0VfUEFUSFMgKz0gJChfcGF0aHMpKSwgXAorICAgICQoZXJyb3IgTXVsdGlwbGUgb2NjdXJl
bmNlcyBvZiByZXBsYWNlIGZpbGUgJChwZikgaW4gJChfcGF0aHMpKSBcCisgICkgXAorICAkKGlm
ICQoZmlsdGVyIDAsICQod29yZHMgJCh3aWxkY2FyZCAkKGFkZHN1ZmZpeCAvJChwZiksICQoTE9D
QUxfUEFUSCkpKSkpLCBcCisgICAgJChlcnJvciBTcGVjaWZpZWQgdGhlIHNlcG9saWN5IGZpbGUg
JChwZikgaW4gUFJPRFVDVF9TRVBPTElDWV9SRVBMQUNFLCBcCisgICAgICBidXQgbm9uZSBmb3Vu
ZCBpbiAkKExPQ0FMX1BBVEgpKSwgXAorICApIFwKKykKKworIyBCdWlsZHMgcGF0aHMgZm9yIGFs
bCByZXF1ZXN0ZWQgcG9saWN5IGZpbGVzIHcuci50CisjIGJvdGggUFJPRFVDVF9TRVBPTElDWV9S
RVBMQUNFIGFuZCBQUk9EVUNUX1NFUE9MSUNZX1VOSU9OCisjIHByb2R1Y3QgdmFyaWFibGVzLgor
IyAkKDEpOiB0aGUgc2V0IG9mIHBvbGljeSBuYW1lIHBhdGhzIHRvIGJ1aWxkCitidWlsZF9wb2xp
Y3kgPSAkKGZvcmVhY2ggdHlwZSwgJCgxKSwgXAorICAkKGZvcmVhY2ggZXhwYW5kZWRfdHlwZSwg
JChub3RkaXIgJCh3aWxkY2FyZCAkKGFkZHN1ZmZpeCAvJCh0eXBlKSwgJChMT0NBTF9QQVRIKSkp
KSwgXAorICAgICQoaWYgJChmaWx0ZXIgJChleHBhbmRlZF90eXBlKSwgJChQUk9EVUNUX1NFUE9M
SUNZX1JFUExBQ0UpKSwgXAorICAgICAgJCh3aWxkY2FyZCAkKGFkZHN1ZmZpeCAkKGV4cGFuZGVk
X3R5cGUpLCAkKGRpciAkKExPQ0FMX1NFUE9MSUNZX1JFUExBQ0VfUEFUSFMpKSkpLCBcCisgICAg
ICAkKExPQ0FMX1BBVEgpLyQoZXhwYW5kZWRfdHlwZSkgXAorICAgICkgXAorICApIFwKKyAgJChm
b3JlYWNoIHVuaW9uX3BvbGljeSwgJCh3aWxkY2FyZCAkKGFkZHN1ZmZpeCAvJCh0eXBlKSwgJChM
T0NBTF9TRVBPTElDWV9ESVJTKSkpLCBcCisgICAgJChpZiAkKGZpbHRlciAkKG5vdGRpciAkKHVu
aW9uX3BvbGljeSkpLCAkKFBST0RVQ1RfU0VQT0xJQ1lfVU5JT04pKSwgXAorICAgICAgJCh1bmlv
bl9wb2xpY3kpLCBcCisgICAgKSBcCisgICkgXAorKQogCiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjCiBpbmNsdWRlICQoQ0xFQVJfVkFSUykKQEAgLTM4LDcgKzcxLDcgQEAgaW5j
bHVkZSAkKEJVSUxEX1NZU1RFTSkvYmFzZV9ydWxlcy5tawogc2Vwb2xpY3lfcG9saWN5LmNvbmYg
Oj0gJChpbnRlcm1lZGlhdGVzKS9wb2xpY3kuY29uZgogJChzZXBvbGljeV9wb2xpY3kuY29uZik6
IFBSSVZBVEVfTUxTX1NFTlMgOj0gJChNTFNfU0VOUykKICQoc2Vwb2xpY3lfcG9saWN5LmNvbmYp
OiBQUklWQVRFX01MU19DQVRTIDo9ICQoTUxTX0NBVFMpCi0kKHNlcG9saWN5X3BvbGljeS5jb25m
KSA6ICQod2lsZGNhcmQgJChhZGRwcmVmaXggJChMT0NBTF9QQVRIKS8sc2VjdXJpdHlfY2xhc3Nl
cyBpbml0aWFsX3NpZHMgYWNjZXNzX3ZlY3RvcnMgZ2xvYmFsX21hY3JvcyBtbHNfbWFjcm9zIG1s
cyBwb2xpY3lfY2FwYWJpbGl0aWVzIHRlX21hY3JvcyBhdHRyaWJ1dGVzICoudGUpICQoTE9DQUxf
UE9MSUNZX1RFKSAkKGFkZHByZWZpeCAkKExPQ0FMX1BBVEgpLywgcm9sZXMgdXNlcnMgaW5pdGlh
bF9zaWRfY29udGV4dHMpICQoTE9DQUxfUE9MSUNZX0lOSVRJQUxfU0lEX0NPTlRFWFRTKSAkKGFk
ZHByZWZpeCAkKExPQ0FMX1BBVEgpLyxmc191c2UpICQoTE9DQUxfUE9MSUNZX0ZTX1VTRSkgJChh
ZGRwcmVmaXggJChMT0NBTF9QQVRIKS8sZ2VuZnNfY29udGV4dHMpICQoTE9DQUxfUE9MSUNZX0dF
TkZTX0NPTlRFWFRTKSAkKGFkZHByZWZpeCAkKExPQ0FMX1BBVEgpLyxwb3J0X2NvbnRleHRzKSAk
KExPQ0FMX1BPTElDWV9QT1JUX0NPTlRFWFRTKSkKKyQoc2Vwb2xpY3lfcG9saWN5LmNvbmYpIDog
JChjYWxsIGJ1aWxkX3BvbGljeSwgc2VjdXJpdHlfY2xhc3NlcyBpbml0aWFsX3NpZHMgYWNjZXNz
X3ZlY3RvcnMgZ2xvYmFsX21hY3JvcyBtbHNfbWFjcm9zIG1scyBwb2xpY3lfY2FwYWJpbGl0aWVz
IHRlX21hY3JvcyBhdHRyaWJ1dGVzICoudGUgcm9sZXMgdXNlcnMgaW5pdGlhbF9zaWRfY29udGV4
dHMgZnNfdXNlIGdlbmZzX2NvbnRleHRzIHBvcnRfY29udGV4dHMpCiAJQG1rZGlyIC1wICQoZGly
ICRAKQogCSQoaGlkZSkgbTQgLUQgbWxzX251bV9zZW5zPSQoUFJJVkFURV9NTFNfU0VOUykgLUQg
bWxzX251bV9jYXRzPSQoUFJJVkFURV9NTFNfQ0FUUykgLXMgJF4gPiAkQAogCkBAIC01OCw3ICs5
MSw3IEBAIExPQ0FMX01PRFVMRV9QQVRIIDo9ICQoVEFSR0VUX1JPT1RfT1VUKQogaW5jbHVkZSAk
KEJVSUxEX1NZU1RFTSkvYmFzZV9ydWxlcy5tawogCiBmaWxlX2NvbnRleHRzIDo9ICQoaW50ZXJt
ZWRpYXRlcykvZmlsZV9jb250ZXh0cwotJChmaWxlX2NvbnRleHRzKTogJChMT0NBTF9QQVRIKS9m
aWxlX2NvbnRleHRzICQoTE9DQUxfUE9MSUNZX0ZDKQorJChmaWxlX2NvbnRleHRzKTogJChjYWxs
IGJ1aWxkX3BvbGljeSwgZmlsZV9jb250ZXh0cykKIAlAbWtkaXIgLXAgJChkaXIgJEApCiAJJCho
aWRlKSBtNCAtcyAkXiA+ICRACiAKQEAgLTc0LDcgKzEwNyw3IEBAIExPQ0FMX01PRFVMRV9QQVRI
IDo9ICQoVEFSR0VUX1JPT1RfT1VUKQogaW5jbHVkZSAkKEJVSUxEX1NZU1RFTSkvYmFzZV9ydWxl
cy5tawogCiBzZWFwcF9jb250ZXh0cy50bXAgOj0gJChpbnRlcm1lZGlhdGVzKS9zZWFwcF9jb250
ZXh0cy50bXAKLSQoc2VhcHBfY29udGV4dHMudG1wKTogJChMT0NBTF9QQVRIKS9zZWFwcF9jb250
ZXh0cyAkKExPQ0FMX1BPTElDWV9TQykKKyQoc2VhcHBfY29udGV4dHMudG1wKTogJChjYWxsIGJ1
aWxkX3BvbGljeSwgc2VhcHBfY29udGV4dHMpCiAJQG1rZGlyIC1wICQoZGlyICRAKQogCSQoaGlk
ZSkgbTQgLXMgJF4gPiAkQAogCkBAIC05NCw3ICsxMjcsNyBAQCBMT0NBTF9NT0RVTEVfUEFUSCA6
PSAkKFRBUkdFVF9ST09UX09VVCkKIGluY2x1ZGUgJChCVUlMRF9TWVNURU0pL2Jhc2VfcnVsZXMu
bWsKIAogcHJvcGVydHlfY29udGV4dHMgOj0gJChpbnRlcm1lZGlhdGVzKS9wcm9wZXJ0eV9jb250
ZXh0cwotJChwcm9wZXJ0eV9jb250ZXh0cyk6ICQoTE9DQUxfUEFUSCkvcHJvcGVydHlfY29udGV4
dHMgJChMT0NBTF9QT0xJQ1lfUEMpCiskKHByb3BlcnR5X2NvbnRleHRzKTogJChjYWxsIGJ1aWxk
X3BvbGljeSwgcHJvcGVydHlfY29udGV4dHMpCiAJQG1rZGlyIC1wICQoZGlyICRAKQogCSQoaGlk
ZSkgbTQgLXMgJF4gPiAkQAogCg==
--20cf30207fc46fcab504ca9f2885--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
