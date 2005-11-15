Subject: Re: [ SELINUX ] Make rpm_execcon failure non-fatal in permissive
	mode.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <437974B6.7020203@cornell.edu>
References: <437974B6.7020203@cornell.edu>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 07:54:02 -0500
Message-Id: <1132059242.5415.324.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-15 at 00:40 -0500, Ivan Gyurdiev wrote:
> Changelog: Makes failure in rpm_execcon non-fatal in permissive mode.
> See: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=173094
> 
> P.S. I'm not sure why an rpm-specific function is in the shared library 
> - seems strange to me.

Needs the following diff on top of your diff in order to correctly
handle failures while setting up the context.  Second hunk isn't
strictly needed but seems desirable for cleanliness.

Index: libselinux/src/rpm.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libselinux/src/rpm.c,v
retrieving revision 1.7
diff -u -p -r1.7 rpm.c
--- libselinux/src/rpm.c	15 Nov 2005 12:49:52 -0000	1.7
+++ libselinux/src/rpm.c	15 Nov 2005 12:50:11 -0000
@@ -30,6 +30,7 @@ int rpm_execcon(unsigned int verified __
 
 	if (!strcmp(mycon, newcon)) {
 		/* No default transition, use rpm_script_t for now. */
+		rc = -1;
 		con = context_new(mycon);
 		if (!con)
 			goto out;
@@ -39,6 +40,7 @@ int rpm_execcon(unsigned int verified __
 		newcon = strdup(context_str(con));
 		if (!newcon)
 			goto out;
+		rc = 0;
 	}
 
 	rc = setexeccon(newcon);


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
