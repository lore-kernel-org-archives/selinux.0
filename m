Message-ID: <465F1E77.1070301@tycho.nsa.gov>
Date: Thu, 31 May 2007 15:13:59 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: reindent selinux.h
References: <465E0BBC.4080508@tycho.nsa.gov> <1180620819.3340.239.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1180620819.3340.239.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Wed, 2007-05-30 at 19:41 -0400, Eamon Walsh wrote:
>   
>> We say that C++ is considered harmful, yet we have allowed "extern C" 
>> declarations to infect our header files and eat up 10% of every line.
>>
>> This claustrophobic madness must be stopped.
>>     
>
> While I don't object to the change, note that the next time someone runs
> 'make indent' on the tree, we'll be right back to where we were before.
> Unless we can make Lindent a bit smarter.
>   
The following works for me:

Index: scripts/Lindent
===================================================================
--- scripts/Lindent	(revision 2445)
+++ scripts/Lindent	(working copy)
@@ -1,2 +1,8 @@
 #!/bin/sh
+
+perl -e 'undef $/;' -pi \
+     -e 's|#ifdef __cplusplus\n(.*?)\n#endif|//__CPP \1|g' "$@"
+
 indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs "$@"
+
+perl -pi -e 's|^//__CPP (.*)$|#ifdef __cplusplus\n\1\n#endif|' "$@"



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
