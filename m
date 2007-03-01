Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l21JDBbw015952
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:13:11 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l21JEXtV001445
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 19:14:33 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l21JEXum001587
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:14:33 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l21JES2j026303
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:14:28 -0500
Received: from [10.11.14.203] (vpn-14-203.rdu.redhat.com [10.11.14.203])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l21JERMa025356
	for <selinux@tycho.nsa.gov>; Thu, 1 Mar 2007 14:14:28 -0500
Subject: Re: [PATCH] sepolgen: process USER_AVC messages
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <1172768366.30103.28.camel@localhost.localdomain>
References: <1172768366.30103.28.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 14:13:51 -0500
Message-Id: <1172776431.3099.12.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-01 at 11:59 -0500, Karl MacMillan wrote:
> This patch adds USER_AVC messages to the message types parsed by
> sepolgen.
> 
> diff -r 9bb2118cf4a4 sepolgen/src/sepolgen/audit.py
> --- a/sepolgen/src/sepolgen/audit.py	Thu Mar 01 11:33:49 2007 -0500
> +++ b/sepolgen/src/sepolgen/audit.py	Thu Mar 01 11:58:51 2007 -0500
> @@ -32,7 +32,7 @@ def get_audit_msgs():
>         string contain all of the audit messages returned by ausearch.
>      """
>      import subprocess
> -    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,MAC_POLICY_LOAD,DAEMON_START"],
> +    output = subprocess.Popen(["/sbin/ausearch", "-m", "AVC,USER_AVC,MAC_POLICY_LOAD,DAEMON_START"],
>                                stdout=subprocess.PIPE).communicate()[0]
>      return output
>  

This and the other two patches for refpolicy output style and interface
call parameter extraction were merged into trunk.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
