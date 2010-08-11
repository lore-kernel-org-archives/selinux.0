Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7BExRI8026841
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 10:59:27 -0400
Received: from demumfd002.nsn-inter.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o7BExh8I008928
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 14:59:43 GMT
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id o7BExOL7032647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 16:59:24 +0200
Received: from demuexc024.nsn-intra.net (demuexc024.nsn-intra.net [10.159.32.11])
	by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id o7BExOjS032064
	for <selinux@tycho.nsa.gov>; Wed, 11 Aug 2010 16:59:24 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: User defined roles on Linux
Date: Wed, 11 Aug 2010 22:59:14 +0800
Message-ID: <DF79449D87A52D44843D75136C2DD02602FAB1CA@SGSIEXC009.nsn-intra.net>
From: "S, Senthilprabu (NSN - IN/Bangalore)" <senthilprabu.s@nsn.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello All, 
    I am a newbie to Linux and SELinux as well. So apologize me if my question is stupid. All these days, I have been playing with Solaris. Have implemented user profiles and associated them with roles using RBAC on Solaris to facilitate set of users to run my application. Users assuming my role can only start, stop and troubleshoot application whereas not possible to execute any other commands. Now after RHEL 5.5 migration, I am trying to implement similar roles here too. After running through various RHEL manuals I assume that SELinux can be used to define RBAC roles to some extend, even though its main feature is to implement Mandatory Access Control (MAC). I see few pre-defined roles like  sysadm_r and staff_u. Now my question is it possible to create user defined roles on RHEL 5.5 using SELinux and assign it to shared os accounts?. If possible but not through SELinux, please let me how it can be done?.



Thanks in advance,
Senthil Prabu.S


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
