Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8EBmHLa006465
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 07:48:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8EBmFn0028305
	for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2003 11:48:16 GMT
Date: Sun, 14 Sep 2003 12:47:44 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Colin Walters <walters@verbum.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Using Colin's Debian archive
Message-ID: <20030914114744.GA17185@vnl.com>
References: <20030913160546.GD16830@vnl.com> <20030913163259.GE16830@vnl.com> <20030913164219.GF16830@vnl.com> <200309140326.59834.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200309140326.59834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If you are trying to work with the experimental 
debian packages for selinux available from Colin's
site, you can fit it into your normal update 
procedures.

Add this line to the top of your /etc/apt/sources.list file:

deb http://web.verbum.org/debian experimental/

Add this to your /etc/apt/preferences file, or if
you haven't got one, make this the whole of it:

Package: *
Pin: release l=walters
Pin-Priority: 1100

This will also work with dselect if you are using
apt as the update method.

-- 
------------------------------------------------------
       IN MY NAME:            Dale Amon, CEO/MD
  No Mushroom clouds over     Islandone Society
    London and New York.      www.islandone.org
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
