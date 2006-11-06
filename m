Message-ID: <454F5BDC.2020202@redhat.com>
Date: Mon, 06 Nov 2006 10:59:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Latest policycoreutils patch - This time with the patch.
Content-Type: multipart/mixed;
 boundary="------------050702090307080805060808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050702090307080805060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

New audit message in newrole on failure

-fPIE on restorecond

/var/run/wtmp added to restorecond

Fixes for genhomedircon man page


--------------050702090307080805060808
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-1.32/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c	2006-09-29 11:50:09.000000000 -0400
+++ policycoreutils-1.32/newrole/newrole.c	2006-10-20 09:13:45.000000000 -0400
@@ -680,6 +680,7 @@
 	{
 		fprintf(stderr, _("newrole: incorrect password for %s\n"),
 			pw->pw_name);
+		send_audit_message(0, old_context, new_context, ttyn);
 		return (-1);
 	}
 	/* If we reach here, then we have authenticated the user. */
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/po/policycoreutils.pot policycoreutils-1.32/po/policycoreutils.pot
--- nsapolicycoreutils/po/policycoreutils.pot	2006-08-28 16:58:21.000000000 -0400
+++ policycoreutils-1.32/po/policycoreutils.pot	2006-10-20 09:14:03.000000000 -0400
@@ -8,7 +8,7 @@
 msgstr ""
 "Project-Id-Version: PACKAGE VERSION\n"
 "Report-Msgid-Bugs-To: \n"
-"POT-Creation-Date: 2006-06-29 15:53-0400\n"
+"POT-Creation-Date: 2006-10-20 09:14-0400\n"
 "PO-Revision-Date: YEAR-MO-DA HO:MI+ZONE\n"
 "Last-Translator: FULL NAME <EMAIL@ADDRESS>\n"
 "Language-Team: LANGUAGE <LL@li.org>\n"
@@ -26,221 +26,226 @@
 msgid "%s:  Can't load policy:  %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:97
+#: ../newrole/newrole.c:98
 #, c-format
 msgid "Out of memory!\n"
 msgstr ""
 
-#: ../newrole/newrole.c:199 ../run_init/run_init.c:126
+#: ../newrole/newrole.c:200 ../run_init/run_init.c:126
 #, c-format
 msgid "failed to initialize PAM\n"
 msgstr ""
 
-#: ../newrole/newrole.c:210
+#: ../newrole/newrole.c:211
 #, c-format
 msgid "failed to set PAM_TTY\n"
 msgstr ""
 
-#: ../newrole/newrole.c:246 ../run_init/run_init.c:154
+#: ../newrole/newrole.c:247 ../run_init/run_init.c:154
 msgid "Password:"
 msgstr ""
 
-#: ../newrole/newrole.c:281 ../run_init/run_init.c:189
+#: ../newrole/newrole.c:282 ../run_init/run_init.c:189
 #, c-format
 msgid "Cannot find your entry in the shadow passwd file.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:287 ../run_init/run_init.c:195
+#: ../newrole/newrole.c:288 ../run_init/run_init.c:195
 #, c-format
 msgid "getpass cannot open /dev/tty\n"
 msgstr ""
 
-#: ../newrole/newrole.c:354
+#: ../newrole/newrole.c:355
 #, c-format
 msgid "Error initing capabilities, aborting.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:368
+#: ../newrole/newrole.c:369
 #, c-format
 msgid "Error dropping capabilities, aborting\n"
 msgstr ""
 
-#: ../newrole/newrole.c:375
+#: ../newrole/newrole.c:376
 #, c-format
 msgid "Error changing uid, aborting.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:382
+#: ../newrole/newrole.c:383
 #, c-format
 msgid "Error resetting KEEPCAPS, aborting\n"
 msgstr ""
 
-#: ../newrole/newrole.c:390
+#: ../newrole/newrole.c:391
 #, c-format
 msgid "Error dropping SETUID capability, aborting\n"
 msgstr ""
 
-#: ../newrole/newrole.c:463
+#: ../newrole/newrole.c:410
+#, c-format
+msgid "Error connecting to audit system.\n"
+msgstr ""
+
+#: ../newrole/newrole.c:416
+#, c-format
+msgid "Error allocating memory.\n"
+msgstr ""
+
+#: ../newrole/newrole.c:423
+#, c-format
+msgid "Error sending audit message.\n"
+msgstr ""
+
+#: ../newrole/newrole.c:511
 #, c-format
 msgid "Sorry, newrole may be used only on a SELinux kernel.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:468
+#: ../newrole/newrole.c:516
 #, c-format
 msgid "Could not determine enforcing mode.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:488
+#: ../newrole/newrole.c:536
 #, c-format
 msgid "Error: multiple roles specified\n"
 msgstr ""
 
-#: ../newrole/newrole.c:498
+#: ../newrole/newrole.c:546
 #, c-format
 msgid "Error: multiple types specified\n"
 msgstr ""
 
-#: ../newrole/newrole.c:508
+#: ../newrole/newrole.c:556
 #, c-format
 msgid "Sorry, -l may be used with SELinux MLS support.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:515
