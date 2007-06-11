Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BE6J5N015757
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:06:19 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BE6IDE009113
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:06:18 GMT
Subject: Re: fix openvpn log/run file context
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301437.l4UEbJ3D007987@localhost.localdomain>
References: <200705301437.l4UEbJ3D007987@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:04:53 -0400
Message-Id: <1181570693.16029.14.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:37 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/openvpn.fc	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/openvpn.fc	2007-05-30 09:08:15.000000000 -0400
> @@ -11,5 +11,5 @@
>  #
>  # /var
>  #
> -/var/log/openvpn.*	--	gen_context(system_u:object_r:openvpn_var_log_t,s0)
> -/var/run/openvpn.*	--	gen_context(system_u:object_r:openvpn_var_run_t,s0)
> +/var/log/openvpn(/.*)?		gen_context(system_u:object_r:openvpn_var_log_t,s0)
> +/var/run/openvpn(/.*)?		gen_context(system_u:object_r:openvpn_var_run_t,s0)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
