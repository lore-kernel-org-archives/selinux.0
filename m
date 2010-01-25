Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0PHD3eL010047
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 12:13:07 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0PHCwJn017231
	for <selinux@tycho.nsa.gov>; Mon, 25 Jan 2010 17:12:59 GMT
Message-Id: <201001251713.o0PHD1Fj018291@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Subject: Re: bzip support in libsemanage and out of memory (userspace ticket 7)
Date: Mon, 25 Jan 2010 18:13:01 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_2e72a290b4c2e1d46036b79506c4a480"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------_=_NextPart_000_2e72a290b4c2e1d46036b79506c4a480
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_f0af3f65426c822712c203062d19eebb"


------_=_NextPart_001_f0af3f65426c822712c203062d19eebb
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Stephen,

the Makefile didn't expand properly the variable because there was a space in build.conf at the end of line 15. I have attached the correct build.conf now.

Regards,

Guido 

------_=_NextPart_001_f0af3f65426c822712c203062d19eebb--

------_=_NextPart_000_2e72a290b4c2e1d46036b79506c4a480
Content-Type: application/octet-stream;
	name="build.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="build.conf"

IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwojCiMg
UG9saWN5IGJ1aWxkIG9wdGlvbnMKIwoKIyBQb2xpY3kgdmVyc2lvbgojIEJ5
IGRlZmF1bHQsIGNoZWNrcG9saWN5IHdpbGwgY3JlYXRlIHRoZSBoaWdoZXN0
CiMgdmVyc2lvbiBwb2xpY3kgaXQgc3VwcG9ydHMuICBTZXR0aW5nIHRoaXMg
d2lsbAojIG92ZXJyaWRlIHRoZSB2ZXJzaW9uLiAgVGhpcyBvbmx5IGhhcyBh
bgojIGVmZmVjdCBmb3IgbW9ub2xpdGhpYyBwb2xpY2llcy4KI09VVFBVVF9Q
T0xJQ1kgPSAxOAoKIyBQb2xpY3kgVHlwZQojIHN0YW5kYXJkLCBtbHMsIG1j
cwpUWVBFID0gbWxzCgojIFBvbGljeSBOYW1lCiMgSWYgc2V0LCB0aGlzIHdp
bGwgYmUgdXNlZCBhcyB0aGUgcG9saWN5CiMgbmFtZS4gIE90aGVyd2lzZSB0
aGUgcG9saWN5IHR5cGUgd2lsbCBiZQojIHVzZWQgZm9yIHRoZSBuYW1lLgpO
QU1FID0gcmVmcG9saWN5CgojIERpc3RyaWJ1dGlvbgojIFNvbWUgZGlzdHJp
YnV0aW9ucyBoYXZlIHBvcnRpb25zIG9mIHBvbGljeQojIGZvciBwcm9ncmFt
cyBvciBjb25maWd1cmF0aW9ucyBzcGVjaWZpYyB0byB0aGUKIyBkaXN0cmli
dXRpb24uICBTZXR0aW5nIHRoaXMgd2lsbCBlbmFibGUgb3B0aW9ucwojIGZv
ciB0aGUgZGlzdHJpYnV0aW9uLgojIHJlZGhhdCwgZ2VudG9vLCBkZWJpYW4s
IHN1c2UsIGFuZCByaGVsNCBhcmUgY3VycmVudCBvcHRpb25zLgojIEZlZG9y
YSB1c2VycyBzaG91bGQgZW5hYmxlIHJlZGhhdC4KRElTVFJPID0gZGViaWFu
IAoKIyBVbmtub3duIFBlcm1pc3Npb25zIEhhbmRsaW5nCiMgVGhlIGJlaGF2
aW9yIGZvciBoYW5kbGluZyBwZXJtaXNzaW9ucyBkZWZpbmVkIGluIHRoZQoj
IGtlcm5lbCBidXQgbWlzc2luZyBmcm9tIHRoZSBwb2xpY3kuICBUaGUgcGVy
bWlzc2lvbnMKIyBjYW4gZWl0aGVyIGJlIGFsbG93ZWQsIGRlbmllZCwgb3Ig
dGhlIHBvbGljeSBsb2FkaW5nCiMgY2FuIGJlIHJlamVjdGVkLgojIGFsbG93
LCBkZW55LCBhbmQgcmVqZWN0IGFyZSBjdXJyZW50IG9wdGlvbnMuClVOS19Q
RVJNUyA9IGFsbG93IAoKIyBEaXJlY3QgYWRtaW4gaW5pdAojIFNldHRpbmcg
dGhpcyB3aWxsIGFsbG93IHN5c2FkbSB0byBkaXJlY3RseQojIHJ1biBpbml0
IHNjcmlwdHMsIGluc3RlYWQgb2YgcmVxdXJpbmcgcnVuX2luaXQuCiMgVGhp
cyBpcyBhIGJ1aWxkIG9wdGlvbiwgYXMgcm9sZSB0cmFuc2l0aW9ucyBkbwoj
IG5vdCB3b3JrIGluIGNvbmRpdGlvbmFsIHBvbGljeS4KRElSRUNUX0lOSVRS
QyA9IHkgCgojIEJ1aWxkIG1vbm9saXRoaWMgcG9saWN5LiAgUHV0dGluZyBu
IGhlcmUKIyB3aWxsIGJ1aWxkIGEgbG9hZGFibGUgbW9kdWxlIHBvbGljeS4K
TU9OT0xJVEhJQyA9IG4KCiMgVXNlci1iYXNlZCBhY2Nlc3MgY29udHJvbCAo
VUJBQykKIyBFbmFibGUgVUJBQyBmb3Igcm9sZSBzZXBhcmF0aW9ucy4KVUJB
QyA9IG4gCgojIE51bWJlciBvZiBNTFMgU2Vuc2l0aXZpdGllcwojIFRoZSBz
ZW5zaXRpdml0aWVzIHdpbGwgYmUgczAgdG8gcyhNTFNfU0VOUy0xKS4KIyBE
b21pbmFuY2Ugd2lsbCBiZSBpbiBpbmNyZWFzaW5nIG51bWVyaWNhbCBvcmRl
cgojIHdpdGggczAgYmVpbmcgbG93ZXN0LgpNTFNfU0VOUyA9IDE2CgojIE51
bWJlciBvZiBNTFMgQ2F0ZWdvcmllcwojIFRoZSBjYXRlZ29yaWVzIHdpbGwg
YmUgYzAgdG8gYyhNTFNfQ0FUUy0xKS4KTUxTX0NBVFMgPSAxMDI0CgojIE51
bWJlciBvZiBNQ1MgQ2F0ZWdvcmllcwojIFRoZSBjYXRlZ29yaWVzIHdpbGwg
YmUgYzAgdG8gYyhNTFNfQ0FUUy0xKS4KTUNTX0NBVFMgPSAxMDI0IAoKIyBT
ZXQgdGhpcyB0byB5IHRvIG9ubHkgZGlzcGxheSBzdGF0dXMgbWVzc2FnZXMK
IyBkdXJpbmcgYnVpbGQuClFVSUVUID0gbgo=


------_=_NextPart_000_2e72a290b4c2e1d46036b79506c4a480--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
