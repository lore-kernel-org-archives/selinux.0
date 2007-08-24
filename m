From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Fri, 24 Aug 2007 17:10:17 -0400
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <905414.86820.qm@web36602.mail.mud.yahoo.com>
In-Reply-To: <905414.86820.qm@web36602.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708241710.17586.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, August 24 2007 4:42:16 pm Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> > > Hmm. In one case the name reflects the purpose (label of peer) and
> > > in the other the name reflects the mechanism (label used in SECMARK).
> > > I like the clarification of the former as it tells an LSM writer
> > > what to use the label for, while I dislike the latter because it
> > > does nothing to help me understand the intent of the mechanism.
> >
> > Feel free to suggest something better, I don't think anyone was ever
> > really in
> > love with the term "secmark label".  I believe at one point Stephen
> > suggested "iptables label", does that sound any better?
>
> It does because it describes the intended use.

Actually, after reading Josh's mail I'm now thinking "netfilter label" is 
probably a better choice.  After all, the bikeshed will need to be repainted 
in a few years ... ;)

> > > > As a reminder, below is a definition of the two types of labels.
> > > >
> > > > Secmark, or internal, labels are essentially a means for integrating
> > > > the traditional firewall rules with SELinux mandatory access
> > > > controls.
> > >
> > > Is it really intended that Secmark is an SELinux specific mechanism?
> >
> > I don't see why it _has_ to be a SELinux specific mechanism.  I
> > understand that some of the netfilter code is SELinux specific (mostly
> > the part dealing with SELinux secctx/secid conversions) but you could
> > either change that to the more generic LSM secctx/secid conversion API or
> > simply augment it for SMACK (I even see some nice case statements already
> > in place to make things easy for you).
>
> I can see where the mechanism is intended for generality and
> where there is strong SELinux influence. I always get nervous
> when what looks like a general mechanism is described in terms
> of a specific use to which it gets put.

Then channel some of that nervous energy into some patches :)  Really, I think 
you could probably "fix" some of this without affecting the user visible 
portion of it ... but then again I haven't thought about it for that long.

> > > I would personally be
> > > disappointed if the mechanism were unavailable to other LSMs, but that
> > > is of course your call.
> >
> > As long as their is an LSM my opinion is that all mechanisms which live
> > outside the LSM and/or provide services to LSM modules should be agnostic
> > of any one particular LSM.  However, this does not mean that the is must
> > deal only with binary/string/secctx labels; if it makes sense to deal
> > strictly with secid tokens then so be it.
>
> Maybe we can fix that in 3.0. That is, I'll accept it for now,
> but someday we really ought to revisit the decision.

Sure, in a perfect world we would have void pointers everywhere, with a well 
defined set of lifecycle management hooks that would enable us to do whatever 
we wanted in terms of labeling objects on the system.  It's a nice idea, 
scratch that, a truly awesome idea, but I just don't see that happening in 
the near future.

> > > >  * Loopback/Localhost peer packet labeling
> > > >
> > > > This has been a long standing requirement which at first glance seems
> > > > like it
> > > >
> > > > would be simple to achieve but in practice it has proven quiet
> > > > difficult to implement.  Current solutions to the problem involve
> > > > using either NetLabel/CIPSO or labeled IPsec over loopback to provide
> > > > peer labels, unfortunately both have drawbacks.  NetLabel/CIPSO is
> > > > currently limited to only conveying the MLS sensitivity label over
> > > > the wire and only then for IPv4
> > > >
> > > > packets.  Labeled IPsec can convey the full SELinux label/context of
> > > > the peer
> > > >
> > > > for both IPv4 and IPv6 but is difficult to configure and introduces
> > > > unnecessary overhead for packets that never leave the machine.
> > >
> > > In the early Smack development I experimented with a scheme that
> > > was very like CIPSO with the exception that it carried the MAC
> > > information directly.
> >
> > I am thinking along the same lines for NetLabel/CIPSO, similar to the old
> > Selopt concept.  I'm also considering adding some additional fields/info
> > to carry additional information that used to passed along via
> > MaxSix/SAMP; more on that when I get to that work item.
> >
> > > That would be a smack_t for me, but it would do u32s just fine.
> >
> > While having to deal only with secids would make life easier, it might be
> > possible to offer alternate option formats for different LSMs (as long as
> > they were in mainline).
>
> Well, you could define the interface to take a pointer and length,
> thereby leaving it up to the LSM.

Yes, that is one of the things I'm considering but one of the drawbacks to 
this approach is that it makes commonality between LSMs very hard.

We can talk more about the exact functionality/API later if you would like, 
right now I think we should stick to the topics in the original email so we 
don't get stuck in a rathole.  My plan is to start looking into this after 
the fallback label issue is resolved.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