+#: ../newrole/newrole.c:563
 #, c-format
 msgid "Error: multiple levels specified\n"
 msgstr ""
 
-#: ../newrole/newrole.c:537
+#: ../newrole/newrole.c:585
 #, c-format
 msgid "Couldn't get default type.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:559
+#: ../newrole/newrole.c:608
 #, c-format
 msgid "failed to get old_context.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:572
+#: ../newrole/newrole.c:621
 #, c-format
 msgid "failed to get new context.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:596
+#: ../newrole/newrole.c:645
 #, c-format
 msgid "cannot find your entry in the passwd file.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:606
+#: ../newrole/newrole.c:655
 #, c-format
 msgid "Error!  Shell is not valid.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:614
+#: ../newrole/newrole.c:663
 #, c-format
 msgid "Error!  Could not retrieve tty information.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:618
+#: ../newrole/newrole.c:667
 #, c-format
 msgid "Authenticating %s.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:632
+#: ../newrole/newrole.c:681
 #, c-format
 msgid "newrole: incorrect password for %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:657
+#: ../newrole/newrole.c:707
 #, c-format
 msgid "failed to set new role %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:671
+#: ../newrole/newrole.c:721
 #, c-format
 msgid "failed to set new type %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:688
+#: ../newrole/newrole.c:738
 #, c-format
 msgid "failed to build new range with level %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:693
+#: ../newrole/newrole.c:743
 #, c-format
 msgid "failed to set new range %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:708
+#: ../newrole/newrole.c:758
 #, c-format
 msgid "failed to convert new context to string\n"
 msgstr ""
 
-#: ../newrole/newrole.c:717
+#: ../newrole/newrole.c:766
 #, c-format
 msgid "%s is not a valid context\n"
 msgstr ""
 
-#: ../newrole/newrole.c:730
+#: ../newrole/newrole.c:780
 #, c-format
 msgid "Error!  Could not open %s.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:738
+#: ../newrole/newrole.c:788
 #, c-format
 msgid "%s!  Could not get current context for %s, not relabeling tty.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:757
+#: ../newrole/newrole.c:807
 #, c-format
 msgid "%s!  Could not get new context for %s, not relabeling tty.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:771
+#: ../newrole/newrole.c:821
 #, c-format
 msgid "%s!  Could not set new context for %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:784
+#: ../newrole/newrole.c:834
 #, c-format
 msgid "newrole: failure forking: %s"
 msgstr ""
 
-#: ../newrole/newrole.c:789
+#: ../newrole/newrole.c:839
 #, c-format
 msgid "Warning!  Could not restore context for %s\n"
 msgstr ""
 
-#: ../newrole/newrole.c:810
+#: ../newrole/newrole.c:860
 #, c-format
 msgid "%s changed labels.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:834
+#: ../newrole/newrole.c:884
 #, c-format
 msgid "Could not close descriptors.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:869 ../run_init/run_init.c:397
+#: ../newrole/newrole.c:909
 #, c-format
-msgid "Could not set exec context to %s.\n"
+msgid "Error allocating shell.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:881
+#: ../newrole/newrole.c:922 ../run_init/run_init.c:397
 #, c-format
-msgid "Error connecting to audit system.\n"
-msgstr ""
-
-#: ../newrole/newrole.c:886
-#, c-format
-msgid "Error allocating memory.\n"
-msgstr ""
-
-#: ../newrole/newrole.c:892
-#, c-format
-msgid "Error sending audit message.\n"
+msgid "Could not set exec context to %s.\n"
 msgstr ""
 
-#: ../newrole/newrole.c:903
+#: ../newrole/newrole.c:932
 msgid "failed to exec shell\n"
 msgstr ""
 
@@ -276,674 +281,683 @@
 msgid "authentication failed.\n"
 msgstr ""
 
-#: ../scripts/chcat:70 ../scripts/chcat:140
+#: ../scripts/chcat:75 ../scripts/chcat:145
 msgid "Requires at least one category"
 msgstr ""
 
-#: ../scripts/chcat:84 ../scripts/chcat:154
+#: ../scripts/chcat:89 ../scripts/chcat:159
 #, c-format
 msgid "Can not modify sensitivity levels using '+' on %s"
 msgstr ""
 
-#: ../scripts/chcat:88
+#: ../scripts/chcat:93
 #, c-format
 msgid "%s is already in %s"
 msgstr ""
 
-#: ../scripts/chcat:159 ../scripts/chcat:169
+#: ../scripts/chcat:164 ../scripts/chcat:174
 #, c-format
 msgid "%s is not in %s"
 msgstr ""
 
-#: ../scripts/chcat:232 ../scripts/chcat:237
+#: ../scripts/chcat:237 ../scripts/chcat:242
 msgid "Can not combine +/- with other types of categories"
 msgstr ""
 
-#: ../scripts/chcat:282
+#: ../scripts/chcat:287
 msgid "Can not have multiple sensitivities"
 msgstr ""
 
