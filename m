Message-ID: <465C3C94.4020609@redhat.com>
Date: Tue, 29 May 2007 10:45:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Dead links in checkpolicy/checkmodule man pages.
Content-Type: multipart/mixed;
 boundary="------------050709000102030308010607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050709000102030308010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think we should just move to the toplevel directory



--------------050709000102030308010607
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

--- checkpolicy-2.0.2/checkmodule.8~	2007-04-12 16:03:00.000000000 -0400
+++ checkpolicy-2.0.2/checkmodule.8	2007-05-29 10:43:29.000000000 -0400
@@ -47,7 +47,7 @@ $ checkmodule -M -m httpd.te -o httpd.mo
 
 .SH "SEE ALSO"
 .B semodule(8), semodule_package(8)
-SELinux documentation at http://www.nsa.gov/selinux/docs.html,
+SELinux documentation at http://www.nsa.gov/selinux,
 especially "Configuring the SELinux Policy".
 
 
--- checkpolicy-2.0.2/checkpolicy.8~	2007-04-12 16:03:00.000000000 -0400
+++ checkpolicy-2.0.2/checkpolicy.8	2007-05-29 10:43:21.000000000 -0400
@@ -34,7 +34,7 @@ Write a binary policy file to the specif
 Specify the policy version, defaults to the latest.
 
 .SH "SEE ALSO"
-SELinux documentation at http://www.nsa.gov/selinux/docs.html,
+SELinux documentation at http://www.nsa.gov/selinux,
 especially "Configuring the SELinux Policy".
 
 

--------------050709000102030308010607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
