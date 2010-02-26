Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1QDfwGl024020
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 08:42:02 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1QDgK9q023735
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 13:42:21 GMT
Message-ID: <4B87CFA0.8030707@redhat.com>
Date: Fri, 26 Feb 2010 08:41:52 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Joshua Brindle <method@manicmethod.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fixfiles using new setfiles/restorecon simplification
References: <4B85902B.70300@redhat.com> <4B8726DA.8040806@manicmethod.com>
In-Reply-To: <4B8726DA.8040806@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/25/2010 08:41 PM, Joshua Brindle wrote:
>
> What version of the kernel was this added in? I don't want to 
> completely break old kernels using new toolchains (CLIP backports 
> toolchains to RHEL 4 and 5). It would be better to use seclabel if it 
> is there, otherwise fall back to the old list.
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
The problem with this is we end up with a lot of cruft in the toolchain, 
that is continually out of data, and makes it hard to figure out what 
the script is doing.  We have older versions of the tool chain for those 
platforms, shouldn't we have sort of the latest toolchain.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
