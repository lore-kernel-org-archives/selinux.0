Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA21555
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 09:41:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id NAA26177
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 13:40:06 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id NAA26165 for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 13:40:04 GMT
Date: Wed, 5 Jun 2002 09:41:16 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: [patch] Re: mini policy for initrd
In-Reply-To: <20020524122608.989A28B9@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206050930060.1786-200000@raven>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-959030623-1023284476=:1786"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-959030623-1023284476=:1786
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 24 May 2002, Russell Coker wrote:

> I've developed a mini policy for an initrd, but now I have a problem.
>
> On boot after the root file system is mounted the mappings of PSIDs to SIDs
> are made BEFORE the policy is loaded from the root file system.  This means
> that 95% of all files on my root file system lose their labels...
>
> Is there any possibility of solving this in the kernel?  Or should I just
> make sure that my initrd policy contains all the types for all files on the
> root file system?

I've attached a patch that changes the SELinux kernel module to _not_
automatically remap invalid PSIDs when the PSID mapping is loaded and to
reload the PSID mapping after a policy reload upon a change_root or
pivot_root operation.  This should address this problem.  However, note
the initrd policy will still need to define the types for the small set of
files on the real root filesystem that are accessed prior to the
completion of the PSID reloading, e.g. root_t, etc_t, policy_config_t,
file_labels_t.  This patch has not yet been committed.  Feedback is
welcome.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com



---559023410-959030623-1023284476=:1786
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="psid.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.33.0206050941160.1786@raven>
Content-Description: 
Content-Disposition: attachment; filename="psid.patch"

