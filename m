Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9LExGWt027215
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 10:59:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9LExFIE028936
	for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:59:15 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9LExF1J028933 for <selinux@tycho.nsa.gov>; Tue, 21 Oct 2003 14:59:15 GMT
Subject: Re: init patch for loading policy
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200310220043.09925.russell@coker.com.au>
References: <200310200148.15852.russell@coker.com.au>
	 <200310211052.28494.russell@coker.com.au>
	 <1066739366.27065.39.camel@moss-spartans.epoch.ncsc.mil>
	 <200310220043.09925.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1066748352.27065.100.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 21 Oct 2003 10:59:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-21 at 10:43, Russell Coker wrote: 
> The results I have so far indicate that this approach has significant 
> problems.
> 
> Diverting /sbin/init with a shell script works better than this.

Ok, thanks for looking into it.  So what exactly is the problem with
diverting /sbin/init again?  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
