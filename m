Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98HxqrT023984
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 13:59:53 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98HxqZ2014235
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 17:59:52 GMT
Subject: Re: gentoo diff for mysqld
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: petre rodan <kaiowas@gentoo.org>, Erich Schubert <erich@debian.org>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200410071648.47636.russell@coker.com.au>
References: <41625B74.2090503@gentoo.org>
	 <1097001016.15549.4.camel@wintermute.xmldesign.de>
	 <4163CF0D.4070201@gentoo.org>  <200410071648.47636.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1097258322.13326.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 13:58:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have merged the tmp_domain and daemontools chunks into CVS.

On Thu, 2004-10-07 at 02:48, Russell Coker wrote:
> On Wed, 6 Oct 2004 20:55, petre rodan <kaiowas@gentoo.org> wrote:
> > Here is a new patch with no distro_gentoo ifdefs.
> > Also can someone please tell me when is that 'allow mysqld_t
> > sysadm_home_t:file { read getattr };' needed? I have never felt the need
> > for that rule and I'd be happy to see it go.
> 
> The start command for mysqld reads the file /root/.my.cnf , or used to at 
> least.  Has it changed?
> 
> I've merged the tmp_domain and daemontools bits into my tree.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
