Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAGNeo0n013585
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 18:40:50 -0500
Received: from us.intercode.com.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAGNemsk026773
	for <selinux@tycho.nsa.gov>; Fri, 16 Nov 2007 23:40:49 GMT
Date: Sat, 17 Nov 2007 10:40:35 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tcho.nsa.gov
Subject: Re: [PATCH] SELinux: return EOPNOTSUPP not ENOTSUPP
In-Reply-To: <1195248956.2924.93.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0711171040250.11097@us.intercode.com.au>
References: <1195248956.2924.93.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 16 Nov 2007, Eric Paris wrote:

> ENOTSUPP is not a valid error code in the kernel (it is defined in some
> NFS internal error codes and has been improperly used other places).  In
> the !CONFIG_SECURITY_SELINUX case though it is possible that we could
> return this from selinux_audit_rule_init().  This patch just returns the
> userspace valid EOPNOTSUPP.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 

Applied.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
