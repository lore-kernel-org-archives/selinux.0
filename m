Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA04385
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 11:32:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h06GW2I04884
	for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 16:32:02 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-smtp.csoconline.com [140.169.2.146])
        by jazzband.ncsc.mil  with SMTP id h06GVsf04880 for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2003 16:32:02 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015244A4@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
        mark.westerman@westcam.com
Subject: RE: Policy Language
Date: Mon, 6 Jan 2003 10:27:24 -0600 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I used the wrong terminology (ambiguous) Your are absolutely
correct that it is not ambiguous. While the following foo.y 
is easily handled in a (yacc) file, it is not so easily handled
in other languages. While I am asking could we put a ';' at the
end of all statements ? 

For a regular expression on the two statements.

CLASS identifier
CLASS identifier { identifier_list }

To identify the second from the first I have to look
for a { and not just a white space or a ;


whereas

CLASSDEF identifier
CLASS identifier { identifier_list }

I not longer have to look for '{' just a white space
on the CLASSDEF

If we use a ; at the end of all statement that would also
remove the difficulty of looking for a '{' to tell the difference
between the two  statements.

Would a ; be too difficult ? You could make the checkpolicy 
backwards compatible.



Mark









-----Original Message-----
From: Stephen D. Smalley [mailto:sds@epoch.ncsc.mil]
Sent: Monday, January 06, 2003 9:29 AM
To: selinux@tycho.nsa.gov; mark.westerman@westcam.com
Subject: Re: Policy Language



> In working toward a policy management system I have run across a few
> ambiguities in the language.

The grammar in policy_parse.y is unambiguous.  For that matter, the attached

grammar for the constructs that you mentioned is unambiguous, even with a 
completely free form statement list.  There are no conflicts.  What
precisely is 
the problem?

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
