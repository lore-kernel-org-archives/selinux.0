Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2FGbwal027321
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 11:37:58 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2FGaI1r009974
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 16:36:20 GMT
Subject: Re: [PATCH] MLS interface update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Chad Hanson <chanson@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <20060310162359.GC2949@dhcp-225.il.tcs-sec.com>
References: <20060310162359.GC2949@dhcp-225.il.tcs-sec.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 11:37:53 -0500
Message-Id: <1142440673.20739.8.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-10 at 10:23 -0600, Chad Hanson wrote:
> This patch updates existing mls interfaces and summaries to reflect the
> current mls constraints.  Also, there are also new interface definitions
> for some mls attributes which were lacking interfaces.

Merged the new interfaces, with some changes.  I added 'all_levels' to
the interface names to make it clear that they allow all levels, changed
the socket-related interfaces from "net" to "socket" in the interface
name, and changed "ipc" to "sysvipc" in the interface name to make it
clear its only SysV IPC, not pipes, etc.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
