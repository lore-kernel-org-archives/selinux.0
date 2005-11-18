Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAIGkPMA022546
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 11:46:25 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAIGkCoG019738
	for <selinux@tycho.nsa.gov>; Fri, 18 Nov 2005 16:46:22 GMT
Subject: Re: Current Reference Policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437E0328.1010304@redhat.com>
References: <437CA7D7.6090308@redhat.com>
	 <1132254164.7259.61.camel@sgc.columbia.tresys.com>
	 <437DED16.4090506@redhat.com> <1132330347.7259.92.camel@sgc>
	 <437E0328.1010304@redhat.com>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 11:46:23 -0500
Message-Id: <1132332383.7259.94.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-11-18 at 11:36 -0500, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> >>> On Thu, 2005-11-17 at 10:55 -0500, Daniel J Walsh wrote:
> >>>> Allow users to su to root and then suspend the session.
> >
> > Did you really intend to add these to only the targeted policy?
> >   
> I think their could be a problem with terminal labeling if we allow it
> in strict. Ie the tty gets labeled sysadm_tty_t and then you suspend,
> Nothing will work and you can't type fg.

Ok, that makes sense.  I'll merge this part too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
