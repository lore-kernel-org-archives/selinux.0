Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q21IbRMs002618
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2012 13:37:27 -0500
Received: by eaa1 with SMTP id 1so327937eaa.12
        for <selinux@tycho.nsa.gov>; Thu, 01 Mar 2012 10:37:24 -0800 (PST)
Date: Thu, 1 Mar 2012 19:35:53 +0100
From: Sven Vermeulen <sven.vermeulen@siphos.be>
To: SELinux development <selinux@tycho.nsa.gov>
Subject: Re: Suggestion on fixing a old libselinux problem.
Message-ID: <20120301183552.GA14832@siphos.be>
References: <4F4E8EDF.1030405@redhat.com>
 <1330550573.20078.24.camel@moss-pluto>
 <1330551258.20078.28.camel@moss-pluto>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1330551258.20078.28.camel@moss-pluto>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 29, 2012 at 04:34:18PM -0500, Stephen Smalley wrote:
> > On Wed, 2012-02-29 at 15:47 -0500, Daniel J Walsh wrote:
> > > Right now we have an open bug on confined users.  Basically if you
> > > setup a confined user guest_u and attempt to login to that user via
> > > xdm_t, you get a context of guest_u:guest_r:oddjob_mkhomedir_t:s0
> > > 
> > > selinuxdefcon pwalsh system_u:system_r:xdm_t:s0
> > > guest_u:guest_r:oddjob_mkhomedir_t:s0

We had a similar issue with vixie-cron. It's attempt to get an initial
context gave strange results and we had a rough time figuring out what was
the case.

Now, we recommend users to run getseuser to find out what the returned
context is on the user' system and check if it is cronjob_t [1].

[1] http://www.gentoo.org/proj/en/hardened/selinux-faq.xml#cronfails

> > Last time we discussed this, I thought we agreed to migrate away from
> > the current usage of security_compute_user (/selinux/user) altogether
> > within libselinux, and replace it with a simpler userspace configuration
> > and logic for determining user roles and levels.
> 
> I don't think we want to introduce greater complexity and more possible
> failures causes into the mix for determining user contexts.  Simplest
> option would be to change get_ordered_context_list() to return the empty
> list / fail in that case rather than return the full reachable list from
> security_compute_user. 

I agree. I find it illogical that it returns a full reachable list.

Wkr,
	Sven Vermeulen

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
