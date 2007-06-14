Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EHZ9ku018935
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 13:35:09 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EHZ8tB022693
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 17:35:08 GMT
Date: Thu, 14 Jun 2007 13:35:04 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Chad Sellers <csellers@tresys.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
In-Reply-To: <C296F304.23443%csellers@tresys.com>
Message-ID: <Line.LNX.4.64.0706141334280.19226@localhost.localdomain>
References: <C296F304.23443%csellers@tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Jun 2007, Chad Sellers wrote:

> Yes, it's definitely an interesting scenario, when a program can succeed in
> enforcing but fail in permissive. Though it might help us convince more
> people to run in enforcing ;-)

ITYM "convince more people to disable SELinux"



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
