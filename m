Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6H0KO7U031712
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 20:20:26 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6H0KLwV014215
	for <selinux@tycho.nsa.gov>; Tue, 17 Jul 2007 00:20:24 GMT
Date: Mon, 16 Jul 2007 20:20:18 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, zohar@us.ibm.com,
        safford@watson.ibm.com
Subject: Re: [RFC]integrity: SELinux patch
In-Reply-To: <1184594240.5860.5.camel@localhost.localdomain>
Message-ID: <Line.LNX.4.64.0707162015490.14773@d.namei>
References: <1184594240.5860.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Jul 2007, Mimi Zohar wrote:

> +#define FILE__MEASURE                             0x00100000UL

Just a logistical note, we need Eric's patch to handle undefined 
permissions, so we don't break userspace with changes such as this.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
