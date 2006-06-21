Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LLFCsP000943
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 17:15:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LLFAYx006268
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 21:15:11 GMT
From: Steve Grubb <sgrubb@redhat.com>
To: paul.moore@hp.com
Subject: Re: [RFC 4/7] NetLabel: core NetLabel subsystem
Date: Wed, 21 Jun 2006 17:15:05 -0400
Cc: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@epoch.ncsc.mil,
        jmorris@redhat.com
References: <20060621194234.979661000@flek.zko.hp.com> <20060621200032.379679000@flek.zko.hp.com>
In-Reply-To: <20060621200032.379679000@flek.zko.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200606211715.05868.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 21 June 2006 15:42, paul.moore@hp.com wrote:
> Add a new kernel subsystem, NetLabel, to provide explicit packet labeling
> services (CIPSO, RIPSO, etc.) to LSM developers.  NetLabel is designed to
> work in conjunction with a LSM to intercept and decode security labels on
> incoming network packets as well as ensure that outgoing network packets
> are labeled according to the security mechanism employed by the LSM.  The
> NetLabel subsystem is configured through a NETLINK interface described in
> the header files included in this patch.

This patch doesn't build. It fails like this:

`netlbl_netlink_exit' referenced in section `.init.text' of net/built-in.o: 
defined in discarded section `.exit.text' of net/built-in.o
`netlbl_domhsh_exit' referenced in section `.init.text' of net/built-in.o: 
defined in discarded section `.exit.text' of net/built-in.o

I deleted the __exit and __init  for now so that the build procedes. But this 
needs to get fixed in next iteration.

Thanks,
-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
