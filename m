Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0KKxa9h000347
 for <selinux@tycho.nsa.gov>; Wed, 20 Jan 2016 15:59:36 -0500
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: User range vs. context's range
To: SELinux List <selinux@tycho.nsa.gov>
Message-ID: <569FF52A.6040207@tresys.com>
Date: Wed, 20 Jan 2016 15:59:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

What is the intended behavior for a user's allowed range in the policy
vs. any labels in the policy (e.g. netifcon)?  My expectation is that
the allowed range should still apply, but it doesn't seem that
checkpolicy checks that, based on what I've seen.  For example, the new
sediff test policies have this user[1]:

user added_user roles system level s1 range s1;

and checkpolicy doesn't error on this[2] later in the policy:

genfscon added_genfs / added_user:object_r:system:s0

I think this should fail compilation since s0 is not in added_user's
allowed range.



[1]
https://github.com/TresysTechnology/setools/blob/master/tests/diff_right.conf#L605
[2]
https://github.com/TresysTechnology/setools/blob/master/tests/diff_right.conf#L633

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