-#: ../scripts/chcat:288
+#: ../scripts/chcat:293
 #, c-format
 msgid "Usage %s CATEGORY File ..."
 msgstr ""
 
-#: ../scripts/chcat:289
+#: ../scripts/chcat:294
 #, c-format
 msgid "Usage %s -l CATEGORY user ..."
 msgstr ""
 
-#: ../scripts/chcat:290
+#: ../scripts/chcat:295
 #, c-format
 msgid "Usage %s [[+|-]CATEGORY],...]q File ..."
 msgstr ""
 
-#: ../scripts/chcat:291
+#: ../scripts/chcat:296
 #, c-format
 msgid "Usage %s -l [[+|-]CATEGORY],...]q user ..."
 msgstr ""
 
-#: ../scripts/chcat:292
+#: ../scripts/chcat:297
 #, c-format
 msgid "Usage %s -d File ..."
 msgstr ""
 
-#: ../scripts/chcat:293
+#: ../scripts/chcat:298
 #, c-format
 msgid "Usage %s -l -d user ..."
 msgstr ""
 
-#: ../scripts/chcat:294
+#: ../scripts/chcat:299
 #, c-format
 msgid "Usage %s -L"
 msgstr ""
 
-#: ../scripts/chcat:295
+#: ../scripts/chcat:300
 #, c-format
 msgid "Usage %s -L -l user"
 msgstr ""
 
-#: ../scripts/chcat:296
+#: ../scripts/chcat:301
 msgid "Use -- to end option list.  For example"
 msgstr ""
 
-#: ../scripts/chcat:297
+#: ../scripts/chcat:302
 msgid "chcat -- -CompanyConfidential /docs/businessplan.odt"
 msgstr ""
 
-#: ../scripts/chcat:298
+#: ../scripts/chcat:303
 msgid "chcat -l +CompanyConfidential juser"
 msgstr ""
 
-#: ../semanage/semanage:122
+#: ../semanage/semanage:127
 msgid "Requires 2 or more arguments"
 msgstr ""
 
-#: ../semanage/semanage:127
+#: ../semanage/semanage:132
 #, c-format
 msgid "%s not defined"
 msgstr ""
 
-#: ../semanage/semanage:151
+#: ../semanage/semanage:156
 #, c-format
 msgid "%s not valid for %s objects\n"
 msgstr ""
 
-#: ../semanage/semanage:178 ../semanage/semanage:186
+#: ../semanage/semanage:183 ../semanage/semanage:191
 msgid "range not supported on Non MLS machines"
 msgstr ""
 
-#: ../semanage/semanage:244
+#: ../semanage/semanage:249
 msgid "You must specify a role"
 msgstr ""
 
-#: ../semanage/semanage:246
+#: ../semanage/semanage:251
 msgid "You must specify a prefix"
 msgstr ""
 
-#: ../semanage/semanage:295
+#: ../semanage/semanage:300
 #, c-format
 msgid "Options Error %s "
 msgstr ""
 
-#: ../semanage/semanage:299
+#: ../semanage/semanage:304
 #, c-format
 msgid "Invalid value %s"
 msgstr ""
 
-#: ../semanage/seobject.py:124
+#: ../semanage/seobject.py:130
 msgid "translations not supported on non-MLS machines"
 msgstr ""
 
-#: ../semanage/seobject.py:131
+#: ../semanage/seobject.py:137
 #, python-format
 msgid "Unable to open %s: translations not supported on non-MLS machines"
 msgstr ""
 
-#: ../semanage/seobject.py:171 ../semanage/seobject.py:185
+#: ../semanage/seobject.py:177 ../semanage/seobject.py:191
 #, python-format
 msgid "Translations can not contain spaces '%s' "
 msgstr ""
 
-#: ../semanage/seobject.py:174
+#: ../semanage/seobject.py:180
 #, python-format
 msgid "Invalid Level '%s' "
 msgstr ""
 
-#: ../semanage/seobject.py:177
+#: ../semanage/seobject.py:183
 #, python-format
 msgid "%s already defined in translations"
 msgstr ""
 
-#: ../semanage/seobject.py:189
+#: ../semanage/seobject.py:195
 #, python-format
 msgid "%s not defined in translations"
 msgstr ""
 
-#: ../semanage/seobject.py:209
+#: ../semanage/seobject.py:215
 msgid "SELinux policy is not managed or store cannot be accessed."
 msgstr ""
 
-#: ../semanage/seobject.py:214
+#: ../semanage/seobject.py:220
 msgid "Cannot read policy store."
 msgstr ""
 
-#: ../semanage/seobject.py:219
+#: ../semanage/seobject.py:225
 msgid "Could not establish semanage connection"
 msgstr ""
 
