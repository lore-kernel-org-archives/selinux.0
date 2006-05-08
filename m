Subject: Re: [PATCH] Libsepol test framework
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1146593621.15260.17.camel@jackjack.columbia.tresys.com>
References: <1146593621.15260.17.camel@jackjack.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:41:51 -0400
Message-Id: <1147092111.23640.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 14:13 -0400, Karl MacMillan wrote:
> Steve,
> 
> Attached are two patches to add a simple test framework to libsepol and,
> in the future, to the other libraries. It depends CUnit
> (http://cunit.sourceforge.net/), a workable if not exciting unit testing
> framework for C.
> 
> The compiler-cleanup patch is needed to make it easier for the unit
> tests to load source policies. I think that using source policies for
> unit testing libsepol will be more maintainable over the long run. It
> also removes some code duplication between checkpolicy.c and
> checkmodule.c.
> 
> The test-framework patch, which depends upon the computer-cleanup patch,
> adds a simple test to libsepol and the makefile changes
> to introduce a top-level make target "test". Example output from running
> the test target is included below.
> 
> The test policy is in a separate email to you because it is large (a
> complete base policy.conf from reference policy).
> 
> More patches with additional tests will be submitted over time.
> 
> Please apply.

Merged.  However, at present, this requires not only having a copy of
checkpolicy sources but also having them prebuilt (make test in libsepol
with checkpolicy sources present but not built will fail), which seems
undesirable.  Actual output that I see has only 36 asserts vs the output
you posted (19044?).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
