Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0LJ0LQo006594
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 14:00:21 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0LJ0LTs010495
	for <selinux@tycho.nsa.gov>; Mon, 21 Jan 2008 19:00:21 GMT
Subject: Re: mcs mls
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Justin Mattock <justinmattock@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <dd18b0c30801211043h4000c6bdg211ec6390039d195@mail.gmail.com>
References: <dd18b0c30801211043h4000c6bdg211ec6390039d195@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 21 Jan 2008 13:58:49 -0500
Message-Id: <1200941929.4595.82.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-01-21 at 10:43 -0800, Justin Mattock wrote:
> Hello; If mcs seems to be shaky with the Xserver, then the best
> solution in my mind would be to stay with refpolicy standard.
> until there is secure support for the xserver.  Personally using a
> standard policy is probably more than enough protection, for an
> everyday civilian,("hopefully")  More over, The whole goal I had with
> SELinux  was to learn what it was and how it works, and to learn
> something, "educational". 

I think you misunderstood my response.  MCS won't be any different than
standard in terms of X server support, as MCS designed such that it
won't cause denials unless you start applying varying category sets to
domains and objects.  You'll still have the same issues with TE on any
of the configurations.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
