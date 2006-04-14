Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3EK7QuS003831
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 16:07:26 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3EK7PZb026265
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 20:07:25 GMT
Subject: Re: VPN module
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Petre Rodan <kaiowas@gentoo.org>
Cc: SE Linux <selinux@tycho.nsa.gov>, Erich Schubert <erich@debian.org>
In-Reply-To: <20060414185125.GA7399@peter.sunspire.org>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de>
	 <1144248600.12875.2.camel@sgc.columbia.tresys.com>
	 <20060414185125.GA7399@peter.sunspire.org>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 16:07:35 -0400
Message-Id: <1145045255.8881.12.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-04-14 at 21:51 +0300, Petre Rodan wrote:
> We had to come up with an openvpn module asap and due to the fact that
> Erich did not have it on his high priority todo list, I went ahead and
> wrote it.

Merged.  One fix, I moved the initrc_t reading openvpn_etc_t to the init
module.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
