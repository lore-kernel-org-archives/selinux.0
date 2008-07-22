Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MAISfY006841
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 06:18:28 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MAIRfY014311
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 10:18:27 GMT
Message-ID: <4885B3EB.704@redhat.com>
Date: Tue, 22 Jul 2008 06:18:19 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: david@hardeman.nu
CC: selinux@tycho.nsa.gov, cpebenito@tresys.com
Subject: Re: [refpolicy-patch 07/23] corenetwork policy update
References: <20080719205002.462190042@hardeman.nu> <20080719210252.218847592@hardeman.nu>
In-Reply-To: <20080719210252.218847592@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

david@hardeman.nu wrote:
> This patch should be a no-brainer, additional network port names only...
> 
> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-3.5.0/policy/modules/kernel/corenetwork.te.in
> --- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2008-06-12 23:25:03.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/kernel/corenetwork.te.in	2008-07-15 14:05:12.000000000 -0400
> @@ -75,6 +75,7 @@
>  network_port(aol, udp,5190,s0, tcp,5190,s0, udp,5191,s0, tcp,5191,s0, udp,5192,s0, tcp,5192,s0, udp,5193,s0, tcp,5193,s0) 
>  network_port(apcupsd, tcp,3551,s0, udp,3551,s0)
>  network_port(asterisk, tcp,1720,s0, udp,2427,s0, udp,2727,s0, udp,4569,s0, udp,5060,s0)
> +network_port(audit, tcp,60,s0)
>  network_port(auth, tcp,113,s0)
>  network_port(bgp, tcp,179,s0, udp,179,s0, tcp,2605,s0, udp,2605,s0)
>  type biff_port_t, port_type, reserved_port_type; dnl network_port(biff) # no defined portcon in current strict
> @@ -82,6 +83,7 @@
>  network_port(clockspeed, udp,4041,s0)
>  network_port(cluster, tcp,5149,s0, udp,5149,s0, tcp,40040,s0, tcp,50006,s0, udp,50006,s0, tcp,50007,s0, udp,50007,s0, tcp,50008,s0, udp,50008,s0)
>  network_port(comsat, udp,512,s0)
> +network_port(cyphesis, udp,32771,s0, tcp,6767,s0, tcp,6769,s0)
>  network_port(cvs, tcp,2401,s0, udp,2401,s0)
>  network_port(dcc, udp,6276,s0, udp,6277,s0)
>  network_port(dbskkd, tcp,1178,s0)
> @@ -91,6 +93,7 @@
>  network_port(distccd, tcp,3632,s0)
>  network_port(dns, udp,53,s0, tcp,53,s0)
>  network_port(fingerd, tcp,79,s0)
> +network_port(flash, tcp,1935,s0, udp,1935,s0)
>  network_port(ftp_data, tcp,20,s0)
>  network_port(ftp, tcp,21,s0)
>  network_port(gatekeeper, udp,1718,s0, udp,1719,s0, tcp,1721,s0, tcp,7000,s0)
> @@ -109,11 +112,13 @@
>  network_port(ircd, tcp,6667,s0)
>  network_port(isakmp, udp,500,s0)
>  network_port(iscsi, tcp,3260,s0)
> +network_port(isns, tcp,3205,s0, udp,3205,s0)
>  network_port(jabber_client, tcp,5222,s0, tcp,5223,s0)
>  network_port(jabber_interserver, tcp,5269,s0)
>  network_port(kerberos_admin, tcp,464,s0, udp,464,s0, tcp,749,s0)
>  network_port(kerberos_master, tcp,4444,s0, udp,4444,s0)
>  network_port(kerberos, tcp,88,s0, udp,88,s0, tcp,750,s0, udp,750,s0)
> +network_port(kprop, tcp,754,s0)
>  network_port(ktalkd, udp,517,s0, udp,518,s0)
>  network_port(ldap, tcp,389,s0, udp,389,s0, tcp,636,s0, udp,636,s0, tcp,3268,s0)
>  type lrrd_port_t, port_type; dnl network_port(lrrd_port_t) # no defined portcon
> @@ -122,6 +127,8 @@
>  network_port(mmcc, tcp,5050,s0, udp,5050,s0)
>  network_port(monopd, tcp,1234,s0)
>  network_port(msnp, tcp,1863,s0, udp,1863,s0)
> +network_port(munin, tcp,4949,s0, udp,4949,s0)
> +network_port(mythtv, tcp,6543,s0, udp,6543,s0)
>  network_port(mysqld, tcp,1186,s0, tcp,3306,s0)
>  portcon tcp 63132-63163 gen_context(system_u:object_r:mysqld_port_t, s0)
>  network_port(nessus, tcp,1241,s0)
> @@ -133,10 +140,13 @@
>  network_port(pegasus_http, tcp,5988,s0)
>  network_port(pegasus_https, tcp,5989,s0)
>  network_port(postfix_policyd, tcp,10031,s0)
> +network_port(pulseaudio, tcp,4713,s0)
> +network_port(pgpkeyserver, udp, 11371,s0, tcp,11371,s0)
>  network_port(pop, tcp,106,s0, tcp,109,s0, tcp,110,s0, tcp,143,s0, tcp,220,s0, tcp,993,s0, tcp,995,s0, tcp,1109,s0)
>  network_port(portmap, udp,111,s0, tcp,111,s0)
>  network_port(postgresql, tcp,5432,s0)
>  network_port(postgrey, tcp,60000,s0)
> +network_port(prelude, tcp,4690,s0, udp,4690,s0)
>  network_port(printer, tcp,515,s0)
>  network_port(ptal, tcp,5703,s0)
>  network_port(pxe, udp,4011,s0)
> @@ -148,11 +158,11 @@
>  network_port(ricci_modcluster, tcp,16851,s0, udp,16851,s0)
>  network_port(rlogind, tcp,513,s0)
>  network_port(rndc, tcp,953,s0)
> -network_port(router, udp,520,s0)
> +network_port(router, udp,520,s0, udp,521,s0, tcp,521,s0)
>  network_port(rsh, tcp,514,s0)
>  network_port(rsync, tcp,873,s0, udp,873,s0)
>  network_port(rwho, udp,513,s0)
> -network_port(smbd, tcp,139,s0, tcp,445,s0)
> +network_port(smbd, tcp,137-139,s0, tcp,445,s0)
>  network_port(smtp, tcp,25,s0, tcp,465,s0, tcp,587,s0)
>  network_port(snmp, udp,161,s0, udp,162,s0, tcp,199,s0)
>  network_port(spamd, tcp,783,s0)
> @@ -170,7 +180,12 @@
>  network_port(transproxy, tcp,8081,s0)
>  type utcpserver_port_t, port_type; dnl network_port(utcpserver) # no defined portcon
>  network_port(uucpd, tcp,540,s0)
> +network_port(virt, tcp,16509,s0, udp,16509,s0, tcp,16514,s0, udp,16514,s0)
> +
>  network_port(vnc, tcp,5900,s0)
> +# Reserve 100 ports for vnc/virt machines
> +portcon tcp 5901-5999 gen_context(system_u:object_r:vnc_port_t, s0)
> +network_port(whois, tcp,43,s0, udp,43,s0)
>  network_port(wccp, udp,2048,s0)
>  network_port(xdmcp, udp,177,s0, tcp,177,s0)
>  network_port(xen, tcp,8002,s0)
> 
Port 60 for audit should not be added as this is not a registered port
and it could change.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiFs+oACgkQrlYvE4MpobPU9QCfblEAulhdQhTUyiQF12BtHV9Y
CNkAnRdQr73Wcl1O2/dZjy9pRDJNBNvg
=AIAm
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
