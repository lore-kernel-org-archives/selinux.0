Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA5F02o1031794
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 10:00:02 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA5EwN1q012764
	for <selinux@tycho.nsa.gov>; Wed, 5 Nov 2008 14:58:24 GMT
Subject: Re: user guide drafts: "Searching for and Viewing Denials" and
 "Analyzing Denials"
From: Eric Paris <eparis@redhat.com>
To: Murray McAllister <mmcallis@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <49114299.4070400@redhat.com>
References: <49114299.4070400@redhat.com>
Content-Type: text/plain
Date: Wed, 05 Nov 2008 09:59:30 -0500
Message-Id: <1225897170.3300.114.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-11-05 at 16:52 +1000, Murray McAllister wrote:
> 
> In certain situations, the tcontext may match the scontext, such as when 
> a Linux user is confined and SELinux policy prevents them from 
> performing an action, for example, running a setuid application.

Not in love with that example, no explicit "run suid" permission (as sds
recently corrected me)

In certain situations, the tcontext may match the scontext, such as when
a process tries to use more resources, eg. memory usage, open file
descriptors, or things like that, than normal limits allow.  This will
cause a security check to see if the process is allow to violate the
limits.  This check is done with with tcontext == scontext.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
