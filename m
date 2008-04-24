Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3OEjfOn017477
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 10:45:41 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m3OEjeEF022347
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2008 14:45:41 GMT
Subject: Re: [refpolicy] potential rsync patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Patrick Neely <patrick.neely@gtri.gatech.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4804A54F.1020108@gtri.gatech.edu>
References: <4804A54F.1020108@gtri.gatech.edu>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 10:18:46 -0400
Message-Id: <1209046726.25900.11.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-04-15 at 08:53 -0400, Patrick Neely wrote:
> I was creating a module for a script that uses rsync.  I wanted to
> keep 
> the program in the callers domain throughout, so I developed an 
> interface for "rsync.if" that gives a domain the privileges it needs
> to 
> execute a rsync without transitioning to the rsync domain.  Next, I 
> replaced the appropriate te rules in the "rsync.te" with this
> interface 
> which I called "can_rsync_notrans".
> 
> Finally, the transport mechanism I used for rsync was ssh, so I
> created 
> a "can_rsync_over_ssh" interface and added that to the "rysnc.if"
> file.
> 
> This is my first attempt at doing something like this, so I am
> looking 
> for feedback on how to make this more correct and more correctly 
> styled.  It is my goal to get these interfaces incorporated into the 
> reference policy.

Not a bad start.  There are a few things that I see.  The first is the
interface naming, and there is a naming convention page [1] that can
help you fix that.

The actual implementation is fine for the most part.  However, I suggest
a few changes.  It seems that someone wanting to use an rsync client in
their policy is going to have two things that they're going to be
concerned about: what files are being rsynced and which network to use.
These probably shouldn't be included in the interface.  Also, since you
base it on the existing policy, which is for rsync daemon mode, some
permissions can likely be trimmed too, such as the syslog access and
possibly the nsswitch too.

[1] http://oss.tresys.com/projects/refpolicy/wiki/InterfaceNaming

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
