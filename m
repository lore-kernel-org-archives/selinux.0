Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8DGgTLa002534
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 12:42:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8DGgRn0026400
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 16:42:28 GMT
Date: Sat, 13 Sep 2003 17:42:19 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Debian package: how to relabel
Message-ID: <20030913164219.GF16830@vnl.com>
References: <20030913160546.GD16830@vnl.com> <200309140222.39823.russell@coker.com.au> <20030913163259.GE16830@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030913163259.GE16830@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Sep 13, 2003 at 05:32:59PM +0100, Dale Amon wrote:
> On Sun, Sep 14, 2003 at 02:22:39AM +1000, Russell Coker wrote:
> > make -C /etc/selinux relabel
> 
> Close but no cigar. I'm missing /usr/sbin/setfiles.
> What package should have installed it? I've got
> a man page for it but no binary.

In answer to my own question, it appears to be part of the
policycoreutils package, but is not installed for some
reason... I think a forced reinstall is in order!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
