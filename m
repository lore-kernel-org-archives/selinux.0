Subject: Re: [PATCH] libsepol: new capability to support open permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1204211394.3206.67.camel@localhost.localdomain>
References: <1204211394.3206.67.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 15:46:41 -0500
Message-Id: <1204231601.31790.214.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 10:09 -0500, Eric Paris wrote:
> This patch adds support for the new open_perms policy capability.
> Simple yet true.  I would like to point out that after this change
> checkpolicy will also need to be rebuilt with the new libsepol-static
> installed.

Merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
