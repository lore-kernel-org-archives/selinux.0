Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63IwlHa003672
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 14:58:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h63IvsnJ023416
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:57:54 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [144.51.25.14])
	by jazzswing.ncsc.mil  with ESMTP id h63Ivshr023413
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:57:54 GMT
Received: from moss-sooners.epoch.ncsc.mil (moss-sooners.epoch.ncsc.mil [127.0.0.1])
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63Iwjn3031937
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 14:58:45 -0400
Received: (from hdholm@localhost)
	by moss-sooners.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id h63Iwjdx031935
	for selinux@tycho.nsa.gov; Thu, 3 Jul 2003 14:58:45 -0400
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63IueHa003656
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 14:56:41 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h63IudH5026796
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:56:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h63IudRX026793 for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 18:56:39 GMT
Received: from moss-huskers.epoch.ncsc.mil (moss-huskers [144.51.25.140])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h63IudoH018923
	for <selinux@tycho.nsa.gov>; Thu, 3 Jul 2003 14:56:39 -0400 (EDT)
Subject: [Fwd: [PATCH] Add SELinux module to 2.5.74-bk1]
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Message-Id: <1057258598.1110.1048.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 03 Jul 2003 14:56:38 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For those of you who don't subscribe to the linux-kernel mailing list,
we have submitted the "SELinux" module for inclusion in the mainline
kernel, as all of the necessary security hooks have been merged and the
SELinux API and implementation have been reworked based on prior
feedback. 

Note:  The diffstat output included in the forwarded message below
stripped the security/ prefix; I should have used diffstat -p1 instead.

-----Forwarded Message-----

From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>, Greg Kroah-Hartman <greg@kroah.com>, Chris Wright <chris@wirex.com>, James Morris <jmorris@intercode.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add SELinux module to 2.5.74-bk1
Date: 03 Jul 2003 13:44:55 -0400

The patch against 2.5.74-bk1 available from
http://www.nsa.gov/selinux/lk/2.5.74-bk1-selinux.patch.gz adds the
SELinux module to the tree and modifies the security/Makefile and
security/KConfig files for SELinux.  The last dependency for SELinux,
the vm_enough_memory security hook, was included in -bk1.  Please
consider applying.  Thanks.  diffstat output is below.  

-----

 Kconfig                                 |    2 
 Makefile                                |    6 
 selinux/Kconfig                         |   34 
 selinux/Makefile                        |   10 
 selinux/avc.c                           | 1144 ++++++++++
 selinux/hooks.c                         | 3373 ++++++++++++++++++++++++++++++++
 selinux/include/av_inherit.h            |   37 
 selinux/include/av_perm_to_string.h     |  122 +
 selinux/include/av_permissions.h        |  550 +++++
 selinux/include/avc.h                   |  234 ++
 selinux/include/avc_ss.h                |   81 
 selinux/include/class_to_string.h       |   39 
 selinux/include/common_perm_to_string.h |   65 
 selinux/include/flask.h                 |   71 
 selinux/include/flask_types.h           |   73 
 selinux/include/initial_sid_to_string.h |   32 
 selinux/include/objsec.h                |   87 
 selinux/include/security.h              |  180 +
 selinux/selinuxfs.c                     |  592 +++++
 selinux/ss/Makefile                     |   14 
 selinux/ss/avtab.c                      |  273 ++
 selinux/ss/avtab.h                      |   82 
 selinux/ss/constraint.h                 |   62 
 selinux/ss/context.h                    |  131 +
 selinux/ss/ebitmap.c                    |  344 +++
 selinux/ss/ebitmap.h                    |   57 
 selinux/ss/global.h                     |   19 
 selinux/ss/hashtab.c                    |  310 ++
 selinux/ss/hashtab.h                    |  144 +
 selinux/ss/mls.c                        |  735 ++++++
 selinux/ss/mls.h                        |  106 +
 selinux/ss/mls_types.h                  |   65 
 selinux/ss/policydb.c                   | 1300 ++++++++++++
 selinux/ss/policydb.h                   |  274 ++
 selinux/ss/services.c                   | 1387 +++++++++++++
 selinux/ss/services.h                   |   23 
 selinux/ss/sidtab.c                     |  333 +++
 selinux/ss/sidtab.h                     |   71 
 selinux/ss/symtab.c                     |   48 
 selinux/ss/symtab.h                     |   28 
 40 files changed, 12538 insertions(+)

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
