Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3AD64m1031025
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 09:06:04 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l3AD5vgt027854
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 13:06:02 GMT
Subject: Re: cyrus sends mail and uses kerberos
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46043239.4080205@redhat.com>
References: <46043239.4080205@redhat.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 09:06:43 -0400
Message-Id: <1176210403.9840.18.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:02 -0400, Daniel J Walsh wrote:
> --- nsaserefpolicy/policy/modules/services/cyrus.te     2007-03-20 23:38:13.000000000 -0400
> +++ serefpolicy-2.5.10/policy/modules/services/cyrus.te 2007-03-22 15:06:59.000000000 -0400
> @@ -111,6 +111,7 @@
>  userdom_use_sysadm_ptys(cyrus_t)
>  
>  mta_manage_spool(cyrus_t)
> +mta_send_mail(cyrus_t)
>  
>  ifdef(`targeted_policy',`
>         term_dontaudit_use_unallocated_ttys(cyrus_t)
> @@ -123,6 +124,10 @@
>  ')
>  
>  optional_policy(`
> +       kerberos_use(cyrus_t)
> +')
> +
> +optional_policy(`
>         ldap_stream_connect(cyrus_t)
>  ')

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
