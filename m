Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h82IhsLa018846
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 14:43:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h82Ihqet027276
	for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 18:43:52 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h82Ihqlq027273 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2003 18:43:52 GMT
Subject: RE: Type background of SELinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Jenkins, Steven" <JENKINSS@mail.etsu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3566@etsuex1.etsu.edu>
References: <C5FA5FEED6F0884E9EB90BB3C010F1EF8D3566@etsuex1.etsu.edu>
Content-Type: text/plain
Message-Id: <1062528167.18568.167.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 02 Sep 2003 14:42:47 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-29 at 17:22, Jenkins, Steven wrote:
>  Thanks, that's helpful.  Let me see if I understand this correctly:
>  
> * is there a notion of dynamic types?  
> * is there a common type hierarchy (or type tree, as in how C will automatically coerce int's into float's, for example)
> * how are interpreters (such as perl, python, etc) handled that have direct access to the C library?

They really are not types in that sense.  TE "types" have no implicit
relationships; all relationships (permissions) are established
explicitly through the definition of an access matrix.  It would
certainly be possible to support certain notions of inheritance and
hierarchy through extension of the policy configuration language, but
this would still just be compiled down to an explicit access matrix for
use by the kernel.  The TE "types" are OS-maintained security tags on
processes and objects, not something that can be directly manipulated
from applications; the language in which the application is written is
irrelevant, aside from secure transition issues.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
