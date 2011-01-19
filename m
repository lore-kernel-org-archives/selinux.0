Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0JKBxga011372
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 15:11:59 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p0JKBvJu014333
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2011 20:11:58 GMT
Message-ID: <4D37458B.4050705@redhat.com>
Date: Wed, 19 Jan 2011 15:11:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Qwyjibo Jones <qwyjibojones@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux role separation
References: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
In-Reply-To: <AANLkTimSCuwayFiMTr5=M7E=_eAbYmAOuq4o6ZnUDGsW@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/18/2011 01:03 PM, Qwyjibo Jones wrote:
> 
> I am currently working with an Itanium2 system which has RHEL 5.3 MLS
> installed.
> I am trying to understand how separation of roles works in SELinux/MLS
> policy version 21. We have been told that we need to separate roles that
> the sys admin is no longer allowed to do.
> 
> After reading through these threads, in the archives I am still
> wondering about a couple things:
> 
> http://www.nsa.gov/research/selinux/list-archive/0504/thread_body66.shtml#11082
> 
> And this one:
> http://www.nsa.gov/research/selinux/list-archive/0802/thread_body60.shtml
> 
> 1) Is the RHEL 5.x MLS policy version 21 capable of the following
> separation of sysadm_r and secadm_r roles:
> 
>    a) Can the secadm_r role be the only role that can assign roles via
> semanage?
> 
>    b) Can the secadm_r role be the only role that can assign/modify
> network interface labels via semanage?
> 
secadm_r:secadm_t in MLS policy is only allowed to run semanage if the
allow_sysadm_manage_security boolean is turned off.

>    c) Can the secadm_r role be the only role that can control files used
> in auditing, like auditd.conf. audit.rules, /etc/init.d/auditd etc...
> 
auditadm_r:auditadm_t is only allowed to modify these files.

> 2) Is this better accomplished with a combination of SUDO and SELinux?
Since sysadm_t can hack his way around the SELinux controls via tools
like rpm and fdisk, you are better off using sudo to further restrict
his actions, if possible.
> 3) How can I determine what secadm_r can do in the current
> configuration? can any of the CLI tools show me that? ( no gui tools
> available )
> 
You probably want to look at secadm_t

sesearch -A -t secadm_t

> If not, what about RHEL 6 ? ( I understand RHEL 6 is not available to
> Itanium systems, but we may have new hardware soon)
> 
> Any tips. hints, pointers etc... would be very helpfull.
> 
> Thanks for your time,

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk03RYsACgkQrlYvE4MpobPxeQCfYZFtvY0/6oiB0kCUhZfy8NBe
1isAoI2+zCfveZJRpCxIxeu+XAvcjFcw
=vT6y
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
