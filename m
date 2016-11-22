From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH] Fix AUDIT_MAC_POLICY_LOAD event formatting
Date: Tue, 22 Nov 2016 15:13:40 -0500
Message-ID: <1612970.M9BsOE2y15@x2>
In-Reply-To: <8fc7f4df-3c1a-3c5b-ceb9-67b140383ee7@tycho.nsa.gov>
References: <11128714.mipGzmS50p@x2> <1654303.4jsK0rGDo5@x2>
 <8fc7f4df-3c1a-3c5b-ceb9-67b140383ee7@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, November 22, 2016 2:47:15 PM EST Stephen Smalley wrote:
> >> At present, we only generate AUDIT_MAC_STATUS, AUDIT_MAC_LOAD, and
> >> AUDIT_MAC_CONFIG_CHANGE on success (or at least partial success).  If
> >> you truly need to audit failures, then it seems like you either need to
> >> a) do it through syscall audit filters, which already provide a success=
> >> field
> > 
> > I can't imagine what to audit on. There is an open syscall that has a
> > path. But I suspect that does not fail because policy has not be written.
> > There is a write syscall but triggering on that is pretty generic. This is
> > not ideal.
>
> Can't you write an audit syscall filter or watch on
> /sys/fs/selinux/load?  Ditto for /sys/fs/selinux/enforce,
> /sys/fs/selinux/commit_pending_bools, etc.

Yes, you can. But this is for the open syscall. sel_write_load() is the 
function where the auditing is done but its mapped to the .write member of 
sel_load_ops. Auditing on write is not a good thing.

So, if AUDIT_MAC_POLICY_LOAD must only appear when there is success, then its 
best to create a second event for failure and hard code the 'res' fields for 
both.

-Steve
