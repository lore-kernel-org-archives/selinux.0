Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7JFEsOb007428
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 11:14:54 -0400 (EDT)
Received: from mail21.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7JF4K5A024107
	for <selinux@tycho.nsa.gov>; Fri, 19 Aug 2005 15:04:20 GMT
Date: Fri, 19 Aug 2005 11:05:21 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: kernel Oops from policy
In-Reply-To: <1124455129.32663.32.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Pine.LNX.4.63.0508191105030.24678@excalibur.intercode>
References: <200508191925.55561.russell@coker.com.au>
 <1124455129.32663.32.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Aug 2005, Stephen Smalley wrote:

> Seems like a bug that it leads to an Oops, even with the denial.

Does it happen with SELinux disabled?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
