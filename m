Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j13FpW53000978
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 10:51:33 -0500 (EST)
Received: from mx-5.zoominternet.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j13FpZf1005407
	for <selinux@tycho.nsa.gov>; Thu, 3 Feb 2005 15:51:35 GMT
Subject: Re: FC3, Apache and CGI web app
From: Scott Cain <cain@cshl.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <420244C4.8060509@redhat.com>
References: <1107378461.3351.62.camel@localhost.localdomain>
	 <42016640.3050807@redhat.com>
	 <1107405040.3391.17.camel@localhost.localdomain>
	 <42023A75.7050501@redhat.com>
	 <1107444327.3307.13.camel@localhost.localdomain>
	 <420244C4.8060509@redhat.com>
Content-Type: text/plain
Date: Thu, 03 Feb 2005 10:48:48 -0500
Message-Id: <1107445729.3307.28.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-03 at 10:35 -0500, Daniel J Walsh wrote:
> No but you could just change the context of tmp to httpd_sys_content_t
> 
> chcon -R httpd_sys_content_t /var/www/html/gbrowse/tmp
> 
> Which should fix it. 
> 


[scott@localhost gbrowse]$ sudo chcon -R httpd_sys_content_t /var/www/html/gbrowse/tmp
/usr/bin/chcon: invalid context: httpd_sys_content_t

Is there a typo in there somewhere?  Also, is this documented somewhere?
`man` and `info` are particularly terse and not very helpful.

Thanks,
Scott


-- 
------------------------------------------------------------------------
Scott Cain, Ph. D.                                         cain@cshl.org
GMOD Coordinator (http://www.gmod.org/)                     216-392-3087
Cold Spring Harbor Laboratory


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
