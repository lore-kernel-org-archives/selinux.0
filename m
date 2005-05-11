Message-ID: <42824AE2.9020509@us.ibm.com>
Date: Wed, 11 May 2005 14:11:46 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: Chad Sellers <cdselle@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
References: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
In-Reply-To: <20050511174111.48865.qmail@web31610.mail.mud.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:

> --- Chad Sellers <cdselle@tycho.nsa.gov> wrote:
> 
> 
>>This patch us a userspace patch to provide
>>polyinstantiation support in
>>SELinux.  ...
> 
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

In addition to the pathname, the audit record
will contain the user's sensitivity level.

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

-Janak



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
