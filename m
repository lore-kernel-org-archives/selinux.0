Subject: rssh pass two - secure GNU arch committers
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zPSyuvK/B/1Ts88/GdFS"
Message-Id: <1073950831.8539.156.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Mon, 12 Jan 2004 18:40:32 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-zPSyuvK/B/1Ts88/GdFS
Content-Type: multipart/mixed; boundary="=-gjnnw3+vC85WkFuJpEJg"


--=-gjnnw3+vC85WkFuJpEJg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I've extended my previous rssh.te to support multiple archives.  My
ultimate goal here is to have a role for people committing to a GNU arch
archive, which just requires the ability to write files over sftp.  I
don't want to give out full shell accounts for this.

There are two files attached, intended to be
domains/program/unused/rssh.te and macros/program/rssh_macros.te.

Here's a full explanation of how to use it.  Say you have an area that
you want several people to be able to write to over SFTP.  First, you
have to install rssh:  http://rssh.sf.net/

Next, in a local .te policy file (I use domains/misc/local.te), do
something like:

rssh_domain(rhythmbox)

This creates a role: rssh_rhythmbox_r, as well as some important types:
rssh_rhythmbox_ro_t and rssh_rhythmbox_rw_t. =20

Next, create a new user account:
suseradd -s /usr/bin/rssh rhythmbox
mkdir /home/rhythmbox
chcon system_u:object_r:rssh_rhythmbox_ro_t /home/rhythmbox

Now, edit /etc/selinux/users, and add a line that looks like this:

user rhythmbox roles { rssh_rhythmbox_r };

Next, gather public ssh keys (usually ~/.ssh/id_rsa.pub) for all the
people you want to have the ability to write to the archive.=20
Concatenate them all into /home/rhythmbox/.ssh/authorized_keys.

Double-check that the type on .ssh and .authorized_keys is
rssh_rhythmbox_ro_t.  The user should *not* be able to write to these
files.

At this point, double-check that you can log in successfully:

sftp rhythmbox@example.com

And finally, just create the directory you want people to be able to
write to (in my case, /home/rhythmbox/arch), and ensure it has the
rssh_rhythmbox_rw_t type.

In my case, I also wanted the webserver to be able to read these files,
so in my local.te, I do:

