Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA00901
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 09:59:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA22481
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 14:57:43 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA22477
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 14:57:41 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Subba Rao" <sailorn@attglobal.net>, selinux <selinux@tycho.nsa.gov>
Subject: Re: SELinux compile errors
Date: Sat, 30 Nov 2002 15:53:57 +0100
References: <200211292123.VAA00594@jazzband.ncsc.mil>
In-Reply-To: <200211292123.VAA00594@jazzband.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200211301553.57790.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 29 Nov 2002 22:21, Subba Rao wrote:
> This is where I have stopped since I get the following error message:
>
> --------------------------------------
> make -C newrole
> make[1]: Entering directory `/usr/src/selinux/utils/newrole'
> cc -L/usr/local/selinux/lib -Wall -I/usr/local/selinux/include -DUSE_PAM
> -O3 -o newrole newrole.c -ldl -lpam -lpam_misc -lsecure newrole.c:132:
> security/pam_appl.h: No such file or directory
> newrole.c:133: security/pam_misc.h: No such file or directory
> make[1]: *** [newrole] Error 1
> make[1]: Leaving directory `/usr/src/selinux/utils/newrole'
> make: *** [xnewrole] Error 2
> --------------------------------------
>
> It looks like it is looking for PAM library.
>
> Can someone please let me know how to get over this error.  Yesterday after
> I installed PAM, this message went away, but then I was prompted for

You need PAM support and therefore you need the PAM header files and libraries 
installed.

> Kerberos and later for BSD library.  Russell did mention that there is no
> need for Kerberos, so this time I am stopping before having to install PAM.
>  I am using Slackware 8.1 distro.

Install PAM, then show us the error messages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
