Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBHKgNFh011037
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 15:42:23 -0500
Received: from web36613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id lBHKgMMW021597
	for <selinux@tycho.nsa.gov>; Mon, 17 Dec 2007 20:42:22 GMT
Date: Mon, 17 Dec 2007 12:42:06 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC PATCH v8 05/18] LSM: Add secctx_to_secid() LSM hook
To: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        vyekkirala@TrustedCS.com, chanson@TrustedCS.com
In-Reply-To: <1197920974.17307.105.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <870819.98947.qm@web36613.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2007-12-14 at 16:50 -0500, Paul Moore wrote:
> > Add a secctx_to_secid() LSM hook to go along with the existing
> > secid_to_secctx() LSM hook.  This patch also includes the SELinux
> > implementation for this hook.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
> This one can go up anytime, as we have other people wanting such a hook
> too.

I can't provide any justifications why it shouldn't go in,
and there will no doubt be places where the continued use of
secids will require it going forward.

> Or alternatively we need to rationalize the entire selinux/exports
> interface with these hooks as used by the networking and audit
> subsystems, as that issue will be coming up anyway for other LSMs.

Yeah. Smack is taking the pragmatic path, assuming that secid and
secctx will be around at least until pigs nest in trees. You left
out the USB subsystems's use of secid's, which may be the least
savory of all.

> One thing to note is that some of these interfaces treat the context as
> an opaque byte array of a given length, while other ones depend on the
> context to be a NUL-terminated string (e.g. audit).

Smack and SELiunx always provide a NUL-terminated string. I would
be in favor of defining a secctx as the textual representation of a
security blob. If we don't, we'll need to define a third thing that
is the text representation for audit before it's possible to convert
audit from SELinux calls to LSM calls. Converting audit to use LSM
calls will be mostly straitforward if the secctx can be assumed to
be a string.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
