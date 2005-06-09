Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j59JD4gA013283
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 15:13:04 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j59J5apU024901
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 19:05:37 GMT
Date: Thu, 9 Jun 2005 20:13:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Manoj Srivastava <manoj.srivastava@stdc.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Labeling confusion with apt-get/dpkg
Message-ID: <20050609191351.GL8525@lkcl.net>
References: <20050603121834.73852.qmail@web33206.mail.mud.yahoo.com> <20050603131809.GI8365@lkcl.net> <87br6gs9db.fsf@glaurung.internal.golden-gryphon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87br6gs9db.fsf@glaurung.internal.golden-gryphon.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 08, 2005 at 06:43:12PM -0500, Manoj Srivastava wrote:
> On Fri, 3 Jun 2005 14:18:09 +0100, Luke Kenneth Casson Leighton
> <lkcl@lkcl.net> said:  
> 
> >  also have you installed the _modified_ version of dpkg - the one
> >  with the /etc/dpkg/postinst.d patch?
> 
> >  ... get it while it hot, from selinux.lemuria.org/newselinux ...
> 
>         That version is unlikely to get into mainstream dpkg. There is
>  a newer version that does not create  /etc/dpkg/postinst.d
>  functionality, but uset matchpathcon and friends during unpacking to
>  set the correct initial file context, which may get better
>  reception.
 
 HOORAY.

>         http://www.glden-gryphon.com/software/security/Se-Linux.xhtml

 or: http://www.golden-gryphon.com/software/security/selinux.xhtml

 :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
