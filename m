Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10198
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 10:53:51 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA05258
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 15:53:13 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA05254
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 15:53:12 GMT
Date: Fri, 18 Jan 2002 10:53:25 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: ext3 file system
In-Reply-To: <1011303902.5928.2.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0201181023090.3743-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 17 Jan 2002, Justin Smith wrote:

> When trying to label files with the setfiles utilities, the process
> crashes when they encounter the .journal files. These are user-visible,
> but are not regular files (they are immutable in the sense that even
> root cannot change them in any way). The setfiles utilities issue a
> warning that they cannot write to .journal and quit.
>
> Any ideas?
>
> Perhaps there should be some way of exempting the .journal files from
> the labelling process. It is unfortunate that they are visible to users
> (since users cannot actually use them for anything).





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
