Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA01500
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 13:57:04 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA08432
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 17:57:03 GMT
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.101])
	by jazzswing.ncsc.mil  with ESMTP id RAA08428
	for <selinux@tycho.nsa.gov>; Tue, 21 May 2002 17:57:01 GMT
Subject: RE: Policy creation RFC
To: "Frank Mayer" <mayerf@tresys.com>
Cc: <selinux@tycho.nsa.gov>, "Ian Sollars" <ian.sollars@gmx.net>
Message-ID: <OF8E41A9E0.D4ECB574-ON85256BC0.00522D85@us.ibm.com>
From: "Trent Jaeger" <jaegert@us.ibm.com>
Date: Tue, 21 May 2002 13:56:51 -0400
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=0ABBE153DFC1AB158f9e8a93df938690918c0ABBE153DFC1AB15"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0__=0ABBE153DFC1AB158f9e8a93df938690918c0ABBE153DFC1AB15
Content-type: text/plain; charset=US-ASCII

                                                                                                               
                                                                                                               
                                                                                                               


Hi,

We have been working on policy modeling (mostly models and specific
analyses) here as well, and have gained some experience with SELinux
policies.  I think that Frank raises a number of points that our community
will need to address:

--- Default versus "operational dynamic" policy -- My opinion is that any
legitimately modifiable policy needs a simpler model (not just interface)
than the SELinux model.  As Tom pointed out, the level of expertise of the
folks making changes is less than those who established the original
policy.   Policies that are likely to be changed by folks with less
expertise require a simpler model (simpler policies will result).

--- Base policy -- A question I have is whether we can define a fixed base
policy for those services that will (or most likely will) appear in Linux
distributions.  We then support change (with a simpler policy) above that.
I do not think that we want or need to change all parts of the policy -- as
Tom identified he was only interested in a few aspects -- didn't mention
initrc for example.

--- "Official policy language" -- Based on the points above, it is clear to
me that a multiple policy languages will be necessary to support all the
modeling tasks.  However, these languages need to eventually be convertible
into the enforceable representation (SELinux AVT-style).

--- Parsing -- I have changed the SELinux parser (not the lex/yacc, but the
C code behind it) to compile policy.conf into my analysis model.  I was
hoping to do this at as high a level as possible, but I didn't go very
high.  For each base C function (called by the yacc rule), I have created a
stub function that calls a function pointer for each pass that can be
assigned whatever function you like (think LSM).  This means that most of
my C processing is completely different than the SELinux checkpolicy.  I am
sure that higher-level semantic concepts can be defined, but it seemed like
a lot of work.

--- Analysis -- Several folks are looking at analyses of various kinds.
However, we are probably using concepts that are only slightly different
(probably could be built on the same base).  However, we are all starting
(and splitting-off) from a low-level.  This argues for doing some work
defining high-level semantic concepts, but it is not in any single group's
best interests.  We need some good ideas here.

--- GUI (original point) -- I haven't done any significant work on this,
but it will need to be oriented toward the policy problem being solved.

Thoughts?

Regards,
Trent.
----------------------------------
Trent Jaeger
IBM T.J. Watson Research Center
19 Skyline Drive
Hawthorne, NY 10532
jaegert@watson.ibm.com
(914) 784-7225, FAX (914) 784-7595

--0__=0ABBE153DFC1AB158f9e8a93df938690918c0ABBE153DFC1AB15
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>Hi,<br>
<br>
We have been working on policy modeling (mostly models and specific analyses) here as well, and have gained some experience with SELinux policies.  I think that Frank raises a number of points that our community will need to address:<br>
<br>
--- Default versus &quot;operational dynamic&quot; policy -- My opinion is that any legitimately modifiable policy needs a simpler model (not just interface) than the SELinux model.  As Tom pointed out, the level of expertise of the folks making changes is less than those who established the original policy.   Policies that are likely to be changed by folks with less expertise require a simpler model (simpler policies will result).<br>
<br>
--- Base policy -- A question I have is whether we can define a fixed base policy for those services that will (or most likely will) appear in Linux distributions.  We then support change (with a simpler policy) above that.  I do not think that we want or need to change all parts of the policy -- as Tom identified he was only interested in a few aspects -- didn't mention initrc for example.<br>
<br>
--- &quot;Official policy language&quot; -- Based on the points above, it is clear to me that a multiple policy languages will be necessary to support all the modeling tasks.  However, these languages need to eventually be convertible into the enforceable representation (SELinux AVT-style).<br>
<br>
--- Parsing -- I have changed the SELinux parser (not the lex/yacc, but the C code behind it) to compile policy.conf into my analysis model.  I was hoping to do this at as high a level as possible, but I didn't go very high.  For each base C function (called by the yacc rule), I have created a stub function that calls a function pointer for each pass that can be assigned whatever function you like (think LSM).  This means that most of my C processing is completely different than the SELinux checkpolicy.  I am sure that higher-level semantic concepts can be defined, but it seemed like a lot of work.  <br>
<br>
--- Analysis -- Several folks are looking at analyses of various kinds.  However, we are probably using concepts that are only slightly different (probably could be built on the same base).  However, we are all starting (and splitting-off) from a low-level.  This argues for doing some work defining high-level semantic concepts, but it is not in any single group's best interests.  We need some good ideas here.<br>
<br>
--- GUI (original point) -- I haven't done any significant work on this, but it will need to be oriented toward the policy problem being solved.<br>
<br>
Thoughts?<br>
<br>
Regards,<br>
Trent.<br>
----------------------------------<br>
Trent Jaeger<br>
IBM T.J. Watson Research Center<br>
19 Skyline Drive<br>
Hawthorne, NY 10532<br>
jaegert@watson.ibm.com<br>
(914) 784-7225, FAX (914) 784-7595<br>
<br>
</body></html>
--0__=0ABBE153DFC1AB158f9e8a93df938690918c0ABBE153DFC1AB15--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
