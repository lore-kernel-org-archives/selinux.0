MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C83CEF.82CAFFB2"
Subject: RE: newrole in the background
Date: Wed, 12 Dec 2007 10:47:56 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net>
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net> <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com> <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Xavier Toth" <txtoth@gmail.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83CEF.82CAFFB2
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I have made my modifications to newrole.  Is there any testcases or
documentation on what needs to be tested before submitting a patch?
With the minimal testing that I have done everything appears to be
working correctly.

Attached is the patch file.  Please review and comment.

Thanks!
Tim


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
Sent: Tuesday, December 11, 2007 1:18 PM
To: Xavier Toth
Cc: Reed, Tim (US SSA); selinux@tycho.nsa.gov
Subject: Re: newrole in the background

On Tue, 2007-12-11 at 10:06 -0600, Xavier Toth wrote:
> We ended up creating a variant of newrole which doesn't require tty
> access. We did this to run some of our applications in the background
> but still get newroles ability to set the context/level of the child
> and to create a pam session for polyinstantiation. For this to work we
> had to configure our apps into our variants equivalent of
> /etc/selinux/newrole_pam.conf and provide corresponding /etc/pam.d
> files which typically look like :
> #%PAM-1.0
> auth       required     pam_permit.so
> account    required     pam_permit.so
> password   required     pam_permit.so
> session    required     pam_mkpolydir.so debug
> session    required     pam_namespace.so unmnt_remnt
> no_unmount_on_close gen_hash ignore_instance_parent_mode debug
>=20
> This variant was based on a Fedora policysoreutils source rpm because
> the RHEL5 version doesn't contain the code to map applications to
> /etc/pam.d files using /etc/selinux/newrole_pam.conf.

As a workaround, you could certainly create a pty in your application
and use that for newrole - that woudl let you use newrole unmodified.

As a longer term solution, I'd suggest making a patch for newrole that
allows it to gracefully function even in the absence of a tty, and get
that upstreamed, so that you can use newrole as is.

--=20
Stephen Smalley
National Security Agency


------_=_NextPart_001_01C83CEF.82CAFFB2
Content-Type: application/octet-stream;
	name="newrole_no_tty.patch"
Content-Transfer-Encoding: base64
Content-Description: newrole_no_tty.patch
Content-Disposition: attachment;
	filename="newrole_no_tty.patch"

