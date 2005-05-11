Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BIIEgA020117
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 14:18:14 -0400 (EDT)
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
References: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 14:16:51 -0400
Message-Id: <1115835411.28698.12.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-05-11 at 10:41 -0700, Casey Schaufler wrote:
> --- Chad Sellers <cdselle@tycho.nsa.gov> wrote:
> 
> > This patch us a userspace patch to provide
> > polyinstantiation support in
> > SELinux.  ...
> 
> Clever.
> 
> Suppose a user logs in at UNCLASSIFIED (to read email)
> and while she's there she looks at /tmp/foo. She
> logs off, then logs in at SECRET to do some secret
> work, during which she looks at (a different)
> /tmp/foo. The Powers That Be later decide that
> this user may have been up to no good, and want
> to examine the audit trail associated with her.
> How will the two instances of /tmp/foo be
> differentiated in the audit trail?
> 
The two instances of /tmp/foo have different contexts (that's the
reason /tmp was polyinstantiated in the first place).  Any audit
messages (avc messages do this now) should include the context of the
file (as well as device and inode), not just the filename.  So, the two
instances can be differentiated.  Additionally, auditing based on
filename is unreliable to begin with.



> In existing MLS systems many trusted programs
> use "label flipping" to access resources at
> multiple labels. This practice is abhorent and
> decried by MLS system vendors, but common
> nonetheless. These programs are going to have
> trouble moving to your scheme. Not that I
> think that's necessarily bad, but it will come
> up as an issue because the existing MLS systems
> have polyinstantiation mechanisms that handle
> that case.
> 
I agree that this is a bad practice, but these programs could move to my
scheme.  MLS applications that use "label flipping" have to be security
aware in order to perform that flipping (meaning they have to call
security functions to flip their label).  So, they could include a call
to my library function to modify their namespace appropriately when
flipping labels.  Of course, this requires the entrypoint program
starting the application to have setup a new namespace for the
application in the first place.  If the application flips so frequently
that this affects performance, then I'd say the application is flipping
labels a little too frequently.

> 
> Casey Schaufler
> casey@schaufler-ca.com
> 
> 
> 		
> __________________________________ 
> Do you Yahoo!? 
> Yahoo! Small Business - Try our new resources site!
> http://smallbusiness.yahoo.com/resources/ 
-- 
Chad Sellers
cdselle@tycho.nsa.gov


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
