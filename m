Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6FL7hHa020275
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 17:07:43 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6FL6gnJ019419
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:06:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6FL6ghr019416
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2003 21:06:42 GMT
Subject: Re: [patch] various fixes for libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Colin Walters <walters@verbum.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1058144717.4130.5.camel@columbia>
References: <1058144717.4130.5.camel@columbia>
Content-Type: text/plain
Message-Id: <1058303259.13738.813.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 15 Jul 2003 17:07:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2003-07-13 at 21:05, Colin Walters wrote:
> Attached is a patch which fixes various things in libselinux; It adds a
> bunch of consts to the context.h API, handles a missed out-of-memory
> condition, and cleans up some -Wall compile warnings.

This patch has been committed to the sourceforge CVS tree.  Also added
another const for a local variable set to a parameter to avoid a
compiler warning introduced by the const on the parameter.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
