Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38H9dRb019067
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 13:09:40 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i38H7dUZ004174
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:07:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i38H7dmT004170
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:07:39 GMT
Subject: Re: Policy backward compatibility
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis.Kletnieks@vt.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200404081704.i38H4ncM017181@turing-police.cc.vt.edu>
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
	 <200404081704.i38H4ncM017181@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1081444172.6379.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 13:09:32 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-08 at 13:04, Valdis.Kletnieks@vt.edu wrote:
> What would be the upgrade path when installing a new kernel?  Would there be an
> option for the policy tools similar to the current mkinitrd, that allows you to
> specify the kernel version to use (so you can build an initrd for the kernel
> you're about to try to boot)?

Yes, I think so.  Might be a front-end wrapper for checkpolicy that
calls the right checkpolicy-{kernelrelease} binary to generate the
policy for that kernel release.

> What would the scheme be if you had to for some reason boot an older kernel
> (for instance, having to drop back to 2.6.5-mm1 because -mm2 is b0rked for
> something)?

If you include the kernel release in the policy pathname (e.g.
/etc/security/selinux/`uname -r`/policy), as with kernel modules
(/lib/modules/`uname -r`), then the old policy should still be there and
should be used by the older kernel if you reboot it.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
