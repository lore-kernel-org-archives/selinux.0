Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4Hq1SA027448
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 12:52:01 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB4HpLEC016709
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 17:51:21 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kB4HnahJ004287
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 12:49:36 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kB4HnaKc004286
	for selinux@tycho.nsa.gov; Mon, 4 Dec 2006 12:49:36 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB4Hh2VH027034
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 12:43:02 -0500
Received: from web36610.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kB4HgKEC014696
	for <selinux@tycho.nsa.gov>; Mon, 4 Dec 2006 17:42:21 GMT
Date: Mon, 4 Dec 2006 09:43:10 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: User home directory creation with useradd (rhbz#217441)
To: Linda Knippers <linda.knippers@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4571D234.5000207@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <730781.75976.qm@web36610.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Linda Knippers <linda.knippers@hp.com> wrote:


> I don't want more stuff in semanage.  We should be
> able to do it from
> useradd, and from one role.  Right now its a multi
> step operation and
> we can't run useradd and semanage from the same
> role.  Only sysadm_r
> can run useradd and only secadm_r can run semanage
> with the current
> MLS policy.

While this is inconvenient, it is consistant
with the separation of roles. You might want
a role explictitly for this function.
Experiance on other systems has been that
neither the secadm nor the sysadm roles are
sufficient for adding a user by themselves,
nor should they be.

> I've also noticed that only secadm_r can change the
> selinux context
> of a file (makes sense) but secadm_r can't change
> the mode bits of
> the same file, only sysadm_r can.  That doesn't make
> sense to me.

When roles are defined in the context of an
implementaion logical associations don't always
apply. Since SELinux and the policies it
enforces are implemented as an adjunct to the
traditional mechanisms binding a relationship
to their administration is challanging.

> I don't know if that's a bug, a feature or a
> configuration problem
> on my system (and is somewhat off-topic) but its
> another example of
> illogical behavior.

It's illogical only in the context of security
policy integration. Each set of policies are
completely consistant, however the differences
become evident when placed in such proximity.

> Seems like secadm_r can do
> SELinux things but
> not other security administration unrelated to
> SELinux, and that
> makes SELinux look like a wart rather than an
> integrated feature.

Indeed, but take heart as this problem has
come up with Unix MLS systems as well. We
actually dropped the active persuit of roles
in one system because there just didn't seem
to be a useful separation between the system
and security admins, with the exception of
the auditor, which we kept.

> Ok, here's another example.  secadm_r can manage
> policy but can't
> 'touch /.autorelabel', only sysadm_r can do that.

You are seeing the reality of implementation
getting in the way of behavior matching what
a "designed" system ought to do. There are
ways to fix this, but they're expensive and
probably not viable upstream (yet).

So, I don't see that you're going to have
much luck addressing these issues in the
short term as they are artifacts of the
implementation. You might do well to put
some effort into explaining why these
behaviors are rational and necessary in the
context of role separation.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
