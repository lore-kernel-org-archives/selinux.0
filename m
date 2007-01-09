Subject: Re: Fixfiles patch for creating logfile fixed.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45A3B265.2010508@redhat.com>
References: <45A3B265.2010508@redhat.com>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 15:14:16 -0500
Message-Id: <1168373656.7993.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 10:19 -0500, Daniel J Walsh wrote:

--- nsapolicycoreutils/scripts/fixfiles	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.10/scripts/fixfiles	2007-01-09 10:09:19.000000000 -0500
@@ -29,6 +29,9 @@
 RPMILES=""
 OUTFILES=""
 LOGFILE=`tty`
+if [ $? != 0 ]; then
+    LOGFILE="/dev/null"
+fi
 SYSLOGFLAG="-l"
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
