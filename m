Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i86ETsrT021576
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 10:29:54 -0400 (EDT)
Received: from mail.yacme.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i86ET1vL023999
	for <selinux@tycho.nsa.gov>; Mon, 6 Sep 2004 14:29:02 GMT
Subject: Re: SuSE 9.1 SELinux
From: Stefano Zanarini <stefano.zanarini@yacme.com>
Reply-To: stefano.zanarini@yacme.com
To: selinux@tycho.nsa.gov
In-Reply-To: <1094479285.11718.31.camel@gorn.pebenito.net>
References: 
	 <OF93C1DDD2.9FAF1403-ON49256F06.00517E1E-49256F07.0007F249@jp.ibm.com>
	 <1094456102.2213.3.camel@pignoletto.cantina.yacme>
	 <1094479285.11718.31.camel@gorn.pebenito.net>
Content-Type: text/plain
Message-Id: <1094480966.3981.25.camel@zibibbo.cantina.yacme>
Mime-Version: 1.0
Date: Mon, 06 Sep 2004 16:29:26 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Il lun, 2004-09-06 alle 16:01, Chris PeBenito ha scritto:

> This same question was answered a few days ago.  There's a deadlock in
> the reiserfs code, and there's no workaround.  To quote Steve:
> 
> On Fri, 2004-09-03 at 09:53, Stephen Smalley wrote: 
> > reiserfs is known to not work with SELinux.  There is a deadlock in the
> > reiserfs xattr code when interacting with SELinux, and there is no way
> > presently for reiserfs to inform SELinux that it shouldn't try to
> > mediate access to the internal directories and files used to store the
> > xattrs.  reiserfs maintainers know about the issues, but not clear that
> > they care...

yes,I knew about official reiserfs issues,didn't know about the patched
one distribuited by suse .... 
and I've not found any reference about it in suse's documentation and on
suse's kernel patchset seems to be something specific for reiserfs and
selinux

http://ftp.belnet.be/linux/SuSe/people/mason/patches/reiserfs/2.6.5-mm6/reiserfs-selinux-02


bye


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
