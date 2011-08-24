Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7OI4g44014120
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 14:04:42 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7OI4fCT002915
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 18:04:42 GMT
Message-ID: <4E553CB4.4080102@manicmethod.com>
Date: Wed, 24 Aug 2011 14:02:28 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: HarryCiao <harrytaurus2002@hotmail.com>
CC: cpebenito@tresys.com, dwalsh@redhat.com, qingtao.cao@windriver.com,
        slawrence@tresys.com, selinux@tycho.nsa.gov
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com>,<4E53B1E8.2050508@tresys.com> <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl>
In-Reply-To: <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl>
Content-Type: text/plain; charset=GB2312
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

HarryCiao wrote:
<snip>
> The implementation of the save-linked option has no idea about the effort to 
> separate tunables from booleans, so I am afraid it won't help much.
> 

I'm not sure about this. The linked policy should have everything that the
original modules had, with only the value mapping changed. The expansion is
where things get removed. This behavior should not change for a variety of
reasons, including the ability to do a full semantic analysis of the linked policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
