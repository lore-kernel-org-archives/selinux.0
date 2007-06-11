Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BE6fE3015832
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:06:41 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BE6eDE009181
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:06:40 GMT
Subject: Re: Allow tftpd to read public files
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301418.l4UEIIVZ007731@localhost.localdomain>
References: <200705301418.l4UEIIVZ007731@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:05:07 -0400
Message-Id: <1181570707.16029.18.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:18 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/tftp.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/tftp.te	2007-05-30 09:08:15.000000000 -0400
> @@ -69,6 +69,7 @@
>  logging_send_syslog_msg(tftpd_t)
>  
>  miscfiles_read_localization(tftpd_t)
> +miscfiles_read_public_files(tftpd_t)
>  
>  sysnet_read_config(tftpd_t)
>  sysnet_use_ldap(tftpd_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
