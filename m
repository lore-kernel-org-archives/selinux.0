Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EMEvkX009811
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 18:14:57 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EMEuuf007881
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 22:14:56 GMT
Message-ID: <482B6434.4050300@redhat.com>
Date: Wed, 14 May 2008 18:14:12 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@tanso.net>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RHEL5 initrc_t vs. unconfined_t
References: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com>	 <482AEBA8.7090604@redhat.com>	 <20080514144243.GA21546@lc4eb8045376502.ibm.com>	 <482AFDFB.4080404@redhat.com> <911f42990805141246r16c20dqf8effdc48b901dd1@mail.gmail.com>
In-Reply-To: <911f42990805141246r16c20dqf8effdc48b901dd1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan-Frode Myklebust wrote:
| On Wed, May 14, 2008 at 4:58 PM, Daniel J Walsh <dwalsh@redhat.com> wrote:
|> The one to be concerned about is mounting of the unlabeled_t file
|> system.  This looks like you have a file system that SELinux does not
|> know about?
|
|
| Yes, GPFS doesn't support the selinux extended attributes, so the
| filesystems has to be mounted with f.ex. "-o
| "fscontext=user_u:object_r:httpd_var_run_t" for static labelling.
|
|
|   -jf
The other ones are just leaked file descriptors and can be ignored.

The third party provider should close the file descriptors on exec

C code do to this is:

fcntl(fd, F_SETFD, FD_CLOSEXEC)


Or you can add a custom policy module to either donataudit or allow this.

ausearch -M avc | audit2allow -M mypol
semodule -i mypol.pp

will create and install a policy package.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgrZDQACgkQrlYvE4MpobO5gACfQovDnbkKerk3zA+WyD5TcKOK
9q4AoNlf8Mzq9igLo+0BiBNqZk10uBj1
=iJTZ
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
