Date: Wed, 7 May 2008 08:31:23 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH v4] selinux:  support deferred mapping of contexts
In-Reply-To: <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0805070830480.20128@us.intercode.com.au>
References: <1210002195.25678.678.camel@moss-spartans.epoch.ncsc.mil>
 <Xine.LNX.4.64.0805060930520.17367@us.intercode.com.au>
 <1210088427.25678.771.camel@moss-spartans.epoch.ncsc.mil>
 <1210105048.25678.799.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 6 May 2008, Stephen Smalley wrote:

> So, the question is should we just drop this hunk of the patch and only
> support this functionality for setxattr, or do we need
> selinux_inode_init_security() to recover the original context string
> (which is available in the SID table, just not returned by
> security_sid_to_context when it isn't defined by policy) and use that
> for the on-disk xattr value?

I think we need to use the "alternative" context if it exists, so yes.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
