Subject: Re: selinux_audit_set_callback
From: Stephen Smalley <sds@tycho.nsa.gov>
To: casey@schaufler-ca.com
Cc: SELinux List <selinux@tycho.nsa.gov>, Audit List <linux-audit@redhat.com>
In-Reply-To: <160485.79511.qm@web36605.mail.mud.yahoo.com>
References: <160485.79511.qm@web36605.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 30 Jul 2007 10:46:22 -0400
Message-Id: <1185806782.15215.36.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-07-30 at 07:24 -0700, Casey Schaufler wrote:
> What is the rationale behind the selinux_audit_set_callback()
> mechanism? It looks for all the world as if the selinux code
> ought to be able to call the registered function directly.

Looks like it is a legacy of when the callback was a static function
registered from an initcall in the same file where the function was
defined.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
