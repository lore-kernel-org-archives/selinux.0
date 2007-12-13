MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C83DAA.88443448"
Subject: RE: newrole in the background
Date: Thu, 13 Dec 2007 09:06:41 -0800
Message-ID: <436A69503F99214D9EBC27415F66C40C0F597703@blums0008.bluelnk.net>
References: <436A69503F99214D9EBC27415F66C40C0F517115@blums0008.bluelnk.net> <cadfc0e40712110806j5d6676f6j10a8b1dd3c557fa@mail.gmail.com> <1197397057.28006.3.camel@moss-spartans.epoch.ncsc.mil> <436A69503F99214D9EBC27415F66C40C0F5178BE@blums0008.bluelnk.net> <476047A9.90000@gmail.com> <436A69503F99214D9EBC27415F66C40C0F517AD3@blums0008.bluelnk.net> <1197555910.20226.8.camel@moss-spartans.epoch.ncsc.mil> <cadfc0e40712130641r301dd959x895f33ff1e72f581@mail.gmail.com> <1197558486.20226.40.camel@moss-spartans.epoch.ncsc.mil>
From: "Reed, Tim \(US SSA\)" <tim.reed@baesystems.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Xavier Toth" <txtoth@gmail.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C83DAA.88443448
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

New patch...I have added checks around the calls that deal with the tty.
So if ttyn is an empty string (something had a heartache with it being
NULL) then it skips the processing.  It does appear to work but more
testing is needed.  Please review and comment.

Now say if someone ran `newrole -l SystemHigh -- -c "su - foo"` in the
background of a script, you would not be able to give su input as it is
in the background and has no tty.  su in this case exits gracefully I
guess you could say. =20

My point is that if you have an application that needs to run from
newrole, in the background AND requires user input, you will not be able
to give the application input while it is in the background and have it
work successfully.

Example:
foo.sh
---------------
#!/bin/bash

./bar.sh &
---------------
bar.sh
---------------
#!/bin/bash

su - root -c /bin/date
---------------

su exits because there is no tty for input.  So is chasing down having
newrole run in a pseudo tty in the background and accept input worth the
time?

Thanks,
Tim


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
Sent: Thursday, December 13, 2007 10:08 AM
To: Xavier Toth
Cc: Reed, Tim (US SSA); SE Linux
Subject: Re: newrole in the background

On Thu, 2007-12-13 at 08:41 -0600, Xavier Toth wrote:
> On Dec 13, 2007 8:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Thu, 2007-12-13 at 04:30 -0800, Reed, Tim (US SSA) wrote:
> > > Good point.  That is why I was looking for test cases or
something.
> > >
> > > I am going to explore Stephen suggestion more of making the lack
of a
> > > tty non-fatal.  But won't we want newrole to have a tty so that it
can
> > > send/receive input from the user?  That is the reason why I was
having
> > > it creating a pseudo tty.
> > >
> > > Suggestions.....
> >
> > You said you wanted to be able to use newrole while detached from
any
> > tty, thus no input is possible there.  Right?
> >
> > So if you have newrole or the subsequent application use a pam
module
> > that requires a tty, it is going to fail regardless in that
situation.
> > Your situation presumes that you aren't using pam modules that
require a
> > tty.
> >
> > Only thing to check is to make sure that the pam modules fail
gracefully
> > in that situation and newrole correctly exits with an error in that
> > case.
> >
> >
> > --
> > Stephen Smalley
> > National Security Agency
> >
> >
>=20
> Right, but doesn't pam_unix exec unix_chkpwd and wait for it to exit?
> Or will unix_chkpwd fail because there isn't a tty?

That's what we need to check - that the pam module or unix_chkpwd
correctly handle the case where there is no tty.  And that is better
than having it block indefinitely on a pty that we've created that will
never provide any input at all...

--=20
Stephen Smalley
National Security Agency


------_=_NextPart_001_01C83DAA.88443448
Content-Type: application/octet-stream;
	name="newrole_no_tty_2.patch"
