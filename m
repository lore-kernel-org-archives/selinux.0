Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hADIg4Sf020523
	for <selinux@tycho.nsa.gov>; Thu, 13 Nov 2003 13:42:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hADIfbBb014464
	for <selinux@tycho.nsa.gov>; Thu, 13 Nov 2003 18:41:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id hADIfa4o014461
	for <selinux@tycho.nsa.gov>; Thu, 13 Nov 2003 18:41:36 GMT
Subject: Re: selinux directory
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carlos =?ISO-8859-1?Q?An=EDsio?= Monteiro <monteiro@ipen.br>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <3FB3CC14.1020004@ipen.br>
References: <3FB3CC14.1020004@ipen.br>
Content-Type: text/plain; charset=UTF-8
Message-Id: <1068748920.15086.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 Nov 2003 13:42:00 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-11-13 at 13:23, Carlos Anísio Monteiro wrote:
> Hi.
> 
> Please, anyone could say me what need of the files in the /selinux 
> directory.
> Files: access, context, create, load, relabel and user.
> The enforce file is to enforce mode.

They are all described in the selinux-doc README.  libselinux provides
functions to access them.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
