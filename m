Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KGWuRb020461
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 12:32:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4KGUQB2008693
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:30:26 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4KGUQwi008690
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 16:30:26 GMT
Subject: Re: FAM uses seteuid and setegid
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <rcoker@redhat.com>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040520162445.GM8810@lkcl.net>
References: <20040520121538.GA8810@lkcl.net>
	 <200405210114.53119.rcoker@redhat.com>  <20040520162445.GM8810@lkcl.net>
Content-Type: text/plain
Message-Id: <1085070739.521.201.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 20 May 2004 12:32:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-05-20 at 12:24, Luke Kenneth Casson Leighton wrote:
> > Famd is badly designed for security.  There has been talk of replacing that 
> > functionality with other code, the general concept is that for a local FAM 
> > you just have the first process to call it fork off a child process which 
> > executes a famd in the user context, then other processes with the same UID 
> > can connect to the same famd.
>  
>  that's much more sensible.

Yes, but unfortunately it doesn't help with remote FAM usage, which
isn't uncommon.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
