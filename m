Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RGrsH8018318
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 12:53:54 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RGrqQQ008133
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 16:53:53 GMT
Subject: Re: [refpolicy] sendmail needs to read ssl/tls certs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <CDEB1AB5-859C-4046-A505-357973103EEF@sf-net.com>
References: <CDEB1AB5-859C-4046-A505-357973103EEF@sf-net.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 12:52:49 -0400
Message-Id: <1188233569.6723.14.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-23 at 02:31 -0400, Stefan Schulze Frielinghaus wrote:
> --- /usr/src/refpolicy-20070629/policy/modules/services/sendmail.te     2007-06-29 16:48:13.000000000 +0200
> +++ policy/modules/services/sendmail.te 2007-08-23 08:25:51.000000000 +0200
> @@ -91,6 +91,7 @@
>  
>  logging_send_syslog_msg(sendmail_t)
>  
> +miscfiles_read_certs(sendmail_t)
>  miscfiles_read_localization(sendmail_t)
>  
>  sysnet_dns_name_resolve(sendmail_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
