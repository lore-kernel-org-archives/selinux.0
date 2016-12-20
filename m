Message-ID: <1482250452.28169.28.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: =?ISO-8859-1?Q?Jos=E9?= Bollo <jobol@nonadev.net>, selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, casey@schaufler-ca.com,
 john.johansen@canonical.com
Date: Tue, 20 Dec 2016 11:14:12 -0500
In-Reply-To: <1482140693.2178.1.camel@nonadev.net>
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2016-12-19 at 10:44 +0100, José Bollo wrote:
> Le vendredi 16 décembre 2016 à 12:41 -0500, Stephen Smalley a écrit :
> > 
> > Processes can only alter their own security attributes via
> > /proc/pid/attr nodes.  This is presently enforced by each
> > individual
> > security module and is also imposed by the Linux credentials
> > implementation, which only allows a task to alter its own
> > credentials.
> > Move the check enforcing this restriction from the individual
> > security modules to proc_pid_attr_write() before calling the
> > security
> > hook,
> > and drop the unnecessary task argument to the security hook since
> > it
> > can
> > only ever be the current task.
> 
> Hi Stephen,
> 
> The module PTAGS that I made relies on the ability to write files in
> /proc/pid/attr/...
> 
> Why did I used this files? Thaere are serious reasons:
>  - follows the life cycle of the process
>  - implements pid namespace
> 
> There is absolutely no way to get these features easyly outside that
> implementation context of /proc/pid/attr/xxx.
> 
> For these reasons I vote against that change.
> 
> You will probably ask me where is PTAGS used and what is is made for.
> 
> So it is not used but the principle of its use is benefical to the
> community. It allows a kind of user land implementation of
> capabilities.
> 
> You probably know that the kernel can not do all things for a good
> reason: it is not intended to do all things. So there is a need for
> user land features. PTAGS is an intent to fulfill an empty gap.
> 
> I made a presentation at FOSDEM on the subject that may allows you to
> understand the beginning of the issue that I'm writing about [2]. 
> 
> [1] https://lkml.org/lkml/2016/11/23/122
> [2] https://archive.fosdem.org/2015/schedule/event/sec_enforcement/

Looking at your PTAGS implementation, I feel it is only fair to warn
you that your usage of /proc/pid/attr is insecure, regardless of
whether you use task security blobs or cred security blobs.

Getting the attributes of another process via /proc/pid files is
inherently racy, as the process may exit and another process with
different attributes may be created with the same pid (and no, this is
not theoretical; it has been demonstrated). Similarly, setting the
attributes of another process via /proc/pid files is likewise
inherently racy; you may end up setting the attributes on the wrong
process entirely.  Setting another process' attributes in this manner
is also prone to other kinds of races, since there is no coordination
between the process execution state and when the new tag is applied.

Again, I encourage you to reconsider your approach if you want to have
a secure solution.
