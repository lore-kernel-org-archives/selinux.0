Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94DFooV013497
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 09:15:50 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k94DEdo0006765
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 13:14:39 GMT
Subject: Re: init unconfined in RHEL4?
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Osborn, Justin D." <Justin.Osborn@jhuapl.edu>, selinux@tycho.nsa.gov
In-Reply-To: <200610040754.06676.russell@coker.com.au>
References: 
	 <7B95239DDD54E54B9BFA23847142B1EE10A28A@aplesnation.dom1.jhuapl.edu>
	 <7B95239DDD54E54B9BFA23847142B1EE10A29E@aplesnation.dom1.jhuapl.edu>
	 <4522CFC7.7040801@redhat.com>  <200610040754.06676.russell@coker.com.au>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 09:15:43 -0400
Message-Id: <1159967743.14831.67.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-10-04 at 07:54 +1000, Russell Coker wrote:
> On Wednesday 04 October 2006 07:01, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Osborn, Justin D. wrote:
> > > I'm working on a RHEL4 system with the Reference Policy and init is
> > > running in unconfined_t.  This leads to most other processes on the
> > > system running in unconfined_t.  Has anyone seen similar errors?
> >
> > In RHEL4 only 15 Targets are confined,  Everything else runs in an
> > unconfined domain.
> >
> > > This is the Ref. Policy version released in March, I got the latest
> > > svn version but it doesn't work with the libsepol and checkpolicy
> > > RHEL4 RPMs on the Tresys site.
> 
> Justin, the problem is that you are running a non-standard policy on RHEL4.
> 
> If you run the back-port of the reference policy on RHEL4 then Red Hat won't 
> support you and most developers won't be interested as development happens on 
> Rawhide.
> 
> If you have problems with Refpolicy on RHEL4 and can reproduce them on FC6test 
> releases then many people will be interested in investigating the problems.  
> But if it's only a problem for Refpolicy on RHEL4 then you are probably on 
> your own.

Actually, we are interested in RHEL4.  Its going to still be around for
years, and is still important, which is why there is a rhel4 distro
tunable.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
