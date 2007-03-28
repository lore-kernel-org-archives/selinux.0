Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SIX0SP025677
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 14:33:00 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2SIWxLB004124
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 18:32:59 GMT
Message-ID: <460AB4CF.4040404@redhat.com>
Date: Wed, 28 Mar 2007 14:32:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Samba guys reviewed samba policy and fixed some of the ports
 used by samba
References: <46042767.8050508@redhat.com> <1175105856.29300.107.camel@sgc.columbia.tresys.com>
In-Reply-To: <1175105856.29300.107.camel@sgc.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------060106010806070308070901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060106010806070308070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Fri, 2007-03-23 at 15:15 -0400, Daniel J Walsh wrote:
>   
>> Also added new ports for squid.
>>     
>
> Looks like the wrong patch.
>
>   
Sorry try this one.


--------------060106010806070308070901
Content-Type: text/x-patch;
 name="corenetwork.te.in.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="corenetwork.te.in.patch"

--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.11/policy/modules/kernel/corenetwork.te.in	2007-03-27 15:45:12.000000000 -0400
@@ -100,7 +105,7 @@
 network_port(kerberos_master, tcp,4444,s0, udp,4444,s0)
 network_port(kerberos, tcp,88,s0, udp,88,s0, tcp,750,s0, udp,750,s0)
 network_port(ktalkd, udp,517,s0, udp,518,s0)
-network_port(ldap, tcp,389,s0, udp,389,s0, tcp,636,s0, udp,636,s0)
+network_port(ldap, tcp,3268,s0, tcp,389,s0, udp,389,s0, tcp,636,s0, udp,636,s0)
 type lrrd_port_t, port_type; dnl network_port(lrrd_port_t) # no defined portcon
 network_port(lmtp, tcp,24,s0, udp,24,s0)
 network_port(mail, tcp,2000,s0)
@@ -108,7 +113,7 @@
 network_port(mysqld, tcp,3306,s0)
 network_port(nessus, tcp,1241,s0)
 network_port(netsupport, tcp,5405,s0, udp,5405,s0)
-network_port(nmbd, udp,137,s0, udp,138,s0, udp,139,s0)
+network_port(nmbd, udp,137,s0, udp,138,s0)
 network_port(ntp, udp,123,s0)
 network_port(ocsp, tcp,9080,s0)
 network_port(openvpn, tcp,1194,s0, udp,1194,s0)
@@ -132,7 +137,7 @@
 network_port(router, udp,520,s0)
 network_port(rsh, tcp,514,s0)
 network_port(rsync, tcp,873,s0, udp,873,s0)
-network_port(smbd, tcp,137-139,s0, tcp,445,s0)
+network_port(smbd, tcp,139,s0, tcp,445,s0)
 network_port(smtp, tcp,25,s0, tcp,465,s0, tcp,587,s0)
 network_port(snmp, udp,161,s0, udp,162,s0, tcp,199,s0)
 network_port(spamd, tcp,783,s0)
@@ -140,6 +145,7 @@
 network_port(soundd, tcp,8000,s0, tcp,9433,s0)
 type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
 type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
+network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0, )
 network_port(swat, tcp,901,s0)
 network_port(syslogd, udp,514,s0)
 network_port(telnetd, tcp,23,s0)

--------------060106010806070308070901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
