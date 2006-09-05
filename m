Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k85EaA9u005377
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 10:36:10 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k85EZRd6012168
	for <selinux@tycho.nsa.gov>; Tue, 5 Sep 2006 14:35:27 GMT
Subject: Re: refpolicy updates from debian
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1157466795.20129.1.camel@wintermute.xmldesign.de>
References: <1157161065.9799.28.camel@wintermute.xmldesign.de>
	 <1157394109.3199.234.camel@sgc>
	 <1157399016.4446.20.camel@wintermute.xmldesign.de>
	 <1157464940.3199.250.camel@sgc>
	 <1157466795.20129.1.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:37:52 -0400
Message-Id: <1157467072.3199.255.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 16:33 +0200, Erich Schubert wrote:
> Hello Christopher,
> > this.  I have added the appropriate rules and fc entries.  However, I
> > don't see any options for usbmodules that would have it write to
> > usb.ids, so why does your patch have this access?
> 
> It's not supposed to, there is a script called update-usbids which does
> that. I assume it's being called from package postinsts, and should run
> with these permissions fine. But I havn't tested that. But usually the
> package managers can write regular files, can't they?

Yes, but what I'm referring to is:

+allow usbmodules_t usbmodules_var_lib_t:dir rw_dir_perms;
+allow usbmodules_t usbmodules_var_lib_t:file create_file_perms;

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
