Subject: Re: [ SEMANAGE ] Clear obsoleted objects
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437B42A9.7010407@cornell.edu>
References: <437A7AD5.6040500@cornell.edu>
	 <1132150739.3425.16.camel@moss-spartans.epoch.ncsc.mil>
	 <437B42A9.7010407@cornell.edu>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 09:39:23 -0500
Message-Id: <1132151963.3901.1.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-16 at 09:31 -0500, Ivan Gyurdiev wrote:
> >
> > Thanks, merged as of libsemanage 1.3.55.
> >   
> I just found a bug ... should be using rtable->key_free(key), not free(key).

Ok.

Index: libsemanage/src/policy_components.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/policy_components.c,v
retrieving revision 1.14
diff -u -p -r1.14 policy_components.c
--- libsemanage/src/policy_components.c	16 Nov 2005 13:49:15 -0000	1.14
+++ libsemanage/src/policy_components.c	16 Nov 2005 14:36:06 -0000
@@ -49,7 +49,7 @@ static int clear_obsolete(
 	for (i=0; i < nrecords; i++)	
 		rtable->free(records[i]);
 	free(records);
-	free(key);
+	rtable->key_free(key);
 	return STATUS_SUCCESS;
 
 	err:
@@ -57,7 +57,7 @@ static int clear_obsolete(
 	for (i=0; i < nrecords; i++)
 		rtable->free(records[i]);
 	free(records);
-	free(key);
+	rtable->key_free(key);
 	return STATUS_ERR;
 }
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
