Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16HOmRb023865
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 12:24:48 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16HNQQk003002
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 17:23:26 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
	by jazzswing.ncsc.mil  with ESMTP id i16HNQYo002997
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 17:23:26 GMT
Subject: XFS security namespace
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-Fo484FT8NaZ9At962j+b"
Message-Id: <1076088280.5286.10.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Fri, 06 Feb 2004 11:24:40 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Fo484FT8NaZ9At962j+b
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Announcing the XFS Security Extended Attribute Namepsace

Now available, with the release of kernel 2.6.2, is the security xattr
namespace in XFS.  Thanks goes to Tad Glines for his initial kernel
patch, and Nathan Scott and the other SGI people for the final version
that's been integrated.  All thats required is the attached patch to
make the Security Labels option available (this is already in SGI CVS,
slated for inclusion in Linus' tree).  Nathan tells me that the
namespace code is also in Marcelo's BK tree, and requires a similar
config patch.

No updates to attr or xfsprogs are required.  xfsdump/restore will need
to be updated, but its not ready yet.  I've been working with the SGI
people on that, so hopefully it will be ready soon.

All that needs to be changed in the policy is to add a fs_use_xattr
entry for XFS, and then adjust the Makefile relabel target to relabel
XFS filesystems.  I have attached a patch against the NSA policy in
sourceforge CVS to do this.  (note the extra space in the 'make relabel'
awk command is intentional, otherwise it matches selinuxfs too)

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-Fo484FT8NaZ9At962j+b
Content-Disposition: attachment; filename=xfs_security-kconfig.diff
Content-Type: text/x-patch; name=xfs_security-kconfig.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4yLXJjMy5vcmlnL2ZzL0tjb25maWcJMjAwNC0wMi0wMyAxNDoyOToxNC4w
MDAwMDAwMDAgLTA2MDANCisrKyBsaW51eC0yLjYuMi1yYzMvZnMvS2NvbmZpZwkyMDA0LTAyLTA0
IDAwOjE5OjQ3Ljg1OTQwMTAwMCAtMDYwMA0KQEAgLTM1Niw2ICszNTYsMTggQEANCiANCiAJICBJ
ZiB5b3UgZG9uJ3Qga25vdyB3aGF0IEFjY2VzcyBDb250cm9sIExpc3RzIGFyZSwgc2F5IE4NCiAN
Citjb25maWcgWEZTX1NFQ1VSSVRZDQorCWJvb2wgIlNlY3VyaXR5IExhYmVscyINCisJZGVwZW5k
cyBvbiBYRlNfRlMNCisJaGVscA0KKwkgIFNlY3VyaXR5IGxhYmVscyBzdXBwb3J0IGFsdGVybmF0
aXZlIGFjY2VzcyBjb250cm9sIG1vZGVscw0KKwkgIGltcGxlbWVudGVkIGJ5IHNlY3VyaXR5IG1v
ZHVsZXMgbGlrZSBTRUxpbnV4LiAgVGhpcyBvcHRpb24NCisJICBlbmFibGVzIGFuIGV4dGVuZGVk
IGF0dHJpYnV0ZSBoYW5kbGVyIGZvciBmaWxlIHNlY3VyaXR5DQorCSAgbGFiZWxzIGluIHRoZSBY
RlMgZmlsZXN5c3RlbS4NCisNCisJICBJZiB5b3UgYXJlIG5vdCB1c2luZyBhIHNlY3VyaXR5IG1v
ZHVsZSB0aGF0IHJlcXVpcmVzIHVzaW5nDQorCSAgZXh0ZW5kZWQgYXR0cmlidXRlcyBmb3IgZmls
ZSBzZWN1cml0eSBsYWJlbHMsIHNheSBOLg0KKw0KIGNvbmZpZyBNSU5JWF9GUw0KIAl0cmlzdGF0
ZSAiTWluaXggZnMgc3VwcG9ydCINCiAJaGVscA0K

--=-Fo484FT8NaZ9At962j+b
Content-Disposition: attachment; filename=selinux-xfs.diff
Content-Type: text/x-patch; name=selinux-xfs.diff; charset=ISO-8859-1
Content-Transfer-Encoding: base64

SW5kZXg6IE1ha2VmaWxlDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51eC9u
c2Evc2VsaW51eC11c3IvcG9saWN5L01ha2VmaWxlLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4x
MA0KZGlmZiAtdSAtYiAtQiAtcjEuMTAgTWFrZWZpbGUNCi0tLSBNYWtlZmlsZQk0IEZlYiAyMDA0
IDIwOjEzOjE3IC0wMDAwCTEuMTANCisrKyBNYWtlZmlsZQk1IEZlYiAyMDA0IDAyOjM1OjEwIC0w
MDAwDQpAQCAtMTEzLDcgKzExMyw3IEBADQogCW12ICRALnRtcCAkQA0KIA0KIHJlbGFiZWw6ICAk
KEZDKSAkKFNFVEZJTEVTKQ0KLQkkKFNFVEZJTEVTKSAkKEZDKSBgbW91bnQgfCBhd2sgJy9leHRb
MjNdLipydy97cHJpbnQgJCQzfSdgDQorCSQoU0VURklMRVMpICQoRkMpIGBtb3VudCB8IGF3ayAn
LyhleHRbMjNdfCB4ZnMpLipydy97cHJpbnQgJCQzfSdgDQogDQogZmlsZV9jb250ZXh0cy9taXNj
Og0KIAlta2RpciAtcCBmaWxlX2NvbnRleHRzL21pc2MNCkluZGV4OiBmc191c2UNCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0NClJDUyBmaWxlOiAvY3Zzcm9vdC9zZWxpbnV4L25zYS9zZWxpbnV4LXVzci9wb2xpY3kvZnNf
dXNlLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xLjEuMQ0KZGlmZiAtdSAtYiAtQiAtcjEuMS4x
LjEgZnNfdXNlDQotLS0gZnNfdXNlCTE0IEF1ZyAyMDAzIDEyOjM3OjM1IC0wMDAwCTEuMS4xLjEN
CisrKyBmc191c2UJNSBGZWIgMjAwNCAwMjozNToxMCAtMDAwMA0KQEAgLTYsNiArNiw3IEBADQog
IyBSZXF1aXJlcyB0aGF0IGEgc2VjdXJpdHkgeGF0dHIgaGFuZGxlciBleGlzdCBmb3IgdGhlIGZp
bGVzeXN0ZW0uDQogZnNfdXNlX3hhdHRyIGV4dDIgc3lzdGVtX3U6b2JqZWN0X3I6ZnNfdDsNCiBm
c191c2VfeGF0dHIgZXh0MyBzeXN0ZW1fdTpvYmplY3Rfcjpmc190Ow0KK2ZzX3VzZV94YXR0ciB4
ZnMgc3lzdGVtX3U6b2JqZWN0X3I6ZnNfdDsNCiANCiAjIFVzZSB0aGUgYWxsb2NhdGluZyB0YXNr
IFNJRCB0byBsYWJlbCBpbm9kZXMgaW4gdGhlIGZvbGxvd2luZyBmaWxlc3lzdGVtDQogIyB0eXBl
cywgYW5kIGxhYmVsIHRoZSBmaWxlc3lzdGVtIGl0c2VsZiB3aXRoIHRoZSBzcGVjaWZpZWQgY29u
dGV4dC4NCg==

--=-Fo484FT8NaZ9At962j+b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
