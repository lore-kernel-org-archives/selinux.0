Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA24959
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 12:10:23 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA01288
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 16:09:46 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id QAA01283
	for <selinux@tycho.nsa.gov>; Fri, 12 Jul 2002 16:09:44 GMT
Date: Fri, 12 Jul 2002 12:09:50 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: chattr
In-Reply-To: <20020712151809.F1FC8F9@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0207121200060.28541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 12 Jul 2002, Russell Coker wrote:

> Sorry I made a mistake, you can't set the i attribute, but you can set the
> attributes suSd.

True, as long as you have setattr permission to the type (at least, with
ext2 and ext3).  So I think that the real issue is that 'setattr'
permission is unnecessarily included in the rw_file_perms and rw_dir_perms
macros.  For better control, we should probably remove it from these
macros and selectively grant it as needed.  It would still remain in the
create_file_perms and create_dir_perms macros.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
