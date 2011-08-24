Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OAWGCE025704
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 06:32:16 -0400
Received: from snt0-omc4-s32.snt0.hotmail.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OAWES9007389
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 10:32:15 GMT
Message-ID: <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_83eab0c1-f2e5-49d4-85fc-8ca898da4c7d_"
From: HarryCiao <harrytaurus2002@hotmail.com>
To: <cpebenito@tresys.com>, <dwalsh@redhat.com>
CC: <qingtao.cao@windriver.com>, <slawrence@tresys.com>,
        <selinux@tycho.nsa.gov>
Subject: RE: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in
 expansion.
Date: Wed, 24 Aug 2011 10:32:13 +0000
In-Reply-To: <4E53B1E8.2050508@tresys.com>
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com>
 <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com>
 <4E53AE8C.6020707@redhat.com>,<4E53B1E8.2050508@tresys.com>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_83eab0c1-f2e5-49d4-85fc-8ca898da4c7d_
Content-Type: multipart/alternative;
	boundary="_bb7157ab-760d-4a9b-be31-260184e32f10_"

--_bb7157ab-760d-4a9b-be31-260184e32f10_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi Chris,

> Date: Tue, 23 Aug 2011 09:58:00 -0400
> From: cpebenito@tresys.com
> To: dwalsh@redhat.com
> CC: qingtao.cao@windriver.com; slawrence@tresys.com; selinux@tycho.nsa.gov
> Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
> 
> On 08/23/11 09:43, Daniel J Walsh wrote:
> > Eliminating booleans would be great and replacing them with tunables,
> > but the tunables must be discoverable, and it must be easy for the
> > administrator to discover the "tunable" and turn it on.
> > 
> > Currently audit2allow/audit2why turns on all booleans in a policy and
> > checks to see if an AVC would be allowed with any boolean.  Then it
> > prints out the booleans that would have allowed the access.  We use
> > this functionality within setroubleshoot.  This is critical to making
> > selinux policy usable.
> > 
> > User wants to allow ftp to access homedirs, he sets up ftp and SELinux
> > blocks the access.  Setroubleshoot comes up and says turn on the
> > ftp_home_dir boolean to allow this access.
> > 
> > 
> > If we can not duplicate this functionality then I NAK the change from
> > booleans to tunables.
> 
> Seems very easy to reproduce, as long as you turn on save-linked in
> semanage.conf.  The linked policy would have all the tunable
> information, right Harry?
> 

The implementation of the save-linked option has no idea about the effort to separate tunables from booleans, so I am afraid  it won't help much.

However, you did enlighten me to create a new option "handle-tunable" for semanage.conf, then we can specify whether discarding tunable is desirable and its value would be saved into a new member "handle_tunable" in policydb_t. Then in the separation_tunables() in link.c, policydb_t.handle_tunable would be consulted about how to handle tunables.

By default this handle-tunable option for semanage.conf could be set to "discard", if audit2allow/audit2why are needed to debug AVC denied messages, we could set this option to "preserve" and rebuild and reload policy.X. When the related tunable is found we could toggle its default value to true and rebuild policy.X with the option back to "discard" again.

This way I think Dan's worries would be addressed. Right?

BTW, Is this the correct or best way to pass configuration options on to link process? I have created two patches for above logic(see attached), however I am pretty new to semanage and run into syntax error while parsing semanage.conf. Chris, could you please kindly take a look at what has been wrong in my 0007 patch? Many thanks!

Cheers,
Harry


> -- 
> Chris PeBenito
> Tresys Technology, LLC
> www.tresys.com | oss.tresys.com
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
 		 	   		  
--_bb7157ab-760d-4a9b-be31-260184e32f10_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
font-size: 10pt;
font-family:Î¢ÈíÑÅºÚ
}
--></style>
</head>
<body class='hmmessage'><div dir='ltr'>
Hi Chris,<br><br><div>&gt; Date: Tue, 23 Aug 2011 09:58:00 -0400<br>&gt; From: cpebenito@tresys.com<br>&gt; To: dwalsh@redhat.com<br>&gt; CC: qingtao.cao@windriver.com; slawrence@tresys.com; selinux@tycho.nsa.gov<br>&gt; Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.<br>&gt; <br>&gt; On 08/23/11 09:43, Daniel J Walsh wrote:<br>&gt; &gt; Eliminating booleans would be great and replacing them with tunables,<br>&gt; &gt; but the tunables must be discoverable, and it must be easy for the<br>&gt; &gt; administrator to discover the "tunable" and turn it on.<br>&gt; &gt; <br>&gt; &gt; Currently audit2allow/audit2why turns on all booleans in a policy and<br>&gt; &gt; checks to see if an AVC would be allowed with any boolean.  Then it<br>&gt; &gt; prints out the booleans that would have allowed the access.  We use<br>&gt; &gt; this functionality within setroubleshoot.  This is critical to making<br>&gt; &gt; selinux policy usable.<br>&gt; &gt; <br>&!
 gt; &gt; User wants to allow ftp to access homedirs, he sets up ftp and SELinux<br>&gt; &gt; blocks the access.  Setroubleshoot comes up and says turn on the<br>&gt; &gt; ftp_home_dir boolean to allow this access.<br>&gt; &gt; <br>&gt; &gt; <br>&gt; &gt; If we can not duplicate this functionality then I NAK the change from<br>&gt; &gt; booleans to tunables.<br>&gt; <br>&gt; Seems very easy to reproduce, as long as you turn on save-linked in<br>&gt; semanage.conf.  The linked policy would have all the tunable<br>&gt; information, right Harry?<br>&gt; <br><br>The implementation of the save-linked option has no idea about the effort to separate tunables from booleans, so I am afraid&nbsp; it won't help much.<br><br>However, you did enlighten me to create a new option "handle-tunable" for semanage.conf, then we can specify whether discarding tunable is desirable and its value would be saved into a new member "handle_tunable" in policydb_t. Then in the separation_tunables() in l!
 ink.c, policydb_t.handle_tunable would be consulted about how to handl
