Subject: [RFC] policy diffing of MLS levels/ranges
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Klaus Weidner <klaus@atsec.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Thu, 01 Mar 2007 18:42:23 +0000
Message-Id: <1172774544.19169.61.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For the next release of SETools, we are working on diffing MLS
components of the policy in the sediff/sediffx tools.  We're looking for
some feedback on how a diff for a range should be done.

Say for example we have the range: s0:c1,c2 - s2:c0.c10

The policy has:
* sensitivities s0 to s2, dominance in increasing numerical order
* categories c0 to c10
* each level allowed all categories

Then the policy is changed:
* remove category c5
* add sensitivity s1a between s1 and s2
* level s1a allowed category set is c1,c2

How should the difference in the above range be represented?

Our current idea is to present a diff of each level in the range.  The
diff for a level would show a level addition/removal if a sensitivity is
added/removed (dominance changes would be shown in a difference
section).  The level would be considered modified if categories are
added/removed by changing the category set allowed for the level (via
changing the level statement and/or adding/removing categories).  So the
first question would be, what should the category set be for each level
of a range?

We think it basically takes the top level's category set and uses it for
each level, dropping categories if they're not allowed for a particular
level.  However this doesn't really show that the minimal category set
is c1 and c2.  One way might be to specially mark the minimal category
set.  Another way might be to change setools' view of levels to instead
be the sensitivity and all combinations of categories.  However this
would quickly become overwhelming in a diff.  Other options would be to
report a level diff if the endpoints in a grouping change (s0:c0.c10 in
both the original and modified policy would not be reported as a change
since c5 is inside c0.c10).  Taking that further we could not report the
above as a diff since the endpoints of the range aren't different.

To make the above options clearer, here's how the outputs might look
like:

1) independent categories:

s0:c1,c2 - s2:c0.c10
added levels:
 + s1a: c1,c2
modified levels:
 * s0: c0,c1,c2,c3,c4,c6,c7,c8,c9,c10, -c5
 * s1: c0,c1,c2,c3,c4,c6,c7,c8,c9,c10, -c5
 * s2: c0,c1,c2,c3,c4,c6,c7,c8,c9,c10, -c5

1a) independent categories with min category set indicated

s0:c1,c2 - s2:c0.c10
added levels:
 + s1a: (c1,c2)
modified levels:
 * s0: (c1,c2) c0,c3,c4,c6,c7,c8,c9,c10,-c5
 * s1: (c1,c2) c0,c3,c4,c6,c7,c8,c9,c10,-c5
 * s2: (c1,c2) c0,c3,c4,c6,c7,c8,c9,c10,-c5

2) category combinations:

s0:c1,c2 - s2:c0.c10
added levels:
 + s1a: {c1,c2}
modified levels:
 * s0: -{c1,c2,c5}, -{c1,c2,c3,c5}, -{c1,c2,c3,c4,c5}, ....
 * s1: -{c1,c2,c5}, -{c1,c2,c3,c5}, -{c1,c2,c3,c4,c5}, ....
 * s2: -{c1,c2,c5}, -{c1,c2,c3,c5}, -{c1,c2,c3,c4,c5}, ....

3) diff only for changes in each level's category endpoints, and
added/removed levels:

s0:c1,c2 - s2:c0.c10
added levels:
 + s1a: c1,c2

4) diff only for changes in the range's endpoints
[no diff]

Suggestions?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
