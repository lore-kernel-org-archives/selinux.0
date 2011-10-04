Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p94074xq025006
	for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2011 20:07:04 -0400
Received: from mail-vw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p94073un009962
	for <selinux@tycho.nsa.gov>; Tue, 4 Oct 2011 00:07:03 GMT
Received: by vws19 with SMTP id 19so3866357vws.12
        for <selinux@tycho.nsa.gov>; Mon, 03 Oct 2011 17:07:03 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: David Howells <dhowells@redhat.com>
Cc: selinux@tycho.nsa.gov, netdev@vger.kernel.org
Subject: Re: [PATCH] SELinux: Fix RCU deref check warning in sel_netport_insert()
Date: Mon, 03 Oct 2011 20:06:59 -0400
Message-ID: <1743108.Ii53PKTyVY@olly>
In-Reply-To: <25906.1317683262@redhat.com>
References: <2230709.7n5noARWFd@sifl> <20111003135824.15303.10147.stgit@warthog.procyon.org.uk> <25906.1317683262@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, October 4, 2011 12:07:42 AM David Howells wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> > We should probably do the same for the security/selinux/netif.c as it
> > uses the same logic; David is this something you want to tackle?
> 
> I can have a look, but it won't be before Wednesday.

Not a problem, if you don't get to it just let me know and I'll put together a 
patch.

Thanks.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
