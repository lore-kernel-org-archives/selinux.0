Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13Fx653001033
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 10:59:07 -0500 (EST)
Subject: Re: FC3, Apache and CGI web app
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Scott Cain <cain@cshl.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1107445729.3307.28.camel@localhost.localdomain>
References: <1107378461.3351.62.camel@localhost.localdomain>
	 <42016640.3050807@redhat.com>
	 <1107405040.3391.17.camel@localhost.localdomain>
	 <42023A75.7050501@redhat.com>
	 <1107444327.3307.13.camel@localhost.localdomain>
	 <420244C4.8060509@redhat.com>
	 <1107445729.3307.28.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1107445953.5324.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 03 Feb 2005 10:52:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-03 at 10:48, Scott Cain wrote:
> [scott@localhost gbrowse]$ sudo chcon -R httpd_sys_content_t /var/www/html/gbrowse/tmp
> /usr/bin/chcon: invalid context: httpd_sys_content_t
> 
> Is there a typo in there somewhere?  Also, is this documented somewhere?
> `man` and `info` are particularly terse and not very helpful.

You need to specify -t if you are only specifying the type (vs. the
entire security context), e.g.
	chcon -R -t httpd_sys_context_t ...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
