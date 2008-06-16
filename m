Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5GIxUuN023084
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 14:59:30 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m5GIxUwL024974
	for <selinux@tycho.nsa.gov>; Mon, 16 Jun 2008 18:59:30 GMT
Subject: Re: new domain for libvirt
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4831B4CB.4060506@comcast.net>
References: <4831B4CB.4060506@comcast.net>
Content-Type: text/plain
Date: Mon, 16 Jun 2008 14:58:31 -0400
Message-Id: <1213642711.11146.67.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-05-19 at 13:11 -0400, Daniel J Walsh wrote:
> 
> Gzip archive attachment
> (system_virt.patch.gz)

Merged.  I commented out missing interface calls.  I also moved the
kernel proc entries for xen into the optional that has the other xen
rules.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
