Subject: Re: [PATCH 0/9] Open loaders and interpreters with new creds
 during exec
From: Stephen Smalley <sds@tycho.nsa.gov>
To: David Howells <dhowells@redhat.com>
Cc: Serge Hallyn <serge.hallyn@canonical.com>, eparis@redhat.com,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
        Oleg Nesterov
 <oleg@redhat.com>, casey@schaufler-ca.com
In-Reply-To: <21766.1304160537@redhat.com>
References: <20110428200218.GB9186@hallyn.com>
	 <20110421143020.31318.59457.stgit@warthog.procyon.org.uk>
	 <21766.1304160537@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 May 2011 09:28:31 -0400
Message-ID: <1304342911.16563.39.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2011-04-30 at 11:48 +0100, David Howells wrote:
> Of course, this may not apply to scripts, since we don't normally allow those
> to effect SUID/SGID transitions.  Should set-security-label transitions be
> ignored on scripts too (which I think was one of the points Casey was taking
> about)?  Should the script interpreter simply reset the credentials to those
> of the current user?

The kernel should allow set-security-label transitions on scripts;
SELinux makes use of such transitions particularly for system
initialization, where the caller is already at least as trusted as the
callee.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
