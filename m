Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4DHtaRb006135
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 13:55:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4DHrERA021240
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 17:53:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i4DHrDjN021237
	for <selinux@tycho.nsa.gov>; Thu, 13 May 2004 17:53:13 GMT
Subject: Re: Linux 2.6.6-rc3-mm2 and SELinux support of stacked modules
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Valdis.Kletnieks@vt.edu, Joshua Brindle <jbrindle@snu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
References: <200405100238.i4A2cDRW027971@turing-police.cc.vt.edu>
Content-Type: text/plain
Message-Id: <1084470920.14586.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 13 May 2004 13:55:20 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-05-09 at 22:38, Valdis.Kletnieks@vt.edu wrote:
> I've attached a patch that does the secondary_ops callback for essentially
> everything used by either my already-written code, in-progress code, or the
> BSDJail module.

A couple of notes regarding your insertion of secondary_ops calls:

1) Joshua Brindle (cc'd) posted a patch to this list earlier to likewise
add secondary ops for another security module.  There were two points of
overlap:  inode_permission and file_mmap.  In the case of
inode_permission, you both inserted the secondary hook call after the
null mask test (existence test).  Are you sure that you will never want
to see such calls in a secondary module?  In the case of file_mmap,
Joshua's diff only calls the secondary module if there is a file struct,
whereas your diff always calls the secondary module.  The latter offers
greater flexibility to the secondary module, so I'm inclined to use it,
but thought I should note it as it means that the secondary module will
need to test for the null file case and act accordingly.

2) Neither the post_mountroot nor pivotroot hooks are likely to survive
long term IMHO, so I don't plan on adding them to the SELinux module.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
