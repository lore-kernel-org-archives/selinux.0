Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2AH5SRb020550
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 12:05:29 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2AH5R0F001259
	for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 17:05:27 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i2AH5RgZ001256 for <selinux@tycho.nsa.gov>; Wed, 10 Mar 2004 17:05:27 GMT
Subject: Re: blocking security xattr changes when policy is not loaded
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040310155916.GA11097@suse.de>
References: <200403092329.42958.arekm@pld-linux.org>
	 <1078923038.4029.37.camel@moss-spartans.epoch.ncsc.mil>
	 <20040310155916.GA11097@suse.de>
Content-Type: text/plain
Message-Id: <1078938321.4029.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 10 Mar 2004 12:05:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-10 at 10:59, Thorsten Kukuk wrote:
> But if you add this check, the security attributes will be missing
> for the new file. I don't think that this is the expected behavior.

If you run with selinux=0 (or with SELinux enabled but no policy), then
you have to assume that some file labels are going to be wrong when you
next boot SELinux with a policy.  Even if certain programs preserve the
labels on certain files, there are going to be some files (e.g.
/etc/mtab) that are no longer going to be typed correctly.  And the
trustworthiness of any of the labels is suspect, obviously, as any root
process may have tampered with them.  Hence, you need to relabel your
filesystem anyway after running with selinux=0 or no policy in order to
get it back to a known safe state.  

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
