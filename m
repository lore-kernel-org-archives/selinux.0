Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kABIBIuK025416
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 13:11:18 -0500
Received: from mail4.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kABIAYII003665
	for <selinux@tycho.nsa.gov>; Sat, 11 Nov 2006 18:10:34 GMT
Date: Sat, 11 Nov 2006 13:11:20 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
cc: dccp@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH RFC] SELinux support for DCCP
In-Reply-To: <XMMS.LNX.4.64.0611110203540.25507@d.namei>
Message-ID: <XMMS.LNX.4.64.0611111305560.30219@d.namei>
References: <XMMS.LNX.4.64.0611110203540.25507@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Btw, I couldn't find anything to test DCCPv6 with (GNU netcat somehow 
lacks IPv6 support), so wrote some simple apps to do this:

http://namei.org/misc/dccp/


- James
-- 
James Morris
<jmorris@namei.org>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
