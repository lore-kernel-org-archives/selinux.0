Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4MJNwI4023404
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 15:23:58 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4MJNvtV000234
	for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 19:23:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h4MJNual000229 for <selinux@tycho.nsa.gov>; Thu, 22 May 2003 19:23:56 GMT
Subject: Re: about security contexts for objects
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Giorgio Zanin <selinux_list@yahoo.it>, selinux@tycho.nsa.gov
In-Reply-To: <200305230235.50512.russell@coker.com.au>
References: <3ECCDA52.5010802@yahoo.it>
	 <200305230235.50512.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1053631371.1032.43.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 May 2003 15:22:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-05-22 at 12:35, Russell Coker wrote:
> > Is it possible to define O(c) (c=a given object class different from
> > "process") just looking at some configuration rules?
> > If I look at the file context configuration, I can get some elements of
> > O(file) and O(dir), but I think I can't catch all of them.
> 
> Look at the policy for all types that have the attribute file_type, that 
> should catch all of them.

Not all of them.  The file_type attribute is limited to files associated
with conventional (disk-based) filesystems and is used in allow rules
permitting the association of such types with those filesystems.  It
doesn't cover types associated with pseudo filesystems.

Giorgio's suggestion of determining the set of possible file types by
inspection of the set of allow rules where a file class is used seems
reasonable.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
