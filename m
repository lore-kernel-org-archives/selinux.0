Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1PH4oRb001127
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 12:04:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1PH4nQQ003406
	for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 17:04:49 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1PH4nP0003403 for <selinux@tycho.nsa.gov>; Wed, 25 Feb 2004 17:04:49 GMT
Subject: Re: Suggested change to setfiles interface.
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <403CBDC4.30100@redhat.com>
References: <403CBDC4.30100@redhat.com>
Content-Type: text/plain
Message-Id: <1077728683.22658.171.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 25 Feb 2004 12:04:43 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-02-25 at 10:22, Daniel J Walsh wrote:
> I find it curios that the setfiles interface works in recursive mode by 
> default.  As we have been trying to get the install to handle labeling 
> the file system, several files had to be labeled in the installer 
> including /.  The only way to do this was to pipe
> echo / | setfiles -s file_context

Further thought:  Given that we recently added a matchpathcon() function
to libselinux, you could easily turn restorecon into a C program that
uses matchpathcon() and lsetfilecon() on its arguments, rather than
using setfiles at all.  Would that address your need?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
