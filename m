Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n61DWWTe010248
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 09:32:32 -0400
Received: from mx2.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n61DX84N028994
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 13:33:09 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n61DWV9M014796
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 09:32:31 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n61DWUo9022986
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 09:32:30 -0400
Received: from [10.16.3.86] (dhcp-100-3-86.bos.redhat.com [10.16.3.86])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n61DWU8r026830
	for <selinux@tycho.nsa.gov>; Wed, 1 Jul 2009 09:32:30 -0400
Message-ID: <4A4B656D.1030004@redhat.com>
Date: Wed, 01 Jul 2009 09:32:29 -0400
From: Christopher Pardy <cpardy@redhat.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: [Fwd: [Patch] libsemanage: remember and retrieve dontaudit settings]
Content-Type: multipart/mixed;
 boundary="------------040107070101060206070901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040107070101060206070901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Creates a empty file disable_dontaudit in the polciy directory
(/etc/selinux/<policytype>). Checks for the existance of this file to
set the sepol disable don't audit upon handle creation. Also provides
the function "int semanage_get_disable_dontaudit()" which returns the
don't audit property of the current policy.

Signed-off-by: Christopher Pardy <cpardy@redhat.com>

--------------040107070101060206070901
Content-Type: text/plain;
 name="libsemanage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage.patch"

diff -r selinux/libsemanage/include/semanage/handle.h selinux.old/libsemanage/include/semanage/handle.h
72,74d71
< /* Get the whether or not dontaudits are disabled upon commit */
< int semanage_get_disable_dontudit();
< 
Only in selinux/libsemanage/src: boolean_record.o
Only in selinux/libsemanage/src: booleans_activedb.o
Only in selinux/libsemanage/src: booleans_active.o
Only in selinux/libsemanage/src: booleans_file.o
Only in selinux/libsemanage/src: booleans_local.o
Only in selinux/libsemanage/src: booleans_policydb.o
Only in selinux/libsemanage/src: booleans_policy.o
Only in selinux/libsemanage/src: context_record.o
Only in selinux/libsemanage/src: database_activedb.o
Only in selinux/libsemanage/src: database_file.o
Only in selinux/libsemanage/src: database_join.o
Only in selinux/libsemanage/src: database_llist.o
Only in selinux/libsemanage/src: database.o
Only in selinux/libsemanage/src: database_policydb.o
Only in selinux/libsemanage/src: debug.o
Only in selinux/libsemanage/src: direct_api.o
Only in selinux/libsemanage/src: fcontext_record.o
Only in selinux/libsemanage/src: fcontexts_file.o
Only in selinux/libsemanage/src: fcontexts_local.o
Only in selinux/libsemanage/src: fcontexts_policy.o
diff -r selinux/libsemanage/src/handle.c selinux.old/libsemanage/src/handle.c
30d29
< #include <unistd.h>
80,82d78
< 	/* Set disable dontaudit */
< 	sepol_set_disable_dontaudit(sh->sepolh,semanage_get_disable_dontaudit())
< 
117,135d112
< int semanage_get_disable_dontaudit()
< {
< 	/*get the policy type*/
< 	char *poltype;
< 	selinux_getpolicytype(&poltype);
< 	/*create a pathname*/
< 	char path[255];
< 	strcpy(path,"/etc/selinux/");
< 	strcat(path,poltype);
< 	strcat(path,"/disable_dontaudit");
< 	/*free the string poltype string*/
< 	free(poltype);
< 	/*check for the files existance*/
< 	if (access(path,F_OK) == 0)
< 		return 1;
< 	else
< 		return 0;
< }
< 
141,158d117
< 	/*get the policy type*/
< 	char *poltype;
< 	selinux_getpolicytype(&poltype);
< 	/*create a pathname*/
< 	char path[255];
< 	strcpy(path,"/etc/selinux/");
< 	strcat(path,poltype);
< 	strcat(path,"/disable_dontaudit");
< 	/*free the string poltype string*/
< 	free(poltype);
< 	/*touch or delete the file*/
< 	if (disable_dontaudit != 0){
< 		FILE *touch;
< 		touch = fopen(path,"w");
< 		fclose(touch);
< 	}else
< 		remove(path);
< 
Only in selinux/libsepol/tests: debug.o


--------------040107070101060206070901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
