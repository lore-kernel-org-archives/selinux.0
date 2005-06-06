Message-Id: <200506061740.j56HeH5F009471@gotham.columbia.tresys.com>
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>
Cc: "'NSA Selinux Mailinglist'" <selinux@tycho.nsa.gov>
Subject: RE: couple validatetrans questions
Date: Mon, 6 Jun 2005 13:40:17 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-reply-to: <1116963618.27904.193.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> It lets you impose restrictions on file relabeling based on the
> entire (process context, old file context, new file context) triple,
> unlike the pairwise permission checks.   

Am I correct in understanding that for constrain statements, t1 (and u1 &
r1) mean source type (user or role) and t2 (and u2 & r2) mean target.
However, for validatetrans, t3 now means source (i.e., the subject process),
and t1 now means "old" context and t2 "new" context (since validatetrans
deals only with context relabel)?

I expected *1 to stay meaning the source/subject context, but concluded it
was as above. Did I miss something? 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