Content-Transfer-Encoding: base64
Content-Description: newrole_no_tty_2.patch
Content-Disposition: attachment;
	filename="newrole_no_tty_2.patch"

ZGlmZiAtTmF1ciBwb2xpY3ljb3JldXRpbHMtMS4zNC4xMS9uZXdyb2xlL25ld3JvbGUuYyBwb2xp
Y3ljb3JldXRpbHMtMS4zNC4xMS1vcmlnL25ld3JvbGUvbmV3cm9sZS5jCi0tLSBwb2xpY3ljb3Jl
dXRpbHMtMS4zNC4xMS9uZXdyb2xlL25ld3JvbGUuYwkyMDA3LTEyLTEzIDExOjA3OjAxLjAwMDAw
MDAwMCAtMDUwMAorKysgcG9saWN5Y29yZXV0aWxzLTEuMzQuMTEtb3JpZy9uZXdyb2xlL25ld3Jv
bGUuYwkyMDA3LTEyLTEyIDE1OjU2OjQ0LjAwMDAwMDAwMCAtMDUwMApAQCAtNjM5LDUxICs2Mzks
NDcgQEAKIAkJcmV0dXJuIC0xOwogCX0KIAotCWlmKCBzdHJsZW4oIHR0eW4gKSA+IDAgKQotCSAg
ewotCSAgICAvKiBSZS1vcGVuIFRUWSBkZXNjcmlwdG9yICovCi0JICAgIGZkID0gb3Blbih0dHlu
LCBPX1JEV1J8T19OT05CTE9DSyk7Ci0JICAgIGlmIChmZCA8IDApIHsKLQkgICAgICBmcHJpbnRm
KHN0ZGVyciwgXygiRXJyb3IhICBDb3VsZCBub3Qgb3BlbiAlcy5cbiIpLCB0dHluKTsKLQkgICAg
ICByZXR1cm4gZmQ7Ci0JICAgIH0KLQkgICAgZmNudGwoZmQsIEZfU0VURkwsIGZjbnRsKGZkLCBG
X0dFVEZMLCAwKSAmIH5PX05PTkJMT0NLKTsKLQkgICAgCi0JICAgIGlmIChmZ2V0ZmlsZWNvbihm
ZCwgJnR0eV9jb24pIDwgMCkgewotCSAgICAgIGZwcmludGYoc3RkZXJyLCBfKCIlcyEgIENvdWxk
IG5vdCBnZXQgY3VycmVudCBjb250ZXh0ICIKLQkJCQkiZm9yICVzLCBub3QgcmVsYWJlbGluZyB0
dHkuXG4iKSwKLQkJICAgICAgZW5mb3JjaW5nID8gIkVycm9yIiA6ICJXYXJuaW5nIiwgdHR5bik7
Ci0JICAgICAgaWYgKGVuZm9yY2luZykKLQkJZ290byBjbG9zZV9mZDsKLQkgICAgfQotCSAgICAK
LQkgICAgaWYgKHR0eV9jb24gJiYKLQkJKHNlY3VyaXR5X2NvbXB1dGVfcmVsYWJlbChuZXdfY29u
dGV4dCwgdHR5X2NvbiwKLQkJCQkJICBTRUNDTEFTU19DSFJfRklMRSwgJm5ld190dHlfY29uKSA8
IDApKSB7Ci0JICAgICAgZnByaW50ZihzdGRlcnIsCV8oIiVzISAgQ291bGQgbm90IGdldCBuZXcg
Y29udGV4dCBmb3IgJXMsICIKLQkJCQkgICJub3QgcmVsYWJlbGluZyB0dHkuXG4iKSwKLQkJICAg
ICAgZW5mb3JjaW5nID8gIkVycm9yIiA6ICJXYXJuaW5nIiwgdHR5bik7Ci0JICAgICAgaWYgKGVu
Zm9yY2luZykKLQkJZ290byBjbG9zZV9mZDsKLQkgICAgfQotCSAgICAKLQkgICAgaWYgKG5ld190
dHlfY29uKQotCSAgICAgIGlmIChmc2V0ZmlsZWNvbihmZCwgbmV3X3R0eV9jb24pIDwgMCkgewot
CQlmcHJpbnRmKHN0ZGVyciwKLQkJCV8oIiVzISAgQ291bGQgbm90IHNldCBuZXcgY29udGV4dCBm
b3IgJXNcbiIpLAorCS8qIFJlLW9wZW4gVFRZIGRlc2NyaXB0b3IgKi8KKwlmZCA9IG9wZW4odHR5
biwgT19SRFdSfE9fTk9OQkxPQ0spOworCWlmIChmZCA8IDApIHsKKwkJZnByaW50ZihzdGRlcnIs
IF8oIkVycm9yISAgQ291bGQgbm90IG9wZW4gJXMuXG4iKSwgdHR5bik7CisJCXJldHVybiBmZDsK
Kwl9CisJZmNudGwoZmQsIEZfU0VURkwsIGZjbnRsKGZkLCBGX0dFVEZMLCAwKSAmIH5PX05PTkJM
T0NLKTsKKworCWlmIChmZ2V0ZmlsZWNvbihmZCwgJnR0eV9jb24pIDwgMCkgeworCQlmcHJpbnRm
KHN0ZGVyciwgXygiJXMhICBDb3VsZCBub3QgZ2V0IGN1cnJlbnQgY29udGV4dCAiCisJCQkiZm9y
ICVzLCBub3QgcmVsYWJlbGluZyB0dHkuXG4iKSwKKwkJCWVuZm9yY2luZyA/ICJFcnJvciIgOiAi
V2FybmluZyIsIHR0eW4pOworCQlpZiAoZW5mb3JjaW5nKQorCQkJZ290byBjbG9zZV9mZDsKKwl9
CisKKwlpZiAodHR5X2NvbiAmJgorCSAgICAoc2VjdXJpdHlfY29tcHV0ZV9yZWxhYmVsKG5ld19j
b250ZXh0LCB0dHlfY29uLAorCQkJCSAgICAgIFNFQ0NMQVNTX0NIUl9GSUxFLCAmbmV3X3R0eV9j
b24pIDwgMCkpIHsKKwkJZnByaW50ZihzdGRlcnIsCV8oIiVzISAgQ291bGQgbm90IGdldCBuZXcg
Y29udGV4dCBmb3IgJXMsICIKKwkJCSJub3QgcmVsYWJlbGluZyB0dHkuXG4iKSwKIAkJCWVuZm9y
Y2luZyA/ICJFcnJvciIgOiAiV2FybmluZyIsIHR0eW4pOwotCQlmcmVlY29uKG5ld190dHlfY29u
KTsKLQkJbmV3X3R0eV9jb24gPSBOVUxMOwogCQlpZiAoZW5mb3JjaW5nKQotCQkgIGdvdG8gY2xv
c2VfZmQ7Ci0JICAgICAgfQotCSAgICAKLQkgICAgKnR0eV9jb250ZXh0ID0gdHR5X2NvbjsKLQkg
ICAgKm5ld190dHlfY29udGV4dCA9IG5ld190dHlfY29uOwotCSAgICByZXR1cm4gZmQ7Ci0JICB9
Ci0JZWxzZQotCSAgcmV0dXJuIDA7CisJCQlnb3RvIGNsb3NlX2ZkOworCX0KKworCWlmIChuZXdf
dHR5X2NvbikKKwkJaWYgKGZzZXRmaWxlY29uKGZkLCBuZXdfdHR5X2NvbikgPCAwKSB7CisJCQlm
cHJpbnRmKHN0ZGVyciwKKwkJCQlfKCIlcyEgIENvdWxkIG5vdCBzZXQgbmV3IGNvbnRleHQgZm9y
ICVzXG4iKSwKKwkJCQllbmZvcmNpbmcgPyAiRXJyb3IiIDogIldhcm5pbmciLCB0dHluKTsKKwkJ
CWZyZWVjb24obmV3X3R0eV9jb24pOworCQkJbmV3X3R0eV9jb24gPSBOVUxMOworCQkJaWYgKGVu
Zm9yY2luZykKKwkJCQlnb3RvIGNsb3NlX2ZkOworCQl9CisKKwkqdHR5X2NvbnRleHQgPSB0dHlf
Y29uOworCSpuZXdfdHR5X2NvbnRleHQgPSBuZXdfdHR5X2NvbjsKKwlyZXR1cm4gZmQ7CisKIGNs
b3NlX2ZkOgogCWZyZWVjb24odHR5X2Nvbik7CiAJY2xvc2UoZmQpOwpAQCAtODAzLDE3ICs3OTks
MTQgQEAKIAkJCQkJInNwZWNpZmllZFxuIikpOwogCQkJCXJldHVybiAtMTsKIAkJCX0KLQkJCWlm
KCBzdHJsZW4oIHR0eW4gKSA+IDAgKQotCQkJICB7Ci0JCQkgICAgaWYgKGZnZXRmaWxlY29uKDAs
JnR0eV9jb24pID49IDApIHsKLQkJCSAgICAgIGlmIChzZWxpbnV4X2NoZWNrX3NlY3VyZXR0eV9j
b250ZXh0KHR0eV9jb24pIDwgMCkgewotCQkJCWZwcmludGYoc3RkZXJyLCBfKCJFcnJvcjogeW91
IGFyZSBub3QgYWxsb3dlZCB0byBjaGFuZ2UgbGV2ZWxzIG9uIGEgbm9uIHNlY3VyZSB0ZXJtaW5h
bFxuIikpOworCQkJaWYgKGZnZXRmaWxlY29uKDAsJnR0eV9jb24pID49IDApIHsKKwkJCQlpZiAo
c2VsaW51eF9jaGVja19zZWN1cmV0dHlfY29udGV4dCh0dHlfY29uKSA8IDApIHsKKwkJCQkJZnBy
aW50ZihzdGRlcnIsIF8oIkVycm9yOiB5b3UgYXJlIG5vdCBhbGxvd2VkIHRvIGNoYW5nZSBsZXZl
bHMgb24gYSBub24gc2VjdXJlIHRlcm1pbmFsXG4iKSk7CisJCQkJCWZyZWVjb24odHR5X2Nvbik7
CisJCQkJCXJldHVybiAtMTsKKwkJCQl9CiAJCQkJZnJlZWNvbih0dHlfY29uKTsKLQkJCQlyZXR1
cm4gLTE7Ci0JCQkgICAgICB9Ci0JCQkgICAgICBmcmVlY29uKHR0eV9jb24pOwotCQkJICAgIH0K
LQkJCSAgfQorCQkJfQogCiAJCQlsZXZlbF9zID0gb3B0YXJnOwogCQkJYnJlYWs7CkBAIC05MzEs
NiArOTI0LDcgQEAKIAogCXJldHVybiAwOwogfQorCiAvKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgKgogICog
QWxsIGNvZGUgdXNlZCBmb3IgYm90aCBQQU0gYW5kIHNoYWRvdyBwYXNzd2QgZ29lcyBpbiB0aGlz
IHNlY3Rpb24uCkBAIC0xMTMzLDI2ICsxMTI3LDI0IEBACiAJfQogCiAJLyogQ0hJTEQgKi8KLQlp
Ziggc3RybGVuKCB0dHluICkgPiAwICkKLQkgIHsKLQkgICAgLyogQ2xvc2UgdGhlIHR0eSBhbmQg
cmVvcGVuIGRlc2NyaXB0b3JzIDAgdGhyb3VnaCAyICovCi0JICAgIGlmIChjbG9zZShmZCkgfHwg
Y2xvc2UoMCkgfHwgY2xvc2UoMSkgfHwgY2xvc2UoMikpIHsKLQkgICAgICBmcHJpbnRmKHN0ZGVy
ciwgXygiQ291bGQgbm90IGNsb3NlIGRlc2NyaXB0b3JzLlxuIikpOwotCSAgICAgIGdvdG8gZXJy
X2Nsb3NlX3BhbTsKLQkgICAgfQotCSAgICBmZCA9IG9wZW4odHR5biwgT19SRE9OTFl8T19OT05C
TE9DSyk7Ci0JICAgIGlmIChmZCAhPSAwKQotCSAgICAgIGdvdG8gZXJyX2Nsb3NlX3BhbTsKLQkg
ICAgZmNudGwoZmQsIEZfU0VURkwsIGZjbnRsKGZkLCBGX0dFVEZMLCAwKSAmIH5PX05PTkJMT0NL
KTsKLQkgICAgZmQgPSBvcGVuKHR0eW4sIE9fUkRXUnxPX05PTkJMT0NLKTsKLQkgICAgaWYgKGZk
ICE9IDEpCi0JICAgICAgZ290byBlcnJfY2xvc2VfcGFtOwotCSAgICBmY250bChmZCwgRl9TRVRG
TCwgZmNudGwoZmQsIEZfR0VURkwsIDApICYgfk9fTk9OQkxPQ0spOwotCSAgICBmZCA9IG9wZW4o
dHR5biwgT19SRFdSfE9fTk9OQkxPQ0spOwotCSAgICBpZiAoZmQgIT0gMikKLQkgICAgICBnb3Rv
IGVycl9jbG9zZV9wYW07Ci0JICAgIGZjbnRsKGZkLCBGX1NFVEZMLCBmY250bChmZCwgRl9HRVRG
TCwgMCkgJiB+T19OT05CTE9DSyk7Ci0JICB9CisJLyogQ2xvc2UgdGhlIHR0eSBhbmQgcmVvcGVu
IGRlc2NyaXB0b3JzIDAgdGhyb3VnaCAyICovCisJaWYgKGNsb3NlKGZkKSB8fCBjbG9zZSgwKSB8
fCBjbG9zZSgxKSB8fCBjbG9zZSgyKSkgeworCQlmcHJpbnRmKHN0ZGVyciwgXygiQ291bGQgbm90
IGNsb3NlIGRlc2NyaXB0b3JzLlxuIikpOworCQlnb3RvIGVycl9jbG9zZV9wYW07CisJfQorCWZk
ID0gb3Blbih0dHluLCBPX1JET05MWXxPX05PTkJMT0NLKTsKKwlpZiAoZmQgIT0gMCkKKwkJZ290
byBlcnJfY2xvc2VfcGFtOworCWZjbnRsKGZkLCBGX1NFVEZMLCBmY250bChmZCwgRl9HRVRGTCwg
MCkgJiB+T19OT05CTE9DSyk7CisJZmQgPSBvcGVuKHR0eW4sIE9fUkRXUnxPX05PTkJMT0NLKTsK
KwlpZiAoZmQgIT0gMSkKKwkJZ290byBlcnJfY2xvc2VfcGFtOworCWZjbnRsKGZkLCBGX1NFVEZM
LCBmY250bChmZCwgRl9HRVRGTCwgMCkgJiB+T19OT05CTE9DSyk7CisJZmQgPSBvcGVuKHR0eW4s
IE9fUkRXUnxPX05PTkJMT0NLKTsKKwlpZiAoZmQgIT0gMikKKwkJZ290byBlcnJfY2xvc2VfcGFt
OworCWZjbnRsKGZkLCBGX1NFVEZMLCBmY250bChmZCwgRl9HRVRGTCwgMCkgJiB+T19OT05CTE9D
Syk7CisKIAkvKgogCSAqIFN0ZXAgNTogIEV4ZWN1dGUgYSBuZXcgc2hlbGwgd2l0aCB0aGUgbmV3
IGNvbnRleHQgaW4gYG5ld19jb250ZXh0Jy4gCiAJICoK

------_=_NextPart_001_01C83DAA.88443448--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
