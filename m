Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2VHnqRb022896
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 12:49:52 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i2VHlvlU014711
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 17:47:57 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i2VHlvkh014708
	for <selinux@tycho.nsa.gov>; Wed, 31 Mar 2004 17:47:57 GMT
Subject: Re: Problems to compile the src.rpm packages on Red Hat Linux 9.0
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis.Kletnieks@vt.edu
Cc: "lcvleo@ig.com.br" <lcvleo@ig.com.br>, selinux@tycho.nsa.gov
In-Reply-To: <200403311625.i2VGPU5n010010@turing-police.cc.vt.edu>
References: <1080685248.6780.5.camel@linux.linuxista.eti.br>
	 <1080739324.22514.4.camel@moss-spartans.epoch.ncsc.mil>
	 <200403311625.i2VGPU5n010010@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1080755381.22514.85.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 31 Mar 2004 12:49:42 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-03-31 at 11:25, Valdis.Kletnieks@vt.edu wrote:
> Either I'm missing something, or the FC2 test2 RPMS still only speak
> the policy.15 format, no sign of .16/.17 yet.  Can somebody enlighten
> me as to whether
> 
> a) I'm dense and forgot to do <FOO>?
> b) it's already in the Fedora pipe and should arrive shortly?
> c) Punt and roll my own while I wait for the RPM to show up?

The userland support was included in FC2 test2 for policy.16, but
disabled by default since the kernel did not include the support yet. 
However, the latest kernel package from FC2 devel does include policy.16
support (since it is now in 2.6.5-rcX).  So if you install FC2 test2 and
update your kernel, then you should be able to comment out the
POLICYCOMPAT definition in the policy Makefile and build and use
policy.16.

For policy.17, you still need to build a patched kernel and checkpolicy
at present, but you should otherwise be able to use FC2 test2 as your
base.  I expect that SysVinit will get updated to search for any of the
supported policy versions, but that is to provide compatibility for
people using older policies.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
