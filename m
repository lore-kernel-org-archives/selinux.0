Subject: RE: ipsec and getpeercon()
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Joy Latten <latten@us.ibm.com>,
        selinux@tycho.nsa.gov, paul.moore@hp.com
In-Reply-To: <36282A1733C57546BE392885C061859201512D46@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C061859201512D46@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 13:48:45 -0400
Message-Id: <1157132925.20971.38.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 11:49 -0400, Venkat Yekkirala wrote:
<snip>
> 
> I am thinking about this as well. Rather than use the Type specified in
> the SPD rule, we could use the one from the connecting domain. Should
> only be a minor change code-wise.
> 

so you want to implicitly label the SA's? I'm doubtful that this will
help, unless applications are going to take on the burden of setting up
their own SA's, I'm not sure that will ever happen.

> This way you could have just a set of domains that "polmatch"
> to a specific policy domain/Type, but they could all be using
> unique SAs based on the context of the connecting domain.
> 

Is there much overhead in having lots of SA's between 2 hosts? How can
you do things like RPC where the port will be dynamic with multiple SA's
in use?

> > 
> > Another way is if I could have a local proxy that has a 
> > single SA to the
> > destination machine and can send an appropriate context in 
> > the AH or ESP
> > header (in the authentication data field? I don't now the 
> > ipsec spec at
> > all so I'm not sure if any of this is possible, please let me know if
> > not so I can start looking elsewhere).
> 
> Not feasible AFAIK. The spi is the only identifier that can
> reasonably be leveraged like we do currently.
> 
> > 
> > Note that we may be sending contexts that aren't even valid 
> > on the local
> > machine, but would be valid on the destination machine. 
> 
> Could you please elaborate on this (a practical scenario).
> 

The most obvious scenario I have is 2 SELinux machines, one using MLS
and one not. The context on the client side (root:sysadm_r:admin_tool_t)
would be invalid on the destination.

We are also looking at how SELinux machines that are in different
administrative realms can interact, particularly when the policies are
disparate and they have no shared namespace and the context structure
may or may not be the same (as above).

We basically need to be able to send an opaque context to the
destination that is not verified locally (via a trusted proxy) 

> > 
> > is any of this possible?
> > 
> 
> Sounds like we are making some progress here. Thanks for the discussion.

Thank you, I'm getting an understanding of how all this works now..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
