Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9FFFrrT006565
	for <selinux@tycho.nsa.gov>; Fri, 15 Oct 2004 11:15:53 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9FFFrxT005847
	for <selinux@tycho.nsa.gov>; Fri, 15 Oct 2004 15:15:53 GMT
Subject: Re: Asterisk on SELinux
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: Erich Schubert <erich@debian.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200410151827.05984.russell@coker.com.au>
References: <1097499317.16758.40.camel@wintermute.xmldesign.de>
	 <200410151827.05984.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1097853280.3472.7.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 15 Oct 2004 11:14:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Fri, 2004-10-15 at 04:27, Russell Coker wrote:
> On Mon, 11 Oct 2004 22:55, Erich Schubert <erich@debian.org> wrote:
> > # the debian standard installation hasn't got all dirs needed
> > allow asterisk_t asterisk_spool_t:dir create_dir_perms;
> 
> This is what create_dir_file() is for.
> 
> > # some helper apps are probably there
> > allow asterisk_t { bin_t sbin_t }:dir search;
> 
> There seems little point in allowing directory search without allowing it to 
> do anything under that directory.  This needs more investigation.
> 
> > Unfortunately, while asterisk does now start (as root only, not as
> > non-root-user... not sure why, but i think the user/group setup isn't
> > right yet... how do i change a unix users primary group in selinux?)
> > my test SIP call didn't get properly accepted.
> 
> UID/GID stuff works the same way in SE Linux as in regular Linux, except that 
> sometimes what you want is not permitted.  ;)
> 
> vipw/vigr do the usual stuff.
> 
> I've attached a patch for asterisk which includes the parts of your policy 
> changes that I think are ready for inclusion.  I don't think that the sbin_t 
> part is complete and therefore it shouldn't go in yet.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
