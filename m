Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GDkmrT024793
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 09:46:48 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GDklsh012258
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 13:46:47 GMT
Subject: Re: hald fix
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200409162151.44819.russell@coker.com.au>
References: <200409162151.44819.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1095342276.30684.96.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 16 Sep 2004 09:44:36 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-09-16 at 07:51, Russell Coker wrote:
> The attached patch fixes a typo to make hald work with dbus and removes an 
> unnecessary can_exec_any().

Are all helpers executed by hald now labeled with hald_exec_t?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
