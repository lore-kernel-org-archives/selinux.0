Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h93DjAsJ009875
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 09:45:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h93DhKZt017700
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 13:43:20 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h93DhKM3017697
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2003 13:43:20 GMT
Subject: Re: Updated Release
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: Howard Holm <hdholm@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <20031003064750.GA4555@markus.schuldei.org>
References: <1065114741.27477.3042.camel@moss-huskies>
	 <20031003064750.GA4555@markus.schuldei.org>
Content-Type: text/plain
Message-Id: <1065188703.4080.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Oct 2003 09:45:03 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-10-03 at 02:47, Andreas Schuldei wrote:
> * Howard Holm (hdholm@epoch.ncsc.mil) [031002 21:37]:
> > The
> > star package has been added.
> 
> is that the tar which was enhanced for backing up selinux
> attributes?

It is not the patched tar program from the old SELinux.
Instead, it is a patched form of Joerg Schilling's star(1) archiver.  He
has incorporated the EA support into the upstream star, so we are able
to leverage that support for storing the SELinux attributes in the
archive, but there is a small SELinux-specific patch to use the SELinux
API to create extracted files immediately with their SELinux security
context (rather than having to set the security context _after_ creating
the file), since the xattr API does not support that functionality.
	
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
