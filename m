Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA19553
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 11:16:05 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA13354
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 15:14:25 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id PAA13350
	for <selinux@tycho.nsa.gov>; Mon, 15 Apr 2002 15:14:25 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A101524344@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Howard Holm'" <hdholm@epoch.ncsc.mil>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: RE: db conflict ?
Date: Mon, 15 Apr 2002 10:16:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



On Monday, April 15, 2002 9:40 AM, Holm, Howard wrote:

> > The binary package will install the logrotate into
> > it normal (for Redhat at least) location.
> > I will have rpm do an uninstall of the
> > previous version of logrotate then install the 
> > NSA modified logrotate. The NSA modified version will 
> > insert a conflict to the normal logrotate.
> 
> I'm not sure what you mean by "have rpm do an uninstall"
> I would think that a "supercedes: logrotate" and maybe
> "provides: logrotate" would cause the replacement to be
> automatic and cause less confusion for other packages
> that might depend on logrotate than a "conflicts" would.
> 
You have a very good point. I did not think about requires:
I did not see supercedes: tag in my documentation, but I did 
see provides: tag. 

Mark
 

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
