Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i393YkRb022591
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 23:34:46 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i393WkUZ009316
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 03:32:46 GMT
Received: from ms-smtp-04-eri0.southeast.rr.com (ms-smtp-04-lbl.southeast.rr.com [24.25.9.103])
	by jazzswing.ncsc.mil  with ESMTP id i393WkmT009313
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2004 03:32:46 GMT
Received: from [192.168.1.100] (rdu88-244-196.nc.rr.com [24.88.244.196])
	by ms-smtp-04-eri0.southeast.rr.com (8.12.10/8.12.7) with ESMTP id i393YhC8029581
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 23:34:43 -0400 (EDT)
Subject: Re: Fedora Core 2 Test 2
From: John Reuning <john@metalab.unc.edu>
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <32926.192.168.1.3.1081469476.squirrel@www>
References: <1081459652.24857.33.camel@hawaii.efficax.net>
	 <32926.192.168.1.3.1081469476.squirrel@www>
Content-Type: text/plain
Message-Id: <1081481682.11877.26.camel@camelot>
Mime-Version: 1.0
Date: Thu, 08 Apr 2004 23:34:43 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'll offer my limited experience with fc2t2.  I've done two installs,
both onto clean systems with reformatted partitions.  There was an
option to disable selinux in the installer click-through choices.

The first install resulted in an almost unusable system.  I think
something hiccuped because the fs labeling was messed up.  For example,
I couldn't create user accounts as root because the root user didn't
have access to write /etc/shadow or /etc/passwd.  A manual relabeling of
the file systems fixed the problem.  After that, everything was fine.

The second install was smooth.  No labeling or policy problems yet. 
Although, I haven't used the system except as a headless test server.

I haven't tried upgrading a fc1 system to fc2t2.  Maybe that's a source
of trouble?

Thanks,

-John R.

> > 1: I was a little surprised to find that SELinux was installed by
> > default and that there didn't seem to be a way to avoid it. This said,
> > the kernel did come up properly and the system booted.
> > [snip]



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
