Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA03839
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 12:58:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA12687
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 16:57:21 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA12683
	for <selinux@tycho.nsa.gov>; Tue, 24 Sep 2002 16:57:21 GMT
Date: Tue, 24 Sep 2002 12:58:31 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <azeredo@qmc.ufsc.br>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Problems compiling selinux in Mandrake 8.1
In-Reply-To: <1032881732.3d908644afb3b@qmc.ufsc.br>
Message-ID: <Pine.GSO.4.33.0209241252310.23277-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 24 Sep 2002 azeredo@qmc.ufsc.br wrote:

>   After giving up compiling selinux on SuSe 7.2  cause LIDS didn't work

Sorry, I don't understand.  LIDS and SELinux are two different security
modules, and you can't use them together without some kind of stacking
module.  So why would you enable LIDS?  In any event, people on the list
have previously reported using SELinux on SuSe, so that should be
possible.

> I am now trying to compile selinux on Mandrake 8.1, and got the
> following mesage:

Are you using the current release of SELinux (2002082308) from the NSA web
site (http://www.nsa.gov/selinux)?  If not, what are you using?

> security/vmlinux-obj.o: In function `selopt_init':
> security/vmlinux-obj.o(.text.init+0x1af): undefined reference to `selopt_queue_exit'
> security/vmlinux-obj.o(.text.init+0x1b4): undefined reference to `selopt_cache_exit'
> security/vmlinux-obj.o(.text.init+0x1b9): undefined reference to
> `selopt_perimtab_exit'
> security/vmlinux-obj.o(.text.init+0x1be): undefined reference to `flnetlink_exit'
> make: *** [vmlinux] Error 1

What is your .config?  In particular, is NetFilter enabled and which
SELinux options did you enable?

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