-#: ../semanage/seobject.py:238 ../semanage/seobject.py:296
-#: ../semanage/seobject.py:343 ../semanage/seobject.py:424
-#: ../semanage/seobject.py:493 ../semanage/seobject.py:549
-#: ../semanage/seobject.py:1080 ../semanage/seobject.py:1119
-#: ../semanage/seobject.py:1188 ../semanage/seobject.py:1222
+#: ../semanage/seobject.py:244 ../semanage/seobject.py:302
+#: ../semanage/seobject.py:349 ../semanage/seobject.py:430
+#: ../semanage/seobject.py:501 ../semanage/seobject.py:559
+#: ../semanage/seobject.py:1090 ../semanage/seobject.py:1129
+#: ../semanage/seobject.py:1204 ../semanage/seobject.py:1238
 #, python-format
 msgid "Could not create a key for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:242 ../semanage/seobject.py:300
-#: ../semanage/seobject.py:347 ../semanage/seobject.py:353
+#: ../semanage/seobject.py:248 ../semanage/seobject.py:306
+#: ../semanage/seobject.py:353 ../semanage/seobject.py:359
 #, python-format
 msgid "Could not check if login mapping for %s is defined"
 msgstr ""
 
-#: ../semanage/seobject.py:244
+#: ../semanage/seobject.py:250
 #, python-format
 msgid "Login mapping for %s is already defined"
 msgstr ""
 
-#: ../semanage/seobject.py:248
+#: ../semanage/seobject.py:254
 #, python-format
 msgid "Linux User %s does not exist"
 msgstr ""
 
-#: ../semanage/seobject.py:252
+#: ../semanage/seobject.py:258
 #, python-format
 msgid "Could not create login mapping for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:256 ../semanage/seobject.py:438
+#: ../semanage/seobject.py:262 ../semanage/seobject.py:444
 #, python-format
 msgid "Could not set name for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:261 ../semanage/seobject.py:448
+#: ../semanage/seobject.py:267 ../semanage/seobject.py:454
 #, python-format
 msgid "Could not set MLS range for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:265
+#: ../semanage/seobject.py:271
 #, python-format
 msgid "Could not set SELinux user for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:269 ../semanage/seobject.py:321
-#: ../semanage/seobject.py:359 ../semanage/seobject.py:463
-#: ../semanage/seobject.py:526 ../semanage/seobject.py:565
-#: ../semanage/seobject.py:692 ../semanage/seobject.py:734
-#: ../semanage/seobject.py:763 ../semanage/seobject.py:890
-#: ../semanage/seobject.py:931 ../semanage/seobject.py:963
-#: ../semanage/seobject.py:1060 ../semanage/seobject.py:1103
-#: ../semanage/seobject.py:1135 ../semanage/seobject.py:1206
-#: ../semanage/seobject.py:1238
+#: ../semanage/seobject.py:275 ../semanage/seobject.py:327
+#: ../semanage/seobject.py:365 ../semanage/seobject.py:470
+#: ../semanage/seobject.py:536 ../semanage/seobject.py:575
+#: ../semanage/seobject.py:702 ../semanage/seobject.py:744
+#: ../semanage/seobject.py:773 ../semanage/seobject.py:900
+#: ../semanage/seobject.py:941 ../semanage/seobject.py:973
+#: ../semanage/seobject.py:1070 ../semanage/seobject.py:1113
+#: ../semanage/seobject.py:1145 ../semanage/seobject.py:1222
+#: ../semanage/seobject.py:1254
 msgid "Could not start semanage transaction"
 msgstr ""
 
-#: ../semanage/seobject.py:273 ../semanage/seobject.py:277
+#: ../semanage/seobject.py:279 ../semanage/seobject.py:283
 #, python-format
 msgid "Could not add login mapping for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:292
+#: ../semanage/seobject.py:298
 msgid "Requires seuser or serange"
 msgstr ""
 
-#: ../semanage/seobject.py:302 ../semanage/seobject.py:349
+#: ../semanage/seobject.py:308 ../semanage/seobject.py:355
 #, python-format
 msgid "Login mapping for %s is not defined"
 msgstr ""
 
-#: ../semanage/seobject.py:306
+#: ../semanage/seobject.py:312
 #, python-format
 msgid "Could not query seuser for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:325 ../semanage/seobject.py:329
+#: ../semanage/seobject.py:331 ../semanage/seobject.py:335
 #, python-format
 msgid "Could not modify login mapping for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:355
+#: ../semanage/seobject.py:361
 #, python-format
 msgid "Login mapping for %s is defined in policy, cannot be deleted"
 msgstr ""
 
-#: ../semanage/seobject.py:364 ../semanage/seobject.py:368
+#: ../semanage/seobject.py:370 ../semanage/seobject.py:374
 #, python-format
 msgid "Could not delete login mapping for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:382
+#: ../semanage/seobject.py:388
 msgid "Could not list login mappings"
 msgstr ""
 
-#: ../semanage/seobject.py:428 ../semanage/seobject.py:497
-#: ../semanage/seobject.py:553 ../semanage/seobject.py:559
+#: ../semanage/seobject.py:434 ../semanage/seobject.py:505
+#: ../semanage/seobject.py:563 ../semanage/seobject.py:569
 #, python-format
 msgid "Could not check if SELinux user %s is defined"
 msgstr ""
 
-#: ../semanage/seobject.py:430
+#: ../semanage/seobject.py:436
 #, python-format
 msgid "SELinux user %s is already defined"
 msgstr ""
 
