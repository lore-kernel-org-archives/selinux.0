Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8DLRcLa003604
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 17:27:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8DLRbn0005553
	for <selinux@tycho.nsa.gov>; Sat, 13 Sep 2003 21:27:38 GMT
Date: Sat, 13 Sep 2003 22:27:27 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Debian package: how to relabel
Message-ID: <20030913212727.GA28358@vnl.com>
References: <20030913160546.GD16830@vnl.com> <20030913163259.GE16830@vnl.com> <20030913164219.GF16830@vnl.com> <200309140326.59834.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309140326.59834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 14, 2003 at 03:26:59AM +1000, Russell Coker wrote:
> I guess there are problems with the dependencies for Debian packages.  
> Reinstall is not necessary, just install policycoreutils (or is that what you 
> meant?).

No, a reinstall. There was a policycoreutils.list and etc already in
the system and a setfiles.8 man page. I did a

	apt-get install --reinstall policycoreutils

and just forced it. No idea why it gave me only a partial 
install.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
