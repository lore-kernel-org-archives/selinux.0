Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA00043
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 15:36:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA26967
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:36:00 GMT
Received: from web40015.mail.yahoo.com (web40015.mail.yahoo.com [66.218.78.55])
	by jazzswing.ncsc.mil  with SMTP id TAA26957
	for <selinux@tycho.nsa.gov>; Thu, 27 Jun 2002 19:35:59 GMT
Message-ID: <20020627193625.27977.qmail@web40015.mail.yahoo.com>
Date: Thu, 27 Jun 2002 12:36:25 -0700 (PDT)
From: Brad Chapman <jabiru_croc@yahoo.com>
Subject: Re: Major reduction in errors
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20020627184720.E0872694@lyta.coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mr. Coker,

--- Russell Coker <russell@coker.com.au> wrote: 
> avc:  denied  { read } for  pid=12 exe=/sbin/devfsd path=/.devfsd dev=00:07 
> ino=2 scontext=system_u:system_r:devfsd_t tcontext=system_u:object_r:devfs_t 
> tclass=chr_file
> 
> You need the following in the devfs_contexts file:
> devfscon /.devfsd               system_u:object_r:devfs_control_t

        This causes a syntax error when I attempt to compile the policy.

Brad




=====
Brad Chapman

Permanent e-mails: kakadu_croc@yahoo.com
		   jabiru_croc@yahoo.com
		   tanami_croc@devel.lbsd.net

__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
