Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96HqqeH002414
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 13:52:52 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96HpdQW029746
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 17:51:39 GMT
Subject: Re: Labeled Networking For LSPP: Where we are and where we need to
	go (quickly)
From: Eric Paris <eparis@redhat.com>
To: Paul Moore <paul.moore@hp.com>
Cc: James Morris <jmorris@namei.org>, vyekkirala@TrustedCS.com,
        selinux@tycho.nsa.gov, redhat-lspp@redhat.com, chanson@TrustedCS.com
In-Reply-To: <4526960A.9040005@hp.com>
References: <1160150738.10614.116.camel@localhost.localdomain>
	 <4526835A.2080707@hp.com> <Pine.LNX.4.64.0610061335270.6460@d.namei>
	 <4526960A.9040005@hp.com>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 13:54:09 -0400
Message-Id: <1160157249.10614.133.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-06 at 13:44 -0400, Paul Moore wrote:
> James Morris wrote:
> > On Fri, 6 Oct 2006, Paul Moore wrote:
> > 
> >>>-netlabel unlabeled patch
> >>
> >>While not a bugfix like the previous two, this is a "logic bug" fix which should
> >>go into RHEL5.
> >  
> > Where is the patch for this?
> > 
> 
> I believe this is the patch I RFC'd to the SELinux list yesterday morning and
> posted to netdev for inclusion yesterday evening.  Looking at my mail this
> morning as well as your git tree show that it was accepted/applied.
> 
> Eric, please correct me if I'm wrong.

Correct, 

[PATCH 1/1] NetLabel: use SECINITSID_UNLABELED for a base SID

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
