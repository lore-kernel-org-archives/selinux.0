Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBDKoVeQ023194
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 15:50:32 -0500
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBDKp3ca018654
	for <selinux@tycho.nsa.gov>; Wed, 13 Dec 2006 20:51:04 GMT
Message-ID: <458067B3.20107@hp.com>
Date: Wed, 13 Dec 2006 15:50:59 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Klaus Weidner <klaus@atsec.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC 0/2] stricter MLS policy constraints
References: <20061212072825.GA3362@w-m-p.com>
In-Reply-To: <20061212072825.GA3362@w-m-p.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Klaus Weidner wrote:
> The patches are very lightly tested (the policy builds, and permits
> unlabeled ssh login in enforcing mode) -- can the people doing labeled
> networking tests please test it?

I did a quick test using the refpolicy from SVN and your patches; the good news
is that simple tests using netcat worked as expected and there did not appear to
be any regressions.

The bad news is that I realized we never added NetLabel receive permissions to
any of the application domains (try to telnet into a machine with NetLabel);
only the user domains have the NetLabel receive permissions.  As a result I
wasn't able to try any more elaborate tests without fixing the policy.  It will
probably take a little while to get a patch out to address this as there are a
lot of domains which need to be changed; that said I'm probably about a third of
the way through at this point.

In case anyone is interested, the policy changes boil down to the following:

 ifdef(`enable_mls',`
        corenet_tcp_recv_netlabel(app_domain_t)
        corenet_udp_recv_netlabel(app_domain_t)
 ')

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
