Subject: Re: [PATCH] selinux: Unify for- and while-loop style
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>, jmorris@namei.org,
        eparis@parisplace.org, selinux@tycho.nsa.gov
In-Reply-To: <200808081007.53012.paul.moore@hp.com>
References: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi>
	 <200808070815.25086.paul.moore@hp.com>
	 <Pine.LNX.4.64L.0808081339060.25897@ruuvi.it.helsinki.fi>
	 <200808081007.53012.paul.moore@hp.com>
Content-Type: text/plain
Date: Thu, 14 Aug 2008 12:45:30 -0400
Message-Id: <1218732330.29535.40.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-08-08 at 10:07 -0400, Paul Moore wrote:
> On Friday 08 August 2008 6:45:26 am Vesa-Matti J Kari wrote:
> > Hello,
> >
> > On Thu, 7 Aug 2008, Paul Moore wrote:
> > > On Wednesday 06 August 2008 8:18:20 pm Vesa-Matti Kari wrote:
> > > > Replace "thing != NULL" comparisons with just "thing" to make
> > > > the code look more uniform (mixed styles were used even in the
> > > > same source file).
> > > >
> > > > Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
> > > > ---
> > > >  security/selinux/ss/avtab.c       |    2 +-
> > > >  security/selinux/ss/conditional.c |   16 ++++++++--------
> > > >  security/selinux/ss/ebitmap.c     |    4 ++--
> > > >  security/selinux/ss/hashtab.c     |    6 +++---
> > > >  security/selinux/ss/services.c    |    8 ++++----
> > > >  security/selinux/ss/sidtab.c      |   12 ++++++------
> > >
> > > In my opinion this suffers from the same problems as the variable
> > > renaming patches.  I vote "no".
> >
> > Hmmm. To avoid wasting my time, I asked beforehand whether such a
> > trivial unifying patch was acceptable. I did this on the selinux
> > mailing list and below you can see my original message followed by
> > Stephen Smalley's response (it was the only reply that I got):
> 
> I didn't respond to that other thread because I was responding to your 
> other thread at the same time regarding the variable renaming issue.  
> Perhaps I should have replied to that particular thread as well but 
> considering there was no code/patch attached I chose to spend my time 
> on other higher priority issues including your other thread.
> 
> Yes, I can see Stephen replied to your original email and indicated he 
> agreed on having one style.  It isn't clear to me that he necessarily 
> agrees with patches that do nothing more than change coding style, but 
> I don't want to speak for Stephen.  As far as I'm concerned patches 
> which do nothing but change coding style or rename variables do more 
> harm than good and for that reason I'm NACK'ing this patch.
> 
> The good news for you is that I'm just one person, and while ultimately 
> it is the maintainer's call (James or Stephen probably, I'm actually 
> not sure these days) the entire community can voice their opinion.

Coding style cleanups are just part of life in the Linux kernel, and
while they make life a bit harder for developers by conflicting with
pending patches, I think they are viewed nonetheless as a win by the
Linux kernel developer community in order to promote readability and
long term maintainability by more than just the original developer(s).

So I have no problem with these or other similar coding style cleanups
to any of my code - I'm not ashamed to admit I botched the coding style
in the first place ;)
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