e tunables.<br><br>By default this handle-tunable option for semanage.conf could be set to "discard", if audit2allow/audit2why are needed to debug AVC denied messages, we could set this option to "preserve" and rebuild and reload policy.X. When the related tunable is found we could toggle its default value to true and rebuild policy.X with the option back to "discard" again.<br><br>This way I think Dan's worries would be addressed. Right?<br><br>BTW, Is this the correct or best way to pass configuration options on to link process? I have created two patches for above logic(see attached), however I am pretty new to semanage and run into syntax error while parsing semanage.conf. Chris, could you please kindly take a look at what has been wrong in my 0007 patch? Many thanks!<br><br>Cheers,<br>Harry<br><br><br>&gt; -- <br>&gt; Chris PeBenito<br>&gt; Tresys Technology, LLC<br>&gt; www.tresys.com | oss.tresys.com<br>&gt; <br>&gt; --<br>&gt; This message was distributed to subscrib!
 ers of the selinux mailing list.<br>&gt; If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with<br>&gt; the words "unsubscribe selinux" without quotes as the message.<br></div> 		 	   		  </div></body>
</html>
--_bb7157ab-760d-4a9b-be31-260184e32f10_--

--_83eab0c1-f2e5-49d4-85fc-8ca898da4c7d_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0007-Add-new-option-of-handle-tunable-to-semanage.conf.patch"

