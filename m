Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16EPnRb022717
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 09:25:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i16EORQk023660
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 14:24:27 GMT
Received: from mailhost.unt.edu (mailhost.unt.edu [129.120.209.40])
	by jazzswing.ncsc.mil  with ESMTP id i16EOQYo023643
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 14:24:27 GMT
Message-ID: <1076077531.4023a3db6de27@eaglemail.unt.edu>
Date: Fri,  6 Feb 2004 08:25:31 -0600
From: Ignacio Tripodi <ignaciot@unt.edu>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
Subject: Re: Issues relabeling filesystems
References: <BEA0F082-5867-11D8-A76A-000393013D1A@unt.edu> <200402062335.12533.russell@coker.com.au>
In-Reply-To: <200402062335.12533.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Russell Coker <russell@coker.com.au>:

> On Fri, 6 Feb 2004 16:46, Ignacio Tripodi <ignaciot@unt.edu> wrote:
> > /usr/sbin/setfiles: relocation error: /usr/sbin/setfiles: symbol
> > nftw64, version GLIBC_2.3.3 not defined in file libc.so.6 with link
> > time reference

> How recent were the rpms you used to create the file system image?  If they 
> were not recent then I recommend updating to the latest stuff and the problem
> should disappear.

I used the RPM's off the three iso images available at :
http://download.fedora.redhat.com/pub/fedora/linux/core/1/i386/iso/ 

and added the necessary additional SELinux-related packages from: 
http://download.fedora.redhat.com/pub/fedora/linux/core/development/i386/Fedora/RPMS/

Do you think these are the most updated sources? 

Ignacio
CoPS Lab
University of North Texas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
