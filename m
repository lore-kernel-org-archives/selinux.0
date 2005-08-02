Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j72FtlgA027695
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 11:55:47 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j72FmBcP028055
	for <selinux@tycho.nsa.gov>; Tue, 2 Aug 2005 15:48:16 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 11:49:51 -0400
Message-Id: <1122997791.26992.27.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
Sourceforge from http://serefpolicy.sourceforge.net.  The change log
follows at the bottom of the email.  In particular, the policy now works
as a targeted policy so that people can begin testing it on
non-production machines.  There is a guide to switching a Fedora Core 4
system over to a targeted Reference Policy on Sourceforge
(http://serefpolicy.sourceforge.net/index.php?page=switch).

Again, for those that are interesting in contributing, right now the
best help would be to convert existing policies over to reference
policy; there is a list of modules on the status page on Sourceforge.
We are using the NSA example policy 1.23.2 as a baseline for the
policies (also available on the download page), and we ask that these
policies are used when converting modules.  After all of the policies
are converted over, then we will update reference policy to the current
NSA CVS policy.

20050802 (2 Aug 2005)
        * Fix comparison bug in fc_sort.
        * Fix handling of ordered and unordered HTML lists.
        * Corenetwork now supports multiple network interfaces having the
          same type.
        * Doc tool now creates pages for global Booleans and global tunables.
        * Doc tool now links directly to the interface/template in the
          module page when it is selected in the interface/template index.
        * Added support for layer summaries.
        * Added policies:
                ipsec
                nscd
                pcmcia
                raid

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
