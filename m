Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NCEmHa024786
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 08:14:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6NCDgFB010155
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 12:13:42 GMT
Received: from prometheus.epoch.ncsc.mil (prometheus.epoch.ncsc.mil [144.51.25.40])
	by jazzswing.ncsc.mil  with ESMTP id h6NCDgGD010152
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 12:13:42 GMT
Received: from prometheus.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6NCElxH014044
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 08:14:47 -0400
Received: (from jwcart2@localhost)
	by prometheus.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h6NCEldm014042
	for selinux@tycho.nsa.gov; Wed, 23 Jul 2003 08:14:47 -0400
Date: Tue, 22 Jul 2003 16:59:04 -0400 (EDT)
From: Dean Anderson <dean@av8.com>
To: Russell Coker <russell@coker.com.au>
cc: Tobias <CoUnt3r@gmx.net>, <SELinux@tycho.nsa.gov>
Subject: Re: hidden files and se linux?
In-Reply-To: <200307221603.29847.russell@coker.com.au>
Message-ID: <Pine.LNX.4.44.0307221650220.21542-100000@vista.av8.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is an easy hack to do this, as can be seen by examining linux kernel
module root kits.  It does not need to be "integrated" into selinux.

One thing to watch for though, is that many of the kernel module rootkits
have memory leaks. (Usually this is a clue to rooted machines) The code
from a root kit needs some serious repair, but demonstrates the general
idea.

It might be useful to have second syslogd logging SElinux events
off-machine, and to hide both SELinux and this syslogd, to create some
confusion for the cracker, and thereby insuring that you know he is there
before he knows that you know.

		--Dean

On Tue, 22 Jul 2003, Russell Coker wrote:

> On Mon, 21 Jul 2003 18:38, Tobias wrote:
> > is it possible to hide files under selinux?
>
> To do that properly requires poly-instantiated directories.  AFAIK no-one will
> do that in the near future, more important file system related things such as
> NFS file labeling have not been done yet...
>
> SE Linux allows you to deny "getattr" access (IE a stat() system call fails),
> but "ls *" will still show the existance of files.
>
> It is my understanding that LIDS allows the files to be hidden (so a readdir()
> will not show them).  But this is not fully adequate, a hostile user can
> guess at file names and try to create them, if a file creation fails and
> there are no other issues (such as lack of disk space) then you can infer the
> existance of the file name.  Polyinstantiated directories is the solution to
> this problem.
>
> I think that the consensus of opinion of people on this list is that hidden
> files without polyinstantiated directories is of little use.
>
> There has been some previous discussion of this matter, checking the list
> archives (see my web site for the link) will provide you with more
> information.
>
> --
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
