Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MLOjWt006269
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:24:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9MLOQIS027272
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:24:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9MLOQDc027269
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:24:26 GMT
Subject: Re: [PATCH] libselinux-1
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Bastian Blank <bastian@waldi.eu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031020211931.GA2179@wavehammer.waldi.eu.org>
References: <20031020211931.GA2179@wavehammer.waldi.eu.org>
Content-Type: text/plain
Message-Id: <1066857878.32228.167.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Oct 2003 17:24:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 17:19, Bastian Blank wrote:
> hi folks
> 
> this patch fixes following problems:
> - Build static lib with non-PIC files
> files: src/Makefile

Thanks, merged. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
