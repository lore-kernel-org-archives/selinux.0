Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3NFreI4002545
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 11:53:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3NFrPVf022593
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 15:53:25 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h3NFrP4D022590
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 15:53:25 GMT
Subject: Re: selinux programming: security_get_sids
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200304231131.52183.carsten.grohmann@raumbildsysteme.de>
References: <200304231131.52183.carsten.grohmann@raumbildsysteme.de>
Content-Type: text/plain
Message-Id: <1051113202.14761.79.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 23 Apr 2003 11:53:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-23 at 05:31, Carsten Grohmann wrote:
> Hi,
> 
> is it possible to call security_get_sids and others with nel=0? 
> Thus I could allocate the necessary memory without to check to less 
> memory and call realloc.

Yes, you can call security_get_sids with nel=0, and likewise for other
calls that return variable length data (e.g. security_sid_to_context),
in which case they will set the nel or len to the necessary value, set
errno to ENOSPC and return -1.  However, we typically allocate an
initial buffer and pass its length on the initial call, then realloc and
call again if that fails, so that in the common case, only a single call
is necessary.

Please note that the API is being significantly changed for mainline
2.5, and that SIDs are no longer exported to userspace.  The new process
attribute API (/proc/pid/attr) and  file attribute API ([gs]etxattr)
pass security contexts directly, as does the new policy API (selinuxfs).

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