SW5kZXg6IHNlY3VyaXR5L3NlbGludXgvaG9va3MuYw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvbHNtL2xzbS0yLjQvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS42
OQ0KZGlmZiAtdSAtcjEuNjkgaG9va3MuYw0KLS0tIHNlY3VyaXR5L3NlbGlu
dXgvaG9va3MuYwkyMDAyLzA1LzE2IDE4OjE0OjA4CTEuNjkNCisrKyBzZWN1
cml0eS9zZWxpbnV4L2hvb2tzLmMJMjAwMi8wNi8wNSAxMjo0MToyNA0KQEAg
LTIxNjAsOCArMjE2MCwxMiBAQA0KIA0KIHN0YXRpYyB2b2lkIHNlbGludXhf
cG9zdF9tb3VudHJvb3QJKHZvaWQpDQogew0KKwlzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiOw0KKwlzdHJ1Y3Qgc3VwZXJibG9ja19zZWN1cml0eV9zdHJ1Y3Qg
KnNic2VjOw0KIAlpbnQgcmM7DQorCWludCByZWluaXRfcHNpZHMgPSAwOw0K
IA0KKw0KIAlpZiAoIXNzX3ByZWNvbmRpdGlvbigpKSB7DQogCQkvKiBQZXJm
b3JtIHRoZSBpbml0aWFsIGxvYWQgb2YgdGhlIHBvbGljeSBkdXJpbmcgYm9v
dGluZy4NCiAJCSAgIEEgZmFpbHVyZSBoZXJlIGlzIGZhdGFsIHVubGVzcyB0
aGUgZGV2ZWxvcG1lbnQgbW9kdWxlIA0KQEAgLTIxNzYsMTkgKzIxODAsMzUg
QEANCiAJCSAgIElmIG9uZSBleGlzdHMsIGl0IHdpbGwgcmVwbGFjZSB0aGUg
aW5pdHJkIHBvbGljeS4gDQogCQkgICBPdGhlcndpc2UsIHdlIGNvbnRpbnVl
IG9wZXJhdGluZyB1bmRlciB0aGUgaW5pdHJkIHBvbGljeS4NCiAJCSAgIFRo
aXMgb2NjdXJzIHdoZW4gdGhlIG9sZCBjaGFuZ2Vfcm9vdCBtZWNoYW5pc20g
aXMgdXNlZC4gKi8NCi0JCWlmIChzeXNfc2VjdXJpdHlfbG9hZF9wb2xpY3ko
TlVMTCwgMCkpDQorCQlpZiAoc3lzX3NlY3VyaXR5X2xvYWRfcG9saWN5KE5V
TEwsIDApKSB7DQogCQkJcHJpbnRrKCJzZWxpbnV4X3Bvc3RfbW91bnRyb290
OiAgdW5hYmxlIHRvIHJlbG9hZCBwb2xpY3kgZnJvbSBuZXcgcm9vdC5cbiIp
Ow0KKwkJfSBlbHNlIHsNCisJCQlyZWluaXRfcHNpZHMgPSAxOw0KKwkJfQ0K
IAl9DQogDQogCWlmICghY3VycmVudC0+ZnMgfHwgIWN1cnJlbnQtPmZzLT5y
b290bW50IHx8ICFjdXJyZW50LT5mcy0+cm9vdG1udC0+bW50X3NiKSB7DQog
CQlwcmludGsoInNlbGludXhfcG9zdF9tb3VudHJvb3Q6ICB1bmFibGUgdG8g
aW5pdGlhbGl6ZSByb290IGZpbGVzeXN0ZW0uXG4iKTsNCiAJCXJldHVybjsN
CiAJfQ0KKwlzYiA9IGN1cnJlbnQtPmZzLT5yb290bW50LT5tbnRfc2I7DQog
DQotCXJjID0gc3VwZXJibG9ja19wcmVjb25kaXRpb24oY3VycmVudC0+ZnMt
PnJvb3RtbnQtPm1udF9zYik7DQorCXJjID0gc3VwZXJibG9ja19wcmVjb25k
aXRpb24oc2IpOw0KIAlpZiAocmMgPD0gMCkNCiAJCXJldHVybjsNCiANCisJ
aWYgKHJlaW5pdF9wc2lkcykgew0KKwkJc2JzZWMgPSBzYi0+c19zZWN1cml0
eTsNCisJCWlmIChzYnNlYy0+dXNlc19wc2lkcyAmJiBzYnNlYy0+cHNpZHRh
Yikgew0KKwkJCXBzaWRfcmVsZWFzZShzYik7DQorCQkJcmMgPSBwc2lkX2lu
aXQoc2IpOw0KKwkJCWlmIChyYyA8IDApIHsNCisJCQkJcHJpbnRrKCJzZWxp
bnV4X3Bvc3RfbW91bnRyb290OiAgdW5hYmxlIHRvIHJlaW5pdGlhbGl6ZSB0
aGUgUFNJRCBtYXBwaW5nXG4iKTsNCisJCQkJcmV0dXJuOw0KKwkJCX0NCisJ
CX0NCisJfQ0KKw0KIAlyZXR1cm47DQogfQ0KIA0KQEAgLTIyMDYsMTIgKzIy
MjYsMzggQEANCiANCiBzdGF0aWMgdm9pZCBzZWxpbnV4X3Bvc3RfcGl2b3Ry
b290IChzdHJ1Y3QgbmFtZWlkYXRhICpvbGRfbmQsIHN0cnVjdCBuYW1laWRh
dGEgKm5ld19uZCkNCiB7DQorCXN0cnVjdCBzdXBlcl9ibG9jayAqc2I7DQor
CXN0cnVjdCBzdXBlcmJsb2NrX3NlY3VyaXR5X3N0cnVjdCAqc2JzZWM7DQor
CWludCByYzsNCisNCiAJLyogVHJ5IHRvIHJlbG9hZCB0aGUgcG9saWN5IGZy
b20gdGhlIG5ldyByb290IGZpbGVzeXN0ZW0uIA0KIAkgICBJZiBvbmUgZXhp
c3RzLCBpdCB3aWxsIHJlcGxhY2UgdGhlIGluaXRyZCBwb2xpY3kuIA0KIAkg
ICBPdGhlcndpc2UsIHdlIGNvbnRpbnVlIG9wZXJhdGluZyB1bmRlciB0aGUg
aW5pdHJkIHBvbGljeS4NCiAJICAgVGhpcyBvY2N1cnMgd2hlbiB0aGUgcGl2
b3Rfcm9vdCBtZWNoYW5pc20gaXMgdXNlZC4gKi8NCi0JaWYgKHN5c19zZWN1
cml0eV9sb2FkX3BvbGljeShOVUxMLCAwKSkNCisJaWYgKHN5c19zZWN1cml0
eV9sb2FkX3BvbGljeShOVUxMLCAwKSkgew0KIAkJcHJpbnRrKCJzZWxpbnV4
X3Bvc3RfcGl2b3Ryb290OiAgdW5hYmxlIHRvIHJlbG9hZCBwb2xpY3kuXG4i
KTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwkvKiBUcnkgdG8gcmVpbml0aWFs
aXplIHRoZSBQU0lEIG1hcHBpbmcgYmFzZWQgb24gdGhlIG5ldyBwb2xpY3kg
Ki8NCisNCisJaWYgKCFuZXdfbmQtPm1udCB8fCAhbmV3X25kLT5tbnQtPm1u
dF9zYikNCisJCXJldHVybjsNCisJc2IgPSBuZXdfbmQtPm1udC0+bW50X3Ni
Ow0KKw0KKwlyYyA9IHN1cGVyYmxvY2tfcHJlY29uZGl0aW9uKHNiKTsNCisJ
aWYgKHJjIDw9IDApDQorCQlyZXR1cm47DQorCXNic2VjID0gc2ItPnNfc2Vj
dXJpdHk7DQorDQorCWlmIChzYnNlYy0+dXNlc19wc2lkcyAmJiBzYnNlYy0+
cHNpZHRhYikgew0KKwkJcHNpZF9yZWxlYXNlKHNiKTsNCisJCXJjID0gcHNp
ZF9pbml0KHNiKTsNCisJCWlmIChyYyA8IDApIHsNCisJCQlwcmludGsoInNl
bGludXhfcG9zdF9waXZvdHJvb3Q6ICB1bmFibGUgdG8gcmVpbml0aWFsaXpl
IHRoZSBQU0lEIG1hcHBpbmdcbiIpOw0KKwkJCXJldHVybjsNCisJCX0NCisJ
fQ0KIH0NCiANCiAvKiBpbm9kZSBzZWN1cml0eSBvcGVyYXRpb25zICovDQpJ
bmRleDogc2VjdXJpdHkvc2VsaW51eC9wc2lkLmMNCj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0NClJDUyBmaWxlOiAvY3ZzL2xzbS9sc20tMi40L3NlY3VyaXR5
L3NlbGludXgvcHNpZC5jLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xDQpk
aWZmIC11IC1yMS4xIHBzaWQuYw0KLS0tIHNlY3VyaXR5L3NlbGludXgvcHNp
ZC5jCTIwMDEvMTIvMDcgMTQ6MzI6NTkJMS4xDQorKysgc2VjdXJpdHkvc2Vs
aW51eC9wc2lkLmMJMjAwMi8wNi8wNSAxMjo0MToyNA0KQEAgLTYxNiw2ICs2
MTYsNyBAQA0KIAkJaWYgKHJjKSB7DQogCQkJcHJpbnRrKCJwc2lkZmlsZXNf
aW5pdDogIGVycm9yICVkIGluIG9idGFpbmluZyBTSUQgZm9yIGNvbnRleHQg
JXMgKHBzaWQgJWQpLlxuIiwgDQogCQkJICAgICAgIC1yYywgY2J1ZiwgdC0+
bmV4dF9wc2lkKTsNCisjaWYgMA0KIAkJCWlmICgoc2ItPnNfZmxhZ3MgJiBN
U19SRE9OTFkpID09IDApIHsNCiAJCQkJcmMgPSB3cml0ZV9hYnMoJnQtPmlu
ZGV4X2ZwLCANCiAJCQkJCSAgICAgICAoY29uc3QgY2hhciopJnQtPnJhd19z
aW5kZXgsIA0KQEAgLTYzMCw2ICs2MzEsNyBAQA0KIAkJCQlpZiAodC0+bl9i
YWQgPCBCQURfUFNJRFMpDQogCQkJCQl0LT5iYWRfcHNpZHNbdC0+bl9iYWQr
K10gPSB0LT5uZXh0X3BzaWQ7DQogCQkJfQ0KKyNlbmRpZg0KIAkJCXQtPm5l
eHRfcHNpZCsrOw0KIAkJfQ0KIAkJZWxzZQ0K
---559023410-959030623-1023284476=:1786--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
