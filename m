Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85EY0YP005274
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 10:34:00 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k85EXGd6011840
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:33:17 GMT
Subject: Re: refpolicy updates from debian
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157464940.3199.250.camel@sgc>
References: <1157161065.9799.28.camel@wintermute.xmldesign.de>
	 <1157394109.3199.234.camel@sgc>
	 <1157399016.4446.20.camel@wintermute.xmldesign.de>
	 <1157464940.3199.250.camel@sgc>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 16:33:15 +0200
Message-Id: <1157466795.20129.1.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Christopher,
> this.  I have added the appropriate rules and fc entries.  However, I
> don't see any options for usbmodules that would have it write to
> usb.ids, so why does your patch have this access?

It's not supposed to, there is a script called update-usbids which does
that. I assume it's being called from package postinsts, and should run
with these permissions fine. But I havn't tested that. But usually the
package managers can write regular files, can't they?

> Can you send me a copy of the script off list?

Will do.

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C   (o_
   There was never a good war or a bad peace. - Benjamin Franklin   //\
         Humor sollte immmer dabeisein, auch bei Problemen.         V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
