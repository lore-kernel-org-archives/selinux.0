Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5EGql69015398
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 12:52:47 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5EGqUtB012887
	for <selinux@tycho.nsa.gov>; Thu, 14 Jun 2007 16:52:30 GMT
Date: Thu, 14 Jun 2007 12:52:16 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Chad Sellers <csellers@tresys.com>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
In-Reply-To: <1181836985.17547.645.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0706141250100.18953@localhost.localdomain>
References: <C296D9C6.23423%csellers@tresys.com>
 <1181836512.17547.640.camel@moss-spartans.epoch.ncsc.mil>
 <1181836985.17547.645.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 14 Jun 2007, Stephen Smalley wrote:

> +	if (selinux_enforcing) {
> +		rc = avc_has_perm_noaudit(sid, sid, SECCLASS_CAP_OVERRIDE,
> +					  CAP_TO_MASK(cap), AVC_STRICT, NULL);
> +		if (!rc)
> +			goto out;

I wonder if this will break applications now -- if their suid bit is 
removed, and SELinux authoritatively grants capabilities, they'll just 
stop working in permissive mode.



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
