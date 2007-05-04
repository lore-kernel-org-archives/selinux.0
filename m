Message-ID: <463B330A.8030109@redhat.com>
Date: Fri, 04 May 2007 09:20:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fix to genhomedircon to find conflicting directories correctly.
Content-Type: multipart/mixed;
 boundary="------------000904090009020905020700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000904090009020905020700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------000904090009020905020700
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude=sepolgen-1.0.8 --exclude=gui --exclude=po -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-2.0.14/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2007-04-25 11:08:44.000000000 -0400
+++ policycoreutils-2.0.14/scripts/genhomedircon	2007-05-04 09:14:57.000000000 -0400
@@ -302,7 +302,7 @@
 			    
 			    regex = re.sub("\(\/\.\*\)\?", "", regex)
 			    regex = regex + "/*$"
-			    if re.search(home, regex, 0):
+			    if re.search(regex,home, 0):
 				    return 1
 		    except:
 			    continue

--------------000904090009020905020700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
