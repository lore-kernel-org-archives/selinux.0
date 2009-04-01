Date: Thu, 2 Apr 2009 09:53:26 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
cc: Eric Paris <eparis@parisplace.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, method@manicmethod.com,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Permissive domain in userspace object manager
In-Reply-To: <49D2BE6D.4030708@ak.jp.nec.com>
Message-ID: <alpine.LRH.2.00.0904020953140.30245@tundra.namei.org>
References: <49C7667A.3020804@ak.jp.nec.com> <49C7A88E.4020408@rubix.com>  <49C84200.9090107@ak.jp.nec.com> <49C9D524.9050208@ak.jp.nec.com>  <49CB3CEB.1070505@ak.jp.nec.com> <49CD8E68.9090004@tycho.nsa.gov>  <49D034B9.9080406@ak.jp.nec.com>
 <49D175C6.2050001@ak.jp.nec.com> <1238517993.2484.123.camel@localhost.localdomain> <49D2BE6D.4030708@ak.jp.nec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Apr 2009, KaiGai Kohei wrote:

> This patch enables applications to handle permissive domain correctly.
> 
> Since the v2.6.26 kernel, SELinux has supported an idea of permissive
> domain which allows certain processes to work as if permissive mode,
> even if the global setting is enforcing mode.
> However, we don't have an application program interface to inform
> what domains are permissive one, and what domains are not.
> It means applications focuses on SELinux (XACE/SELinux, SE-PostgreSQL
> and so on) cannot handle permissive domain correctly.
> 
> This patch add the sixth field (flags) on the reply of the /selinux/access
> interface which is used to make an access control decision from userspace.
> If the first bit of the flags field is positive, it means the required
> access control decision is on permissive domain, so application should
> allow any required actions, as the kernel doing.
> 
> This patch also has a side benefit. The av_decision.flags is set at
> context_struct_compute_av(). It enables to check required permissions
> without read_lock(&policy_rwlock).
> 
>  Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

Applied.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
