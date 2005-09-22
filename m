Message-ID: <4332F1B5.2010704@diyab.net>
Date: Thu, 22 Sep 2005 14:02:29 -0400
From: Timothy <timothy@diyab.net>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Lee Lowder <friedbob@sbcglobal.net>, selinux@tycho.nsa.gov
Subject: Re: Getting started with SELinux and Slackware
References: <43325C75.3060405@sbcglobal.net> <1127392107.19487.23.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1127392107.19487.23.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

All of the modified slackware sources that I used to build that old
release are available on that ftp site (ftp.diyab.net/selinux).  I
haven't had time to update any of it in a while but it generally just
requires checking the newer patches and rebuilding the tgz from the
slackbuild script.

I included PAM because I think it has good advantages so all of the
packages I built include PAM support.  Not sure what would be involved
in building without PAM.  Most likely it just requires removing the
configure flags to enable PAM from the build scripts.

I'll be more than happy to help you out if you want.

Timothy,

Stephen Smalley wrote:
> On Thu, 2005-09-22 at 02:25 -0500, Lee Lowder wrote:
> 
>>I am using Slackware 10.2 with kernel 2.6.13.2, and am wanting to get 
>>going with SELinux.  I know that Timothy Wood had made some packages in 
>>the past, but his site (as listed on the SELinux for Distrubtions page) 
>>gives a 403 error.
> 
> 
> Yes, looks like the old URL is dead.  But looking at his top-level site
> (which redirects to his blog now), I see a reference to
> ftp://ftp.diyab.net/selinux/ as the new location for his Slackware
> selinux packages.  Looks a little dated (based off the 9 March 2005
> release of SELinux).
> 
> 
>>I don't mind installing it all myself, but I am not sure where to start. 
>>  I do know I will need PAM, as Slackware does not include it by default.
> 
> 
> SELinux doesn't strictly require the use of PAM; you can port it to
> Slackware without necessarily converting to PAM.  Using SELinux without
> PAM (and pam_selinux) just requires policy modifications to allow direct
> program reading of /etc/shadow and direct patching of login.
> pam_selinux was actually introduced by Red Hat when they integrated
> SELinux into Fedora Core; prior to that, login was directly patched for
> SELinux.  So an alternative path is to resurrect the old login patch for
> SELinux and adjust policy accordingly.
> 
> 
>>If someone could point me to some info to help guide me through this, or 
>>provide such info, I would greatly appreciate it.  Thank you.
> 
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDMvG1SYq2KfPEK/gRAmhZAJwL2uR8LksFu8GvUPm7Xm11N5itqgCfZ1Lc
MI5lEc0AbeHraiwh7BB+hFM=
=2pzw
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
