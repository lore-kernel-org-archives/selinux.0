Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4OERvRb010883
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 10:27:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4OEPSB2027682
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:25:28 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4OEPRwi027679
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 14:25:27 GMT
Subject: Re: [PATCH][RFC] Allow administrator control over per-user
	default_contexts
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Timothy <timothy@diyab.net>
Cc: Russell Coker <russell@coker.com.au>, Valdis.Kletnieks@vt.edu,
   selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   selinux-dev@tresys.com
In-Reply-To: <200405241004.07827.timothy@diyab.net>
References: <1085155374.2789.131.camel@moss-spartans.epoch.ncsc.mil>
	 <200405240612.15645.russell@coker.com.au>
	 <1085402633.26446.45.camel@moss-spartans.epoch.ncsc.mil>
	 <200405241004.07827.timothy@diyab.net>
Content-Type: text/plain
Message-Id: <1085408849.26446.98.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 24 May 2004 10:27:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-05-24 at 10:04, Timothy wrote:
> How about check for /etc/security/default_contexts.user/username and if it 
> exists, ignore $HOME/.default_contexts.  Next 
> check /etc/security/default_contexts.user/username for a valid context that 
> is allowed by policy and if it does exist, then use that.  Otherwise use the 
> system default. Then if an administrator wants to disable user set contexts 
> an not set a specific one he can just create an empty file for that username 
> in the /etc/security/default_contexts.user directory and no extra file would 
> be needed.

The logic already allows for leaving the per-user default_contexts file
empty or incomplete; it always pulls the context lists from both the
per-user default_contexts file and the system default_contets file (with
the latter given lower precedence) and omits any contexts that would be
invalid for the user or unreachable from the calling context.  But the
approach you suggest still requires the admin to at least create an
empty file for every user account simply to disable use of
$HOME/.default_contexts, which is burdensome and error-prone if the
admin simply wants to disallow all use of $HOME/.default_contexts.  I
think we want a simple mechanism for the admin to express that goal
without needing to maintain per-user files at all, even empty ones.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
