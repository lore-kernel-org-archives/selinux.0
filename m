Subject: RE: generic fallbacks of getpeercon (Re: [redhat-lspp] Labeling an
	interface)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vyekkirala@TrustedCS.com
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        "'Paul Moore'" <paul.moore@hp.com>,
        KaiGai Kohei <kaigai@ak.jp.nec.com>, Joe Nall <joe@nall.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>, ewalsh@tycho.nsa.gov
In-Reply-To: <000801c7a869$aecf1d70$cc0a010a@tcssec.com>
References: <000801c7a869$aecf1d70$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 14:47:25 -0400
Message-Id: <1181155645.3699.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-06-06 at 13:37 -0500, Venkat Yekkirala wrote:
> > Yes, I'm not referring to fallback behavior there but instead to how
> > they are using security_compute_create() to compute the domain
> > transition on the child.  While preserving the MLS range from 
> > the peer.
> 
> Just curious; how does policy analysis based on allow rules you (Stephen)
> mentioned earlier play into this in userland?

The allow rules completely describe what is permitted to happen in the
system, including all possible domain transitions and information flows.
The type transition rules are consulted to determine appropriate labels,
both by the kernel (via direct security_transition_sid calls) and by
various security-aware applications (via security_compute_create(3)),
but if there isn't a corresponding set of allow rules for that type
transition, then it will be denied nonetheless.  Thus, while you will
likely want to look at the type transition rules to understand the
default system behaviors, you can omit them from analysis when you are
checking for all possible flows.

Note that the set of allow rules needed to authorize a given type
transition may vary considerably.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
