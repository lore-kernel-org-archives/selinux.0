Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SGCGe8017296
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 11:12:16 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SGDbM8024816
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 16:13:37 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: Kerberized telnetd support in policy
Date: Wed, 28 Feb 2007 11:13:55 -0500
Message-ID: <1172679235.11157.69.camel@sgc>
In-Reply-To: <200702261746.l1QHktrL030756@localhost.localdomain>
References: <200702261746.l1QHktrL030756@localhost.localdomain>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <dwalsh@localhost.localdomain>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 12:46 -0500, dwalsh@localhost.localdomain wrote:
> 
> 
> ===File /tmp/patches/done/nsaserefpolicy_policy_modules_services_telnet.patch===
> --- nsaserefpolicy/policy/modules/services/telnet.te	2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/services/telnet.te	2007-02-26 11:02:34.000000000 -0500
> @@ -88,6 +88,7 @@
>  # for identd; cjp: this should probably only be inetd_child rules?
>  optional_policy(`
>  	kerberos_use(telnetd_t)
> +	kerberos_read_keytab(telnetd_t)
>  ')
>  
>  optional_policy(`
> ============================================================

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
