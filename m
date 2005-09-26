Subject: Re: reserved_port_type attribute
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1127757038.32172.22.camel@sgc.columbia.tresys.com>
References: <1127757038.32172.22.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 14:20:42 -0400
Message-Id: <1127758842.19016.163.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-09-26 at 13:50 -0400, Christopher J. PeBenito wrote:
> According to attrib.te, reserved_port_type is supposed to be for ports
> that are less than 1024.  Why is reserved_port_t not included?

As I recall, reserved_port_type was introduced for dontaudit rules to
suppress noise when userspace scans for an available reserved port (in
particular, when libc sunrpc client code calls bindresvport(3)).  So in
these cases, I think that the domain was already being allowed name_bind
to the reserved_port_t type, and only needed dontaudit for the specific
port types.

If checkpolicy were enhanced to prune unnecessary auditallow and
dontaudit rules after collecting all allow rules, then it would do no
harm to add reserved_port_t to the attribute.  At present, you'll bloat
the policy slightly by doing it because checkpolicy isn't smart enough
to drop the extraneous dontaudit rule for the allowed case.

>   Also,
> http_cache_port_t, ptal_port_t, clamd_port_t, pyzor_port_t, and
> dbskkd_port_t aren't labeling any ports below 1024 (dbskkd_port_t
> doesn't even have a portcon), so why have they been given this
> attribute?

Likely shouldn't have it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
