Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7P3M4eM008277
	for <selinux@tycho.nsa.gov>; Wed, 24 Aug 2011 23:22:04 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7P3M3KK006199
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 03:22:03 GMT
Message-ID: <4E55BFE1.60608@windriver.com>
Date: Thu, 25 Aug 2011 11:22:09 +0800
From: Harry Ciao <qingtao.cao@windriver.com>
Reply-To: <qingtao.cao@windriver.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: HarryCiao <harrytaurus2002@hotmail.com>, <cpebenito@tresys.com>,
        <dwalsh@redhat.com>, <slawrence@tresys.com>, <selinux@tycho.nsa.gov>
Subject: Re: [v0 PATCH 6/6] Skip tunable identifier and cond_node_t in expansion.
References: <1314094112-6477-1-git-send-email-qingtao.cao@windriver.com> <1314094112-6477-7-git-send-email-qingtao.cao@windriver.com> <4E53AE8C.6020707@redhat.com>,<4E53B1E8.2050508@tresys.com> <SNT139-W39AB9329AEFF0B29157316AB110@phx.gbl> <4E553CB4.4080102@manicmethod.com>
In-Reply-To: <4E553CB4.4080102@manicmethod.com>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Joshua,

Joshua Brindle 写道:
> HarryCiao wrote:
> <snip>
>   
>> The implementation of the save-linked option has no idea about the effort to 
>> separate tunables from booleans, so I am afraid it won't help much.
>>
>>     
>
> I'm not sure about this. The linked policy should have everything that the
> original modules had, with only the value mapping changed. The expansion is
> where things get removed. This behavior should not change for a variety of
> reasons, including the ability to do a full semantic analysis of the linked policy.
>
>   
I can't agree more that the linked module has everything but with the
identifiers' value remapped, actually the separate_tunables() is called
at the very end of link phase, which would do three operations:
1. change the flags for some cond_bool_datum_t;
2. change the flags for some cond_node_t;
3. re-link the effective branch of a tunable conditional, to the end of
its home decl->avrules list;

The 1st and 2nd operations won't stand in the way of any analysis, and
we could set the "handle-tunable = preserve" option in semanage.conf to
bypass the 3rd one.

Thanks,
Harry



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