ZGlmZiAtTmF1ciBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS1vcmlnL25ld3JvbGUvTWFrZWZpbGUg
cG9saWN5Y29yZXV0aWxzLTEuMzQuMTEvbmV3cm9sZS9NYWtlZmlsZQotLS0gcG9saWN5Y29yZXV0
aWxzLTEuMzQuMTEtb3JpZy9uZXdyb2xlL01ha2VmaWxlCTIwMDctMDUtMDMgMTI6NTc6MDIuMDAw
MDAwMDAwIC0wNDAwCisrKyBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS9uZXdyb2xlL01ha2VmaWxl
CTIwMDctMTItMTIgMTM6NDA6MTQuMDAwMDAwMDAwIC0wNTAwCkBAIC0yMiw3ICsyMiw3IEBACiAK
IENGTEFHUyA/PSAtV2Vycm9yIC1XYWxsIC1XCiBvdmVycmlkZSBDRkxBR1MgKz0gLURWRVJTSU9O
PVwiJChWRVJTSU9OKVwiICQoTERGTEFHUykgLUkkKFBSRUZJWCkvaW5jbHVkZSAtRFVTRV9OTFMg
LURMT0NBTEVESVI9IlwiJChMT0NBTEVESVIpXCIiIC1EUEFDS0FHRT0iXCJwb2xpY3ljb3JldXRp
bHNcIiIKLUxETElCUyArPSAtbHNlbGludXggLWxzZXBvbCAtTCQoUFJFRklYKS9saWIKK0xETElC
UyArPSAtbHV0aWwgLWxzZWxpbnV4IC1sc2Vwb2wgLUwkKFBSRUZJWCkvbGliCiBpZmVxICgke1BB
TUh9LCAvdXNyL2luY2x1ZGUvc2VjdXJpdHkvcGFtX2FwcGwuaCkKIAlvdmVycmlkZSBDRkxBR1Mg
Kz0gLURVU0VfUEFNCiAJTERMSUJTICs9IC1scGFtIC1scGFtX21pc2MKZGlmZiAtTmF1ciBwb2xp
Y3ljb3JldXRpbHMtMS4zNC4xMS1vcmlnL25ld3JvbGUvbmV3cm9sZS5jIHBvbGljeWNvcmV1dGls
cy0xLjM0LjExL25ld3JvbGUvbmV3cm9sZS5jCi0tLSBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS1v
cmlnL25ld3JvbGUvbmV3cm9sZS5jCTIwMDctMDItMjIgMTE6MDg6MTkuMDAwMDAwMDAwIC0wNTAw
CisrKyBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS9uZXdyb2xlL25ld3JvbGUuYwkyMDA3LTEyLTEy
IDEzOjQ1OjAxLjAwMDAwMDAwMCAtMDUwMApAQCAtNTcsNiArNTcsNyBAQAogCiAjaW5jbHVkZSA8
c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4JCS8qIGZvciBtYWxsb2MoKSwgcmVhbGxvYygp
LCBmcmVlKCkgKi8KKyNpbmNsdWRlIDxwdHkuaD4gICAgICAgICAgICAgICAgLyogZm9yIGZvcmtw
dHkoKSAqLwogI2luY2x1ZGUgPHB3ZC5oPgkJLyogZm9yIGdldHB3dWlkKCkgKi8KICNpbmNsdWRl
IDxzeXMvdHlwZXMuaD4JCS8qIHRvIG1ha2UgZ2V0dWlkKCkgYW5kIGdldHB3dWlkKCkgaGFwcHkg
Ki8KICNpbmNsdWRlIDxzeXMvd2FpdC5oPgkJLyogZm9yIHdhaXQoKSAqLwpAQCAtOTI0LDcgKzky
NSw1MSBAQAogCiAJcmV0dXJuIDA7CiB9CisvKioKKyAqIFRoaXMgZnVuY3Rpb24gY2hlY2tzIHRv
IHNlZSBpZiB3ZSBhcmUgYWxyZWFkeSBpbiBoYXZlIGEgdHR5LCBpZgorICogbm90IHRoZW4gaXQg
Y3JlYXRlcyBhIHBzZXVkbyB0dHkgZm9yIHRoaXMgc2Vzc2lvbi4KKyAqLworc3RhdGljIGludCBn
ZXRfcHR5KCB2b2lkICkKK3sKKyAgaW50IG1hc3RlckZEOworICBjaGFyICp0dHluOworCisgIHR0
eW4gPSB0dHluYW1lKFNURElOX0ZJTEVOTyk7CiAKKyAgLy8gaWYgd2UgZG8gbm90IGhhdmUgYSB0
dHkgdGhlbiBjcmVhdGUgb25lIGZvciBvdXJzZWx2ZXMKKyAgaWYgKCF0dHluIHx8ICp0dHluID09
ICdcMCcpIAorICAgIHsKKyAgICAgIHN3aXRjaCggZm9ya3B0eSggJm1hc3RlckZELCBOVUxMLCBO
VUxMLCBOVUxMICkgKQorCXsKKwljYXNlIC0xOgorCSAgeworCSAgICBmcHJpbnRmKCBzdGRlcnIs
IF8oIlVuYWJsZSB0byBmb3JrIG5ldyB0dHkiKSApOworCSAgICByZXR1cm4gLTE7CisJICB9CisJ
ICBicmVhazsKKwljYXNlIDA6IC8vQ0hJTEQKKwkgIHsKKwkgICAgcmV0dXJuIDA7CisJICB9CisJ
ICBicmVhazsKKwlkZWZhdWx0OiAvL1BBUkVOVAorCSAgeworCSAgICBjaGFyIGJ1ZlsxMDI0XTsK
KwkgICAgaW50IGNudDsKKwkgICAgCisJICAgIHdoaWxlKCAoY250ID0gcmVhZCggbWFzdGVyRkQs
IGJ1ZiwgMTAyNCApKSA+IDAgKQorCSAgICAgIHsKKwkJYnVmW2NudF0gPSAnXDAnOworCQlwcmlu
dGYoICIlcyIsIGJ1ZiApOworCSAgICAgIH0KKwkgICAgCisJICAgIHJldHVybiAtMTsKKwkgIH0K
KwkgIGJyZWFrOworCX0KKyAgICB9CisgIHJldHVybiAwOworfQogLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgog
ICoKICAqIEFsbCBjb2RlIHVzZWQgZm9yIGJvdGggUEFNIGFuZCBzaGFkb3cgcGFzc3dkIGdvZXMg
aW4gdGhpcyBzZWN0aW9uLgpAQCAtOTQ4LDYgKzk5MywxMiBAQAogCXBpZF90IGNoaWxkUGlkID0g
MDsKIAljaGFyICpzaGVsbF9hcmd2MCA9IE5VTEw7CiAKKwlpbnQgZXJyOworCWlmICggKGVyciA9
IGdldF9wdHkoICkpIDwgMCApCisJICB7CisJICAgIHJldHVybiBlcnI7CisJICB9CisJCiAjaWZk
ZWYgVVNFX1BBTQogCWludCByYzsKIAlpbnQgcGFtX3N0YXR1czsJCSAgIC8qIHBhbSByZXR1cm4g
Y29kZSAqLwo=

------_=_NextPart_001_01C83CEF.82CAFFB2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
