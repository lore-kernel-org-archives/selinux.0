Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA05249
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 09:54:58 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA25507
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 13:53:16 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id NAA25503
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2001 13:53:15 GMT
Date: Mon, 1 Oct 2001 09:52:54 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Conan Callen <ccallen@windowpane.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Updated release
In-Reply-To: <Pine.LNX.4.33.0109292325530.15881-100000@localhost.localdomain>
Message-ID: <Pine.SOL.3.95.1011001093847.24962C-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 29 Sep 2001, Conan Callen wrote:

> I checked the changes file didn't find anything to indicate any changes in
> the area below. I wanted to double check and see if anyone had some
> pointers.

The selinux/ChangeLog file has a summary of the changes to LSM and
SELinux since the last release.

> When the updated kernel is built can the existing policy be used?
> 
> Is it nessessary to rebuild the policy dir, setfiles, relable, etc. If so, can
> the previous config files & te files be copied in or have any file formats
> changed?

I would generally recommend doing a full installation, following the
instructions in README as before.  You don't need to do step 8 unless you
were running the non-LSM SELinux prototype.  There have been changes to
the policy and setfiles/file_contexts configuration since the last
release.  If you made customizations to your policy and  
setfiles/file_contexts, then you should check whether the same 
customizations are still needed, since we may have merged them into the 
example policy.  We try to merge policy customizations into the example
policy when people contribute them back to us as long as they are
reasonable.  The configuration languages haven't changed, other than
the addition of the policy/devfs_contexts file for devfs file labeling.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
