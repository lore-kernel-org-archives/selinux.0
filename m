Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h97FgPWt012334
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 11:42:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h97FgO7d004242
	for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:42:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h97FgNRn004239 for <selinux@tycho.nsa.gov>; Tue, 7 Oct 2003 15:42:24 GMT
Subject: Re: /selinux/enforce permissions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <200310080129.48815.russell@coker.com.au>
References: <200310080000.51892.russell@coker.com.au>
	 <1065536810.3919.221.camel@moss-spartans.epoch.ncsc.mil>
	 <200310080129.48815.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1065541333.3919.256.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 07 Oct 2003 11:42:13 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2003-10-07 at 11:29, Russell Coker wrote:
> The old SE Linux allowed the avc_enforcing() system call from any context, and 
> when the machine was not in enforcing mode avc_toggle() could be run from any 
> UID.  If we want to preserve the same functionality as old SE Linux then we 
> want mode 0644.

What functionality depended on that behavior?  Doesn't seem worth
retaining to me.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