RnJvbSAwMjdiZGMyNjY4NTg0ZjgxN2NhMmI0ODYyMmVkYWM2ZWJmZDk5YTI5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBXZWQsIDI0IEF1ZyAyMDExIDE3OjIwOjI5ICswODAwClN1YmplY3Q6IFtQQVRDSCA3
LzhdIEFkZCBuZXcgb3B0aW9uIG9mICJoYW5kbGUtdHVuYWJsZSIgdG8gc2VtYW5hZ2UuY29uZgoK
QWRkIGEgbmV3IG9wdGlvbiBvZiAiaGFuZGxlLXR1bmFibGUiIHRvIHNlbWFuYWdlLmNvbmYsIHdo
aWNoIGlzIHVzZWQKdG8gaW5kaWNhdGUgaG93IHRvIGhhbmRsZSB0dW5hYmxlcyBkdXJpbmcgbGlu
ay9leHBhbnNpb24uCgpTaWduZWQtb2ZmLWJ5OiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5k
cml2ZXIuY29tPgotLS0KIGxpYnNlbWFuYWdlL3NyYy9jb25mLXBhcnNlLnkgICAgICAgICAgICAg
ICB8ICAgMTQgKysrKysrKysrKysrKysKIGxpYnNlbWFuYWdlL3NyYy9jb25mLXNjYW4ubCAgICAg
ICAgICAgICAgICB8ICAgIDEgKwogbGlic2VtYW5hZ2Uvc3JjL3NlbWFuYWdlX2NvbmYuaCAgICAg
ICAgICAgIHwgICAgMSArCiBsaWJzZW1hbmFnZS9zcmMvc2VtYW5hZ2Vfc3RvcmUuYyAgICAgICAg
ICAgfCAgICAyICsrCiBsaWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiLmggICAgICAgICAg
fCAgICA1ICsrKysrCiBsaWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiL3BvbGljeWRiLmgg
fCAgICA5ICsrKysrKysrKwogbGlic2Vwb2wvc3JjL2V4cGFuZC5jICAgICAgICAgICAgICAgICAg
ICAgIHwgICAgMSArCiBsaWJzZXBvbC9zcmMvcG9saWN5ZGJfcHVibGljLmMgICAgICAgICAgICAg
fCAgIDE3ICsrKysrKysrKysrKysrKysrCiA4IGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL2NvbmYtcGFy
c2UueSBiL2xpYnNlbWFuYWdlL3NyYy9jb25mLXBhcnNlLnkKaW5kZXggNzdjMDBiMi4uZTFjOTE0
OCAxMDA2NDQKLS0tIGEvbGlic2VtYW5hZ2Uvc3JjL2NvbmYtcGFyc2UueQorKysgYi9saWJzZW1h
bmFnZS9zcmMvY29uZi1wYXJzZS55CkBAIC01OSw2ICs1OSw3IEBAIHN0YXRpYyBpbnQgcGFyc2Vf
ZXJyb3JzOwogCiAldG9rZW4gTU9EVUxFX1NUT1JFIFZFUlNJT04gRVhQQU5EX0NIRUNLIEZJTEVf
TU9ERSBTQVZFX1BSRVZJT1VTIFNBVkVfTElOS0VECiAldG9rZW4gTE9BRF9QT0xJQ1lfU1RBUlQg
U0VURklMRVNfU1RBUlQgRElTQUJMRV9HRU5IT01FRElSQ09OIEhBTkRMRV9VTktOT1dOIFVTRVBB
U1NXRAorJXRva2VuIEhBTkRMRV9UVU5BQkxFCiAldG9rZW4gQlpJUF9CTE9DS1NJWkUgQlpJUF9T
TUFMTAogJXRva2VuIFZFUklGWV9NT0RfU1RBUlQgVkVSSUZZX0xJTktFRF9TVEFSVCBWRVJJRllf
S0VSTkVMX1NUQVJUIEJMT0NLX0VORAogJXRva2VuIFBST0dfUEFUSCBQUk9HX0FSR1MKQEAgLTg1
LDYgKzg2LDcgQEAgc2luZ2xlX29wdDogICAgIG1vZHVsZV9zdG9yZQogICAgICAgICB8ICAgICAg
IGRpc2FibGVfZ2VuaG9tZWRpcmNvbgogICAgICAgICB8ICAgICAgIHVzZXBhc3N3ZAogICAgICAg
ICB8ICAgICAgIGhhbmRsZV91bmtub3duCisJfAloYW5kbGVfdHVuYWJsZQogCXwJYnppcF9ibG9j
a3NpemUKIAl8CWJ6aXBfc21hbGwKICAgICAgICAgOwpAQCAtMTc5LDYgKzE4MSwxNyBAQCBoYW5k
bGVfdW5rbm93bjogSEFORExFX1VOS05PV04gJz0nIEFSRyB7CiAJZnJlZSgkMyk7CiAgfQogCito
YW5kbGVfdHVuYWJsZTogSEFORExFX1RVTkFCTEUgJz0nIEFSRyB7CisJaWYgKHN0cmNhc2VjbXAo
JDMsICJkaXNjYXJkIikgPT0gMCkgeworCQljdXJyZW50X2NvbmYtPmhhbmRsZV90dW5hYmxlID0g
U0VQT0xfRElTQ0FSRF9UVU5BQkxFOworCX0gZWxzZSBpZiAoc3RyY2FzZWNtcCgkMywgInByZXNl
cnZlIikgPT0gMCkgeworCQljdXJyZW50X2NvbmYtPmhhbmRsZV90dW5hYmxlID0gU0VQT0xfUFJF
U0VSVkVfVFVOQUJMRTsKKwl9IGVsc2UgeworCQl5eWVycm9yKCJoYW5kbGUtdHVuYWJsZSBjYW4g
b25seSBiZSAnZGlzY2FyZCcgb3IgJ3ByZXNlcnZlJyIpOworCX0KKwlmcmVlKCQzKTsKKyB9CisK
IGJ6aXBfYmxvY2tzaXplOiAgQlpJUF9CTE9DS1NJWkUgJz0nIEFSRyB7CiAJaW50IGJsb2Nrc2l6
ZSA9IGF0b2koJDMpOwogCWZyZWUoJDMpOwpAQCAtMjY1LDYgKzI3OCw3IEBAIHN0YXRpYyBpbnQg
c2VtYW5hZ2VfY29uZl9pbml0KHNlbWFuYWdlX2NvbmZfdCAqIGNvbmYpCiAJY29uZi0+cG9saWN5
dmVycyA9IHNlcG9sX3BvbGljeV9rZXJuX3ZlcnNfbWF4KCk7CiAJY29uZi0+ZXhwYW5kX2NoZWNr
ID0gMTsKIAljb25mLT5oYW5kbGVfdW5rbm93biA9IC0xOworCWNvbmYtPmhhbmRsZV90dW5hYmxl
ID0gLTE7CiAJY29uZi0+dXNlcGFzc3dkID0gMTsKIAljb25mLT5maWxlX21vZGUgPSAwNjQ0Owog
CWNvbmYtPmJ6aXBfYmxvY2tzaXplID0gOTsKZGlmZiAtLWdpdCBhL2xpYnNlbWFuYWdlL3NyYy9j
b25mLXNjYW4ubCBiL2xpYnNlbWFuYWdlL3NyYy9jb25mLXNjYW4ubAppbmRleCBlNTcxMTlkLi5j
YTQ0OWRkIDEwMDY0NAotLS0gYS9saWJzZW1hbmFnZS9zcmMvY29uZi1zY2FuLmwKKysrIGIvbGli
c2VtYW5hZ2Uvc3JjL2NvbmYtc2Nhbi5sCkBAIC00OCw2ICs0OCw3IEBAIHNhdmUtbGlua2VkICAg
ICAgIHJldHVybiBTQVZFX0xJTktFRDsKIGRpc2FibGUtZ2VuaG9tZWRpcmNvbiByZXR1cm4gRElT
QUJMRV9HRU5IT01FRElSQ09OOwogdXNlcGFzc3dkIHJldHVybiBVU0VQQVNTV0Q7CiBoYW5kbGUt
dW5rbm93biAgICByZXR1cm4gSEFORExFX1VOS05PV047CitoYW5kbGUtdHVuYWJsZSAgICByZXR1
cm4gSEFORExFX1RVTkFCTEU7CiBiemlwLWJsb2Nrc2l6ZQlyZXR1cm4gQlpJUF9CTE9DS1NJWkU7
CiBiemlwLXNtYWxsCXJldHVybiBCWklQX1NNQUxMOwogIltsb2FkX3BvbGljeV0iICAgcmV0dXJu
IExPQURfUE9MSUNZX1NUQVJUOwpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL3NlbWFuYWdl
X2NvbmYuaCBiL2xpYnNlbWFuYWdlL3NyYy9zZW1hbmFnZV9jb25mLmgKaW5kZXggZjU4ZDlhYy4u
ZGE3Y2M1OCAxMDA2NDQKLS0tIGEvbGlic2VtYW5hZ2Uvc3JjL3NlbWFuYWdlX2NvbmYuaAorKysg
Yi9saWJzZW1hbmFnZS9zcmMvc2VtYW5hZ2VfY29uZi5oCkBAIC00MCw2ICs0MCw3IEBAIHR5cGVk
ZWYgc3RydWN0IHNlbWFuYWdlX2NvbmYgewogCWludCBkaXNhYmxlX2dlbmhvbWVkaXJjb247CiAJ
aW50IHVzZXBhc3N3ZDsKIAlpbnQgaGFuZGxlX3Vua25vd247CisJaW50IGhhbmRsZV90dW5hYmxl
OwogCW1vZGVfdCBmaWxlX21vZGU7CiAJaW50IGJ6aXBfYmxvY2tzaXplOwogCWludCBiemlwX3Nt
YWxsOwpkaWZmIC0tZ2l0IGEvbGlic2VtYW5hZ2Uvc3JjL3NlbWFuYWdlX3N0b3JlLmMgYi9saWJz
ZW1hbmFnZS9zcmMvc2VtYW5hZ2Vfc3RvcmUuYwppbmRleCA4ZDZmZjFjLi40MDk4ZDhhIDEwMDY0
NAotLS0gYS9saWJzZW1hbmFnZS9zcmMvc2VtYW5hZ2Vfc3RvcmUuYworKysgYi9saWJzZW1hbmFn
ZS9zcmMvc2VtYW5hZ2Vfc3RvcmUuYwpAQCAtMTcyMyw2ICsxNzIzLDggQEAgaW50IHNlbWFuYWdl
X2V4cGFuZF9zYW5kYm94KHNlbWFuYWdlX2hhbmRsZV90ICogc2gsCiAJfQogCWlmIChzaC0+Y29u
Zi0+aGFuZGxlX3Vua25vd24gPj0gMCkKIAkJc2Vwb2xfcG9saWN5ZGJfc2V0X2hhbmRsZV91bmtu
b3duKG91dCwgc2gtPmNvbmYtPmhhbmRsZV91bmtub3duKTsKKwlpZiAoc2gtPmNvbmYtPmhhbmRs
ZV90dW5hYmxlID4gMCkKKwkJc2Vwb2xfcG9saWN5ZGJfc2V0X2hhbmRsZV90dW5hYmxlKG91dCwg
c2gtPmNvbmYtPmhhbmRsZV90dW5hYmxlKTsKIAogCSpwb2xpY3lkYiA9IG91dDsKIAlyZXR1cm4g
U1RBVFVTX1NVQ0NFU1M7CmRpZmYgLS1naXQgYS9saWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGlj
eWRiLmggYi9saWJzZXBvbC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiLmgKaW5kZXggNDNlMjNiMy4u
NTk3NWY4OCAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvaW5jbHVkZS9zZXBvbC9wb2xpY3lkYi5oCisr
KyBiL2xpYnNlcG9sL2luY2x1ZGUvc2Vwb2wvcG9saWN5ZGIuaApAQCAtMTM1LDQgKzEzNSw5IEBA
IGV4dGVybiBpbnQgc2Vwb2xfcG9saWN5ZGJfbWxzX2VuYWJsZWQoY29uc3Qgc2Vwb2xfcG9saWN5
ZGJfdCAqIHApOwogICovCiBleHRlcm4gaW50IHNlcG9sX3BvbGljeWRiX2NvbXBhdF9uZXQoY29u
c3Qgc2Vwb2xfcG9saWN5ZGJfdCAqIHApOwogCisvKiBTZXQgaG93IHRvIGhhbmRsZSB0dW5hYmxl
cyAqLworI2RlZmluZSBTRVBPTF9ESVNDQVJEX1RVTkFCTEUJICAgIDgKKyNkZWZpbmUgU0VQT0xf
UFJFU0VSVkVfVFVOQUJMRQkgICAgMTYKK2V4dGVybiBpbnQgc2Vwb2xfcG9saWN5ZGJfc2V0X2hh
bmRsZV90dW5hYmxlKHNlcG9sX3BvbGljeWRiX3QgKiBwLAorCQkJCQkgICAgIHVuc2lnbmVkIGlu
dCBoYW5kbGVfdHVuYWJsZSk7CiAjZW5kaWYKZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2luY2x1ZGUv
c2Vwb2wvcG9saWN5ZGIvcG9saWN5ZGIuaCBiL2xpYnNlcG9sL2luY2x1ZGUvc2Vwb2wvcG9saWN5
ZGIvcG9saWN5ZGIuaAppbmRleCAxODQ4YTdiLi44NzFhODk0IDEwMDY0NAotLS0gYS9saWJzZXBv
bC9pbmNsdWRlL3NlcG9sL3BvbGljeWRiL3BvbGljeWRiLmgKKysrIGIvbGlic2Vwb2wvaW5jbHVk
ZS9zZXBvbC9wb2xpY3lkYi9wb2xpY3lkYi5oCkBAIC01NDUsNiArNTQ1LDkgQEAgdHlwZWRlZiBz
dHJ1Y3QgcG9saWN5ZGIgewogCXVuc2lnbmVkIHBvbGljeXZlcnM7CiAKIAl1bnNpZ25lZCBoYW5k
bGVfdW5rbm93bjsKKworCS8qIGRpc2NhcmQgdHVuYWJsZXMgb3IgdHJlYXQgdGhlbSBhcyBib29s
ZWFucyAqLworCXVuc2lnbmVkIGhhbmRsZV90dW5hYmxlOwogfSBwb2xpY3lkYl90OwogCiBzdHJ1
Y3Qgc2Vwb2xfcG9saWN5ZGIgewpAQCAtNzA5LDYgKzcxMiwxMiBAQCBleHRlcm4gaW50IHBvbGlj
eWRiX3NldF90YXJnZXRfcGxhdGZvcm0ocG9saWN5ZGJfdCAqcCwgaW50IHBsYXRmb3JtKTsKIAog
I2RlZmluZSBQT0xJQ1lEQl9DT05GSUdfVU5LTk9XTl9NQVNLCShERU5ZX1VOS05PV04gfCBSRUpF
Q1RfVU5LTk9XTiB8IEFMTE9XX1VOS05PV04pCiAKKy8qIHRoZSBjb25maWcgZmxhZ3MgcmVsYXRl
ZCB0byBob3cgdG8gaGFuZGxlIHR1bmFibGVzIGFyZSBiaXRzIDggYW5kIDE2ICovCisjZGVmaW5l
IERJU0NBUkRfVFVOQUJMRQkJU0VQT0xfRElTQ0FSRF9UVU5BQkxFCisjZGVmaW5lIFBSRVNFUlZF
X1RVTkFCTEUJU0VQT0xfUFJFU0VSVkVfVFVOQUJMRQorCisjZGVmaW5lIFBPTElDWURCX0NPTkZJ
R19UVU5BQkxFX01BU0sJKERJU0NBUkRfVFVOQUJMRSB8IFBSRVNFUlZFX1RVTkFCTEUpCisKICNk
ZWZpbmUgT0JKRUNUX1IgIm9iamVjdF9yIgogI2RlZmluZSBPQkpFQ1RfUl9WQUwgMQogCmRpZmYg
LS1naXQgYS9saWJzZXBvbC9zcmMvZXhwYW5kLmMgYi9saWJzZXBvbC9zcmMvZXhwYW5kLmMKaW5k
ZXggZmY4YTIxNC4uYzg1ZTIzMCAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvc3JjL2V4cGFuZC5jCisr
KyBiL2xpYnNlcG9sL3NyYy9leHBhbmQuYwpAQCAtMjcxMCw2ICsyNzEwLDcgQEAgaW50IGV4cGFu
ZF9tb2R1bGUoc2Vwb2xfaGFuZGxlX3QgKiBoYW5kbGUsCiAJLyogQ29weSBtbHMgc3RhdGUgZnJv
bSBiYXNlIHRvIG91dCAqLwogCW91dC0+bWxzID0gYmFzZS0+bWxzOwogCW91dC0+aGFuZGxlX3Vu
a25vd24gPSBiYXNlLT5oYW5kbGVfdW5rbm93bjsKKwlvdXQtPmhhbmRsZV90dW5hYmxlID0gYmFz
ZS0+aGFuZGxlX3R1bmFibGU7CiAKIAkvKiBDb3B5IHRhcmdldCBmcm9tIGJhc2UgdG8gb3V0ICov
CiAJb3V0LT50YXJnZXRfcGxhdGZvcm0gPSBiYXNlLT50YXJnZXRfcGxhdGZvcm07CmRpZmYgLS1n
aXQgYS9saWJzZXBvbC9zcmMvcG9saWN5ZGJfcHVibGljLmMgYi9saWJzZXBvbC9zcmMvcG9saWN5
ZGJfcHVibGljLmMKaW5kZXggZjZhZTc5My4uYWYwODgwNiAxMDA2NDQKLS0tIGEvbGlic2Vwb2wv
c3JjL3BvbGljeWRiX3B1YmxpYy5jCisrKyBiL2xpYnNlcG9sL3NyYy9wb2xpY3lkYl9wdWJsaWMu
YwpAQCAtMTUyLDYgKzE1MiwyMyBAQCBpbnQgc2Vwb2xfcG9saWN5ZGJfc2V0X2hhbmRsZV91bmtu
b3duKHNlcG9sX3BvbGljeWRiX3QgKiBzcCwKIAlyZXR1cm4gMDsKIH0KIAoraW50IHNlcG9sX3Bv
bGljeWRiX3NldF9oYW5kbGVfdHVuYWJsZShzZXBvbF9wb2xpY3lkYl90ICogc3AsCisJCQkJICAg
ICAgdW5zaWduZWQgaW50IGhhbmRsZV90dW5hYmxlKQoreworCXN0cnVjdCBwb2xpY3lkYiAqcCA9
ICZzcC0+cDsKKworCXN3aXRjaCAoaGFuZGxlX3R1bmFibGUpIHsKKwljYXNlIFNFUE9MX0RJU0NB
UkRfVFVOQUJMRToKKwljYXNlIFNFUE9MX1BSRVNFUlZFX1RVTkFCTEU6CisJCWJyZWFrOworCWRl
ZmF1bHQ6CisJCXJldHVybiAtMTsKKwl9CisKKwlwLT5oYW5kbGVfdHVuYWJsZSA9IGhhbmRsZV90
dW5hYmxlOworCXJldHVybiAwOworfQorCiBpbnQgc2Vwb2xfcG9saWN5ZGJfcmVhZChzZXBvbF9w
b2xpY3lkYl90ICogcCwgc2Vwb2xfcG9saWN5X2ZpbGVfdCAqIHBmKQogewogCXJldHVybiBwb2xp
Y3lkYl9yZWFkKCZwLT5wLCAmcGYtPnBmLCAwKTsKLS0gCjEuNy4wLjQKCg==

