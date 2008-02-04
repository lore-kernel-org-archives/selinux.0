Date: Mon, 4 Feb 2008 14:11:07 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200802041911.m14JB6eR017794@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: Re: checkpolicy patch: avoid warning in rawhide
Cc: jbrindle@tresys.com, sds@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It turns out the same issue also exists in policy_scan.l

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

 - todd

 checkpolicy/policy_scan.l   |    2 +-
 libsemanage/src/conf-scan.l |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: trunk/libsemanage/src/conf-scan.l
===================================================================
--- trunk/libsemanage/src/conf-scan.l	(revision 2783)
+++ trunk/libsemanage/src/conf-scan.l	(working copy)
@@ -32,7 +32,7 @@
 %}
 
 %option stack prefix="semanage_"
-%option nounput noyy_push_state noyy_pop_state noyy_top_state
+%option noinput nounput noyy_push_state noyy_pop_state noyy_top_state
 
 %x arg
 
Index: trunk/checkpolicy/policy_scan.l
===================================================================
--- trunk/checkpolicy/policy_scan.l	(revision 2783)
+++ trunk/checkpolicy/policy_scan.l	(working copy)
@@ -43,7 +43,7 @@
 unsigned int policydb_errors = 0;
 %}
 
-%option nounput
+%option noinput nounput
 
 %array
 letter  [A-Za-z]

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
