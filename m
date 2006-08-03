Subject: Re: [PATCH 0/5] libsepol unit tests
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <1154614649.4909.17.camel@twoface.columbia.tresys.com>
References: <1154614649.4909.17.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 10:52:42 -0400
Message-Id: <1154616762.32479.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 10:17 -0400, Joshua Brindle wrote:
> This patchset adds unit tests to libsepol for the linker, the expander
> and the dependency algorithm as well as more infrastructure to make
> adding tests much easier. The linker and dep tests are fairly exhaustive
> but the expander ones will need to be added to over time. I lindented
> the patches but removed the line length limit, since almost all the
> calls were over 80 columns the link limit mutilated the tests and made
> them very difficult to read.

Needs to be updated for the symtab_datum_t change.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
