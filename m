Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k37E9dPA002744
	for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2006 10:09:40 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k37E7pwv024583
	for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2006 14:07:51 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k37EA7Co012934
	for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2006 10:10:08 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k37EA7TB012933
	for selinux@tycho.nsa.gov; Fri, 7 Apr 2006 10:10:07 -0400
Subject: Re: rsync resetting contexts in /var/www
From: "J. Simonetti" <jsimonetti@denit.net>
To: Erich Schubert <erich@debian.org>
Cc: "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
In-Reply-To: <1144273018.19128.68.camel@wintermute.xmldesign.de>
References: <1144234218.7521.70.camel@jeroen.office.denit.net>
	 <1144259773.25790.102.camel@moss-spartans.epoch.ncsc.mil>
	 <1144273018.19128.68.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 09:58:31 +0200
Message-Id: <1144310312.7521.88.camel@jeroen.office.denit.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-04-05 at 23:36 +0200, Erich Schubert wrote:
> rsync writes data to temp files first, then renames them to their final
> name IIRC. So even if you replace files with files from a remote machine
> they'll probably get the default contexts again, just by not replacing
> the existing ones, but actually being "moved in place" of the old files.
> That is a sane behaviour, since network connections might be unstable
> and you'll have intact files all the time that way. You could maybe
> patch rsync to restore the old files label onto the new file, but I'm
> not sure if that is the right way to do it.

This sounds dead on. By creating a directory /var/www/rsync with the
correct context and running rsync with the options
'--partial-dir=/var/www/rsync/ --temp-dir=/var/www/rsync/', contexts are
now as they should be.

-- 
Met vriendelijke groeten,
 
Jeroen Simonetti
Network Manager
 
Denit Internet Services BV
Contactweg 131
1014 BJ  Amsterdam
Tel: +31 (0)20 337 2560
Fax: +31 (0)20 337 1802

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
