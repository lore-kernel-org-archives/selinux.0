Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7SDES5u010539
	for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 09:14:30 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7SDDqTk028643
	for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 13:13:53 GMT
Subject: Re: [OT] a trouble with posting to '*.@tycho.nsa.gov'
From: Erich Schubert <erich@debian.org>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: jwcart2@epoch.ncsc.mil, himainu-ynakam@miomio.jp, selinux@tycho.nsa.gov
In-Reply-To: <44F2DF61.3050505@kaigai.gr.jp>
References: <44F2DF61.3050505@kaigai.gr.jp>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 15:13:16 +0200
Message-Id: <1156770796.3222.14.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> In recent days, I have faced to a trouble when I tried to post
> messages into '*@tycho.nsa.gov'.
> The phenomenon was that any messages were not delivered when we
> used some specific SMTP servers. Today, I heard that Y.Nakamura

Try net.ipv4.tcp_ecn = 0
IIRC one of the routers to the server has issues with ECN.

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
   Der Weise erkennt einen Freund auch ohne Wein. --- Chao-Hsiu Chen   V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
