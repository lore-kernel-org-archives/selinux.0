Subject: Re: [PATCH] remove selinux stacked ops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@osdl.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@wirex.com
In-Reply-To: <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
	 <20050825225104.GC7762@shell0.pdx.osdl.net>
	 <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:58:11 -0400
Message-Id: <1125057491.5812.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 07:48 -0400, Stephen Smalley wrote:
> > @@ -4568,8 +4421,8 @@ int selinux_disable(void)
> >  
> >  	selinux_disabled = 1;
> >  
> > -	/* Reset security_ops to the secondary module, dummy or capability. */
> > -	security_ops = secondary_ops;
> > +	/* Reset security_ops to the default */
> > +	security_ops = original_ops;
> >  
> >  	/* Unregister netfilter hooks. */
> >  	selinux_nf_ip_exit();
> 
> a runtime disable of SELinux by /sbin/init (upon finding
> SELINUX=disabled in /etc/selinux/config) ends up leaving us with null
> ops rather than the capability or dummy ops.  Thus, SELINUX=disabled
> turns off all security ;(

Ok, as with my prior comment, this one is also invalidated by the fact
that the static inlines fall back to the cap_ functions if the operation
is NULL.  So I suppose this would work.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
