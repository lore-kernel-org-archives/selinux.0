Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA12949
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 13:29:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA10195
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 17:29:36 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id RAA10189
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2001 17:29:35 GMT
Date: Tue, 17 Apr 2001 13:28:25 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Michael N. Bernstein" <bernstein.46@osu.edu>
cc: selinux@tycho.nsa.gov
Subject: Re: security enhancements outside of flask model
In-Reply-To: <LMEJJDOADCLJPCBCJHFKMEIMCAAA.bernstein.46@osu.edu>
Message-ID: <Pine.SOL.3.95.1010417131729.15065d-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


With regard to kernel modules, SELinux controls the use of
the Linux capabilities, so the ability to use the module-related
system calls can be controlled by the policy.  The example
policy configuration protects the integrity of the module utilities,
module configuration and module object files, and it restricts
the ability to use the module calls.

The document available at http://www.nsa.gov/selinux/slinux-abs.html
describes the current set of controls provided by SELinux.  It
also describes potential areas for adding further controls in
the System Call Review section.  

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com

On Tue, 17 Apr 2001, Michael N. Bernstein wrote:

> Is there any work being done in the selinux realm to secure other
> parts of the kernel?  (e.g. kernel module, etc.).


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
