Message-ID: <43BC208E.7020905@cornell.edu>
Date: Wed, 04 Jan 2006 14:22:54 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, Joshua Brindle <jbrindle@tresys.com>,
   Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] [SETSEBOOL] Clone record on set/add/modify
References: <43BBD6C0.6020108@cornell.edu>	 <1136395785.27632.272.camel@moss-spartans.epoch.ncsc.mil>	 <43BBF408.7030701@cornell.edu> <1136399098.27632.284.camel@moss-spartans.epoch.ncsc.mil> <43BBFCB2.8@cornell.edu> <43BC3715.7030803@redhat.com> <43BC1EE4.3040603@cornell.edu>
In-Reply-To: <43BC1EE4.3040603@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------010204030407060304020907"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010204030407060304020907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> Well, the add function is broken, as you noted in your other mail, but 
> why it crashes I have no idea.
Here's a patch to fix the add function. Typically I test modify and 
assume add/set work - they're mostly the same.
I guess assumptions are a bad thing. Before Joshua says "I told you so" 
- I will update pywrap-test.py by tomorrow.

Now I'm curious to investigate the segfault - that should most 
definitely *not* happen.


--------------010204030407060304020907
Content-Type: text/x-patch;
 name="libsemanage.toggle_modify.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.toggle_modify.diff"

diff -Naurp --exclude man --exclude-from excludes old/libsemanage/src/database_llist.c new/libsemanage/src/database_llist.c
--- old/libsemanage/src/database_llist.c	2006-01-04 12:18:17.000000000 -0500
+++ new/libsemanage/src/database_llist.c	2006-01-04 14:16:49.000000000 -0500
@@ -136,6 +136,7 @@ hidden int dbase_llist_add(
 	if (dbase_llist_cache_prepend(handle, dbase, data) < 0)
 		goto err;
 
+	dbase->modified = 1;
 	return STATUS_SUCCESS;
 
 	err:

--------------010204030407060304020907--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