-#: ../semanage/seobject.py:434
+#: ../semanage/seobject.py:440
 #, python-format
 msgid "Could not create SELinux user for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:443
+#: ../semanage/seobject.py:449
 #, python-format
 msgid "Could not add role %s for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:452
+#: ../semanage/seobject.py:458
 #, python-format
 msgid "Could not set MLS level for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:456
+#: ../semanage/seobject.py:460 ../semanage/seobject.py:527
+#, python-format
+msgid "Invalid prefix %s"
+msgstr ""
+
+#: ../semanage/seobject.py:463
 #, python-format
 msgid "Could not add prefix %s for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:459
+#: ../semanage/seobject.py:466
 #, python-format
 msgid "Could not extract key for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:467 ../semanage/seobject.py:471
+#: ../semanage/seobject.py:474 ../semanage/seobject.py:478
 #, python-format
 msgid "Could not add SELinux user %s"
 msgstr ""
 
-#: ../semanage/seobject.py:487
+#: ../semanage/seobject.py:495
 msgid "Requires prefix, roles, level or range"
 msgstr ""
 
-#: ../semanage/seobject.py:489
+#: ../semanage/seobject.py:497
 msgid "Requires prefix or roles"
 msgstr ""
 
-#: ../semanage/seobject.py:499 ../semanage/seobject.py:555
+#: ../semanage/seobject.py:507 ../semanage/seobject.py:565
 #, python-format
 msgid "SELinux user %s is not defined"
 msgstr ""
 
-#: ../semanage/seobject.py:503
+#: ../semanage/seobject.py:511
 #, python-format
 msgid "Could not query user for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:530 ../semanage/seobject.py:534
+#: ../semanage/seobject.py:540 ../semanage/seobject.py:544
 #, python-format
 msgid "Could not modify SELinux user %s"
 msgstr ""
 
-#: ../semanage/seobject.py:561
+#: ../semanage/seobject.py:571
 #, python-format
 msgid "SELinux user %s is defined in policy, cannot be deleted"
 msgstr ""
 
-#: ../semanage/seobject.py:569 ../semanage/seobject.py:573
+#: ../semanage/seobject.py:579 ../semanage/seobject.py:583
 #, python-format
 msgid "Could not delete SELinux user %s"
 msgstr ""
 
-#: ../semanage/seobject.py:585
+#: ../semanage/seobject.py:595
 msgid "Could not list SELinux users"
 msgstr ""
 
-#: ../semanage/seobject.py:591
+#: ../semanage/seobject.py:601
 #, python-format
 msgid "Could not list roles for user %s"
 msgstr ""
 
-#: ../semanage/seobject.py:625
+#: ../semanage/seobject.py:635
 msgid "Protocol udp or tcp is required"
 msgstr ""
 
-#: ../semanage/seobject.py:627
+#: ../semanage/seobject.py:637
 msgid "Port is required"
 msgstr ""
 
-#: ../semanage/seobject.py:638
+#: ../semanage/seobject.py:648
 #, python-format
 msgid "Could not create a key for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:649
+#: ../semanage/seobject.py:659
 msgid "Type is required"
 msgstr ""
 
-#: ../semanage/seobject.py:655 ../semanage/seobject.py:717
-#: ../semanage/seobject.py:751 ../semanage/seobject.py:757
+#: ../semanage/seobject.py:665 ../semanage/seobject.py:727
+#: ../semanage/seobject.py:761 ../semanage/seobject.py:767
 #, python-format
 msgid "Could not check if port %s/%s is defined"
 msgstr ""
 
-#: ../semanage/seobject.py:657
+#: ../semanage/seobject.py:667
 #, python-format
 msgid "Port %s/%s already defined"
 msgstr ""
 
-#: ../semanage/seobject.py:661
+#: ../semanage/seobject.py:671
 #, python-format
 msgid "Could not create port for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:667
+#: ../semanage/seobject.py:677
 #, python-format
 msgid "Could not create context for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:671
+#: ../semanage/seobject.py:681
 #, python-format
 msgid "Could not set user in port context for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:675
+#: ../semanage/seobject.py:685
 #, python-format
 msgid "Could not set role in port context for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:679
+#: ../semanage/seobject.py:689
 #, python-format
 msgid "Could not set type in port context for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:684
+#: ../semanage/seobject.py:694
 #, python-format
 msgid "Could not set mls fields in port context for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:688
+#: ../semanage/seobject.py:698
 #, python-format
 msgid "Could not set port context for %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:696 ../semanage/seobject.py:700
+#: ../semanage/seobject.py:706 ../semanage/seobject.py:710
 #, python-format
 msgid "Could not add port %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:709 ../semanage/seobject.py:906
+#: ../semanage/seobject.py:719 ../semanage/seobject.py:916
 msgid "Requires setype or serange"
 msgstr ""
 
-#: ../semanage/seobject.py:711
+#: ../semanage/seobject.py:721
 msgid "Requires setype"
 msgstr ""
 
