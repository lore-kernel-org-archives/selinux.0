Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JCGLRb009482
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 08:16:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4JCGIAR001923
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:16:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i4JCGIHn001920 for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 12:16:18 GMT
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040519100822.GA31914@colombo.cip.ifi.lmu.de>
References: <20040519074242.GK7348@lkcl.net>
	 <20040519100822.GA31914@colombo.cip.ifi.lmu.de>
Content-Type: text/plain
Message-Id: <1084968971.30873.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 19 May 2004 08:16:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-05-19 at 06:08, Thomas Bleher wrote:
> I don't think that even this is required. It should work without
> patching, just using pam_selinux.so.

At least for gdm, we weren't able to use pam_selinux, because the
pam_open_session is called from the wrong process to set up the exec
context for the desired child.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
