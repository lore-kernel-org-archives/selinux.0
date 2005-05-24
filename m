Subject: Re: couple validatetrans questions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Frank Mayer <mayerf@tresys.com>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>
In-Reply-To: <200505241939.j4OJdt5F031234@gotham.columbia.tresys.com>
References: <200505241939.j4OJdt5F031234@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 24 May 2005 15:40:18 -0400
Message-Id: <1116963618.27904.193.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-24 at 15:40 -0400, Frank Mayer wrote:
> 1) I see that validatetrans was added along with mlsvalidatetrans. Is this
> used anywhere? Is there a notion of its use outside of MLS? If so can anyone
> provide an example?

It is not used yet, but seemed useful to support for types as well.  It
lets you impose restrictions on file relabeling based on the entire
(process context, old file context, new file context) triple, unlike the
pairwise permission checks.

> 2). Is it still the case that validatetrans/mlsvalidatetrans only works for
> file classes? Any plans to extend to other classes?

It only makes sense for object classes that support relabeling, which is
presently only files.  For processes, you only have two contexts (old
process context, new process context) to consider, so the pairwise
permission checks are sufficient.  If we allow relabeling of IPC objects
in the future, then it would make sense to also apply it to them.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
