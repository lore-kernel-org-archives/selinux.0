Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10109
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 10:43:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA04704
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 15:43:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id PAA04700
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 15:43:17 GMT
Date: Fri, 18 Jan 2002 10:43:21 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: ext3 file system
In-Reply-To: <1011303902.5928.2.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0201181035160.3743-100000@raven>
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

First, the journals aren't visible to users on my RH7.2 systems running
the SELinux kernel, so I'm not sure why they are visible on your system.

Second, setfiles should not need to write to .journal.  However, it does
need to be able to set the label of .journal.  If you are running setfiles
on a non-SELinux kernel, setfiles directly updates the persistent label
mapping files in /...security.  If you are running setfiles on a SELinux
kernel, setfiles uses the lchsid system call to set the label for each
file.  At present, lchsid fails on immutable files, just like chmod and
chown.  However, there isn't any strong reason to prevent relabeling of
immutable files, so we could remove this restriction from the [l|f|]chsid
calls in the SELinux module.

Third, you can exempt files from the labeling process by using the
<<none>> specification in the file_contexts configuration.  So, to exempt
.journal files from being relabeled by setfiles, you might add the
following to the end of file_contexts:

.*/\.journal		<<none>>

Of course, this is a questionable choice.  We should probably define a
type for the journal files so that they can be rigorously protected by
the SELinux nondiscretionary access controls.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
