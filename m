Subject: Re: The reason why SEPostgreSQL use original userspace AVC
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Cc: selinux@tycho.nsa.gov, Eamon Walsh <ewalsh@tycho.nsa.gov>
In-Reply-To: <1174480707.22565.367.camel@moss-spartans.epoch.ncsc.mil>
References: <45FE9A2F.40200@kaigai.gr.jp>
	 <1174480707.22565.367.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 10:35:32 -0400
Message-Id: <1174487732.22565.384.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-21 at 08:38 -0400, Stephen Smalley wrote:
> On Mon, 2007-03-19 at 23:11 +0900, KaiGai Kohei wrote:
> > Hi,
> > 
> > This was one of the topics discussed on SELinux developer summit held on
> > last Friday.
> > I like to send the reason why I made a decision to implement SE-PostgreSQL
> > with original userspace AVC, for wider discussion.
> > (SE-PostgreSQL didn't use the userspace AVC provided by libselinux.)
> > 
> > There are two major reasons. The one is a performance gain. The other is
> > concurrency of invalidation.
> > 
> > Any comment and suggestion please.
> > 
> > [ performance gain ]
> > 
> > The biggest reason is originated from the way to associate a security context
> > for each tuple. As I mentioned, I modified the internal data structure of
> > tuples to add its security context. The field is a 4-byte length integer
> > variable (same as object id data type), not a string expression.
> > This value is associated with the contains of 'pg_selinux'.
> > 
> > 'pg_selinux' is one of the system catalogs. System catalogs are special tables
> > which contains database meta information like definition of table, view, stored
> > procedure and so on.
> > 'pg_selinux' has two column. One is 'oid' defined as object id type. It hold
> > a unique number within the table. The other is 'selcontext' defined as variable
> > length text type. It hold a security context in text expression.
> > So, we can refer the pg_selinux system catalog, when a text expression of security
> > context is required.
> > (e.g A case when 'security_context' is specified in SQL queries.)
> > 
> > The object id enables to identify a security context in text expression, so we
> > can also apply them as a key of userspace avc. I named it as psid (persistent
> > security id).
> > 
> > Using psid enables to be unnecessary to handle a text represented security context
> > in the most frequently path. When we have to make a decision whether the fetched
> > tuple is allowed or not, we can search the userspace avc with psid held by the tuple
> > as is.
> > 
> > In the userspace avc provided by libselinux. Its avc_has_perm() requires security_id_t
> > as arguments, but it means we have to translate security context from psid to text
> > representation in a decision making process.
> > No need to say, it make a bad effect to the performance of SE-PostgreSQL.
> 
> So I understand correctly, the underlying issue here is that you want
> your userspace object manager to be able to generate its own SID mapping
> (in your case, using these psids or object ids) rather than have the SID
> mapping handled entirely within libselinux, so that you can have the ids
> also represent something meaningful to the object manager for efficient
> lookup.  It seems possible to have the libselinux userspace AVC export
> interfaces to allow an object manager to optionally populate the
> SID->context mapping itself using identifiers it selects.  Would that
> address your concern?
> 
> > [ concurrency of invalidation ]
> > 
> > SE-PostgreSQL deploys its userspace avc on the shared memory region, and generates
> > a single policy state monitoring process to poll netlink socket at bootup time.
> > It enables to invalidate the userspace avc referred by all SE-PostgreSQL instances
> > concurrently.
> > 
> > If the userspace avc is deployed on the process local memory for each instance,
> > we need policy state monitoring threads for each instances and the invalidation
> > of userspace avc is not done concurrently.
> > At a moment, different policies may be applied between SE-PostgreSQL instances.
> > 
> > In addition, we will get a little performance improvement on startup time of instances.
> > If the userspace avc deployed on the shared memory region, it may contains several
> > access control rules before it is referred at first. It enables to reduce the number
> > of calling system-call.
> > And, it is not necessary to generate a policy state monitoring thread for each
> > SE-PostgreSQL instance.
> 
> I'd be interested in seeing your userspace AVC implementation - is it
> short enough that you can post it, or if not, point us to the specific
> files in your repository?  I would tend to think that any gains you
> might get from sharing a single AVC among multiple processes would tend
> to be negated by 1) the locking required to make that safe (similar to
> the locking support in the AVC for multi-threaded applications), and 2)
> the affect on the cache of having multiple processes using it for
> different access checks.  Also, IIUC, you don't need to have a separate
> thread monitoring the netlink socket per se; the libselinux AVC can
> check just its state on each avc_has_perm call in the non-threaded case.

Did you measure performance using both your own AVC vs. using the
libselinux one to see what the real impact was of these changes?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
