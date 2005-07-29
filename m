Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 14:01:45 -0400
Message-Id: <1122660105.6573.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-07-29 at 12:49 -0400, Stephen Smalley wrote:
> The following patch set reduces the number of avtab nodes by preserving
> attributes in TE allow/dontaudit/auditallow rules when possible rather
> than expanding them during policy compilation, and having the kernel use
> a type->attribute reverse map to perform the access vector computation,
> per the earlier discussions on the list.  This slows down security
> server computations, but these only occur on AVC cache misses, so the
> expected performance impact is negligible.  I have not yet attempted to
> measure the performance impact.  If it proves to be measurable at all,
> we can likely optimize it in the same manner that I used for the
> assertion checking code (see below).
> 
> Unlike the first patchset, where you could just patch the kernel and see
> the memory savings from the reduction in the per-node size even with a
> policy.19 file, this patch set requires you to patch your kernel,
> libsepol, and checkpolicy and build a policy.20 policy in order to see
> the reduction in nodes, as that is handled during compilation.

I forgot to mention:  when I tried recompiling the FC/devel strict
policy with the updated checkpolicy, it failed an assertion check
(neverallow statement) on one of the conditional rules.  Older
checkpolicy wasn't checking assertions on the conditional avtab, only on
the base avtab; this was fixed by Tresys as part of the module support
patches.  The assertion failure turned up to be that rpcd.te has a
create_dir_file(kernel_t, {file_type - shadow_t }) conditional rule if
nfs_export_all_rw is enabled, which means that kernel_t needs the
etc_writer attribute.  kernel.te only gives kernel_t the etc_writer
attribute _if_ the nfs_export_all_rw tunable is defined, but it is no
longer a tunable and has been converted to a boolean (and attribute
assignment isn't conditional).  Hence, I had to add that attribute
(without the ifdef) to compile the policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
