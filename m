Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l08Fkrgk024937
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 10:46:53 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l08FlfuS013929
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2007 15:47:42 GMT
Subject: Re: [PATCH RFC 1/2] stricter MLS policy constraints
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061212073454.GA30421@w-m-p.com>
References: <20061212072825.GA3362@w-m-p.com>
	 <20061212073454.GA30421@w-m-p.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 10:47:41 -0500
Message-Id: <1168271261.12883.4.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-12-12 at 01:34 -0600, Klaus Weidner wrote: 
> Rename the "mlsfilewriteinrange" attribute with no functional changes.
> The reason for the renaming is that this is an object attribute (like
> "mlstrustedobject"), and it's confusing to use the naming scheme usually
> used for subject attributes for it. It's currently only used for the
> printer device object.
> 
> See 0/2 message for additional explanations.

Sorry for the late response, but its taken some time to clear out the
backlog while I was out of the office.  This patch cannot be applied
upstream because there is no compatibility for renaming the attribute.
Since modules are statically compiled, anything that happens to use this
attribute will fail to link.  The other patches seemed ok.

> -attribute mlsfilewriteinrange;
> +attribute mlsrangedobject;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
