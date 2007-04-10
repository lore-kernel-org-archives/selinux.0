Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3ACjwSn030108
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 08:45:58 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3ACjvIR020388
	for <selinux@tycho.nsa.gov>; Tue, 10 Apr 2007 12:45:58 GMT
Subject: Re: djbdns patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>, kaiowas@gentoo.org
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460431FA.6050101@redhat.com>
References: <460431FA.6050101@redhat.com>
Content-Type: text/plain
Date: Tue, 10 Apr 2007 08:46:39 -0400
Message-Id: <1176209199.9840.13.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-23 at 16:00 -0400, Daniel J Walsh wrote:
> Make     ucspitcp_service_domain optional

Perhaps this should be made an init_daemon_domain() too?

> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (djbdns.patch),
> "djbdns.patch"
> 
> --- nsaserefpolicy/policy/modules/services/djbdns.te    2007-01-02 12:57:43.000000000 -0500
> +++ serefpolicy-2.5.10/policy/modules/services/djbdns.te        2007-03-22 15:06:59.000000000 -0400
> @@ -44,4 +44,7 @@
>  libs_use_ld_so(djbdns_axfrdns_t)
>  libs_use_shared_libs(djbdns_axfrdns_t)
>  
> -ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> +optional_policy(`
> +       ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
> +')
> +
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
