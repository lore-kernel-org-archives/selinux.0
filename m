Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBDLoKHT025637
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 16:50:20 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBDLoqEY019613
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 21:50:52 GMT
Message-ID: <458075BA.5030007@hp.com>
Date: Wed, 13 Dec 2006 16:50:50 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: [PATCH RFC 0/2] stricter MLS policy constraints
References: <20061212072825.GA3362@w-m-p.com> <458067B3.20107@hp.com> <20061213214047.GC3362@w-m-p.com>
In-Reply-To: <20061213214047.GC3362@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> On Wed, Dec 13, 2006 at 03:50:59PM -0500, Paul Moore wrote:
> 
>>The bad news is that I realized we never added NetLabel receive permissions to
>>any of the application domains (try to telnet into a machine with NetLabel);
>>only the user domains have the NetLabel receive permissions.  As a result I
>>wasn't able to try any more elaborate tests without fixing the policy.  It will
>>probably take a little while to get a patch out to address this as there are a
>>lot of domains which need to be changed; that said I'm probably about a third of
>>the way through at this point.
>>
>>In case anyone is interested, the policy changes boil down to the following:
>>
>> ifdef(`enable_mls',`
>>        corenet_tcp_recv_netlabel(app_domain_t)
>>        corenet_udp_recv_netlabel(app_domain_t)
>> ')
> 
> 
> Have you considered adding those lines to the existing interfaces in
> policy/modules/kernel/corenetwork.if.in instead? For example, telnetd
> currently uses corenet_tcp_sendrecv_all_if(telnetd_t), and you could make
> that interface provide the needed netlabel rights also.

I did consider doing something similar but I figured sticking with the existing
refpolicy convention was the going to be the path of least resistance and in the
"userdom_basic_networking_template" code the corenet_* NetLabel permissions are
kept separate from the rest of the corenet_* permissions.  It makes more sense
conceptually too I think.

I added Chris to the CC line as he might be able to provide some thoughts on
what he would like to see.

> Do we need something equivalent for labeled IPSEC?

I would think so, but I believe Joy said she is working on that; however, the
policy for NetLabel and labeled IPsec is radically different so labeled IPsec
may have a different approach.

With NetLabel you only need a single allow rule for each domain wishing to
receive labeled network traffic:

 allow my_domain_t unlabeled_t:{ tcp_socket udp_socket } recvfrom;

With labeled IPsec it's a bit more involved.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
