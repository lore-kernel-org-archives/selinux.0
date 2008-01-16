From: David Howells <dhowells@redhat.com>
In-Reply-To: <AEF7FD5A-F622-46A1-8034-2FAF10CEBA46@mac.com>
References: <AEF7FD5A-F622-46A1-8034-2FAF10CEBA46@mac.com> <20080115234652.22183.24850.stgit@warthog.procyon.org.uk>
To: Kyle Moffett <mrlinuxman@mac.com>
Cc: dhowells@redhat.com, sds@tycho.nsa.gov, casey@schaufler-ca.com,
        Trond.Myklebust@netapp.com, npiggin@suse.de,
        linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH 00/26] Permit filesystem local caching
Date: Wed, 16 Jan 2008 16:55:31 +0000
Message-ID: <30682.1200502531@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kyle Moffett <mrlinuxman@mac.com> wrote:

> One vaguely related question:  Is there presently any way to adjust the
> per-user max-key-data limit?

There's no reason there can't be.  It just needs a policy deciding.  Do we
have:

 (1) One control for all.

 (2) One control for all non-root users; no quotas on root.

 (3) One control for root, one control for all non-root users.

 (3) Separate controls for all users.

Should this be a ulimit?  Should a non-root user be able to adjust their own
quotas within limits set by root?

How should the quota be accessed?  The obvious way is to have /proc or /sys
controls.

Non-root quotas tend to be transitory.  When the user_struct pinning them goes
out of scope, they tend to disappear.  How do we recover the settings, if at
all?

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
