Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4LGouVM020238
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 12:50:56 -0400
Received: from g1t0028.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4LGofmg026244
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 16:50:43 GMT
From: Paul Moore <paul.moore@hp.com>
To: "Takesi satoh" <t_mail@mail2Airport.com>
Subject: Re: netif and node check in RHEL5
Date: Wed, 21 May 2008 12:50:38 -0400
Cc: selinux@tycho.nsa.gov
References: <0a1101c8bb47$d12c4270$036a010a@mail2world.com>
In-Reply-To: <0a1101c8bb47$d12c4270$036a010a@mail2world.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805211250.38460.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 21 May 2008 9:37:30 am Takesi satoh wrote:
> I wonder that whether node and netif are checked in RHEL5 or not.

Hello,

I believe RHEL5 makes use of secmark controls instead of the node/netif 
checks (the RH folks can correct me if I am wrong).  You can enable the 
node/netif checks in place of secmark if you want by 
enabling "compat_net" ...

 # echo 1 > /selinux/compat_net

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
