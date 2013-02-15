Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1FL3i3E024963
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2013 16:03:44 -0500
Date: Fri, 15 Feb 2013 22:03:21 +0100
From: Luis Ressel <aranea@aixah.de>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux
 enforcing mode
Message-ID: <20130215220321.53fd94c4@gentp.lnet>
In-Reply-To: <511E8CC3.7010207@tycho.nsa.gov>
References: <20130214222502.2f7d657c@gentp.lnet>
	<511E38E7.4040609@tycho.nsa.gov>
	<20130215150649.22c20d5c@gentp.lnet>
	<511E45F6.4030300@tycho.nsa.gov>
	<20130215160240.47e8d1da@gentp.lnet>
	<511E5568.90103@tycho.nsa.gov>
	<20130215170749.624be7b1@gentp.lnet>
	<511E7C2A.1070101@tycho.nsa.gov>
	<20130215194414.611081d4@gentp.lnet>
	<511E8CC3.7010207@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA512;
 boundary="Sig_/G4HujQvs+KB3C7y0hWA63Wz"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/G4HujQvs+KB3C7y0hWA63Wz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Feb 2013 14:30:11 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 02/15/2013 01:44 PM, Luis Ressel wrote:
> > Again, you're right. On this boot, dontaudit rules were actually
> > enabled. Now, here's another log where they are disabled again.
>=20
> This line from your log file:
>=20
> audit_printk_skb: 643 callbacks suppressed
>=20
> indicates that you are hitting the printk ratelimit (to prevent
> flooding of syslog) and therefore dropping messages.
>=20
> You could apply the attached patch or something like it to disable
> the printk ratelimit on audit messages.

Thanks! Now I finally got a denial message. kernel_t needs search
permissions on unlabeled_t dirs, that's all.

> However, you might want to first fix some of the obvious denials in
> your policy.  The rlimitinh, siginh, and noatsecure ones can
> generally be ignored.  But you are getting various other denials that
> likely should be allowed.  Adding the unconfined module to your
> policy would automatically eliminate any denials for the kernel or
> init domains.

Yes, I did all this testing in a VM, not on the system where I
originally encountered these issues, and I didn't fine-tune the VM
policy. And my policy doesn't include the unconfined module because it
was optional in my distro, defaulted to off and I thought it was only
neccessary for targeted mode. But I'll try it out now.


I want to thank you again for your fast and helpful responses. Without
your help, I probably wouldn't have been able to resolve this issue, at
least not within resonable time. You really saved me from having severe
headaches!

Luis

--Sig_/G4HujQvs+KB3C7y0hWA63Wz
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJRHqKnAAoJEOBVC/zizycOQNoP/A6gWbAs9Myjf8URCI982zwt
Z+WlgR6Q9rRByh5TI6nuZt7oiDmrzEWldbrNnm9aqexcUwrxBY33+o3VSguxryqf
Zjb6nXMU5Xu/Dhp9fz6u+326KwOEjW6pgk3h5cuOKXWj4PIf/CIIvdq6y69wgH6s
OoJ40/ogoaZjnFeyb7p97RSwgxzP5HJRgK0MM0uu7tFgq2vzhhx8oddajrxIYqfK
DYtK7oiEsJNZjeS4CYCoD1WfjL2JJX9gjQsZBi2s4NU1bekZCJ+EzQo0Z3kVHe6X
cxwNQQaNinAbAqHmSVfEgAKB+NNXz5KSDOzV3CZ+4CjQVIFzDpLgi3XPoKerEJI5
jlYm3RM/2kxlGeqyVrQdNrRCfl8O+ZFQHXnWyb24w+JpPwRwvp82FiBAi2iXgCuj
BgjPF5kCDDDItJIgt13TChDyyTZ6yfzKqmnwue5XjMaFTdna1fUMDaSbAih7m8Yd
Bl7VDk42MyTFTcFbTCO/dDp506x9ClIDHyMYXxIR4sAqo1kMtM9lgPrfnH4ey6L5
OxUJ7/yWPPbcC7OdM3dkHqeWarCoaK9DOK4I3L6PqofvAmh7vuHh5kAgOzu99yj2
EHF3eXXwJb2081KKf+o4kz6bHrpKLnaz9ZhaWgDC1yAQpwberA2kXlzk/subBdXr
+/mfUOGQPrVpTwxdOp88
=KqSm
-----END PGP SIGNATURE-----

--Sig_/G4HujQvs+KB3C7y0hWA63Wz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
