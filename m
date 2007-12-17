MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C840ED.05F3760C"
Subject: RE: newrole in the background
Date: Mon, 17 Dec 2007 12:40:13 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F59812B@blums0008.bluelnk.net>
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net> <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com> <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net> <476047A9.90000@gmail.com> <436A69503F99214D9EBC27415F66C40C0F517AD3@blums0008.bluelnk.net> <1197555910.20226.8.camel@moss-spartans.epoch.ncsc.mil> <cadfc0e40712130641r301dd959x895f33ff1e72f581@mail.gmail.com> <1197558486.20226.40.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F597703@blums0008.bluelnk.net> <1197567614.20226.141.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F597E63@blums0008.bluelnk.net> <1197907810.17307.38.camel@moss-spartans.epoch.ncsc.mil>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Xavier Toth" <txtoth@gmail.com>, "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C840ED.05F3760C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Lets try this again....Patch Try #3


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
On Behalf Of Stephen Smalley
Sent: Monday, December 17, 2007 11:10 AM
To: Reed, Tim (US SSA)
Cc: Xavier Toth; SE Linux
Subject: RE: newrole in the background

On Mon, 2007-12-17 at 08:01 -0800, Reed, Tim (US SSA) wrote:
> When newrole goes and grabs the ttyname, if it cannot get one should
it
> still log something to the screen or not?
>=20
> Currently it says "Error! Could not retrieve tty information".  I was
> thinking of changing Error to Warning.

Yes, that's fine.
>=20
> What is the recommendation here?
> Also do you have the coding standards posted somewhere?

We just loosely follow kernel coding style,
http://lxr.linux.no/linux/Documentation/CodingStyle
and make indent can be used as a hammer (but not a very good one).

>=20
> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
> Sent: Thursday, December 13, 2007 12:40 PM
> To: Reed, Tim (US SSA)
> Cc: Xavier Toth; SE Linux
> Subject: RE: newrole in the background
>=20
> On Thu, 2007-12-13 at 09:06 -0800, Reed, Tim (US SSA) wrote:
> > New patch...I have added checks around the calls that deal with the
> tty.
> > So if ttyn is an empty string (something had a heartache with it
being
> > NULL) then it skips the processing.  It does appear to work but more
> > testing is needed.  Please review and comment.
>=20
> Patch is reversed, and doesn't seem to be complete (test for a NULL
> ttyname still remains and is fatal in main).
>=20
> ttyn should really be NULL if not defined - just fix the code.
Cleaner
> and faster to test for NULL than for empty string.  Looks like
> authenticate_via_pam() needs a check.
>=20
> You can simplify the logic a fair amount, e.g. on entry to
relabel_tty()
> and restore_tty_label(), just do a if (!ttyn) return 0;
>=20
> Coding style doesn't match.
>=20
> > Now say if someone ran `newrole -l SystemHigh -- -c "su - foo"` in
the
> > background of a script, you would not be able to give su input as it
> is
> > in the background and has no tty.  su in this case exits gracefully
I
> > guess you could say. =20
> >=20
> > My point is that if you have an application that needs to run from
> > newrole, in the background AND requires user input, you will not be
> able
> > to give the application input while it is in the background and have
> it
> > work successfully.
>=20
> You can't do that anyway, by definition.
>=20
> > Example:
> > foo.sh
> > ---------------
> > #!/bin/bash
> >=20
> > ./bar.sh &
> > ---------------
> > bar.sh
> > ---------------
> > #!/bin/bash
> >=20
> > su - root -c /bin/date
> > ---------------
> >=20
> > su exits because there is no tty for input.  So is chasing down
having
> > newrole run in a pseudo tty in the background and accept input worth
> the
> > time?
>=20
> It doesn't help - there is no input to accept.
>=20
> We just need to make sure that the pam modules and chkpwd don't block
> forever or seg fault when handed a NULL PAM_TTY.
>=20
--=20
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

------_=_NextPart_001_01C840ED.05F3760C
Content-Type: application/octet-stream;
	name="newrole_no_tty_3.patch"
Content-Transfer-Encoding: base64
Content-Description: newrole_no_tty_3.patch
Content-Disposition: attachment;
	filename="newrole_no_tty_3.patch"

