Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA01127
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 10:40:45 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA20113
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:39:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA20109
	for <selinux@tycho.nsa.gov>; Tue, 8 Oct 2002 14:39:04 GMT
Date: Tue, 8 Oct 2002 10:40:30 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: /proc woes
In-Reply-To: <20021008163245.A5508@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210081037410.25356-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 8 Oct 2002, Tom wrote:

> So instead of having a patch, I have a question: My /proc is file_t:
>
> dr-xr-xr-x  root     root     system_u:object_r:file_t         proc

This implies that your /proc is an empty mountpoint and is thus unused.

> Doing a chcon manually fails:
>
> # chcon system_u:object_r:proc_t /proc
> chcon: /proc: Permission denied

Why do you need to assign a different type to this empty mountpoint?  It
doesn't need to be accessed by anything.  Are you just trying to avoid
audit messages about attempts to access it?

The permission denial is due to the filesystem associate permission check
between the file type and the filesystem type.  proc_t isn't authorized to
be associated with an ordinary filesystem type like fs_t.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
