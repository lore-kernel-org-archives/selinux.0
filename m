Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p96MpQXG016124
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 18:51:26 -0400
Received: from mail-wy0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p96MpO00027026
	for <selinux@tycho.nsa.gov>; Thu, 6 Oct 2011 22:51:25 GMT
Received: by wyf19 with SMTP id 19so3823742wyf.12
        for <selinux@tycho.nsa.gov>; Thu, 06 Oct 2011 15:51:24 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Thu, 06 Oct 2011 18:51:19 -0400
Message-ID: <4210290.EWfROnk5ys@sifl>
In-Reply-To: <1624.1317821523@redhat.com>
References: <2230709.7n5noARWFd@sifl> <20111003135824.15303.10147.stgit@warthog.procyon.org.uk> <1624.1317821523@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, October 05, 2011 02:32:03 PM David Howells wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > We should probably do the same for the security/selinux/netif.c as it
> > uses the same logic; David is this something you want to tackle?
> 
> netif.c doesn't use any rcu_dereference*() function directly, though it does
> use list_for_each_entry_rcu().  However, I'm not sure that's a problem. 
> What is it you're referring to?

My apologies, the netport.c and netif.c code is very, very similar and 
whenever I see a patch just for one of the two it causes a reaction that you 
saw above.  While netif.c has a similar function, sel_netif_insert(), it is 
slightly different and doesn't need a rcu_dereference() ad the netport.c code 
does.

Sorry for the confusion.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
