Received: from ultraviolet.org ([192.215.175.10])
	by tycho.ncsc.mil (8.9.3/8.9.3) with SMTP id SAA09346
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 18:37:21 -0400 (EDT)
Date: Tue, 1 Oct 2002 15:36:38 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: selinux@tycho.nsa.gov
Subject: SE Linux on Debian
Message-ID: <20021001153638.J5416@ultraviolet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="g3RkK9jYN81zD2N+"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--g3RkK9jYN81zD2N+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am trying to get SE Linux working on my debian system. I've been running
RedHat for years and I'm somewhat new to debian. :) I am running testing.
I installed 2.4.19 and the lsm-new-2002082308-2.4.19.patch.12.gz with
apt-get also. The kernel is running just fine. But I am having trouble
with the policy and utils.

I installed the debs with apt-get from:

deb http://www.microcomaustralia.com.au/debian/ stable selinux

because that is what is in the topic on the IRC channel. Is it ok to
install these from stable even though my distro is actually testing?

Here are the debs:

libselinux-dev
selinux
selinux-policy-default=20

But the new ps, ls, sshd, etc. do not seem to be included here. Where do I
get those? Are they not in a deb?=20

When I installed the new policy it asked a lot of questions such as:

Setting up selinux-policy-default (2002082308-4.bam.1) ...
File "domains/program/apache.te" changed.
Copy/Ignore/Always ignore/view Diff [c/I/a/d]?=20

I said Copy to all of them. I'm not running all of that but I will be
playing with various different things so I want the latest policies
installed. When it was done asking questions I got this error:

/usr/sbin/checkpolicy:  loading policy configuration from /etc/security/sel=
inux/src/policy.conf

ERROR 'parse error' at token 'run_program' on line 71322:
run_program(sysadm_t, sysadm_r, deb, dpkg_exec_t, dpkg_t)
#
/usr/sbin/checkpolicy:  error(s) encountered while parsing configuration
make: *** [/etc/security/selinux/policy.12] Error 1
dpkg: error processing selinux-policy-default (--configure):
 subprocess post-installation script returned error exit status 2

Errors were encountered while processing:
 selinux-policy-default
E: Sub-process /usr/bin/dpkg returned an error code (1)

Whenever I install a new package apt-get tries to recompile the policy
(why?) and I get the same error.

Any help is greatly appreciated!

--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,=20
senior VP in charge of Microsoft's Windows development 5 Sept 2002

--g3RkK9jYN81zD2N+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj2aI3YACgkQ9PIYKZYVAq22sACfY5szw1ZbG9tGKsnFiWop/EwV
EVsAn0sHevHTviQHLTdnHAAeZ7VbYU1v
=h9AZ
-----END PGP SIGNATURE-----

--g3RkK9jYN81zD2N+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