define(`monk_rssh_domain',`
r_dir_file(httpd_t,rssh_$1_ro_t)
r_dir_file(httpd_t,rssh_$1_rw_t)
dontaudit httpd_t rssh_$1_ro_t:sock_file r_file_perms;
')
monk_rssh_domain(rhythmbox)

The sock_file bits are for another program we use (mini-dinstall).


--=-gjnnw3+vC85WkFuJpEJg
Content-Disposition: attachment; filename=rssh.te
Content-Type: text/plain; name=rssh.te; charset=UTF-8
Content-Transfer-Encoding: base64

I0RFU0MgUnNzaCAtIFJlc3RyaWN0ZWQgKHNjcC9zZnRwKSBvbmx5IHNoZWxsDQojDQojIEF1dGhv
cnM6IENvbGluIFdhbHRlcnMgPHdhbHRlcnNAdmVyYnVtLm9yZz4NCiMgWC1EZWJpYW4tUGFja2Fn
ZTogcnNzaA0KIw0KDQp0eXBlIHJzc2hfZXhlY190LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGUsIGV4
ZWNfdHlwZTsNCg0KaWZkZWYoYHNzaC50ZScsYA0KYWxsb3cgc3NoZF90IHJzc2hfZXhlY190OmZp
bGUgcl9maWxlX3Blcm1zOw0KJykNCg0KIyBTZWUgcnNzaF9tYWNyb3MudGUgZm9yIHRoZSByZXN0
Lg==

--=-gjnnw3+vC85WkFuJpEJg
Content-Disposition: attachment; filename=rssh_macros.te
Content-Type: text/plain; name=rssh_macros.te; charset=UTF-8
Content-Transfer-Encoding: base64

Iw0KIyBNYWNyb3MgZm9yIFJzc2ggZG9tYWlucw0KIw0KIyBBdXRob3I6IENvbGluIFdhbHRlcnMg
PHdhbHRlcnNAdmVyYnVtLm9yZz4NCiMNCg0KIw0KIyByc3NoX2RvbWFpbihkb21haW5fcHJlZml4
KQ0KIw0KIyBEZWZpbmUgYSBzcGVjaWZpYyByc3NoIGRvbWFpbi4NCiMNCiMgVGhlIHR5cGUgZGVj
bGFyYXRpb24gZm9yIHRoZSBleGVjdXRhYmxlIHR5cGUgZm9yIHRoaXMgcHJvZ3JhbSBpcw0KIyBw
cm92aWRlZCBzZXBhcmF0ZWx5IGluIGRvbWFpbnMvcHJvZ3JhbS9yc3NoLnRlLiANCiMNCnVuZGVm
aW5lKGByc3NoX2RvbWFpbicpDQppZmRlZihgcnNzaC50ZScsIGANCmRlZmluZShgcnNzaF9kb21h
aW4nLGANCnR5cGUgcnNzaF8kMV90LCBkb21haW4sIHByaXZsb2csIHByaXZmZDsNCnJvbGUgcnNz
aF8kMV9yIHR5cGVzIHJzc2hfJDFfdDsNCmFsbG93IHN5c3RlbV9yIHJzc2hfJDFfcjsNCg0KdHlw
ZSByc3NoXyQxX3J3X3QsIGZpbGVfdHlwZSwgc3lzYWRtZmlsZTsNCnR5cGUgcnNzaF8kMV9yb190
LCBmaWxlX3R5cGUsIHN5c2FkbWZpbGU7DQoNCmdlbmVyYWxfZG9tYWluX2FjY2Vzcyhyc3NoXyQx
X3QpOw0KdXNlc19zaGxpYihyc3NoXyQxX3QpOw0KYmFzZV9maWxlX3JlYWRfYWNjZXNzKHJzc2hf
JDFfdCk7DQphbGxvdyByc3NoXyQxX3QgdmFyX3Q6ZGlyIHJfZGlyX3Blcm1zOw0Kcl9kaXJfZmls
ZShyc3NoXyQxX3QsIGV0Y190KTsNCnJfZGlyX2ZpbGUocnNzaF8kMV90LCBldGNfcnVudGltZV90
KTsNCnJfZGlyX2ZpbGUocnNzaF8kMV90LCBsb2NhbGVfdCk7DQpjYW5fZXhlYyhyc3NoXyQxX3Qs
IGJpbl90KTsNCmNhbl9leGVjKHJzc2hfJDFfdCwgc3NoZF9zZnRwX2V4ZWNfdCk7DQoNCnJfZGly
X2ZpbGUocnNzaF8kMV90LCByc3NoXyQxX3JvX3QpOw0KY3JlYXRlX2Rpcl9maWxlKHJzc2hfJDFf
dCwgcnNzaF8kMV9yd190KTsNCg0KaWZkZWYoYHNzaC50ZScsYA0KYWxsb3cgcnNzaF8kMV90IHNz
aGRfdDpmZCB1c2U7DQphbGxvdyByc3NoXyQxX3Qgc3NoZF90OnRjcF9zb2NrZXQgcndfc3RyZWFt
X3NvY2tldF9wZXJtczsNCmFsbG93IHJzc2hfJDFfdCBzc2hkX3Q6dW5peF9zdHJlYW1fc29ja2V0
IHJ3X3N0cmVhbV9zb2NrZXRfcGVybXM7DQojIEZvciByZWFkaW5nIC9ob21lL3VzZXIvLnNzaA0K
cl9kaXJfZmlsZShzc2hkX3QsIHJzc2hfJDFfcm9fdCk7DQpkb21haW5fdHJhbnMoc3NoZF90LCBy
c3NoX2V4ZWNfdCwgcnNzaF8kMV90KTsNCicpDQonKQ0KDQonLCBgDQoNCmRlZmluZShgcnNzaF9k
b21haW4nLGAnKQ0KDQonKQ0K

--=-gjnnw3+vC85WkFuJpEJg--

--=-zPSyuvK/B/1Ts88/GdFS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAAzBvOIkJWWp2WGURApDWAJ0SK9J4YLY/k2/D1vbuuTKseS7t9QCfXTmb
SyDaGtBUPl+RWDqg9Jkgb5U=
=yAKU
-----END PGP SIGNATURE-----

--=-zPSyuvK/B/1Ts88/GdFS--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
