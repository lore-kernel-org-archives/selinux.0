Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4CImUI4004211
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2003 14:48:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4CImU7R025147
	for <selinux@tycho.nsa.gov>; Mon, 12 May 2003 18:48:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h4CImTKP025144 for <selinux@tycho.nsa.gov>; Mon, 12 May 2003 18:48:29 GMT
Subject: Re: kernel patches
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris Babcock <cbabcock@luthresearch.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <54829.63.108.92.34.1052760393.squirrel@mxlx1.surveysavvy.com>
References: <54829.63.108.92.34.1052760393.squirrel@mxlx1.surveysavvy.com>
Content-Type: text/plain
Message-Id: <1052765305.4729.253.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 12 May 2003 14:48:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-05-12 at 13:26, Chris Babcock wrote:
> Also, I have seen some vocal opposition to the current implementation of
> LSM in 2.5 on lklm.  Has there been any resolution, and where does this
> put selinux on 2.5?

LSM is still in mainline 2.5, recently submitted patches that add
support for the use of extended attributes by security modules have been
merged, and a recently submitted patch that adds support for a process
attribute API has been queued up for merging.  RFCs on the SELinux
module have also been posted to lkml, and we plan on submitting SELinux
for merging once the process attribute API patch and the security
initcall patch make their way into mainline.  The most significant
objection to LSM has appeared to be the lack of any real security
modules in mainline that use it; this should be addressed by the merging
of SELinux.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
