Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7K3OrrT001150
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 23:24:53 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7K3OqEE015766
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 03:24:52 GMT
Subject: conflict between libselinux and libsepol
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
References: <1092942083.1721.101.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 19 Aug 2004 23:25:42 -0400
Message-Id: <1092972342.29540.35.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-19 at 15:01 -0400, Stephen Smalley wrote:

> The core checkpolicy logic has been moved into libsepol, a library for binary
> policy manipulation.  

There appears to be a conflict between the headers from this and
libselinux, so an application can't presently include both (I am working
on a patch to setfiles which needs this).  Specifically, "struct
av_decision" is defined in both selinux/selinux.h and
sepol/flask_types.h.

Perhaps libselinux should be modified to depend on libsepol, and include
the definition from flask_types.h in selinux.h?





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
