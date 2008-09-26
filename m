Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8QARXOD030151
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 06:27:33 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8QAQXrt007717
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 10:26:34 GMT
Message-ID: <48DCB88E.3080503@kaigai.gr.jp>
Date: Fri, 26 Sep 2008 19:25:18 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Dominick Grift <domg472@gmail.com>
CC: KaiGai Kohei <kaigai@ak.jp.nec.com>, Valdis.Kletnieks@vt.edu,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
Subject: Re: How to find SELinux policy type?
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>	  <48DC5C16.9040607@ak.jp.nec.com> <1222421896.24783.7.camel@sulphur.notebook.internal>
In-Reply-To: <1222421896.24783.7.camel@sulphur.notebook.internal>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dominick Grift wrote:
> On Fri, 2008-09-26 at 12:50 +0900, KaiGai Kohei wrote:
> 
>> Don't worry. I actually maintain the specfile of sepostgresql package
>> that provides its security policy modules. :)
> 
> Can you have a look at this
> please:https://bugzilla.redhat.com/show_bug.cgi?id=463906
> thanks

Oops, :(

Was the sepostgresql related policy backported to F9 selinux-policy?
Thanks for your notification, I'll fix soon.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
