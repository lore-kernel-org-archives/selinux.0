Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8HBVIi006253
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 12:11:31 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8H9sTx029785
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 17:09:54 GMT
Received: from [10.1.13.32] (twoface.columbia.tresys.com [10.1.13.32])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id iB8HBY7K014219
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 12:11:34 -0500
Message-ID: <41B73620.6050905@tresys.com>
Date: Wed, 08 Dec 2004 12:13:04 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: getfilecon() and friends in libselinux
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Some applications in setools, namely findcon, replcon and indexcon walk 
the filesystem and get the file context off files. Previously it was 
fairly known what filesystems supported labeling so they were defined 
during the build process but now that other filesystems (reiser, jfs and 
tmpfs) support labeling but aren't necessarilly widespread we can't 
reliably define the supported filesystems during the build process and 
expect it to work across systems.

The idea is to iterate the filesystem mount points and do a getfilecon() 
or similar on a file in it, then examine the error code returned to 
decide if the filesystem supports xattr and also supports the security 
namespace. Is this a stable API to rely on for this? Will the error 
codes remain stable?

Further, if there is ever support for contexts via psids or something 
that isn't xattr will getfilecon() also be a supported method for 
accessing those?

Joshua Brindle
Tresys Technology

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
