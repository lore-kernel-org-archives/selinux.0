Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OILxx6004729
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 13:21:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OIISlY005221
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 18:18:28 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h2OIIRKX005218
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 18:18:27 GMT
Message-Id: <200303241829.NAA16331@moss-shockers.ncsc.mil>
Date: Mon, 24 Mar 2003 13:29:32 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Important fix for init.te
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Russell Coker wrote:
> Is this something that can/will be fixed?  Or will it have to remain like 
> that?

It seems consistent with the base kernel/capability module processing
for reparent_to_init.  We could define a different initial SID for this
purpose, but that still wouldn't distinguish among different kernel
threads.  It isn't clear how to cleanly support such distinctions.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