ZGlmZiAtTmF1ciBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS1vcmlnL25ld3JvbGUvbmV3cm9sZS5j
IHBvbGljeWNvcmV1dGlscy0xLjM0LjExL25ld3JvbGUvbmV3cm9sZS5jCi0tLSBwb2xpY3ljb3Jl
dXRpbHMtMS4zNC4xMS1vcmlnL25ld3JvbGUvbmV3cm9sZS5jCTIwMDctMTItMTIgMTU6NTY6NDQu
MDAwMDAwMDAwIC0wNTAwCisrKyBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS9uZXdyb2xlL25ld3Jv
bGUuYwkyMDA3LTEyLTE3IDEyOjQxOjE3LjAwMDAwMDAwMCAtMDUwMApAQCAtMTgyLDE1ICsxODIs
MTcgQEAKIAlpbnQgcGFtX3JjOwkJLyogcGFtIHJldHVybiBjb2RlICovCiAJY29uc3QgY2hhciAq
dHR5X25hbWU7CiAKLQlpZiAoc3RybmNtcCh0dHluLCAiL2Rldi8iLCA1KSA9PSAwKQorCWlmICh0
dHluKSB7CisJICBpZiAoc3RybmNtcCh0dHluLCAiL2Rldi8iLCA1KSA9PSAwKQogCQl0dHlfbmFt
ZSA9IHR0eW4gKyA1OwotCWVsc2UKKwkgIGVsc2UKIAkJdHR5X25hbWUgPSB0dHluOwogCi0JcGFt
X3JjID0gcGFtX3NldF9pdGVtKHBhbV9oYW5kbGUsIFBBTV9UVFksIHR0eV9uYW1lKTsKLQlpZiAo
cGFtX3JjICE9IFBBTV9TVUNDRVNTKSB7Ci0JCWZwcmludGYoc3RkZXJyLCBfKCJmYWlsZWQgdG8g
c2V0IFBBTV9UVFlcbiIpKTsKKwkgIHBhbV9yYyA9IHBhbV9zZXRfaXRlbShwYW1faGFuZGxlLCBQ
QU1fVFRZLCB0dHlfbmFtZSk7CisJICBpZiAocGFtX3JjICE9IFBBTV9TVUNDRVNTKSB7CisJICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwgXygiZmFpbGVkIHRvIHNldCBQQU1fVFRZXG4iKSk7CiAJCWdv
dG8gb3V0OworCSAgfQogCX0KIAogCS8qIEFzayBQQU0gdG8gYXV0aGVudGljYXRlIHRoZSB1c2Vy
IHJ1bm5pbmcgdGhpcyBwcm9ncmFtICovCkBAIC02MzQsNiArNjM2LDkgQEAKIAlzZWN1cml0eV9j
b250ZXh0X3QgdHR5X2NvbiA9IE5VTEw7CiAJc2VjdXJpdHlfY29udGV4dF90IG5ld190dHlfY29u
ID0gTlVMTDsKIAorCWlmICghdHR5bikKKwkgIHJldHVybiAwOworCiAJaWYgKGVuZm9yY2luZyA8
IDApIHsKIAkJZnByaW50ZihzdGRlcnIsIF8oIkNvdWxkIG5vdCBkZXRlcm1pbmUgZW5mb3JjaW5n
IG1vZGUuXG4iKSk7CiAJCXJldHVybiAtMTsKQEAgLTY0Miw0MCArNjQ3LDQwIEBACiAJLyogUmUt
b3BlbiBUVFkgZGVzY3JpcHRvciAqLwogCWZkID0gb3Blbih0dHluLCBPX1JEV1J8T19OT05CTE9D
Syk7CiAJaWYgKGZkIDwgMCkgewotCQlmcHJpbnRmKHN0ZGVyciwgXygiRXJyb3IhICBDb3VsZCBu
b3Qgb3BlbiAlcy5cbiIpLCB0dHluKTsKLQkJcmV0dXJuIGZkOworCSAgZnByaW50ZihzdGRlcnIs
IF8oIkVycm9yISAgQ291bGQgbm90IG9wZW4gJXMuXG4iKSwgdHR5bik7CisJICByZXR1cm4gZmQ7
CiAJfQogCWZjbnRsKGZkLCBGX1NFVEZMLCBmY250bChmZCwgRl9HRVRGTCwgMCkgJiB+T19OT05C
TE9DSyk7Ci0KKwkKIAlpZiAoZmdldGZpbGVjb24oZmQsICZ0dHlfY29uKSA8IDApIHsKLQkJZnBy
aW50ZihzdGRlcnIsIF8oIiVzISAgQ291bGQgbm90IGdldCBjdXJyZW50IGNvbnRleHQgIgotCQkJ
ImZvciAlcywgbm90IHJlbGFiZWxpbmcgdHR5LlxuIiksCi0JCQllbmZvcmNpbmcgPyAiRXJyb3Ii
IDogIldhcm5pbmciLCB0dHluKTsKLQkJaWYgKGVuZm9yY2luZykKLQkJCWdvdG8gY2xvc2VfZmQ7
CisJICBmcHJpbnRmKHN0ZGVyciwgXygiJXMhICBDb3VsZCBub3QgZ2V0IGN1cnJlbnQgY29udGV4
dCAiCisJCQkgICAgImZvciAlcywgbm90IHJlbGFiZWxpbmcgdHR5LlxuIiksCisJCSAgZW5mb3Jj
aW5nID8gIkVycm9yIiA6ICJXYXJuaW5nIiwgdHR5bik7CisJICBpZiAoZW5mb3JjaW5nKQorCSAg
ICBnb3RvIGNsb3NlX2ZkOwogCX0KLQorCQogCWlmICh0dHlfY29uICYmCiAJICAgIChzZWN1cml0
eV9jb21wdXRlX3JlbGFiZWwobmV3X2NvbnRleHQsIHR0eV9jb24sCiAJCQkJICAgICAgU0VDQ0xB
U1NfQ0hSX0ZJTEUsICZuZXdfdHR5X2NvbikgPCAwKSkgewotCQlmcHJpbnRmKHN0ZGVyciwJXygi
JXMhICBDb3VsZCBub3QgZ2V0IG5ldyBjb250ZXh0IGZvciAlcywgIgotCQkJIm5vdCByZWxhYmVs
aW5nIHR0eS5cbiIpLAotCQkJZW5mb3JjaW5nID8gIkVycm9yIiA6ICJXYXJuaW5nIiwgdHR5bik7
Ci0JCWlmIChlbmZvcmNpbmcpCi0JCQlnb3RvIGNsb3NlX2ZkOworCSAgZnByaW50ZihzdGRlcnIs
CV8oIiVzISAgQ291bGQgbm90IGdldCBuZXcgY29udGV4dCBmb3IgJXMsICIKKwkJCQkgICJub3Qg
cmVsYWJlbGluZyB0dHkuXG4iKSwKKwkJICBlbmZvcmNpbmcgPyAiRXJyb3IiIDogIldhcm5pbmci
LCB0dHluKTsKKwkgIGlmIChlbmZvcmNpbmcpCisJICAgIGdvdG8gY2xvc2VfZmQ7CiAJfQotCisJ
CiAJaWYgKG5ld190dHlfY29uKQotCQlpZiAoZnNldGZpbGVjb24oZmQsIG5ld190dHlfY29uKSA8
IDApIHsKLQkJCWZwcmludGYoc3RkZXJyLAotCQkJCV8oIiVzISAgQ291bGQgbm90IHNldCBuZXcg
Y29udGV4dCBmb3IgJXNcbiIpLAotCQkJCWVuZm9yY2luZyA/ICJFcnJvciIgOiAiV2FybmluZyIs
IHR0eW4pOwotCQkJZnJlZWNvbihuZXdfdHR5X2Nvbik7Ci0JCQluZXdfdHR5X2NvbiA9IE5VTEw7
Ci0JCQlpZiAoZW5mb3JjaW5nKQotCQkJCWdvdG8gY2xvc2VfZmQ7Ci0JCX0KLQorCSAgaWYgKGZz
ZXRmaWxlY29uKGZkLCBuZXdfdHR5X2NvbikgPCAwKSB7CisJICAgIGZwcmludGYoc3RkZXJyLAor
CQkgICAgXygiJXMhICBDb3VsZCBub3Qgc2V0IG5ldyBjb250ZXh0IGZvciAlc1xuIiksCisJCSAg
ICBlbmZvcmNpbmcgPyAiRXJyb3IiIDogIldhcm5pbmciLCB0dHluKTsKKwkgICAgZnJlZWNvbihu
ZXdfdHR5X2Nvbik7CisJICAgIG5ld190dHlfY29uID0gTlVMTDsKKwkgICAgaWYgKGVuZm9yY2lu
ZykKKwkgICAgICBnb3RvIGNsb3NlX2ZkOworCSAgfQorCQogCSp0dHlfY29udGV4dCA9IHR0eV9j
b247CiAJKm5ld190dHlfY29udGV4dCA9IG5ld190dHlfY29uOwogCXJldHVybiBmZDsKQEAgLTcw
Miw2ICs3MDcsOSBAQAogCWludCByYyA9IDA7CiAJc2VjdXJpdHlfY29udGV4dF90IGNoa190dHlf
Y29udGV4dCA9IE5VTEw7CiAKKwlpZiAoIXR0eW4pCisgICAgCSAgICAgICAgZ290byBza2lwX3Jl
bGFiZWw7CisKIAlpZiAoIW5ld190dHlfY29udGV4dCkKIAkJZ290byBza2lwX3JlbGFiZWw7CiAK
QEAgLTc5OSwxNCArODA3LDE2IEBACiAJCQkJCSJzcGVjaWZpZWRcbiIpKTsKIAkJCQlyZXR1cm4g
LTE7CiAJCQl9Ci0JCQlpZiAoZmdldGZpbGVjb24oMCwmdHR5X2NvbikgPj0gMCkgewotCQkJCWlm
IChzZWxpbnV4X2NoZWNrX3NlY3VyZXR0eV9jb250ZXh0KHR0eV9jb24pIDwgMCkgewotCQkJCQlm
cHJpbnRmKHN0ZGVyciwgXygiRXJyb3I6IHlvdSBhcmUgbm90IGFsbG93ZWQgdG8gY2hhbmdlIGxl
dmVscyBvbiBhIG5vbiBzZWN1cmUgdGVybWluYWxcbiIpKTsKLQkJCQkJZnJlZWNvbih0dHlfY29u
KTsKLQkJCQkJcmV0dXJuIC0xOwotCQkJCX0KKwkJCWlmICh0dHluKSB7CisJCQkgICAgaWYgKGZn
ZXRmaWxlY29uKFNURElOX0ZJTEVOTywmdHR5X2NvbikgPj0gMCkgeworCQkJICAgICAgaWYgKHNl
bGludXhfY2hlY2tfc2VjdXJldHR5X2NvbnRleHQodHR5X2NvbikgPCAwKSB7CisJCQkJZnByaW50
ZihzdGRlcnIsIF8oIkVycm9yOiB5b3UgYXJlIG5vdCBhbGxvd2VkIHRvIGNoYW5nZSBsZXZlbHMg
b24gYSBub24gc2VjdXJlIHRlcm1pbmFsIFxuIikpOwogCQkJCWZyZWVjb24odHR5X2Nvbik7Ci0J
CQl9CisJCQkJcmV0dXJuIC0xOworCQkJICAgICAgfQorCQkJICAgICAgZnJlZWNvbih0dHlfY29u
KTsKKwkJCSAgICB9CisJCQkgIH0KIAogCQkJbGV2ZWxfcyA9IG9wdGFyZzsKIAkJCWJyZWFrOwpA
QCAtOTI0LDcgKzkzNCw2IEBACiAKIAlyZXR1cm4gMDsKIH0KLQogLyoqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgog
ICoKICAqIEFsbCBjb2RlIHVzZWQgZm9yIGJvdGggUEFNIGFuZCBzaGFkb3cgcGFzc3dkIGdvZXMg
aW4gdGhpcyBzZWN0aW9uLgpAQCAtMTAwMywxNSArMTAxMiwxNSBAQAogCWlmIChnZXRwcmV2Y29u
KCZvbGRfY29udGV4dCkpIHsKIAkJZnByaW50ZihzdGRlcnIsIF8oImZhaWxlZCB0byBnZXQgb2xk
X2NvbnRleHQuXG4iKSk7CiAJCXJldHVybiAtMTsKLQl9Ci0KLQl0dHluID0gdHR5bmFtZSgwKTsK
LQlpZiAoIXR0eW4gfHwgKnR0eW4gPT0gJ1wwJykgewotCQlmcHJpbnRmKHN0ZGVyciwKLQkJCV8o
IkVycm9yISAgQ291bGQgbm90IHJldHJpZXZlIHR0eSBpbmZvcm1hdGlvbi5cbiIpKTsKLQkJcmV0
dXJuIC0xOwotCX0KLQorCSAgICAgIH0KKwkgICAgICAKKwl0dHluID0gdHR5bmFtZShTVERJTl9G
SUxFTk8pOworCWlmICghdHR5biB8fCAqdHR5biA9PSAnXDAnKSAKKwkgIHsKKwkgICAgZnByaW50
ZihzdGRlcnIsCisJCSAgICBfKCJXYXJuaW5nISAgQ291bGQgbm90IHJldHJpZXZlIHR0eSBpbmZv
cm1hdGlvbi5cbiIpKTsKKwkgIH0KKwkKIAlpZiAocGFyc2VfY29tbWFuZF9saW5lX2FyZ3VtZW50
cyhhcmdjLCBhcmd2LCB0dHluLCBvbGRfY29udGV4dCwKIAkJCQkJICZuZXdfY29udGV4dCwgJnBy
ZXNlcnZlX2Vudmlyb25tZW50KSkKIAkJcmV0dXJuIC0xOwpAQCAtMTAyNiw4ICsxMDM1LDcgQEAK
IAkgKi8KIAlpZiAoZXh0cmFjdF9wd19kYXRhKCZwdykpCiAJCWdvdG8gZXJyX2ZyZWU7Ci0KLQlw
cmludGYoXygiQXV0aGVudGljYXRpbmcgJXMuXG4iKSwgcHcucHdfbmFtZSk7CisJICAgICAgCiAj
aWZkZWYgVVNFX1BBTQogCXBhbV9zdGF0dXMgPSBwYW1fc3RhcnQoU0VSVklDRV9OQU1FLCBwdy5w
d19uYW1lLCAmcGFtX2NvbnZlcnNhdGlvbiwKIAkJCSAgICAgICAmcGFtX2hhbmRsZSk7CkBAIC0x
MTI0LDMzICsxMTMyLDM1IEBACiAJCWZyZWUocHcucHdfc2hlbGwpOwogCQlmcmVlKHNoZWxsX2Fy
Z3YwKTsKIAkJcmV0dXJuIGV4aXRfY29kZTsKLQl9Ci0KLQkvKiBDSElMRCAqLwotCS8qIENsb3Nl
IHRoZSB0dHkgYW5kIHJlb3BlbiBkZXNjcmlwdG9ycyAwIHRocm91Z2ggMiAqLwotCWlmIChjbG9z
ZShmZCkgfHwgY2xvc2UoMCkgfHwgY2xvc2UoMSkgfHwgY2xvc2UoMikpIHsKLQkJZnByaW50Zihz
dGRlcnIsIF8oIkNvdWxkIG5vdCBjbG9zZSBkZXNjcmlwdG9ycy5cbiIpKTsKLQkJZ290byBlcnJf
Y2xvc2VfcGFtOwotCX0KLQlmZCA9IG9wZW4odHR5biwgT19SRE9OTFl8T19OT05CTE9DSyk7Ci0J
aWYgKGZkICE9IDApCi0JCWdvdG8gZXJyX2Nsb3NlX3BhbTsKLQlmY250bChmZCwgRl9TRVRGTCwg
ZmNudGwoZmQsIEZfR0VURkwsIDApICYgfk9fTk9OQkxPQ0spOwotCWZkID0gb3Blbih0dHluLCBP
X1JEV1J8T19OT05CTE9DSyk7Ci0JaWYgKGZkICE9IDEpCi0JCWdvdG8gZXJyX2Nsb3NlX3BhbTsK
LQlmY250bChmZCwgRl9TRVRGTCwgZmNudGwoZmQsIEZfR0VURkwsIDApICYgfk9fTk9OQkxPQ0sp
OwotCWZkID0gb3Blbih0dHluLCBPX1JEV1J8T19OT05CTE9DSyk7Ci0JaWYgKGZkICE9IDIpCi0J
CWdvdG8gZXJyX2Nsb3NlX3BhbTsKLQlmY250bChmZCwgRl9TRVRGTCwgZmNudGwoZmQsIEZfR0VU
RkwsIDApICYgfk9fTk9OQkxPQ0spOwotCi0JLyoKLQkgKiBTdGVwIDU6ICBFeGVjdXRlIGEgbmV3
IHNoZWxsIHdpdGggdGhlIG5ldyBjb250ZXh0IGluIGBuZXdfY29udGV4dCcuIAotCSAqCi0JICog
RXN0YWJsaXNoIGNvbnRleHQsIG5hbWVzYXBjZSBhbmQgYW55IG9wdGlvbnMgZm9yIHRoZSBuZXcg
c2hlbGwKLQkgKi8KLQlpZiAob3B0aW5kIDwgMSkKKwkgICAgICB9CisJICAgICAgCisJICAgICAg
LyogQ0hJTEQgKi8KKwkgICAgICAvKiBDbG9zZSB0aGUgdHR5IGFuZCByZW9wZW4gZGVzY3JpcHRv
cnMgMCB0aHJvdWdoIDIgKi8KKwkgICAgICBpZiAodHR5bikgeworCQkgIGlmIChjbG9zZShmZCkg
fHwgY2xvc2UoMCkgfHwgY2xvc2UoMSkgfHwgY2xvc2UoMikpIHsKKwkJICAgIGZwcmludGYoc3Rk
ZXJyLCBfKCJDb3VsZCBub3QgY2xvc2UgZGVzY3JpcHRvcnMuXG4iKSk7CisJCSAgICBnb3RvIGVy
cl9jbG9zZV9wYW07CisJCSAgfQorCQkgIGZkID0gb3Blbih0dHluLCBPX1JET05MWXxPX05PTkJM
T0NLKTsKKwkJICBpZiAoZmQgIT0gMCkKKwkJICAgIGdvdG8gZXJyX2Nsb3NlX3BhbTsKKwkJICBm
Y250bChmZCwgRl9TRVRGTCwgZmNudGwoZmQsIEZfR0VURkwsIDApICYgfk9fTk9OQkxPQ0spOwor
CQkgIGZkID0gb3Blbih0dHluLCBPX1JEV1J8T19OT05CTE9DSyk7CisJCSAgaWYgKGZkICE9IDEp
CisJCSAgICBnb3RvIGVycl9jbG9zZV9wYW07CisJCSAgZmNudGwoZmQsIEZfU0VURkwsIGZjbnRs
KGZkLCBGX0dFVEZMLCAwKSAmIH5PX05PTkJMT0NLKTsKKwkJICBmZCA9IG9wZW4odHR5biwgT19S
RFdSfE9fTk9OQkxPQ0spOworCQkgIGlmIChmZCAhPSAyKQorCQkgICAgZ290byBlcnJfY2xvc2Vf
cGFtOworCQkgIGZjbnRsKGZkLCBGX1NFVEZMLCBmY250bChmZCwgRl9HRVRGTCwgMCkgJiB+T19O
T05CTE9DSyk7CisJCSAgCisJCX0KKwkgICAgICAvKgorCSAgICAgICAqIFN0ZXAgNTogIEV4ZWN1
dGUgYSBuZXcgc2hlbGwgd2l0aCB0aGUgbmV3IGNvbnRleHQgaW4gYG5ld19jb250ZXh0Jy4gCisJ
ICAgICAgICoKKwkgICAgICAgKiBFc3RhYmxpc2ggY29udGV4dCwgbmFtZXNhcGNlIGFuZCBhbnkg
b3B0aW9ucyBmb3IgdGhlIG5ldyBzaGVsbAorCSAgICAgICAqLworCSAgICAgIGlmIChvcHRpbmQg
PCAxKQogCQlvcHRpbmQgPSAxOwogCiAJLyogVGhpcyBpcyB1Z2x5LCBidXQgdXNlIG5ld3JvbGUn
cyBhcmd2IGZvciB0aGUgZXhlYydkIHNoZWxscyBhcmd2ICovCg==

------_=_NextPart_001_01C840ED.05F3760C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
