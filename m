Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2SHOLRb001173
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 12:24:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2SHOKFV008370
	for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 17:24:20 GMT
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
        by jazzband.ncsc.mil  with SMTP id i2SHOJ36008354 for <selinux@tycho.nsa.gov>; Sun, 28 Mar 2004 17:24:19 GMT
Message-ID: <4066F136.3DCA73D7@gmx.de>
Date: Sun, 28 Mar 2004 17:37:26 +0200
From: Martin Stricker <shugal@gmx.de>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: how to write and understand a patch file?
References: <20040328100448.19776.qmail@web41308.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Park Lee wrote:
> 
> Hi,
> Would you please tell me how to write and understand a patch file?
> I just want to learn more about it.

You create a patch with `diff` and apply it with `patch`. A patch is
just a list of differences between the original version of a source code
file (you cannot patch a binary) and your altered version.
-- 
Homepage: http://www.martin-stricker.de/
Linux Migration Project: http://www.linux-migration.org/
Red Hat Linux 9 for low memory: http://www.rule-project.org/
Registered Linux user #210635: http://counter.li.org/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
