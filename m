Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA23932
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 11:00:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA01688
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 14:59:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA01682
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 14:59:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Mark =?iso-8859-1?q?M=FCller?= <trusted@web.de>, selinux@tycho.nsa.gov
Subject: Re: Direct logins (via local and ssh) as httpd_admin_r?
Date: Thu, 29 Aug 2002 17:00:30 +0200
References: <200208290944.g7T9ikX09394@mailgate5.cinetic.de> <20020829101253.AAF656D11@lyta.coker.com.au>
In-Reply-To: <20020829101253.AAF656D11@lyta.coker.com.au>
MIME-Version: 1.0
Message-Id: <20020829150031.4B2602EF0@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Aug 2002 12:12, Russell Coker wrote:
> Also httpd_admin_r is not permitted to have domain newrole_t.
>
> I think that httpadm.te is a bad idea, it was written long before I solved
> the problems of multiple user domains which allow this to be solved in a
> much better fashion.  I suggest replacing the contents of httpadm.te with
> something like the following:
> full_user_role(httpd_admin)
> allow system_r httpd_admin_r;
> allow sysadm_r httpd_admin_r;
> allow user_r httpd_admin_r;
> Then followed by appropriate allow lines for httpd_config_t etc.
> Or you could put the above in the httpd_admin_domain() macro.

I've been thinking about this some more.  I think that we need some way of 
handling such user-administration of servers.  This requires some sort of 
run_init program for the service that starts from the user domain.

Also there's the root issue again.  To have the user be able to fully control 
the server they need to be able to stop and start it which usually requires 
root access.  Having full configuration control over a program that is 
started as root means effectively having root access, so they need to be in a 
domain without SETUID/SETGID/DAC_OVERRIDE capabilities, or which is fully 
isolated from other domains by SE Linux controls.  Also of course the server 
will need to be well isolated from the other users...  This means that for 
example we need a separate type for ~/public_html and ~/Maildir so that the 
daemon (and the person controlling it) can't access anything outside of what 
they work on.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
