Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        kaigai@ak.jp.nec.com, joe@nall.com, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <816344.24505.qm@web36611.mail.mud.yahoo.com>
References: <816344.24505.qm@web36611.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 09 Aug 2007 11:39:29 -0400
Message-Id: <1186673969.6916.542.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-09 at 08:32 -0700, Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> 
> > On Thursday 09 August 2007 8:42:43 am Stephen Smalley wrote:
> > > I like the functionality, but I don't like having yet another mechanism
> > > and configuration, and I'm concerned about it being netlabel-centric.
> > 
> > NetLabel has always been designed as a framework to support multiple
> > different 
> > types of labeling protocols/mechanisms.  Adding this bit of functionality to 
> > NetLabel isn't a major departure from the existing architecture.  The only 
> > real substantial changes to the underlying NetLabel framework are the passing
> > 
> > of the IP address family to some of the NetLabel APIs (minor tweak) and the 
> > addition of a secid field to the NetLabel security attributes struct (also a 
> > pretty minor tweak).
> > 
> > I'm also a little confused about your concern over this new feature being 
> > NetLabel-centric?  I guess I don't understand how that is a problem, further 
> > explanation might help ...
> > 
> > I understand your concern regarding the additional configuration.  While 
> > netlabelctl and netlabel_tools are not new, they may be new to users who want
> > 
> > to make use of this new feature.  On an older thread Josh and I had a bit of 
> > a discussion regarding this and while we never really arrived at a magic 
> > solution we did talk about integrating some, or all, of the netlabelctl 
> > functionality into semanage.  This wouldn't be that difficult as most of 
> > the "intelligence" in netlabelctl is already in a separate library; adding 
> > that library to semanage should not be that difficult.  Would that help ease 
> > your configuration concerns?
> > 
> > > The only reason to not use secmark today for a fallback mechanism is the
> > > current separation between 'internal' and 'external' labels.  But I
> > > don't believe that separation is necessary or useful, and secmark today
> > > is effectively unused.  The original usage scenario for it simply hasn't
> > > materialized.
> > >
> > > Meanwhile, getting secmark employed, not only as a mechanism for
> > > assigning default labels (via iptables rules) but also as a seamless way
> > > of propagating labels with socket buffers would solve a lot of our
> > > current limitations.  We'd get loopback labeling for free, flexible and
> > > generic fallback labeling, forwarding controls would become
> > > straightforward, and PEERSEC/SCM_SECURITY becomes much simpler.
> > > NetLabel would benefit from it as well.  There are alternative
> > > implementation approaches, but none as clean and efficient and reliable.
> > > There was a reason we put a sid in the sk_buff in the original SELinux
> > > implementations (prior to Linux 2.6 merge).
> > >
> > > I've had some initial discussions with James, and he seemed open to
> > > revisiting this notion, so I think we need to take another look.
> > 
> > I still think merging the two types of packet labels, "internal" 
> > and "external" is a mistake; I stated my reasoning a few times before so I 
> > will save people following this thread from reading it again.
> > 
> > However, I agree that packet labeling is in a "weird" state right now and 
> > there is a lot of room for improvement.  Bearing in mind your comments that 
> > SECMARK is effectively unused due to lack of demand and that having two types
> > 
> > of packet labels is not helpful I wonder if the following would a worthwhile 
> > effort:
> > 
> >  * Do away with internal label concept completely, but leave the SECMARK
> >    secid field in the sk_buff struct.  This includes removing the SECMARK
> >    related MAC checks on incoming traffic, whether we bring back compat_net
> >    or not is not important.
> >  * Convert the external labeling protocols to make use of the SECMARK secid
> >    field in the sk_buff struct.  The advantage to NetLabel and explicit
> >    labeling protocols is really marginal but this should be a huge win for
> >    labeled IPsec.
> 
> If y'all are going to look at this, please consider that secid's are
> SELinux specific and using them in system interfaces is an impediment
> to the development of other schemes. One important reason that Smack is
> using netlabel in favor of secmark is that secid interface.

The secid notion is the only reason we have a field in the sk_buff at
all.  The original security blob in the sk_buff was rejected by David
Miller when the LSM networking hooks were put forward by James; it comes
back to lifecycle management and overhead.  The secmark (just another
name for a secid) construct in contrast avoids the lifecycle management
requirement and due to its small fixed size avoids significant bloat.
There is considerable doubt that we could even get it expanded to being
a u64, much less turned into a security blob.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
