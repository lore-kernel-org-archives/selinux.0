Date: Wed, 12 Nov 2014 16:35:33 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <pmoore@redhat.com>
Subject: Re: [PATCH] selinux: convert WARN_ONCE() to printk_once() in
 selinux_nlmsg_perm()
Message-ID: <20141112213533.GA11274@madcap2.tricolour.ca>
References: <2373486.3IgvVOFVQB@sifl> <2504561.J229oUfjhi@sifl>
 <20141112212515.GF28076@madcap2.tricolour.ca>
 <1709228.3j5ciILylX@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1709228.3j5ciILylX@sifl>
Cc: james.l.morris@oracle.com, vlee@twopensource.com,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 trinity@vger.kernel.org, sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 14/11/12, Paul Moore wrote:
> On Wednesday, November 12, 2014 04:25:15 PM Richard Guy Briggs wrote:
> > On 14/11/12, Paul Moore wrote:
> > > My apologies, I should have noticed this sooner, but printk_once() is
> > > probably not a good choice here as only the first invalid netlink message
> > > will be displayed.  This is fine if all the invalid netlink messages
> > > happen the same, but that isn't likely to be the case.
> > 
> > This was the same situation with WARN_ONCE(), hence my comment about
> > difficulty in debugging...
> 
> Unfortunately I didn't realize your point until now.
> 
> > > Richard, any objections if I convert the printk_once() to a printk(WARN)
> > > and update the patch description accordingly?
> > 
> > Use pr_warn() instead...
> 
> Normally, yes, but the rest of the SELinux code uses printk(WARN) and I'm a 
> stickler for consistency.

And Joe Perches hasn't handed a patch you've accepted yet to convert it
all over?

As you prefer...

> paul moore

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545
