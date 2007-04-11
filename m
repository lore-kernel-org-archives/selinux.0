Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BHpF6t003444
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 13:51:15 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3BHpDT2025805
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:51:14 GMT
Subject: Re: Samba guys reviewed samba policy and fixed some of the ports
	used by samba
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <460AB4CF.4040404@redhat.com>
References: <46042767.8050508@redhat.com>
	 <1175105856.29300.107.camel@sgc.columbia.tresys.com>
	 <460AB4CF.4040404@redhat.com>
Content-Type: text/plain
Date: Wed, 11 Apr 2007 13:51:57 -0400
Message-Id: <1176313917.9840.48.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-28 at 14:32 -0400, Daniel J Walsh wrote:
> Christopher J. PeBenito wrote:
> > On Fri, 2007-03-23 at 15:15 -0400, Daniel J Walsh wrote:
> >   
> >> Also added new ports for squid.
> >>     
> >
> > Looks like the wrong patch.
> >
> >   
> Sorry try this one.

Merged smbd and nmbd parts.

> 
> 
> 
> 
> 
> 
> differences
> between files
> attachment
> (corenetwork.te.in.patch)
> 
> --- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in      2007-02-19 11:32:51.000000000 -0500
> +++ serefpolicy-2.5.11/policy/modules/kernel/corenetwork.te.in  2007-03-27 15:45:12.000000000 -0400
> @@ -100,7 +105,7 @@
>  network_port(kerberos_master, tcp,4444,s0, udp,4444,s0)
>  network_port(kerberos, tcp,88,s0, udp,88,s0, tcp,750,s0, udp,750,s0)
>  network_port(ktalkd, udp,517,s0, udp,518,s0)
> -network_port(ldap, tcp,389,s0, udp,389,s0, tcp,636,s0, udp,636,s0)
> +network_port(ldap, tcp,3268,s0, tcp,389,s0, udp,389,s0, tcp,636,s0, udp,636,s0)
>  type lrrd_port_t, port_type; dnl network_port(lrrd_port_t) # no defined portcon
>  network_port(lmtp, tcp,24,s0, udp,24,s0)
>  network_port(mail, tcp,2000,s0)
> @@ -108,7 +113,7 @@
>  network_port(mysqld, tcp,3306,s0)
>  network_port(nessus, tcp,1241,s0)
>  network_port(netsupport, tcp,5405,s0, udp,5405,s0)
> -network_port(nmbd, udp,137,s0, udp,138,s0, udp,139,s0)
> +network_port(nmbd, udp,137,s0, udp,138,s0)
>  network_port(ntp, udp,123,s0)
>  network_port(ocsp, tcp,9080,s0)
>  network_port(openvpn, tcp,1194,s0, udp,1194,s0)
> @@ -132,7 +137,7 @@
>  network_port(router, udp,520,s0)
>  network_port(rsh, tcp,514,s0)
>  network_port(rsync, tcp,873,s0, udp,873,s0)
> -network_port(smbd, tcp,137-139,s0, tcp,445,s0)
> +network_port(smbd, tcp,139,s0, tcp,445,s0)
>  network_port(smtp, tcp,25,s0, tcp,465,s0, tcp,587,s0)
>  network_port(snmp, udp,161,s0, udp,162,s0, tcp,199,s0)
>  network_port(spamd, tcp,783,s0)
> @@ -140,6 +145,7 @@
>  network_port(soundd, tcp,8000,s0, tcp,9433,s0)
>  type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
>  type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
> +network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
>  network_port(swat, tcp,901,s0)
>  network_port(syslogd, udp,514,s0)
>  network_port(telnetd, tcp,23,s0)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
