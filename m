Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17378
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 14:00:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA04882
	for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 17:58:26 GMT
Received: from hotmail.com (f51.law14.hotmail.com [64.4.21.51])
        by jazzband.ncsc.mil  with ESMTP id RAA04878 for <selinux@tycho.nsa.gov>; Wed, 28 Aug 2002 17:58:25 GMT
From: "M. H." <metalhead00@hotmail.com>
To: selinux@tycho.nsa.gov
Subject: building libsecure.a advice
Date: Wed, 28 Aug 2002 10:59:59 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F517f8CATwsi6PJyLHI0000cfaa@hotmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi everyone,

Has anyone tried to build JUST libsecure.a. Since SELinux applications need 
to be linked against it, I want to separate all necessary headers and 
libraries (seems like libsecure.a is the only one) so I can integrate them 
in my build environment (rather than relying on the default include or lib 
directories of the system.)
A problem I've run into is finding a simple way of rebuilding the library 
without installing the whole kernel. I tried to run 'make' in the 
selinux/libsecure directory but that fails since selinux/libsecure/include 
misses some necessary files (some of those are in 
lsm-2.4/security/selinux/include.) Has anyone had any luck building ONLY 
libsecure.a?

Thanks,

M.H.


_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
