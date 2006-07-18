Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6IHa4Ca016520
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 13:36:04 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6IHa31F015284
	for <selinux@tycho.nsa.gov>; Tue, 18 Jul 2006 17:36:03 GMT
Subject: Re: [PATCH 4/6] netfilter integration: add netfilter
	contexts	sorting
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <44BD16C1.1080802@tresys.com>
References: <1153168355.10090.49.camel@sgc>
	 <1153235498.10744.26.camel@localhost.localdomain>
	 <44BD16C1.1080802@tresys.com>
Content-Type: text/plain
Date: Tue, 18 Jul 2006 13:36:01 -0400
Message-Id: <1153244161.10744.78.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-18 at 13:13 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Mon, 2006-07-17 at 16:32 -0400, Christopher J. PeBenito wrote:
> >> Add sorting function for netfilter contexts.
> >>
> >>  libsemanage/src/direct_api.c     |    9 +
> >>  libsemanage/src/semanage_store.c |  189 +++++++++++++++++++++++++++++++++++++--
> >>  libsemanage/src/semanage_store.h |    6 +
> >>  3 files changed, 198 insertions(+), 6 deletions(-)
> >>
> > 
> > Is this correct location for the netfilter sorting (file and library)?
> > The file context sorting is a mess now and, again, just continuing that
> > seems like a bad idea.
> > 
> 
> libsemanage owns and manages these files, it is indeed the correct place 
> to do sorting.
> 

There are times you want to sort these files other than via semanage -
for example it would be nice to create a tool to let the developer test
sorting. Putting the sorting infrastructure in libsepol or libselinux
would seem more appropriate to allow that.

Seems to me that libsemanage is too large as it is - keeping it focused
away from the details of policy representation (whether it be .te, .if,
or secmark) would help.

Even if it stays in libsemanage, semanage_store.c seems to be the wrong
location.

> > Again, netfilter contexts seems like an ambiguous name. Secmark rules
> > seems more accurate to me.
> > 
> 
> you can put any netfilter rule in, if in the future there is something 
> other than secmark that affects selinux those rules can also go into 
> this section.
> 

And when those rules arrive integration work will be required and code /
format changes will likely result, nullifying any potential win from
calling it netfilter now. So, it seems like false generality to me.
Secmark more correctly describes the current and, as of now, only use
for this section.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
