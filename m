Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1R1QWDq018369
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 20:26:42 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1Q6eSlw002589
	for <selinux@tycho.nsa.gov>; Sat, 26 Feb 2005 06:40:56 GMT
Subject: RFE: inheritance
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: text/plain
Date: Sat, 26 Feb 2005 01:45:42 -0500
Message-Id: <1109400342.4581.25.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The Java problem is not solved yet.
The problem is that:
- Java needs its own domain due to legacy requirements
- Java should get all the permissions granted to user_t, since
it's a programming language, not an application to be confined.
- Calling base_user_macro($1_java_t) will not work IMHO.

Additionally, I've been looking for a way to inherit 
from multiple types for a while. I posted about this
some time ago re: sharing data between samba and httpd.
It would be nice if there was an easy way to combine 
the rules for several domains. Somebody wrote a perl script
about this, but I'm not sure what happened to that.

So, would it be possible to implement macros like 
INHERIT_SOURCE( { type 1, type 2, type 3 }, { new_type1, new_type2 })
INHERIT_TARGET( { type 1, type 2, type 3 }, { new_type1, new_type2 })

that post-process the policy, and do the following:

INHERIT_SOURCE is for granting a domain the access privileges of 
parent domains. It takes all rules that include type1, type2, type3..
as a source, and replicate those rules replacing typeX with new_type.
Only the source is replaced, not the target. This would be used for
inkscape, lame (if they're not fixed any time soon - I've emailed them),
and Java. 

INHERIT_TARGET would replicate rules that have the parent types
in the target of the rule, and replace that with the derived type(s).
Only the target is replaced, not the source. This would be used for
marking a data type as derived from other data_types, for example,
INHERIT_TARGET( { samba_share_t, httpd_sys_content_t },
samba_httpd_content_t)

So, for example, Java would INHERIT_SOURCE from user_t, 
so it would get the same privileges as user_t, but it would not
INHERIT_TARGET, so things like file_type_auto_trans() would
properly transition $1_java_t to the right user type.

Comments? I'm still trying to decide whether or not this is a stupid
idea...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
