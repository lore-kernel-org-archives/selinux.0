Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAE9QLMA000125
	for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2005 04:26:21 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAE9Ibff007861
	for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2005 09:18:37 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 14 Nov 2005 10:19:09 +0100
Date: Mon, 14 Nov 2005 10:19:08 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Small patch for runuser: disallow suid operation
Message-Id: <20051114091908.GD7828@thorium.jmh.mhn.de>
References: <20051019201719.GA9176@thorium.jmh.mhn.de> <200511122102.18638.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200511122102.18638.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

* Russell Coker <russell@coker.com.au> [2005-11-12 11:12]:
> On Thursday 20 October 2005 06:17, Thomas Bleher 
> <bleher@informatik.uni-muenchen.de> wrote:
> > I think the following small patch should be applied to the coreutils
> > package, on top of the existing patch:
> 
> Sounds reasonable to me.  Have you filed a bugzilla?

Just filed as
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173113

> > --- runuser.c.orig	2005-10-19 22:01:57.000000000 +0200
> > +++ runuser.c	2005-10-19 22:00:53.000000000 +0200
> > @@ -19,6 +19,8 @@
> >  	return PAM_SUCCESS;
> >  }
> >  int pam_open_session(pam_handle_t *pamh, int flags){
> > +	if (getuid() != geteuid()) /* safety net: deny operation if we are suid
> > by accident */ +		error(EXIT_FAIL, 1, "runuser may not be setuid");
> >  	return PAM_SUCCESS;
> >  }
> >  int pam_close_session(pam_handle_t *pamh, int flags){
> 

-- 
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
