Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5KEvfoV026632
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 10:57:41 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5KEveAt000168
	for <selinux@tycho.nsa.gov>; Wed, 20 Jun 2007 14:57:40 GMT
Subject: Re: radius wants to be able to read samba files
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301427.l4UERhvI007829@localhost.localdomain>
References: <200705301427.l4UERhvI007829@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 20 Jun 2007 14:56:02 +0000
Message-Id: <1182351362.16539.31.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:27 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/radius.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/radius.te	2007-05-30 09:08:15.000000000 -0400
> @@ -124,3 +124,7 @@
>  optional_policy(`
>  	udev_read_db(radiusd_t)
>  ')
> +
> +optional_policy(`
> +	samba_read_var_files(radiusd_t)
> +')

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