-#: ../semanage/seobject.py:719 ../semanage/seobject.py:753
+#: ../semanage/seobject.py:729 ../semanage/seobject.py:763
 #, python-format
 msgid "Port %s/%s is not defined"
 msgstr ""
 
-#: ../semanage/seobject.py:723
+#: ../semanage/seobject.py:733
 #, python-format
 msgid "Could not query port %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:738 ../semanage/seobject.py:742
+#: ../semanage/seobject.py:748 ../semanage/seobject.py:752
 #, python-format
 msgid "Could not modify port %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:759
+#: ../semanage/seobject.py:769
 #, python-format
 msgid "Port %s/%s is defined in policy, cannot be deleted"
 msgstr ""
 
-#: ../semanage/seobject.py:767 ../semanage/seobject.py:771
+#: ../semanage/seobject.py:777 ../semanage/seobject.py:781
 #, python-format
 msgid "Could not delete port %s/%s"
 msgstr ""
 
-#: ../semanage/seobject.py:779 ../semanage/seobject.py:798
+#: ../semanage/seobject.py:789 ../semanage/seobject.py:808
 msgid "Could not list ports"
 msgstr ""
 
-#: ../semanage/seobject.py:842 ../semanage/seobject.py:1014
+#: ../semanage/seobject.py:852 ../semanage/seobject.py:1024
 msgid "SELinux Type is required"
 msgstr ""
 
-#: ../semanage/seobject.py:846 ../semanage/seobject.py:910
-#: ../semanage/seobject.py:947 ../semanage/seobject.py:1018
+#: ../semanage/seobject.py:856 ../semanage/seobject.py:920
+#: ../semanage/seobject.py:957 ../semanage/seobject.py:1028
 #, python-format
 msgid "Could not create key for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:850 ../semanage/seobject.py:914
-#: ../semanage/seobject.py:951 ../semanage/seobject.py:957
+#: ../semanage/seobject.py:860 ../semanage/seobject.py:924
+#: ../semanage/seobject.py:961 ../semanage/seobject.py:967
 #, python-format
 msgid "Could not check if interface %s is defined"
 msgstr ""
 
-#: ../semanage/seobject.py:852
+#: ../semanage/seobject.py:862
 #, python-format
 msgid "Interface %s already defined"
 msgstr ""
 
-#: ../semanage/seobject.py:856
+#: ../semanage/seobject.py:866
 #, python-format
 msgid "Could not create interface for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:861 ../semanage/seobject.py:1033
+#: ../semanage/seobject.py:871 ../semanage/seobject.py:1043
 #, python-format
 msgid "Could not create context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:865
+#: ../semanage/seobject.py:875
 #, python-format
 msgid "Could not set user in interface context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:869
+#: ../semanage/seobject.py:879
 #, python-format
 msgid "Could not set role in interface context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:873
+#: ../semanage/seobject.py:883
 #, python-format
 msgid "Could not set type in interface context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:878
+#: ../semanage/seobject.py:888
 #, python-format
 msgid "Could not set mls fields in interface context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:882
+#: ../semanage/seobject.py:892
 #, python-format
 msgid "Could not set interface context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:886
+#: ../semanage/seobject.py:896
 #, python-format
 msgid "Could not set message context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:894 ../semanage/seobject.py:898
+#: ../semanage/seobject.py:904 ../semanage/seobject.py:908
 #, python-format
 msgid "Could not add interface %s"
 msgstr ""
 
-#: ../semanage/seobject.py:916 ../semanage/seobject.py:953
+#: ../semanage/seobject.py:926 ../semanage/seobject.py:963
 #, python-format
 msgid "Interface %s is not defined"
 msgstr ""
 
-#: ../semanage/seobject.py:920
+#: ../semanage/seobject.py:930
 #, python-format
 msgid "Could not query interface %s"
 msgstr ""
 
-#: ../semanage/seobject.py:935 ../semanage/seobject.py:939
+#: ../semanage/seobject.py:945 ../semanage/seobject.py:949
 #, python-format
 msgid "Could not modify interface %s"
 msgstr ""
 
-#: ../semanage/seobject.py:959
+#: ../semanage/seobject.py:969
 #, python-format
 msgid "Interface %s is defined in policy, cannot be deleted"
 msgstr ""
 
-#: ../semanage/seobject.py:967 ../semanage/seobject.py:971
+#: ../semanage/seobject.py:977 ../semanage/seobject.py:981
 #, python-format
 msgid "Could not delete interface %s"
 msgstr ""
 
-#: ../semanage/seobject.py:979
+#: ../semanage/seobject.py:989
 msgid "Could not list interfaces"
 msgstr ""
 
-#: ../semanage/seobject.py:1022 ../semanage/seobject.py:1084
-#: ../semanage/seobject.py:1123 ../semanage/seobject.py:1129
+#: ../semanage/seobject.py:1032 ../semanage/seobject.py:1094
+#: ../semanage/seobject.py:1133 ../semanage/seobject.py:1137
 #, python-format
 msgid "Could not check if file context for %s is defined"
 msgstr ""
 
