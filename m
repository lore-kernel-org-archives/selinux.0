Date: Fri, 8 Aug 2008 13:45:26 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: Paul Moore <paul.moore@hp.com>
cc: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Unify for- and while-loop style
In-Reply-To: <200808070815.25086.paul.moore@hp.com>
Message-ID: <Pine.LNX.4.64L.0808081339060.25897@ruuvi.it.helsinki.fi>
References: <200808070036.m770ajof012753@ruuvi.it.helsinki.fi>
 <200808070815.25086.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

On Thu, 7 Aug 2008, Paul Moore wrote:

> On Wednesday 06 August 2008 8:18:20 pm Vesa-Matti Kari wrote:
> > Replace "thing != NULL" comparisons with just "thing" to make
> > the code look more uniform (mixed styles were used even in the
> > same source file).
> >
> > Signed-off-by: Vesa-Matti Kari <vmkari@cc.helsinki.fi>
> > ---
> >  security/selinux/ss/avtab.c       |    2 +-
> >  security/selinux/ss/conditional.c |   16 ++++++++--------
> >  security/selinux/ss/ebitmap.c     |    4 ++--
> >  security/selinux/ss/hashtab.c     |    6 +++---
> >  security/selinux/ss/services.c    |    8 ++++----
> >  security/selinux/ss/sidtab.c      |   12 ++++++------
>
> In my opinion this suffers from the same problems as the variable
> renaming patches.  I vote "no".

Hmmm. To avoid wasting my time, I asked beforehand whether such a trivial
unifying patch was acceptable. I did this on the selinux mailing list and
below you can see my original message followed by Stephen Smalley's
response (it was the only reply that I got):

==== begin quote ===

On Mon, 2008-07-21 at 12:19 +0300, Vesa-Matti J Kari wrote:
> Hello,
>
> I'm planning to do more trivial fixes to the SELinux kernel subsystem to
> make the coding style look as unified as possible. Before continuing,
> however, I would like to ask for an opinion, because I do not want to
> waste my time.
>
> There currently exist mixed styles such as:
>
>   while (cur != NULL)
>
> vs
>
>   while (cur)
>
> and of course the related "if"- and "for"-variants.
>
> My questions:
>
> 1) Is there a general agreement that only one style should be used?

I'd agree with that, yes.

> 2) If answer to the question 1 is "yes", which one is the preferred
style?

I'm inclined to the latter as it is more concise and loses nothing in
semantics, but I'm open to hearing the other side of it.

A note however:  the core selinux developers are likely to be somewhat
unresponsive to non-critical patches right now because we are at the
SELinux mini-summit and Linux Symposium this week.

==== end quote ===

Best regards,
vmk
-- 
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
