Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0LGouRb002620
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 11:50:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0LGnixr003570
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 16:49:44 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0LGnhYc003567
	for <selinux@tycho.nsa.gov>; Wed, 21 Jan 2004 16:49:44 GMT
Subject: Re: Debian and 2.6 selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Chris Babcock <cbabcock@luthresearch.com>, selinux@tycho.nsa.gov
In-Reply-To: <200401212131.10696.russell@coker.com.au>
References: <1988.68.6.187.64.1074664098.squirrel@mxlx1.surveysavvy.com>
	 <200401211935.42235.russell@coker.com.au>
	 <3302.68.6.187.64.1074680162.squirrel@mxlx1.surveysavvy.com>
	 <200401212131.10696.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1074703839.9767.142.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 21 Jan 2004 11:50:39 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-01-21 at 05:31, Russell Coker wrote:
> The combination that's likely to work best in most ways at the moment is 
> Fedora with Arjan's kernel and Dan's packages.

Actually, Arjan dropped the SELinux diffs from his kernel RPM a while
back; the rawhide kernel is the one to use.  Or 2.6.2-rc1, which
includes all of the SELinux diffs.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
