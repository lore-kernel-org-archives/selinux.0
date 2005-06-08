Subject: RE: couple validatetrans questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: "'NSA Selinux Mailinglist'" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <200506071451.j57Epo5F018028@gotham.columbia.tresys.com>
References: <200506071451.j57Epo5F018028@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 08 Jun 2005 08:06:50 -0400
Message-Id: <1118232410.26902.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-06-07 at 10:51 -0400, Frank Mayer wrote:
> To answer my own question (since no once else did :-), it is indeed the case
> that t1 (usually?) means process in constrain statements but not for
> validatetrans, where t3 now means process and t1 mean "old". Seems like for
> consistency sakes t1 should always be process; and for validatetrans t2 old
> and t3 new. Likewise for [lru]1. The change in perspective is a conceptual
> barrier towards concisely explaining these two similar statements (constrain
> and validatetrans).

For permission checks (which are always pairwise), [urtl]1 is source and
[urtl]2 is target.  Source isn't necessarily a process; some permission
checks are based on object pairs to represent inter-object
relationships.

For validatetrans, TCS chose to use [urtl]1 for the old file label and
[urtl]2 for the new file label, with [urt]3 for the process performing
the relabel.  I think that this stems from the fact that validatetrans
is primarily concerned with the relationship between the two file labels
(using the process attributes merely to check for privilege when the
file labels are not equivalent).  It is essentially an extended form of
the original oldlabel-to-newlabel file transition permission check
(present in the original SELinux, eventually dropped because policy
ended up allowing all possible pairings for complete filesystem
relabelings via setfiles) that lets you also check process privilege.
For pairwise checks between the process label and the old or new file
label, you can still use ordinary constraints on the relabelfrom and
relabelto permissions.

> A trivial code change to make assuming there hasn't been extensive use of
> validatetrans/mlsvalidatetrans. Until then I guess I'll just have to work
> harder at explaining the subtle difference. 

Not clear that this is justified, and would require a coordinated kernel
change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
