Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UFOWmS030318
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 11:24:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7UFOVXa014871
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 15:24:31 GMT
Message-ID: <46D6E0F1.4080407@redhat.com>
Date: Thu, 30 Aug 2007 11:23:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ian jonhson <jonhson.ian@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>, pam-list@redhat.com
Subject: Re: how to run the pam_selinux_check to test SELINUX
References: <8f34198c0708291941n12f2de55y787893586b69fbb5@mail.gmail.com>
In-Reply-To: <8f34198c0708291941n12f2de55y787893586b69fbb5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ian jonhson wrote:
> Hi all,
> 
> I enabled the SELINUX on my FedoraCore4, and test pam_selinux_check.c
> (distributed with Linux-PAM-0.99). However, it seems that it doesn't
> work, and I have no idea how to do next.
> 
> The configuration steps about SELINUX:
> 
> 1. After I installed my FC4, I set the SELINUX=enforcing in
> /etc/sysconfig/selinux;
> 
> 2. reboot my system. It seems that SELINUX have take in effect, the
> FC4 checked and labeled the filesystem...
> 
> Then, I configured the PAM in /etc/pam.d/. My steps are as following:
> 
> 1. create a new PAM configuration file in /etc/pam.d/, named
> pam_selinux_check, and edited it as follows:
> 
> session  sufficient  pam_selinux.so
> 
> 2. compile the pam_selinux_check.c
> 
> OK. Now I tested the pam_selinux_check and want to see some work
> details about SELINUX.
> 
> #  ./pam_selinux_check
> #                                    /*  <--  nothing happen */
> 
> Again, test it with a parameter
> 
> # ./pam_selinux_check  tom
> #                                   /*  <--  nothing happed too */
> 
> did it righ?
> 
> I don't know what I have missed in my configuring the selinux and pam.
> Maybe, one of the missing is that I just set enforcing in
> /etc/sysconfig/selinux, not together with setting SELINUXTYPE=strict.
> However, when I set SELINUXTYPE=strict, I got a error message at
> booting and system dump. The error message said, I have set nothing
> about strict policy.
> But I don't know how to install strict policy.
> 
> I just test the functionalities about selinux MAC enforcement, so
> where can I download a simple strict policy, and how to install in my
> FC4+SELINUX?
> 
> As for PAM, it seems the configuration file is right, since I found
> the pam_selinux.so only built the PAM session hooks.
> 
> I don't know what wrong with it, could anybody give me some advices?
> 
> 
> Thanks in advance,
> 
> Ian

Ian, We no longer support Fedora Core 4 or 5 for that matter.  So I have
no idea what your problem is.  SELinux has come a long way since FC4 so
If you want to play with SELinux I would advise you to move to Fedora 7
or Fedora 8.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG1uDwrlYvE4MpobMRAlpvAKDrbw3t994MzTvPkCcWj+ysgMsPqQCfZwz4
5y2+GAlGmLoyjmxPcS+Omao=
=ATGS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
