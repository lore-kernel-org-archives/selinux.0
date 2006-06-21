Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LLOLSb001179
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 17:24:21 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LLOKsi026122
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 21:24:20 GMT
Message-ID: <4499B8FF.3020505@hp.com>
Date: Wed, 21 Jun 2006 17:24:15 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Steve Grubb <sgrubb@redhat.com>
Cc: redhat-lspp@redhat.com, sds@epoch.ncsc.mil, selinux@tycho.nsa.gov,
        jmorris@redhat.com
Subject: Re: [redhat-lspp] Re: [RFC 4/7] NetLabel: core NetLabel subsystem
References: <20060621194234.979661000@flek.zko.hp.com>	<20060621200032.379679000@flek.zko.hp.com> <200606211715.05868.sgrubb@redhat.com>
In-Reply-To: <200606211715.05868.sgrubb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve Grubb wrote:
> On Wednesday 21 June 2006 15:42, paul.moore@hp.com wrote:
>>Add a new kernel subsystem, NetLabel, to provide explicit packet labeling
>>services (CIPSO, RIPSO, etc.) to LSM developers.  NetLabel is designed to
>>work in conjunction with a LSM to intercept and decode security labels on
>>incoming network packets as well as ensure that outgoing network packets
>>are labeled according to the security mechanism employed by the LSM.  The
>>NetLabel subsystem is configured through a NETLINK interface described in
>>the header files included in this patch.
> 
> 
> This patch doesn't build. It fails like this:
> 
> `netlbl_netlink_exit' referenced in section `.init.text' of net/built-in.o: 
> defined in discarded section `.exit.text' of net/built-in.o
> `netlbl_domhsh_exit' referenced in section `.init.text' of net/built-in.o: 
> defined in discarded section `.exit.text' of net/built-in.o
> 
> I deleted the __exit and __init  for now so that the build procedes. But this 
> needs to get fixed in next iteration.

I removed them from the *.c files but it looks like I forget to remove
them from the *.h files.  Sorry.

I'm still very confused as to why I never see these build errors, yet
you do - can you tell me what compiler version you are using?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
