Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j32FcgDo019911
	for <selinux@tycho.nsa.gov>; Sat, 2 Apr 2005 10:38:43 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j32Fb2u7016186
	for <selinux@tycho.nsa.gov>; Sat, 2 Apr 2005 15:37:02 GMT
Subject: Re: [ PATCH ] X clients cleanup Patch #3
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <200504022227.40688.russell@coker.com.au>
References: <1112308113.17917.9.camel@cobra.ivg2.net>
	 <1112416291.7982.7.camel@cobra.ivg2.net> <424E8A49.2090408@redhat.com>
	 <200504022227.40688.russell@coker.com.au>
Content-Type: text/plain
Date: Sat, 02 Apr 2005 10:43:09 -0500
Message-Id: <1112456589.12762.6.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-04-02 at 22:27 +1000, Russell Coker wrote:
> On Saturday 02 April 2005 22:04, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > Do we want to remove tmpfs_domain from base_user_domain.  I would prever
> > to have policy where X privs for users is optional.
> > Think eventually about loadable modules, where you have a X user support
> > module.  Server users need a lot less privs.
> 
> When you say "X is optional" do you mean to have a boolean or to have it 
> optional at compile time?
> 
> If a boolean then we would probably have the boolean not stop tmpfs access.  
> If optional at compile time then we certainly want tmpfs_domain in 
> base_user_domain.
> 
> I think that in any case we probably want tmpfs_domain in base_user_domain 
> just for best structure of policy.

How do I prevent the tmpfs type from being declared twice (causing a
compile error)? Can't put it in both x_client and user, and other
domains don't declare a tmpfs_domain themselves - they rely on x_client
to do it for them.

I didn't like this either, but removing tmpfs_domain from x_client
also seemed like a bad idea - it causes denials for everything. 
Moving it into the individual domains is a problem, because then 
you're relying on a type in x_client that might not have been declared.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
