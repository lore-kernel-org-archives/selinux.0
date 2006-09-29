Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TEscw5022756
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 10:54:38 -0400
Subject: Re: [redhat-lspp] updated racoon patch
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Steve Grubb <sgrubb@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel Walsh <dwalsh@redhat.com>, SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200609250947.52327.sgrubb@redhat.com>
References: <200609211855.k8LItkZw026669@faith.austin.ibm.com>
	 <200609250843.09248.sgrubb@redhat.com>
	 <200609250947.52327.sgrubb@redhat.com>
Content-Type: text/plain
Date: Fri, 29 Sep 2006 10:55:47 -0400
Message-Id: <1159541747.8496.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 09:47 -0400, Steve Grubb wrote:
> On Monday 25 September 2006 08:43, Steve Grubb wrote:
> > This doesn't build. Where does the POLMATCH define come from? I can't find
> > it anywhere.
> 
> Found that libselinux-devel and 2.6.18 kernel are not in sync. Please apply
> this patch:
> 
> diff -ur libselinux-1.30.28.orig/include/selinux/av_permissions.h libselinux-1.30.28/include/selinux/av_permissions.h
> --- libselinux-1.30.28.orig/include/selinux/av_permissions.h	2006-09-25 09:44:13.000000000 -0400
> +++ libselinux-1.30.28/include/selinux/av_permissions.h	2006-09-25 09:44:47.000000000 -0400
> @@ -468,6 +468,7 @@
>  #define PROCESS__EXECSTACK                        0x04000000UL
>  #define PROCESS__EXECHEAP                         0x08000000UL
>  #define PROCESS__SETKEYCREATE                     0x10000000UL
> +#define PROCESS__SETSOCKCREATE                    0x20000000UL

This one needs to be added to refpolicy too.

>  
>  #define IPC__CREATE                               0x00000001UL
>  #define IPC__DESTROY                              0x00000002UL
> @@ -910,6 +911,7 @@
>  #define ASSOCIATION__SENDTO                       0x00000001UL
>  #define ASSOCIATION__RECVFROM                     0x00000002UL
>  #define ASSOCIATION__SETCONTEXT                   0x00000004UL
> +#define ASSOCIATION__POLMATCH                     0x00000008UL
>  
>  #define NETLINK_KOBJECT_UEVENT_SOCKET__IOCTL      0x00000001UL
>  #define NETLINK_KOBJECT_UEVENT_SOCKET__READ       0x00000002UL

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