--_83eab0c1-f2e5-49d4-85fc-8ca898da4c7d_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0008-handle_tunable-decides-if-tunables-are-preserved-or-.patch"

RnJvbSA2ZTQ1NDcyZmI2YmRlODI3YmMwMTI0MWVkMjY5ZmM4MjExOWRjZTYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIYXJyeSBDaWFvIDxxaW5ndGFvLmNhb0B3aW5kcml2ZXIuY29t
PgpEYXRlOiBXZWQsIDI0IEF1ZyAyMDExIDE0OjM2OjUxICswODAwClN1YmplY3Q6IFtQQVRDSCA4
LzhdIGhhbmRsZV90dW5hYmxlIGRlY2lkZXMgaWYgdHVuYWJsZXMgYXJlIHByZXNlcnZlZCBvciBk
aXNjYXJkZWQuCgpJZiBvbmUgY29uZF9ub2RlX3QncyBleHByZXNzaW9uIGp1c3QgY29udGFpbnMg
dHVuYWJsZSBpZGVudGlmaWVycywgdGhlbgpob3cgdG8gaGFuZGxlIHR1bmFibGUgd291bGQgYmUg
ZGV0ZXJtaW5lZCBieSB0aGUgaGFuZGxlX3R1bmFibGUgZmxhZwppbiBwb2xpY3lkYl90LgoKSWYg
YWxsIHR1bmFibGVzIHNob3VsZCBiZSBwcmVzZXJ2ZWQodGh1cyB0cmVhdGVkIGFzIGJvb2xlYW5z
KSwgdGhlbiB0aGUKVFVOQUJMRSBmbGFnIGJpdCB3b3VsZCBiZSBjbGVhcmVkIGluIHRoZWlyIGNv
bmRfYm9vbF9kYXR1bV90LmZsYWdzLCBzbwp0aGF0IHRoZXNlIHR1bmFibGUgaWRlbnRpZmllcnMg
d29uJ3QgYmUgZGlzY2FyZGVkIGR1cmluZyBleHBhbnNpb24sCm5laXRoZXIgd291bGQgdGhlIGNv
bmRfbm9kZV90IGV2ZXIgYmUgbWFya2VkIGFzIFRVTkFCTEUuCgpCVFcsIGlmIHR1bmFibGVzIGV2
ZXIgbWl4ZWQgd2l0aCBib29sZWFucyBpbiBvbmUgZXhwcmVzc2lvbiwgdHVuYWJsZXMKd291bGQg
YmUgdHJhbnNmb3JtZWQgYXMgYm9vbGVhbnMgYW5kIHByZXNlcnZlZCwgaW4gdGhpcyBjYXNlIHRo
ZSB2YWx1ZSBvZgpoYW5kbGVfdHVuYWJsZSB3b3VsZCBiZSBpZ25vcmVkLgoKU2lnbmVkLW9mZi1i
eTogSGFycnkgQ2lhbyA8cWluZ3Rhby5jYW9Ad2luZHJpdmVyLmNvbT4KLS0tCiBsaWJzZXBvbC9z
cmMvbGluay5jIHwgICA2NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9saWJzZXBvbC9zcmMvbGluay5jIGIvbGlic2Vwb2wvc3JjL2xp
bmsuYwppbmRleCAzNWMwNzViLi40N2QzOGM5IDEwMDY0NAotLS0gYS9saWJzZXBvbC9zcmMvbGlu
ay5jCisrKyBiL2xpYnNlcG9sL3NyYy9saW5rLmMKQEAgLTI0ODYsNiArMjQ4Niw5IEBAIHN0YXRp
YyB2b2lkIHNlcGFyYXRlX3R1bmFibGVzKGxpbmtfc3RhdGVfdCAqc3RhdGUsIHBvbGljeWRiX3Qg
KnBvbCkKIAkgKgogCSAqIElmIHR1bmFibGVzIGFuZCBib29sZWFucyBjby1leGlzdCBpbiB0aGUg
ZXhwcmVzc2lvbiBvZiBhIGNvbmRfbm9kZSwKIAkgKiB0aGVuIHR1bmFibGVzIHdvdWxkIGJlICJ0
cmFuc2Zvcm1lZCIgYXMgYm9vbGVhbnMuCisJICoKKwkgKiBJZiB0dW5hYmxlcyBhcmUgcmVxdWVz
dGVkIHRvIGJlIHByZXNlcnZlZCB0aGVuIHRoZXkgd291bGQgYmUKKwkgKiAidHJhbnNmb3JtZWQi
IGFzIGJvb2xlYW5zLgogCSAqLwogCWZvciAoYmxvY2sgPSBwb2wtPmdsb2JhbDsgYmxvY2sgIT0g
TlVMTDsgYmxvY2sgPSBibG9jay0+bmV4dCkgewogCQlkZWNsID0gYmxvY2stPmVuYWJsZWQ7CkBA
IC0yNTE2LDM1ICsyNTE5LDQyIEBAIHN0YXRpYyB2b2lkIHNlcGFyYXRlX3R1bmFibGVzKGxpbmtf
c3RhdGVfdCAqc3RhdGUsIHBvbGljeWRiX3QgKnBvbCkKIAkJCQkJYm9vbGVhbnMrKzsKIAkJCX0K
IAkJCQotCQkJaWYgKHR1bmFibGVzICYmIGJvb2xlYW5zKSB7Ci0JCQkJLyogVHVuYWJsZSBtaXhl
ZCB3aXRoIGJvb2xlYW4gKi8KLQkJCQlmb3IgKGkgPSAwOyBpIDwgdHVuYWJsZXM7IGkrKykKLQkJ
CQkJdG1wW2ldLT5mbGFncyAmPSB+Q09ORF9CT09MX0ZMQUdTX1RVTkFCTEU7Ci0JCQl9IGVsc2Ug
aWYgKHR1bmFibGVzICYmICFib29sZWFucykgewotCQkJCS8qIFB1cmUgdHVuYWJsZSBjb25kaXRp
b25hbCAqLwotCQkJCWN1cl9ub2RlLT5mbGFncyB8PSBDT05EX05PREVfRkxBR1NfVFVOQUJMRTsK
LQkJCQljdXJfc3RhdGUgPSBjb25kX2V2YWx1YXRlX2V4cHIocG9sLCBjdXJfbm9kZS0+ZXhwcik7
Ci0JCQkJaWYgKGN1cl9zdGF0ZSA9PSAtMSkgewotCQkJCQlwcmludGYoIkV4cHJlc3Npb24gcmVz
dWx0IHdhcyAiCi0JCQkJCQkidW5kZWZpbmVkLCBza2lwcGluZyBhbGwiCi0JCQkJCQkicnVsZXNc
biIpOwotCQkJCQljb250aW51ZTsKKwkJCWlmIChib29sZWFucykgeworCQkJCWN1cl9ub2RlLT5m
bGFncyAmPSB+Q09ORF9OT0RFX0ZMQUdTX1RVTkFCTEU7CisJCQkJaWYgKHR1bmFibGVzKSB7CisJ
CQkJCWZvciAoaSA9IDA7IGkgPCB0dW5hYmxlczsgaSsrKQorCQkJCQkJdG1wW2ldLT5mbGFncyAm
PSB+Q09ORF9CT09MX0ZMQUdTX1RVTkFCTEU7CisJCQkJfQorCQkJfSBlbHNlIHsKKwkJCQlpZiAo
cG9sLT5oYW5kbGVfdHVuYWJsZSA9PSBTRVBPTF9ESVNDQVJEX1RVTkFCTEUpIHsKKwkJCQkJY3Vy
X25vZGUtPmZsYWdzIHw9IENPTkRfTk9ERV9GTEFHU19UVU5BQkxFOworCQkJCQljdXJfc3RhdGUg
PSBjb25kX2V2YWx1YXRlX2V4cHIocG9sLCBjdXJfbm9kZS0+ZXhwcik7CisJCQkJCWlmIChjdXJf
c3RhdGUgPT0gLTEpIHsKKwkJCQkJCXByaW50ZigiRXhwcmVzc2lvbiByZXN1bHQgd2FzICIKKwkJ
CQkJCSAgICAgICAidW5kZWZpbmVkLCBza2lwcGluZyAiCisJCQkJCQkgICAgICAgImFsbCBydWxl
c1xuIik7CisJCQkJCQljb250aW51ZTsKKwkJCQkJfQorCisJCQkJCXRvX2JlX2FwcGVuZGVkID0g
KGN1cl9zdGF0ZSA9PSAxKSA/CisJCQkJCQljdXJfbm9kZS0+YXZ0cnVlX2xpc3QgOgljdXJfbm9k
ZS0+YXZmYWxzZV9saXN0OworCisJCQkJCWlmICh0YWlsKQorCQkJCQkJdGFpbC0+bmV4dCA9IHRv
X2JlX2FwcGVuZGVkOworCQkJCQllbHNlCisJCQkJCQl0YWlsID0gZGVjbC0+YXZydWxlcyA9IHRv
X2JlX2FwcGVuZGVkOworCisJCQkJCS8qIFVwZGF0ZSB0aGUgdGFpbCBvZiBkZWNsLT5hdnJ1bGVz
CisJCQkJCSAqIGZvciBmdXJ0aGVyIGNvbmNhdGVuYXRpb24gKi8KKwkJCQkJd2hpbGUgKHRhaWwg
JiYgdGFpbC0+bmV4dCkKKwkJCQkJCXRhaWwgPSB0YWlsLT5uZXh0OworCisJCQkJCWN1cl9ub2Rl
LT5hdnRydWVfbGlzdCA9IGN1cl9ub2RlLT5hdmZhbHNlX2xpc3QgPSBOVUxMOworCQkJCX0gZWxz
ZSBpZiAocG9sLT5oYW5kbGVfdHVuYWJsZSA9PSBTRVBPTF9QUkVTRVJWRV9UVU5BQkxFKSB7CisJ
CQkJCWN1cl9ub2RlLT5mbGFncyAmPSB+Q09ORF9OT0RFX0ZMQUdTX1RVTkFCTEU7CisJCQkJCWZv
ciAoaSA9IDA7IGkgPCB0dW5hYmxlczsgaSsrKQorCQkJCQkJdG1wW2ldLT5mbGFncyAmPSB+Q09O
RF9CT09MX0ZMQUdTX1RVTkFCTEU7CiAJCQkJfQotCi0JCQkJdG9fYmVfYXBwZW5kZWQgPSAoY3Vy
X3N0YXRlID09IDEpID8KLQkJCQkJY3VyX25vZGUtPmF2dHJ1ZV9saXN0IDogY3VyX25vZGUtPmF2
ZmFsc2VfbGlzdDsKLQotCQkJCWlmICh0YWlsKQotCQkJCQl0YWlsLT5uZXh0ID0gdG9fYmVfYXBw
ZW5kZWQ7Ci0JCQkJZWxzZQotCQkJCQl0YWlsID0gZGVjbC0+YXZydWxlcyA9IHRvX2JlX2FwcGVu
ZGVkOwotCi0JCQkJLyogVXBkYXRlIHRoZSB0YWlsIG9mIGRlY2wtPmF2cnVsZXMgZm9yCi0JCQkJ
ICogZnVydGhlciBjb25jYXRlbmF0aW9uICovCi0JCQkJd2hpbGUgKHRhaWwgJiYgdGFpbC0+bmV4
dCkKLQkJCQkJdGFpbCA9IHRhaWwtPm5leHQ7Ci0KLQkJCQljdXJfbm9kZS0+YXZ0cnVlX2xpc3Qg
PSBjdXJfbm9kZS0+YXZmYWxzZV9saXN0ID0gTlVMTDsKIAkJCX0KIAkJfQogCX0KLS0gCjEuNy4w
LjQKCg==

--_83eab0c1-f2e5-49d4-85fc-8ca898da4c7d_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
