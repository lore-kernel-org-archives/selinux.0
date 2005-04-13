Subject: Re: policy hierarchy patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
In-Reply-To: <425456F1.5000905@trustedcs.com>
References: <1112631282.19526.18.camel@localhost>
	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>
	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>
	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>
	 <425456F1.5000905@trustedcs.com>
Content-Type: text/plain
Date: Wed, 13 Apr 2005 12:16:12 -0400
Message-Id: <1113408972.29415.95.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-04-06 at 16:38 -0500, Darrel Goeddel wrote:
> There is a slightly modified behavior with this patch.  Previously, if you
> specified a category that did not exist (or was not allowed to be associated
> with the specified sensitivity) in a context or rule with mls portions, the
> compiler would issue a warning and keep on chugging.  This generated a perfectly
> nice policy, but you may not be getting what you wanted due to a typo or
> misconfiguration because you missed a warning.  The compiler now treats these
> circumstances as errors just as if you tried to use a type that does not exist
> in an allow rule.

Just to clarify, anytime the compiler calls yyerror (which it was doing
for these errors), it was incrementing policydb_errors, and checkpolicy
checks policydb_errors after yyparse() returns and bails out at that
point if it is non-zero.  Hence, the compiler wasn't treating them as
just warnings, but was proceeding to parse the rest of the policy since
the error didn't prevent continued processing (e.g. so that if you had
several such errors, they would all get reported in one pass rather than
having to repeatedly fix-and-compile, fix-and-compile, ...).

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
