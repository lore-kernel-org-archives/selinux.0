Message-ID: <41F90DD2.5040601@redhat.com>
Date: Thu, 27 Jan 2005 10:50:42 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Minor genhomedircon patch
References: <41F90538.9010107@redhat.com>	 <1106839940.28623.117.camel@moss-spartans.epoch.ncsc.mil>	 <41F90BFD.4010208@redhat.com> <1106840307.28623.122.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1106840307.28623.122.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010102080806040609050006"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010102080806040609050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Without this change UID are compared as strings instead of integers.

--------------010102080806040609050006
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.21.5/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-01-25 10:32:01.000000000 -0500
+++ policycoreutils-1.21.5/scripts/genhomedircon	2005-01-27 10:05:51.000000000 -0500
@@ -96,7 +96,7 @@
 
 	rc=commands.getstatusoutput("grep -h '^UID_MIN' /etc/login.defs | sed -e 's/^UID_MIN[^0-9]*//'")
 	if rc[0] == 0:
-		STARTING_UID=rc[1]
+		STARTING_UID=int(rc[1])
 	else:
 		STARTING_UID=500
 

--------------010102080806040609050006--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
