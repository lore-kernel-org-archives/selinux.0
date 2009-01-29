Subject: Re: [PATCH][RFC] selinux: remove noop secondary_ops calls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, eparis@redhat.com,
        linux-security-module@vger.kernel.org
In-Reply-To: <1233201347-17568-1-git-send-email-jmorris@namei.org>
References: <1233201347-17568-1-git-send-email-jmorris@namei.org>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 12:52:03 -0500
Message-Id: <1233251523.5109.132.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-01-28 at 19:55 -0800, James Morris wrote:
> These patches remove calls to secondary_ops where there is no
> real capability hook, and a couple of SELinux hooks which only
> called these noop hooks.

These look fine to me, modulo the comments already made by Eric and
Serge.

You could further replace the remaining secondary_ops calls with direct
cap_ calls, since the dummy module is gone and the secondary module can
only be the capability module.  Smack and AppArmor already do this, I
believe.

At that point secondary_ops would only be used by selinux_init() to save
the original security_ops pointer for use by selinux_disable() to
restore the original pointer, which ideally would be handled by the
security framework instead (possibly by restoring a limited
unregister_security() that resets to the default_security_ops).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
