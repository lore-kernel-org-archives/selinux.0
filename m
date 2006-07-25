Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PFnurs024647
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 11:49:56 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6PFnuJ2017381
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:49:56 GMT
Subject: Re: [PATCH 3/6] netfilter integration: module store support
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1153235311.10744.24.camel@localhost.localdomain>
References: <1153168354.10090.48.camel@sgc>
	 <1153235311.10744.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 11:49:56 -0400
Message-Id: <1153842596.8634.18.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-18 at 11:08 -0400, Karl MacMillan wrote:
> On Mon, 2006-07-17 at 16:32 -0400, Christopher J. PeBenito wrote:
> > Adds support for committing the netfilter_contexts file, and copying it
> > out to the running system.
> > 
> >  libsemanage/src/direct_api.c     |   25 ++++++++++++++++++-------
> >  libsemanage/src/semanage_store.c |   11 +++++++++++
> >  libsemanage/src/semanage_store.h |    1 +
> >  3 files changed, 30 insertions(+), 7 deletions(-)

> Both of those if blocks are very difficult to parse and adding even more
> expressions to them just makes it worse. I don't know what Steve thinks,
> but blindly continuing poor coding practices will just make the code
> base worse over time (which I think has happened). I would prefer to see
> cleanups happen when the code is being changed.

Blame lindent.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
