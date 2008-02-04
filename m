Date: Mon, 4 Feb 2008 13:43:15 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200802041843.m14IhF2x017588@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: Re: checkpolicy patch: avoid warning in rawhide
Cc: jbrindle@tresys.com, sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd C. Miller wrote:
> A build of trunk on rawhide (with an updated bison) dies in
> checkpolicy due to the input() function being defined but not used. 
> Fix is simple, define YY_NO_INPUT to prevent input() from being
> compiled. 

Of course I meant flex, not bison.  Here's a better fix.

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

 - todd

 policy_scan.l |    1 +
 1 file changed, 1 insertion(+)

Index: trunk/checkpolicy/policy_scan.l
===================================================================
--- trunk/checkpolicy/policy_scan.l	(revision 2783)
+++ trunk/checkpolicy/policy_scan.l	(working copy)
@@ -44,6 +44,7 @@
 %}
 
 %option nounput
+%option noinput
 
 %array
 letter  [A-Za-z]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
