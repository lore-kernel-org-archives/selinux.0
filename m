Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA24819
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 17:40:43 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA19037
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 22:38:35 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id WAA19033
	for <selinux@tycho.nsa.gov>; Wed, 20 Nov 2002 22:38:33 GMT
Date: Thu, 21 Nov 2002 09:43:20 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: conflicting header files
Message-ID: <20021120224320.GA17578@snoopy.apana.org.au>
References: <200211201304.IAA16966@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200211201304.IAA16966@moss-shockers.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Nov 20, 2002 at 08:04:26AM -0500, Stephen D. Smalley wrote:
> 
> > In lsm-2.4/security/selinux/include/linux/flask/security.h, it has:
> 
> These are the internal kernel interfaces to the security server.
> Application code shouldn't be including this file.

Thats what I thought.

However, when compiling checkpolicy,
lsm-2.4/security/selinux/include/linux/flask/ss/global.h is included
(command line parameter), which also includes linux/flask/security.h,

Is checkpolicy considered a special case?
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
