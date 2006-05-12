Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4C4qbp6029588
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 00:52:37 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4C4qY1i028343
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 04:52:35 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Rogelio Serrano" <rogelio.serrano@gmail.com>
Subject: Re: pam_namespace
Date: Fri, 12 May 2006 14:52:35 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200605051623.25533.russell@coker.com.au> <200605120909.11178.russell@coker.com.au> <a9951d2a0605112100m6fde2b40u70b68619fa578111@mail.gmail.com>
In-Reply-To: <a9951d2a0605112100m6fde2b40u70b68619fa578111@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605121452.39618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 12 May 2006 14:00, "Rogelio Serrano" <rogelio.serrano@gmail.com> 
wrote:
> We can go beyond just customizing /tmp though. We can hide /sbin from
> ordinary users and we can hide some of the files from /etc and we can
> actually have each user have their own passwd file. we can hide almost
> all files from /dev. We can actually hide any file or directory we
> want. I played with a custom init a while ago that did all this. I did
> not think linux people want to step outside unix though so i killed
> the project.

The general design idea in SE Linux is that files in /sbin will come from 
packages that are part of the distribution, therefore hiding /sbin from users 
will not provide a benefit.  Denying execute access to sbin_t could be 
implemented, however in Linux things aren't organized well enough to allow 
such a restriction without significant obstruction to normal system 
operation.  Reorganizing the contents of /bin and /sbin is beyond the scope 
of the project.

Hiding the existence of files in /etc is of minimal benefit, the file names 
are usually predictable and every daemon that has complex configuration has a 
sub-directory of /etc to which regular users are not granted search access.

You are correct that Linux people don't want to go too far from the Unix 
traditions.  We have enough problems with unreasoned criticism of SE Linux 
already without adding to it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
