Subject: Re: [PATCH] remove selinux stacked ops
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@osdl.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@wirex.com
In-Reply-To: <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
References: <20050825221732.GR7991@shell0.pdx.osdl.net>
	 <20050825225104.GC7762@shell0.pdx.osdl.net>
	 <1125056906.5812.32.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 26 Aug 2005 07:55:49 -0400
Message-Id: <1125057349.5812.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-08-26 at 07:48 -0400, Stephen Smalley wrote:
> On Thu, 2005-08-25 at 15:51 -0700, Chris Wright wrote:
> > @@ -3620,13 +3523,6 @@ static int selinux_netlink_send(struct s
> >  	return err;
> >  }
> >  
> > -static int selinux_netlink_recv(struct sk_buff *skb)
> > -{
> > -	if (!cap_raised(NETLINK_CB(skb).eff_cap, CAP_NET_ADMIN))
> > -		return -EPERM;
> > -	return 0;
> > -}
> > -
> 
> Hmm...is removing this entirely safe?  Given that dummy is being
> removed, and null ops are no longer being populated, don't we have to
> ensure that we define a SELinux hook function for every cap_ function
> and explicitly call that function?  Likewise, don't we now have to add a
> settime hook to SELinux to preserve behavior?  Previously, it was
> defaulting to the dummy hook, which conveniently called capable(), so it
> ended up working regardless of whether SELinux was stacked with dummy or
> capability.

Ah, never mind - I forgot that you are falling back to the cap_
functions in your static inlines if the operation is null.  So you could
also remove selinux_capset_set and selinux_task_post_setuid.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
