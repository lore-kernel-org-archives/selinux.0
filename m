Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6SK9JOD005115
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 16:09:19 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6SK9Glq013198
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 20:09:16 GMT
Message-ID: <44CA6EEB.6090103@hp.com>
Date: Fri, 28 Jul 2006 16:09:15 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: tgraf@suug.ch, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 2/7] NetLabel: core network changes
References: <44CA59D8.4090702@hp.com>	<20060728185825.GG14627@postel.suug.ch>	<44CA60BC.1030503@hp.com> <20060728.125816.10299135.davem@davemloft.net>
In-Reply-To: <20060728.125816.10299135.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Miller wrote:
> From: Paul Moore <paul.moore@hp.com>
> Date: Fri, 28 Jul 2006 15:08:44 -0400
> 
>>Thanks for your feedback but unless I hear from others that this
>>is a requirement I think I'm going to leave the code as written for the
>>reasons I listed above.
>  
> Please switch over to the scheme which Thomas has suggested.
> 

Okay.  I stated earlier today that I would push a new patchset out to
the list this weekend or perhaps today, but in light of this I think
I'll wait until I have had a chance to make this change which should be
sometime next week.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
