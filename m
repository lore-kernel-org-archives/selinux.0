Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0AHMORb005777
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 12:22:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0AHMDiV012541
	for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 17:22:13 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i0AHMD06012538 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2004 17:22:13 GMT
Message-ID: <400034BE.6040108@redhat.com>
Date: Sat, 10 Jan 2004 12:22:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Bill McCarty <bmccarty@pt-net.net>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: GDM for RHEL 3
References: <27010669.1073686811@[192.168.0.2]>
In-Reply-To: <27010669.1073686811@[192.168.0.2]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Bill McCarty wrote:

> Hi all,
>
> I'm installing SELinux for RHEL 3, including graphical mode support, 
> using the RPM packages available on Dan Walsh's web site. When I try 
> to install gdm, RPM complains that xinitrc 3.33-1 or greater is 
> needed. However, I don't find a binary or source package for xinitrc 
> bearing an appropriate version number. Can someone direct me to one, 
> or otherwise suggest how I can install gdm?
>
> Thanks!
>
> ---------------------------------------------------
> Bill McCarty 

I added xinitrc from Fedora Core to the RHEL3 tree on People.  Hopefully 
this will solve the problem.  I will check a RHEL3 install on Monday.

Dan

>
>
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