-#: ../semanage/seobject.py:1024
+#: ../semanage/seobject.py:1034
 #, python-format
 msgid "File context for %s already defined"
 msgstr ""
 
-#: ../semanage/seobject.py:1028
+#: ../semanage/seobject.py:1038
 #, python-format
 msgid "Could not create file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1037
+#: ../semanage/seobject.py:1047
 #, python-format
 msgid "Could not set user in file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1041
+#: ../semanage/seobject.py:1051
 #, python-format
 msgid "Could not set role in file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1045
+#: ../semanage/seobject.py:1055
 #, python-format
 msgid "Could not set type in file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1050
+#: ../semanage/seobject.py:1060
 #, python-format
 msgid "Could not set mls fields in file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1056
+#: ../semanage/seobject.py:1066
 #, python-format
 msgid "Could not set file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1064 ../semanage/seobject.py:1068
+#: ../semanage/seobject.py:1074 ../semanage/seobject.py:1078
 #, python-format
 msgid "Could not add file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1076
+#: ../semanage/seobject.py:1086
 msgid "Requires setype, serange or seuser"
 msgstr ""
 
-#: ../semanage/seobject.py:1086 ../semanage/seobject.py:1125
+#: ../semanage/seobject.py:1096 ../semanage/seobject.py:1141
 #, python-format
 msgid "File context for %s is not defined"
 msgstr ""
 
-#: ../semanage/seobject.py:1090
+#: ../semanage/seobject.py:1100
 #, python-format
 msgid "Could not query file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1107 ../semanage/seobject.py:1111
+#: ../semanage/seobject.py:1117 ../semanage/seobject.py:1121
 #, python-format
 msgid "Could not modify file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1131
+#: ../semanage/seobject.py:1139
 #, python-format
 msgid "File context for %s is defined in policy, cannot be deleted"
 msgstr ""
 
-#: ../semanage/seobject.py:1139 ../semanage/seobject.py:1143
+#: ../semanage/seobject.py:1149 ../semanage/seobject.py:1153
 #, python-format
 msgid "Could not delete file context for %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1151
+#: ../semanage/seobject.py:1161
 msgid "Could not list file contexts"
 msgstr ""
 
-#: ../semanage/seobject.py:1184
+#: ../semanage/seobject.py:1165
+msgid "Could not list local file contexts"
+msgstr ""
+
+#: ../semanage/seobject.py:1200
 msgid "Requires value"
 msgstr ""
 
-#: ../semanage/seobject.py:1192 ../semanage/seobject.py:1226
-#: ../semanage/seobject.py:1232
+#: ../semanage/seobject.py:1208 ../semanage/seobject.py:1242
+#: ../semanage/seobject.py:1248
 #, python-format
 msgid "Could not check if boolean %s is defined"
 msgstr ""
 
-#: ../semanage/seobject.py:1194 ../semanage/seobject.py:1228
+#: ../semanage/seobject.py:1210 ../semanage/seobject.py:1244
 #, python-format
 msgid "Boolean %s is not defined"
 msgstr ""
 
-#: ../semanage/seobject.py:1198
+#: ../semanage/seobject.py:1214
 #, python-format
 msgid "Could not query file context %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1210 ../semanage/seobject.py:1214
+#: ../semanage/seobject.py:1226 ../semanage/seobject.py:1230
 #, python-format
 msgid "Could not modify boolean %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1234
+#: ../semanage/seobject.py:1250
 #, python-format
 msgid "Boolean %s is defined in policy, cannot be deleted"
 msgstr ""
 
-#: ../semanage/seobject.py:1242 ../semanage/seobject.py:1246
+#: ../semanage/seobject.py:1258 ../semanage/seobject.py:1262
 #, python-format
 msgid "Could not delete boolean %s"
 msgstr ""
 
-#: ../semanage/seobject.py:1254
+#: ../semanage/seobject.py:1270
 msgid "Could not list booleans"
 msgstr ""
 
-#: ../audit2allow/audit2allow:179
+#: ../audit2allow/audit2allow:183
 #, c-format
 msgid "Generating type enforcment file: %s.te"
 msgstr ""
 
-#: ../audit2allow/audit2allow:184
+#: ../audit2allow/audit2allow:188
 msgid "Compiling policy"
 msgstr ""
 
-#: ../audit2allow/audit2allow:195
+#: ../audit2allow/audit2allow:199
 msgid ""
 "\n"
 "******************** IMPORTANT ***********************\n"
 msgstr ""
 
-#: ../audit2allow/audit2allow:196
+#: ../audit2allow/audit2allow:200
 #, c-format
 msgid ""
 "In order to load this newly created policy package into the kernel,\n"
@@ -953,7 +967,7 @@
 "\n"
 msgstr ""
 
