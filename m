Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GE8VL9015837
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 09:08:31 -0500 (EST)
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050216140849.GQ31121@lkcl.net>
References: <20050215213455.GF26294@lkcl.net>
	 <1108559153.19756.49.camel@moss-spartans.epoch.ncsc.mil>
	 <20050216140849.GQ31121@lkcl.net>
Content-Type: text/plain
Message-Id: <1108562413.19756.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 16 Feb 2005 09:00:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-02-16 at 09:08, Luke Kenneth Casson Leighton wrote:
>  in order to be able to restrict users from logging in on a per-IP
>  basis.
> 
>  e.g. so restricted_user1 can ONLY ssh in from 192.168.0.223, because
>  i set up a net_context that said so, and associated
>  sshd_priv_restricted_user1_t with that network context

I'm not clear that this is going to work for you, or that this is the
right approach (vs. using iptables and multiple sshd instances running
in different security contexts and listening on different ports
initially).  Further, I'm not sure where you are going to perform these
dynamic context transitions, as the user isn't authenticated when the
monitor and unprivileged child are created.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
