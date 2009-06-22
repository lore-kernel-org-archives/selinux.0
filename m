Date: Tue, 23 Jun 2009 08:23:43 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        selinux@tycho.nsa.gov
Subject: Re: [patch] selinux:  restore optimization to
 selinux_file_permission
In-Reply-To: <1245696893.12493.22.camel@localhost.localdomain>
Message-ID: <alpine.LRH.2.00.0906230822580.30216@tundra.namei.org>
References: <1245696893.12493.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 22 Jun 2009, Stephen Smalley wrote:

> Restore the optimization to skip revalidation in selinux_file_permission
> if nothing has changed since the dentry_open checks, accidentally removed by
> 389fb800.  Also remove redundant test from selinux_revalidate_file_permission.
> 
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
