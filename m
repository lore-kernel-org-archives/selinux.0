Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1ILhS6f015997
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 16:43:28 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1ILe5p4008095
	for <selinux@tycho.nsa.gov>; Wed, 18 Feb 2009 21:40:05 GMT
Message-ID: <499C80E0.4000908@manicmethod.com>
Date: Wed, 18 Feb 2009 16:42:56 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SE Linux <selinux@tycho.nsa.gov>, Chris PeBenito <cpebenito@tresys.com>
Subject: Re: Patch to libsemanage to remove labeling of /root
References: <496C9A96.1080805@redhat.com> <499B1D53.4030602@manicmethod.com> <499B1EB7.40202@redhat.com> <499B1ECE.2040509@manicmethod.com> <499B2091.8000303@redhat.com> <499B20AA.8050902@manicmethod.com> <499B2956.6090104@redhat.com> <499C2D9F.4040806@manicmethod.com> <499C32C8.2020700@redhat.com> <499C3558.6090609@manicmethod.com> <499C3DE1.70606@redhat.com> <499C5FC8.1040000@manicmethod.com> <499C6ADC.6010100@redhat.com> <499C6C59.2010006@manicmethod.com> <499C7CD0.9070907@redhat.com>
In-Reply-To: <499C7CD0.9070907@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

<snip>

>>> suddenly change labels.  I could not disagree more.
>>>
> The argument here is whether or not /root is a "homedirectory"  I don't
> agree that it is, at least it is not the same as /home/dwalsh.
> 
> They are different and the tools should treat them different.
> 
> Allowing a domain to interact with /root is different then allowing it
> to interact with /home/dwalsh.  By allowing random users to accidentally
> change this is in my mind a security risk.
> 
> I want genhomedircon to handle the case when a user puts his home
> directories in /home/devel/ and /export/home.  So I need genhomedircon.
> 
> But I intend to write policy that relies on the /root directory having a
> fixed file context.
> 

Ok, the tools should be policy agnostic IMO, and this patch hard codes a 
behavior that is policy specific.

I'm not going to merge this patch but if/when you or someone sends one that 
addresses the issue in a flexible way I'll be more open to that.

My suggestion is to make an excluded paths variable in semanage.conf that allows 
downstream users to exclude the paths they care about (alternatively an included 
paths list might be more appropriate, but I'd have to think that through).

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
