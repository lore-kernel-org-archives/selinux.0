Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA3KIjXZ018252
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 15:18:46 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA3KIjJZ019236
	for <selinux@tycho.nsa.gov>; Wed, 3 Nov 2004 20:18:45 GMT
Subject: Re: SELinux capable UML's (bonus: root_fs creation on Debian)
From: Colin Walters <walters@verbum.org>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <87mzxysvi1.fsf@glaurung.internal.golden-gryphon.com>
References: <87mzxysvi1.fsf@glaurung.internal.golden-gryphon.com>
Content-Type: text/plain
Date: Wed, 03 Nov 2004 15:18:46 -0500
Message-Id: <1099513127.3861.12.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-03 at 11:16 -0600, Manoj Srivastava wrote:

> 	I hope this document shall be useful. I find that this is
>  useful for running services on an otherwise insecure box, since in a
>  number of real world situations, a machine can not be run in
>  enforcing mode, possibly because it needs to run applications and
>  services for which MAC policy has not yet been written.

There is the approach of simply marking the programs as
unconfined_exec_t until policy is written.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
