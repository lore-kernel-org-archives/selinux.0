MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Subject: Re: [PATCH] setfiles fails to relabel if selinux not enabled
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <1253109741.18198.93.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 16 Sep 2009 10:16:59 -0400
Cc: Joshua Brindle <jbrindle@tresys.com>, Caleb Case <ccase@tresys.com>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Message-id: <D095955D-66A2-4A9E-854A-5A5AF0C92EF3@mac.com>
References: <1253042418-28141-1-git-send-email-ccase@tresys.com>
 <1253043181.18198.62.camel@moss-pluto.epoch.ncsc.mil>
 <06A6610D4F464D4EBEAFBF2C5F86911E014CEA9F@exchange2.columbia.tresys.com>
 <1253109741.18198.93.camel@moss-pluto.epoch.ncsc.mil>
To: Stephen Smalley <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sep 16, 2009, at 10:02 AM, Stephen Smalley wrote:

>>
>> What is the best we can do? Should we always attempt to relabel if
>> selinux is disabled or not?
>
> The patch is the best we can do - we shouldn't exclude any mounts  
> based
> on the absence of seclabel in /proc/mounts if SELinux is disabled.
> Historically setfiles has always supported relabeling filesystems even
> if SELinux was disabled in the host.

There's a fundamental confusion between the act (of labelling) and the  
use of selinux labels.

The issue shows up when there are multiple (and possibly incompatible)
sets of labels, such as in chroot's, or creating an image for a  
different
installation.

One can choose to not install labels condition on whether  
is_selinux_enabled()
consistently and methodically.

Perhaps a simpple example to illustrate:

	Should cp(1) always copy security labels or only if is_selinux_enabled 
()?

What I'm hearing is "No. cp(1) should copy labels iff  
is_selinux_senabled() is TRUE."

73 de Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
