Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9OLBjWt017286
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 17:11:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9OLBWIS006464
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 21:11:32 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9OLBWDc006461
	for <selinux@tycho.nsa.gov>; Fri, 24 Oct 2003 21:11:32 GMT
Subject: Re: [PATCH] libselinux-2
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031023213354.GA23487@wavehammer.waldi.eu.org>
References: <20031023213354.GA23487@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1067029903.6209.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 24 Oct 2003 17:11:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-10-23 at 17:33, Bastian Blank wrote:
> hi folks
> 
> this patch fixes following problems:
> - mark some attributes as unused
> - signed vs. unsigned
> - add -W -Werror to CFLAGS
> files: utils/*

Merged, except for the CFLAGS change.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
