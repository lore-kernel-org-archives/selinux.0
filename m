Subject: Re: SELinux Design Documentation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20050307163727.53411.qmail@web50206.mail.yahoo.com>
References: <20050307163727.53411.qmail@web50206.mail.yahoo.com>
Content-Type: text/plain
Date: Mon, 07 Mar 2005 11:41:02 -0500
Message-Id: <1110213662.2282.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-03-07 at 08:37 -0800, Casey Schaufler wrote:
> So, where is the "official" design
> documentation for SELinux kept?

The original design and implementation technical report is available
from 
http://www.nsa.gov/selinux/papers/slinux-abs.cfm, which describes the
design and implementation of the original SELinux kernel patch.  A
follow-on report describing the LSM-based SELinux is available from
http://www.nsa.gov/selinux/papers/module-abs.cfm, but the copy presently
on the NSA web site is out of date with respect to the 2.6 SELinux;
we've just updated it to reflect the current code in the CVS tree
(available from the sourceforge site), and that will show up on the NSA
site when we make an updated release based on 2.6.11, likely later this
week.  However, I don't expect any of this to be sufficient for
evaluation; as with the already completed CAPP/EAL3 and CAPP/EAL4
evaluations done for Linux, I expect there to be a lot of further
documentation to have to be created for evaluation of SELinux.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
