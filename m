Subject: Re: [PATCH] move module read/write code into libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jason Tang <jtang@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1122994854.5842.14.camel@localhost.localdomain>
References: <1122994854.5842.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 15:44:32 -0400
Message-Id: <1123011872.11904.56.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-08-02 at 11:00 -0400, Jason Tang wrote:
> With the newly agreed upon use of libsepol as "internal representation
> of data" it has become apparant that module read/write code really
> belongs in libsepol and not in libsemanage.  The following patch moves
> that logic into a new file libsepol/module.c.  It also corrects an
> outstanding error, by adding checkpolicy/test and
> policycoreutils/semodule_package into their parents' Makefile.

Other than the dismod issue, the patch looks good.  Thanks, merged (with
dismod presently not included in the build).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
