Subject: Re: [PATCH 3/5] libsepol tests for the linker
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, kmacmillan@mentalrootkit.com
In-Reply-To: <1154618848.9569.3.camel@twoface.columbia.tresys.com>
References: <1154614654.4909.19.camel@twoface.columbia.tresys.com>
	 <1154618848.9569.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 12:36:55 -0400
Message-Id: <1154623015.32479.67.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-03 at 11:27 -0400, Joshua Brindle wrote:
> On Thu, 2006-08-03 at 10:17 -0400, Joshua Brindle wrote:
> > This tests the linker in a macro fashion. It basically runs policies
> > through the linker and tests for the expected result on the other
> > side.
> > The coverage is listed at the top of each test file
> > (test-linker-types.c).
> 
> updated for symtab_datum_t change

Thanks, all 5 patches merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
