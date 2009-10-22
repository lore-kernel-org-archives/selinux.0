Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n9MIt2Wo027551
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 14:55:02 -0400
Received: from asmtpout028.mac.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n9MIumi2009673
	for <selinux@tycho.nsa.gov>; Thu, 22 Oct 2009 18:56:49 GMT
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Received: from falmouth.jbj.org
 (cpe-069-134-024-120.nc.res.rr.com [69.134.24.120])
 by asmtp028.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTPSA id <0KRX00KDGJ7ES110@asmtp028.mac.com> for
 selinux@tycho.nsa.gov; Thu, 22 Oct 2009 11:54:52 -0700 (PDT)
Subject: Re: RPM support for SELinux
From: Jeff Johnson <n3npq@mac.com>
In-reply-to: <C7061E9C.AB85E%csellers@tresys.com>
Date: Thu, 22 Oct 2009 14:54:49 -0400
Cc: SE Linux <selinux@tycho.nsa.gov>
Message-id: <99964603-25A5-4664-8EE4-99B5C07661C3@mac.com>
References: <C7061E9C.AB85E%csellers@tresys.com>
To: Chad Sellers <csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Oct 22, 2009, at 2:37 PM, Chad Sellers wrote:

> I just wanted to let everyone know that we've submitted a patchset  
> to add
> more robust SELinux support to RPM4. You can view the patchset here:
>
> http://lists.rpm.org/pipermail/rpm-maint/2009-October/002561.html
>
> Note that these patches require running on the current trunk of  
> libselinux
> and libsemanage.
>
> If you're interested in trying out the support or just looking at  
> how it
> works, we've put up a wiki page talking about it here:
>
> http://selinuxproject.org/page/RPM
>
> Comments are welcome.
>


Just a short reply:

	The patches will never be included @rpm5.org as is because
	you missed the abstraction (for packaging) and haven't tied
	various stray identifiers as in
		Type: mls targeted
	to anything concrete.

There are other and deeper flaws within the highly unnormalized data
within the *.bz2 policy blobs.

Equivalent functionality will be done @rpm5.org instead.

73 de Jeff

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
