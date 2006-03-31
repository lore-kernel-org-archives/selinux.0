Subject: Re: The sort algorithm is broken by the second rule,  We need a
	way to pin these rules to the top.
From: Stephen Smalley <sds@tycho.nsa.gov>
Reply-To: sds@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <442D47ED.6040007@tresys.com>
References: <442D41CA.8070702@redhat.com> <442D436A.1010805@tresys.com>
	 <442D4448.2090700@redhat.com>  <442D47ED.6040007@tresys.com>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 14:27:03 -0500
Message-Id: <1143833223.17469.37.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-03-31 at 10:17 -0500, Joshua Brindle wrote:
> Please note that the sorting algorithm is very much heuristic and not 
> perfect. In the discussions we've had around here about this we 
> determined that the correct solution is to make the regexes more 
> specific where possible.

In the old scheme (example policy build), types.fc always went first,
followed by the program .fc files in arbitrary order, leaving the
ordering as specified within each file, and the goal was to put most
generic patterns only in types.fc (manually ordered by the policy writer
based on his goal for prioritization) and to minimize use of regexes
(particularly ones that were overly broad and lacked a reasonably
specific stem) in the individual program .fc files.  Not saying that we
achieved that goal, but that was the approach.

Recent file_contexts seem to have _very_ broad regexes in an attempt to
cover many variations, but I think that this isn't good for
understanding.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
