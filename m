Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB3I17pk019900
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 13:01:07 -0500
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB3I10jY012934
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 18:01:00 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: PATCH: peersid capability support
Date: Mon, 3 Dec 2007 12:32:17 -0500
Cc: "Todd C. Miller" <tmiller@tresys.com>, selinux@tycho.nsa.gov
References: <200711301734.lAUHYKFJ031076@cadmus.columbia.tresys.com> <200711301748.05733.paul.moore@hp.com> <4750A883.5070906@tresys.com>
In-Reply-To: <4750A883.5070906@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712031232.17773.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 30 November 2007 7:19:15 pm Joshua Brindle wrote:
> Paul Moore wrote:
> > 5. Tried installing the module
> > /usr/sbin/load_policy:  Can't load policy:  Invalid argument
> > libsemanage.semanage_reload_policy: load_policy returned error code 2.
> > semodule:  Failed!
> >
> > Help/Ideas?
>
> dmesg should have the error if load_policy fails.

I haven't had a chance to look into it yet, but this is the only thing I can 
see in dmesg that looks related ...

 security: ebitmap: map size 4 does not match my size 64 (high bit was 4)

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