-#: ../audit2allow/audit2allow:203
+#: ../audit2allow/audit2allow:207
 #, c-format
 msgid "Options Error: %s "
 msgstr ""
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecond/Makefile policycoreutils-1.32/restorecond/Makefile
--- nsapolicycoreutils/restorecond/Makefile	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.32/restorecond/Makefile	2006-10-20 09:13:45.000000000 -0400
@@ -5,8 +5,9 @@
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
-CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+LDFLAGS ?= -pie
+CFLAGS ?= -g -Werror -Wall -W 
+override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
 LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 
 all: restorecond
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecond/restorecond.conf policycoreutils-1.32/restorecond/restorecond.conf
--- nsapolicycoreutils/restorecond/restorecond.conf	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.32/restorecond/restorecond.conf	2006-10-23 10:27:22.000000000 -0400
@@ -2,5 +2,6 @@
 /etc/samba/secrets.tdb
 /etc/mtab
 /var/run/utmp
+/var/log/wtmp
 ~/public_html
 ~/.mozilla/plugins/libflashplayer.so
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/genhomedircon.8 policycoreutils-1.32/scripts/genhomedircon.8
--- nsapolicycoreutils/scripts/genhomedircon.8	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.32/scripts/genhomedircon.8	2006-11-06 10:15:40.000000000 -0500
@@ -45,35 +45,30 @@
 .SH DESCRIPTION
 .PP
 This utility is used to generate file context configuration entries for 
-user home directories based on their default roles and is run when building 
-the policy. It can also be run when ever the 
-.I /etc/selinux/<<SELINUXTYPE>>/users/local.users
-file is changed 
+user home directories based on their 
+.B prefix 
+entry in the the 
+.B semanage user record.  
+genhomedircon is run when building 
+the policy. It is also run automaticaly when ever the 
+.B semanage 
+utility modifies 
+.B user
+or
+.B login
+records.
 Specifically, we replace HOME_ROOT, HOME_DIR, and ROLE macros in the 
 .I /etc/selinux/<<SELINUXTYPE>>/contexts/files/homedir_template 
-file with generic and user-specific values.
-.I local.users
-file. If a user has more than one role in 
-.I local.users,
-.B genhomedircon
-uses the first role in the list. 
+file with generic and user-specific values.  HOME_ROOT and HOME_DIR is replaced with each distinct location where login users homedirectories are located.  Defaults to /home. ROLE is replaced based on the prefix entry in the 
+.B user
+record.
 .PP 
-If a user is not listed in 
-.I local.users,
-.B genhomedircon
-assumes that the user's home dir will be found in one of the
-HOME_ROOTs. 
-When looking for these users, 
-.B genhomedircon
-only considers real users. "Real" users (as opposed
-to system users) are those whose UID is greater than or equal 
+genhomedircon searches through all password entires for all "login" user home directories, (as opposed
+to system users).  Login users are those whose UID is greater than or equal 
 .I STARTING_UID
 (default 500) and whose login shell is not "/sbin/nologin", or
 "/bin/false". 
 .PP 
-Users who are explicitly defined in 
-.I local.users,
-are always "real" (including root, in the default configuration).
 .SH AUTHOR
 This manual page was originally written by 
 .I Manoj Srivastava <srivasta@debian.org>,
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.32/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2006-09-14 08:07:24.000000000 -0400
+++ policycoreutils-1.32/semanage/semanage.8	2006-10-20 09:13:45.000000000 -0400
@@ -7,7 +7,7 @@
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
-.B semanage user \-{a|d|m} [\-LrR] selinux_name
+.B semanage user \-{a|d|m} [\-LrRP] selinux_name
 .br
 .B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
 .br
@@ -71,6 +71,9 @@
 .I                \-R, \-\-role
 SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify \-R multiple times.
 .TP
+.I                \-P, \-\-prefix
+SELinux Prefix.  Prefix added to home_dir_t and home_t for labeling users home directories.
+.TP
 .I                \-s, \-\-seuser     
 SELinux user name
 .TP
diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/semanage/seobject.py policycoreutils-1.32/semanage/seobject.py
--- nsapolicycoreutils/semanage/seobject.py	2006-10-17 12:04:55.000000000 -0400
+++ policycoreutils-1.32/semanage/seobject.py	2006-10-20 09:13:45.000000000 -0400
@@ -456,7 +456,8 @@
 				rc = semanage_user_set_mlslevel(self.sh, u, selevel)
 				if rc < 0:
 					raise ValueError(_("Could not set MLS level for %s") % name)
-
+                        if selinux.security_check_context("system_u:object_r:%s_home_t:s0" % prefix) != 0:
+                               raise ValueError(_("Invalid prefix %s") % prefix)
 			rc = semanage_user_set_prefix(self.sh, u, prefix)
 			if rc < 0:
 				raise ValueError(_("Could not add prefix %s for %s") % (r, prefix))
@@ -522,7 +523,9 @@
 				semanage_user_set_mlslevel(self.sh, u, untranslate(selevel))
 
 			if prefix != "":
-				semanage_user_set_prefix(self.sh, u, prefix)
+                               if selinux.security_check_context("system_u:object_r:%s_home_t" % prefix) != 0:
+                                      raise ValueError(_("Invalid prefix %s") % prefix)
+                               semanage_user_set_prefix(self.sh, u, prefix)
 
 			if len(roles) != 0:
 				for r in roles:

--------------050702090307080805060808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
