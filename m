Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l47Ddxlh019820
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 09:39:59 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l47DdpKF000355
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 13:39:51 GMT
Subject: Re: squid patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46278600.2010806@redhat.com>
References: <46278600.2010806@redhat.com>
Content-Type: text/plain
Date: Mon, 07 May 2007 09:39:21 -0400
Message-Id: <1178545161.25271.5.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 11:08 -0400, Daniel J Walsh wrote:
> Added httpd_squid_script_t
> 
> squid_conf_t can be a directory
> Squid also needs additional ports to communicate with
> 
> dovecot and snmp try to read squid files.  (Snuck in a couple of other
> fixes for dovecot and snmp)

Merged except for the apache template, plus:

> +interface(`squid_dontaudit_search_squid_cache',`
> +       gen_require(`
> +               type squid_cache_t;
> +       ')
> +
> +       dontaudit $1 squid_cache_t:dir search_dir_perms;
> +')

Dropped the second squid in the name.

> --- nsaserefpolicy/policy/modules/services/snmp.te      2007-03-26 10:39:04.000000000 -0400
> +++ serefpolicy-2.5.12/policy/modules/services/snmp.te  2007-04-11 17:07:34.000000000 -0400
> @@ -134,6 +134,11 @@
>  ')
>  
>  optional_policy(`
> +       mta_read_config(snmpd_t)
> +       mta_search_queue(snmpd_t)
> +')

The second interface is missing.

>  optional_policy(`
> +       sendmail_read_log(snmpd_t)
> +')

This one is missing too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
