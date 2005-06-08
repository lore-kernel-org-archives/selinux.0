Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j58NpagA006898
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 19:51:36 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j58NiFMV012977
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 23:44:15 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.4/8.13.4/Debian-3) with ESMTP id j58NhDYM030673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 18:43:13 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Labeling confusion with apt-get/dpkg
References: <20050603121834.73852.qmail@web33206.mail.mud.yahoo.com>
	<20050603131809.GI8365@lkcl.net>
Date: Wed, 08 Jun 2005 18:43:12 -0500
In-Reply-To: <20050603131809.GI8365@lkcl.net> (Luke Kenneth Casson Leighton's
	message of "Fri, 3 Jun 2005 14:18:09 +0100")
Message-ID: <87br6gs9db.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 Jun 2005 14:18:09 +0100, Luke Kenneth Casson Leighton
<lkcl@lkcl.net> said:  

>  also have you installed the _modified_ version of dpkg - the one
>  with the /etc/dpkg/postinst.d patch?

>  ... get it while it hot, from selinux.lemuria.org/newselinux ...

        That version is unlikely to get into mainstream dpkg. There is
 a newer version that does not create  /etc/dpkg/postinst.d
 functionality, but uset matchpathcon and friends during unpacking to
 set the correct initial file context, which may get better
 reception.

        http://www.glden-gryphon.com/software/security/Se-Linux.xhtml
 for details.

        manoj
-- 
We are what we pretend to be. Kurt Vonnegut, JR
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
