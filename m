Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1E873Rb002787
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 03:07:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1E85ZlK016563
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 08:05:35 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id i1E85ZOX016554
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 08:05:35 GMT
Received: from nexus.verbum.private (dhcp024-208-187-170.columbus.rr.com [24.208.187.170])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "nexus.verbum.org", Issuer "monk.verbum.org" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id 79A4032A6D6
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 03:09:04 -0500 (EST)
Subject: setfiles sorting
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1vvArCKqgIl3bpA6Ym5n"
Message-Id: <1076745885.13876.12.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Sat, 14 Feb 2004 03:04:46 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1vvArCKqgIl3bpA6Ym5n
Content-Type: multipart/mixed; boundary="=-rqGqritsrl6EGpJTKiG7"


--=-rqGqritsrl6EGpJTKiG7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I recently upgraded my UML setup to 2.6, and I created a new root
filesystem using Debian woody and Brian May's "unstable" SELinux
packages for woody.

However, even after running 'make relabel', a lot of the file contexts
were wrong.  For example, /sbin/getty was still sbin_t, even after
explicitly running setfiles on it.  I verified that the regexp for getty
came after the generic sbin_t regexp in
/etc/selinux/file_contexts/file_contexts.

Staring at the setfiles source code a bit, I came to the conclusion that
this line was wrong:

> 	/* Sort the specifications with most general first */
> 	qsort(spec_arr, nspec, sizeof(struct spec), spec_compare);

As the libc manual says, qsort is not guaranteed to be a stable sort,
and it apparently isn't.  So I think what was happening is the getty_t
rule was being randomly sorted before the generic sbin_t rule.

I don't see why the specifications should be sorted in that way; we
should just go by the order in the file_contexts file.  I guess I don't
understand what the whole bit with looking for metacharacters was trying
to accomplish in the first place.

Anyways, applying the attached patch made it work for me.



--=-rqGqritsrl6EGpJTKiG7
Content-Disposition: attachment; filename=setfiles.patch
Content-Type: text/x-patch; name=setfiles.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeWNvcmV1dGlscy0xLjQvc2V0ZmlsZXMvc2V0ZmlsZXMuYwlUaHUgTm92IDIwIDE1
OjI5OjE3IDIwMDMNCisrKyBwb2xpY3ljb3JldXRpbHMtMS40LmhhY2tlZC9zZXRmaWxlcy9zZXRm
aWxlcy5jCVNhdCBGZWIgMTQgMDc6NTU6NDQgMjAwNA0KQEAgLTQzNywxNSArNDM3LDYgQEANCiAJ
cmV0dXJuIGk7DQogfQ0KIA0KLS8qIFVzZWQgd2l0aCBxc29ydCB0byBzb3J0IHNwZWNzIGZyb20g
bG93ZXN0IHRvIGhpZ2hlc3QgaGFzTWV0YUNoYXJzIHZhbHVlICovDQotaW50IHNwZWNfY29tcGFy
ZShjb25zdCB2b2lkKiBzcGVjQSwgY29uc3Qgdm9pZCogc3BlY0IpDQotew0KLQlyZXR1cm4oDQot
CQkoKGNvbnN0IHN0cnVjdCBzcGVjICopc3BlY0IpLT5oYXNNZXRhQ2hhcnMgLQ0KLQkJKChjb25z
dCBzdHJ1Y3Qgc3BlYyAqKXNwZWNBKS0+aGFzTWV0YUNoYXJzDQotCQkpOyANCi19DQotDQogLyoN
CiAgKiBDaGVjayBmb3IgZHVwbGljYXRlIHNwZWNpZmljYXRpb25zLiBJZiBhIGR1cGxpY2F0ZSBz
cGVjaWZpY2F0aW9uIGlzIGZvdW5kIA0KICAqIGFuZCB0aGUgY29udGV4dCBpcyB0aGUgc2FtZSwg
Z2l2ZSBhIHdhcm5pbmcgdG8gdGhlIHVzZXIuIElmIGEgZHVwbGljYXRlIA0KQEAgLTkxNSw5ICs5
MDYsNiBAQA0KIAkJfQ0KIAl9DQogCWZjbG9zZShmcCk7DQotDQotCS8qIFNvcnQgdGhlIHNwZWNp
ZmljYXRpb25zIHdpdGggbW9zdCBnZW5lcmFsIGZpcnN0ICovDQotCXFzb3J0KHNwZWNfYXJyLCBu
c3BlYywgc2l6ZW9mKHN0cnVjdCBzcGVjKSwgc3BlY19jb21wYXJlKTsNCiANCiAJLyogVmVyaWZ5
IG5vIGV4YWN0IGR1cGxpY2F0ZXMgKi8NCiAJaWYgKG5vZHVwc19zcGVjcygpICE9IDApIHsNCg==

--=-rqGqritsrl6EGpJTKiG7--

--=-1vvArCKqgIl3bpA6Ym5n
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBALdadOIkJWWp2WGURAiugAJ0VUmu1QCEyXQYQuQ9vi6wHFp2IsQCcCKqQ
4oKXOb+WcMiutDUibiv3pYw=
=88af
-----END PGP SIGNATURE-----

--=-1vvArCKqgIl3bpA6Ym5n--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
