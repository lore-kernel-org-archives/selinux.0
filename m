Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p81CSKH3025121
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 08:28:20 -0400
Received: from mail-ww0-f49.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p81CSIHG002673
	for <selinux@tycho.nsa.gov>; Thu, 1 Sep 2011 12:28:18 GMT
Received: by wwf10 with SMTP id 10so1521568wwf.30
        for <selinux@tycho.nsa.gov>; Thu, 01 Sep 2011 05:28:17 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Rongqing Li <rongqing.li@windriver.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 2/2] Add a netlink attribute INET_DIAG_SECCTX
Date: Thu, 01 Sep 2011 08:28:10 -0400
Message-ID: <1971656.b979ahlREa@sifl>
In-Reply-To: <4E5F5153.6070708@windriver.com>
References: <1314779777-12669-1-git-send-email-rongqing.li@windriver.com> <2593215.lUI7et83Qv@sifl> <4E5F5153.6070708@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, September 01, 2011 05:33:07 PM Rongqing Li wrote:
> On 09/01/2011 05:18 AM, Paul Moore wrote:
> > On Wednesday, August 31, 2011 04:36:17 PM rongqing.li@windriver.com wrote:
> >> From: Roy.Li<rongqing.li@windriver.com>
> >> 
> >> Add a new netlink attribute INET_DIAG_SECCTX to dump the security
> >> context of TCP sockets.
> > 
> > You'll have to forgive me, I'm not familiar with the netlink code used
> > by
> > netstat and friends, but is there anyway to report back the security
> > context of UDP sockets?  Or does the code below handle that already?
> > 
> > In general, AF_INET and AF_INET6 sockets, regardless of any upper level
> > protocols, have security contexts associated with them and it would be
> > nice to see them in netstat.
> 
> Yes, this is real concern, If the dumping tcp security context can be
> accepted by netdev, I am planning to implement it for ipv4 udp socket, unix
> socket. then ipv6..

Great, I'm glad to hear you're planning on implementing this for more than 
just TCP.

I understand your desire to have the basic idea accepted with only TCP 
implemented - and that is fine with me - but I would like to see support for 
all of the protocols merged at the same time.  In other words, seeking the 
basic ACKs for TCP from the davem, et al is okay but I'd like to defer merging 
TCP support until you have everything implemented and ready to be merged.

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
