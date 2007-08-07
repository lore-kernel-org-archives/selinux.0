Subject: Re: Fedora/SE-PostgreSQL
From: Stephen Smalley <sds@tycho.nsa.gov>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, cpebenito@tresys.com,
        dwalsh@redhat.com, selinux@tycho.nsa.gov, ewalsh@tycho.nsa.gov
In-Reply-To: <46B7F7EF.2030200@ak.jp.nec.com>
References: <46B079EF.9050909@kaigai.gr.jp>
	 <1186428187.17889.166.camel@moss-spartans.epoch.ncsc.mil>
	 <46B7F7EF.2030200@ak.jp.nec.com>
Content-Type: text/plain
Date: Tue, 07 Aug 2007 08:25:01 -0400
Message-Id: <1186489501.26457.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-07 at 13:41 +0900, KaiGai Kohei wrote:
> Stephen Smalley wrote:
> > On Wed, 2007-08-01 at 21:17 +0900, KaiGai Kohei wrote:
> >> Hi,
> >>
> >> A week ago, I submitted a review request of SE-PostgreSQL to
> >> the Fedora project as follows:
> >>   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249522
> >>
> >> The biggest issue is lack of definitions of new object classes
> >> and access vectors related to database.
> >> Rest of policies can be installed as a binary security policy module
> >> packed within the RPM package, but these definitions and MLS/MCS rules
> >> cannot be moduled.
> >>
> >> The attached patch adds these definitions to the base policy.
> >>
> >> I remember Chris said as follows at the past.
> >>> Is the code on a path to being merged upstream?  I'm hesitant to apply
> >>> class changes until the code is on a plan to be merged.
> >> However, I would like you to consider it again.
> >> I believe that spread of using secure applications, like SE-PostgreSQL,
> >> can help promote SELinux more, and it's so worthful to make it more
> >> uncomplicated to maintain.
> >>
> >> In addition, the next release of PostgreSQL with new features (8.4) is
> >> planed at the autumn 2008. It means that any SE-PostgreSQL users have to
> >> replace the default selinux-policy package by the modified one for a year
> >> and more, at least. I think it's a senseless work.
> >>
> >> It may be a time the definitions of object classes related to database are
> >> integrated into the base security policy.
> > 
> > Likely a good idea as well to ensure that it does not collide with the X
> > object class rework.
> 
> Future modification of object class number is not a matter, because SE-PostgreSQL
> can also obtain them via /selinux/class on the kernel 2.6.23 or later.

Yes, but IIUC, you are still encoding the fixed class/perm numbers into
SE-PostgreSQL when running on older kernels.  Which means that if we
take those values for the revamped X classes, we will break
SE-PostgreSQL on such systems.

> Are you worried about that the reworked X object class uses same namespace
> with what SE-PostgreSQL uses, like "database", "table" and so on?

No, although that brings up another point - I think Eamon intends to
prefix all of the X classes with "x" or "X" to "namespace" them, and you
may want to do likewise for PostgresQL (not clear whether they should
use a postgres-specific prefix or just a db_ prefix to foster re-use for
other database managers).

Regardless, I'd like to make it easier for people to use SE-PostgreSQL,
and until such a time as we can add classes in a module, getting the
definitions into the refpolicy is needed.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
