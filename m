Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2FIvhDo001450
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 13:57:44 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2FIn2NK021156
	for <selinux@tycho.nsa.gov>; Tue, 15 Mar 2005 18:49:02 GMT
Subject: Re: New policy for yam
From: David Hampton <hampton-rh@rainbolthampton.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <4236EF2E.8090104@redhat.com>
References: <1110671442.7641.15.camel@hampton-pc.rainbolthampton.net>
	 <4236EF2E.8090104@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 13:51:32 -0500
Message-Id: <1110912692.14212.29.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-03-15 at 09:20 -0500, Daniel J Walsh wrote:

> Why did you create a yam_crond_t?  Why not just transition to yam_t from 
> crond?

When I first started working on the policy I was trying to be as
restrictive as possible and differentiate between what peripheral files
could be opened when running yam from the command line vs. when running
from cron.  For example, the cron version requires less access to the
terminal and no access to a ssh file descriptor.  The two instances also
try reading their dot files from different directories.

I wrote this policy just after writing an exim policy that distinguished
between user, sysadm, and system invocations of the program.  Perhaps I
went overboard here.

David

P.S. I'm still tweaking the exim policy.  I'll probably post it in a
week or so.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
