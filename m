Message-ID: <1500556382.22177.4.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>, Andy Lutomirski <luto@kernel.org>
Cc: SELinux-NSA <selinux@tycho.nsa.gov>
Date: Thu, 20 Jul 2017 09:13:02 -0400
In-Reply-To: <CAHC9VhTSvcoxZ9uird=eJcgiisyiG2PykLvJ8kniWn7q64yXrA@mail.gmail.com>
References: <20170714164647.6183-1-sds@tycho.nsa.gov>
 <CALCETrWaEAMnxujZ4Y5NY+hO3zLD8nNr+VaL9gJ=4_B8hw6=Pw@mail.gmail.com>
 <CAHC9VhTSvcoxZ9uird=eJcgiisyiG2PykLvJ8kniWn7q64yXrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] selinux: Generalize support for NNP/nosuid SELinux
 domain transitions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-07-19 at 17:08 -0400, Paul Moore wrote:
> On Mon, Jul 17, 2017 at 4:06 PM, Andy Lutomirski <luto@kernel.org>
> wrote:
> > On Fri, Jul 14, 2017 at 9:46 AM, Stephen Smalley <sds@tycho.nsa.gov
> > > wrote:
> > 
> > At the risk of commenting on SELinux in general:
> > 
> > > There is no way to clone all allow rules from
> > > descendants to their ancestors in policy currently, and doing so
> > > would
> > > be undesirable even if it were practical, as it requires leaking
> > > permissions to objects and operations into ancestor domains that
> > > could
> > > weaken their own security in order to allow them to the
> > > descendants
> > > (e.g. if a descendant requires execmem permission, then so do all
> > > of
> > > its ancestors ...
> > 
> > In my mind, permissions like execmem aren't in the same category as
> > normal permissions.  execmem is the right to do something that
> > opens
> > the subject to compromise, not the right to do something to an
> > object
> > that needs protection.  Maybe execmem should be exempt from
> > typebounds.
> 
> I just realized that this got lost in the rest of the discussion ...
> 
> It's worth nothing that from a practical point of bounded type
> transitions aren't likely going to be the solution that will likely
> be
> used to solve this current systemd problem (see the rest of the
> thread).
> 
> However, I understand you were speaking in general terms, and while
> there may be some merit to your suggestion, that would be quite a
> deviation from how things work at the moment and unless typebounds
> takes off (which I am beginning to doubt will happen outside a few
> special domains) I'm not sure it is worth the effort and headache.

I also don't see how execmem is fundamentally different than the other
examples I gave in the patch description; there would still be the
problem of leaking execute access to files, read to symlinks, ...
