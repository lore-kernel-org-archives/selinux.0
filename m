Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8DKUBLa003384
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 16:30:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8DKSWLY024651
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 20:28:32 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h8DKSWsG024562
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 20:28:32 GMT
Subject: Re: Debian package: how to relabel
From: Colin Walters <walters@verbum.org>
To: Dale Amon <amon@vnl.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Russell Coker <russell@coker.com.au>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <20030913160546.GD16830@vnl.com>
References: <20030913160546.GD16830@vnl.com>
Content-Type: text/plain
Message-Id: <1063484919.324.0.camel@columbia>
Mime-Version: 1.0
Date: Sat, 13 Sep 2003 16:28:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-09-13 at 12:05, Dale Amon wrote:
> Question for either one of you. How do I do the equiv
> of a make relabel with the debian package install? I
> have a man page for setfiles but can't seem to find
> the command itself...

You can relabel an individual package like this:

/etc/dpkg/postinst.d/selinux packagename


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
