Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BHhmgA019767
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 13:43:48 -0400 (EDT)
Received: from web31610.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id j4BHfF3Y019626
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 17:41:15 GMT
Message-ID: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
Date: Wed, 11 May 2005 10:41:11 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
To: Chad Sellers <cdselle@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Chad Sellers <cdselle@tycho.nsa.gov> wrote:

> This patch us a userspace patch to provide
> polyinstantiation support in
> SELinux.  ...

Clever.

Suppose a user logs in at UNCLASSIFIED (to read email)
and while she's there she looks at /tmp/foo. She
logs off, then logs in at SECRET to do some secret
work, during which she looks at (a different)
/tmp/foo. The Powers That Be later decide that
this user may have been up to no good, and want
to examine the audit trail associated with her.
How will the two instances of /tmp/foo be
differentiated in the audit trail?

In existing MLS systems many trusted programs
use "label flipping" to access resources at
multiple labels. This practice is abhorent and
decried by MLS system vendors, but common
nonetheless. These programs are going to have
trouble moving to your scheme. Not that I
think that's necessarily bad, but it will come
up as an issue because the existing MLS systems
have polyinstantiation mechanisms that handle
that case.


Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Small Business - Try our new resources site!
http://smallbusiness.yahoo.com/resources/ 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
