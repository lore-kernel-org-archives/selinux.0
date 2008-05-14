Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4EMgQAV013561
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 18:42:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4EMgQuf016699
	for <selinux@tycho.nsa.gov>; Wed, 14 May 2008 22:42:26 GMT
Message-ID: <482B6AA6.3050500@redhat.com>
Date: Wed, 14 May 2008 18:41:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@tanso.net>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: RHEL5 initrc_t vs. unconfined_t
References: <911f42990805131345o43ad62b5pd9aee31feb01e6a9@mail.gmail.com> <482AEBA8.7090604@redhat.com> <20080514144243.GA21546@lc4eb8045376502.ibm.com> <482AFDFB.4080404@redhat.com> <911f42990805141246r16c20dqf8effdc48b901dd1@mail.gmail.com> <482B6434.4050300@redhat.com> <20080514223129.GA29418@lc4eb8045376502.ibm.com>
In-Reply-To: <20080514223129.GA29418@lc4eb8045376502.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan-Frode Myklebust wrote:
| On Wed, May 14, 2008 at 06:14:12PM -0400, Daniel J Walsh wrote:
|> |
|> | Yes, GPFS doesn't support the selinux extended attributes, so the
|> | filesystems has to be mounted with f.ex. "-o
|> | "fscontext=user_u:object_r:httpd_var_run_t" for static labelling.
|> |
|
|> The other ones are just leaked file descriptors and can be ignored.
|
| So what about the mount/umount and everything else GPFS might want to
| do in the lifetime of the system. I have no way of guessing all things
| it might want to do that could possibly be denied in a transitioning
| domain. Is my only option to manually start the fs from an interactive
| shell to get it running as unconfined ?
|
|
|   -jf
You might be able to use the runcon command, or write a simple policy
modules for it.

Something like

...

# cat myapp.te
policy_module(myapp, 1.0)

type myapp_t;
type myapp_exec_t;
init_daemon_domain(myapp_t, myapp_exec_t)

unconfined_domains(myapp_exec_t)

#cat myapp.fc

/usr/bin/myapp  gen_context("system_u:object_r:myapp_exec_t:s0)



# make -f /usr/share/selinux/devel/Makefile
# semodule -i myapp.pp




-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgraqYACgkQrlYvE4MpobP68gCgoBRwcHg1+xGq++qyZCT6bhf+
YTEAn2kGm+rkgq/3uwGz9J77c8hysijo
=vF4t
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
