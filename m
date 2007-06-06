Subject: Re: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
	interface)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul.moore@hp.com>
Cc: vyekkirala@TrustedCS.com, KaiGai Kohei <kaigai@ak.jp.nec.com>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
In-Reply-To: <200706060947.57384.paul.moore@hp.com>
References: <000301c7a83f$ecf25920$cc0a010a@tcssec.com>
	 <200706060947.57384.paul.moore@hp.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 10:28:52 -0400
Message-Id: <1181140132.3699.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 09:47 -0400, Paul Moore wrote:
> On Wednesday, June 6 2007 9:38:10 am Venkat Yekkirala wrote:
> > > Your proposal is slightly different in that I view it more as
> > > a per-domain
> > > renaming scheme where you rename/relabel packets based on the
> > > receiving
> > > domain.  Can you help me understand the advantage of
> > > renaming "untrusted_network_t" to "sepgsql_client_t" from a
> > > policy point of
> > > view?  For example, how would these two policy rules be
> > > different or have any
> > > advantage over one another:
> > >
> > >  allow sepgsql_t untrusted_network_t:<class> <perms>;
> > >  allow sepgsql_t sepgsql_client_t:<class> <perms>:
> >
> > I doubt that the intent here is to change the permission checks
> > to use the transition label. Rather the idea seems to be to
> > have getpeercon() return the transition label (sepgsql_client_t).
> 
> My gut feeling is that getpeercon() should return the same context that we use 
> for permission checks.  If getpeercon() returns something different I fear it 
> could start to get very confusing from a user's/policy-writer's point of 
> view.  Then again, maybe it's just me.

Correct - we want to be able to analyze policy based solely on the allow
rules.

> Perhaps Chris, Dan, and Stephen have some thought on this ...


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
