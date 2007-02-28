From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC 0/4] NetLabel fixups/cleanups
Date: Wed, 28 Feb 2007 16:36:06 -0500
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
References: <20070228201419.115784233@hp.com> <Line.LNX.4.64.0702281607020.10200@d.namei>
In-Reply-To: <Line.LNX.4.64.0702281607020.10200@d.namei>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702281636.06388.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, February 28 2007 4:09:19 pm James Morris wrote:
> On Wed, 28 Feb 2007, Paul Moore wrote:
> > to live dangerously.  This patchset most likely needs a little more work
> > and testing before I feel comfortable submitting it for inclusion, but a
> > little birdie suggested I post them as an RFC patchset.
>
> These look ok to me, and I've applied them to
> git://git.infradead.org/~jmorris/selinux-2.6#for-next-kernel

Thanks.

> It's probably too late to get non-bugfixes into 2.6.21, so they'll
> probably queue there until the next merge window opens, and also go into
> -mm.

I wouldn't want them to go into 2.6.21 even if it were possible.  I just 
haven't done enough testing yet to really feel comfortable with the patches.    
However, having them sit in -mm for a while will go a long way towards giving 
me that warm, fuzzy feeling.  I also continue to bang on them and if anything 
pops up I'll send more patches.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
