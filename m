Subject: Re: mqueue labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1126806046.18007.133.camel@sgc.columbia.tresys.com>
References: <1126806046.18007.133.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 16 Sep 2005 08:14:00 -0400
Message-Id: <1126872840.25919.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-09-15 at 13:40 -0400, Christopher J. PeBenito wrote:
> While updating reference policy baseline to NSA CVS, I noticed that the
> mqueue filesystem has two labeling rules:
> 
> genfscon mqueue / system_u:object_r:mqueue_t
> 
> fs_use_trans mqueue system_u:object_r:tmpfs_t;
> 
> Which is the correct one?

The fs_use_trans rule.  When a POSIX mqueue is created, we want it to
inherit a type derived from the type of the creating domain.  At
present, we simply use the same base type (tmpfs_t) as for System V
shared memory (shm/tmpfs) and thus pick up the existing type transition
rules for per-domain derived types for any POSIX mqueues.  If we find
that it is necessary to distinguish them in the future, we may want a
separate base type with its own set of type transition rules.

Note that the genfscon rule is ignored in this case, as fs_use always
takes precedence.   It should just be removed.  checkpolicy could check
for such duplication between fs_use and genfs.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
