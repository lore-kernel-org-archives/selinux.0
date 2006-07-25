Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6PFrn87024760
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 11:53:49 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k6PFrnJ2017840
	for <selinux@tycho.nsa.gov>; Tue, 25 Jul 2006 15:53:49 GMT
Subject: Re: [PATCH 4/6] netfilter integration: add netfilter
	contexts	sorting
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1153244161.10744.78.camel@localhost.localdomain>
References: <1153168355.10090.49.camel@sgc>
	 <1153235498.10744.26.camel@localhost.localdomain>
	 <44BD16C1.1080802@tresys.com>
	 <1153244161.10744.78.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 25 Jul 2006 11:53:49 -0400
Message-Id: <1153842829.8634.23.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-18 at 13:36 -0400, Karl MacMillan wrote:
> On Tue, 2006-07-18 at 13:13 -0400, Joshua Brindle wrote:
> > Karl MacMillan wrote:
> > > On Mon, 2006-07-17 at 16:32 -0400, Christopher J. PeBenito wrote:
> > >> Add sorting function for netfilter contexts.
> > >>
> > >>  libsemanage/src/direct_api.c     |    9 +
> > >>  libsemanage/src/semanage_store.c |  189 +++++++++++++++++++++++++++++++++++++--
> > >>  libsemanage/src/semanage_store.h |    6 +
> > >>  3 files changed, 198 insertions(+), 6 deletions(-)
> > >>
> > > 
> > > Is this correct location for the netfilter sorting (file and library)?
> > > The file context sorting is a mess now and, again, just continuing that
> > > seems like a bad idea.
> > > 
> > 
> > libsemanage owns and manages these files, it is indeed the correct place 
> > to do sorting.
> > 
> 
> There are times you want to sort these files other than via semanage -
> for example it would be nice to create a tool to let the developer test
> sorting. Putting the sorting infrastructure in libsepol or libselinux
> would seem more appropriate to allow that.
> 
> Seems to me that libsemanage is too large as it is - keeping it focused
> away from the details of policy representation (whether it be .te, .if,
> or secmark) would help.
> 
> Even if it stays in libsemanage, semanage_store.c seems to be the wrong
> location.

These additions are right after the file context sorting functions.  It
wouldn't make sense for file and netfilter sorting to be in different
places.  Moving functions would be outside the scope of this patchset.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
