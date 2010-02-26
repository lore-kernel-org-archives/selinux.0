Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1Q1fxvC020438
	for <selinux@tycho.nsa.gov>; Thu, 25 Feb 2010 20:41:59 -0500
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o1Q1gDtU005349
	for <selinux@tycho.nsa.gov>; Fri, 26 Feb 2010 01:42:17 GMT
Message-ID: <4B8726DA.8040806@manicmethod.com>
Date: Thu, 25 Feb 2010 20:41:46 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Fixfiles using new setfiles/restorecon simplification
References: <4B85902B.70300@redhat.com>
In-Reply-To: <4B85902B.70300@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


What version of the kernel was this added in? I don't want to completely 
break old kernels using new toolchains (CLIP backports toolchains to 
RHEL 4 and 5). It would be better to use seclabel if it is there, 
otherwise fall back to the old list.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
