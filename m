Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o460CgI5028537
	for <selinux@tycho.nsa.gov>; Wed, 5 May 2010 20:12:42 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o460DnVR006757
	for <selinux@tycho.nsa.gov>; Thu, 6 May 2010 00:13:49 GMT
Date: Thu, 6 May 2010 10:12:38 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Alan Rouse <alan.rouse@ericsson.com>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: Life cycle process for building products with selinux
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
Message-ID: <alpine.LRH.2.00.1005061004360.22641@tundra.namei.org>
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5D0EAF4@EUSAACMS0703.eamcs.ericsson.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 5 May 2010, Alan Rouse wrote:

> - Software development:  Where in the software development cycle do you 
> introduce selinux?  Should application developers have to develop on a 
> system confined by selinux?  Is selinux policy maintenance a software 
> development task, or a separate phase in the development cycle?
> 
> - System integration:  Is this where selinux is first turned on?

In a successful case I'm aware of, all updates to applications are tested 
on a staging system before being rolled out, at which point SELinux is 
enabled in permissive mode.  Any AVCs are treated as regressions and the 
developers work with sysadmins/security folk to either fix the application 
or update the system security policy.

> - War stories, lessons learned... or anything of the sort

It would be great to see something like the above written up as a case 
study -- for various reasons, people are not always in an ideal position 
to do so.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
