Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GFAwL9016387
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 10:10:58 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GF7MNj025004
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 15:07:22 GMT
Date: Wed, 16 Feb 2005 15:19:32 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20050216151932.GT31121@lkcl.net>
References: <20050215213455.GF26294@lkcl.net> <1108559153.19756.49.camel@moss-spartans.epoch.ncsc.mil> <20050216140849.GQ31121@lkcl.net> <1108562413.19756.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108562413.19756.96.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 09:00:13AM -0500, Stephen Smalley wrote:
> On Wed, 2005-02-16 at 09:08, Luke Kenneth Casson Leighton wrote:
> >  in order to be able to restrict users from logging in on a per-IP
> >  basis.
> > 
> >  e.g. so restricted_user1 can ONLY ssh in from 192.168.0.223, because
> >  i set up a net_context that said so, and associated
> >  sshd_priv_restricted_user1_t with that network context
> 
> I'm not clear that this is going to work for you, or that this is the
> right approach (vs. using iptables and multiple sshd instances running
> in different security contexts and listening on different ports
> initially).  

 this is the temporary approach that i have in fact taken.


 think in terms of maybe having to add a dozen or more different
 "zones".

 eth0 -> iptables -> /usr/sbin/sshd_eth0 -> restricted_user0
 eth1 -> iptables -> /usr/sbin/sshd_eth1 -> restricted_user1
 ....
 ....
 eth100 -> iptables -> /usr/sbin/sshd_eth100-> restricted_user100

 and it _very_ quickly becomes unmanageable - some time after the
 first two users are added.

 the requirements are such that there will be several different
 users with several different ip addresses / zones from which
 those users need to be restricted.

 i can forsee a point where the customer is going to bitch at me
 to provide a solution.
 

> Further, I'm not sure where you are going to perform these
> dynamic context transitions, as the user isn't authenticated when the
> monitor and unprivileged child are created.  

 do_authentication2() - just afer the username is determined.

 auth2.c's input_userauth_request().
 
 after "user = packet_get_string(NULL)"

 i hope :)

 l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
