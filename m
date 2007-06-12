Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CD0ilo017544
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 09:00:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CD0cgo003112
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:00:41 GMT
Subject: Re: Cyrus attempts to write snmp_var_lib
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301454.l4UEsSwQ008269@localhost.localdomain>
References: <200705301454.l4UEsSwQ008269@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 12:59:09 +0000
Message-Id: <1181653149.16029.59.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:54 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/cyrus.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/cyrus.te	2007-05-30 09:08:15.000000000 -0400
> @@ -138,6 +139,7 @@
>  
>  optional_policy(`
>  	snmp_read_snmp_var_lib_files(cyrus_t)
> +	snmp_dontaudit_write_snmp_var_lib_files(cyrus_t)
>  ')
>  
>  optional_policy(`

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
