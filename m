Subject: Re: newrole cleanup patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20051220195134.61236.qmail@web51505.mail.yahoo.com>
References: <20051220195134.61236.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Dec 2005 10:36:10 -0500
Message-Id: <1135179370.18223.57.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-12-20 at 11:51 -0800, Steve G wrote:
> Hi,
> 
> I've been reviewing newrole in preparation for another patch to add auditing to
> it. The patch is fairly self-explanatory. Some highlights:
> 
> - little const cleanup
> - pass tty to pam
> - add a function to verify the shell is infact known to /etc/shells
> - make sure no signals are blocked
> - If in enforcing mode and error: getting tty context, computing new context, or
> setting new context  then exit with -1.
> - Loop the wait call to handle EINTR
> - open the tty read only or write only depending on stdin, stdout, stderr.
> 
> The patch is attached.

@@ -188,6 +191,16 @@ int authenticate_via_pam( const struct p
     exit( -1 );
   }
 
+  if( strncmp(ttyn, "/dev/", 5) == 0 )
+    tty_name = ttyn+5;
+  else
+    tty_name = ttyn;

I have seen this idiom before, but am not clear on the rationale.  If
the tty isn't under /dev, then what are the real implications?  Possibly
this should just be an error condition?

+
+  if( PAM_SUCCESS != pam_set_item( pam_handle, PAM_TTY, tty_name ) ) {
+    fprintf( stderr, _("failed to set PAM_TTY\n") );
+    goto out;
+  }
+
<snip>
@@ -199,6 +212,7 @@ int authenticate_via_pam( const struct p
   }
 
   /* We're done with PAM.  Free `pam_handle'. */
+out:
   pam_end( pam_handle, PAM_SUCCESS );

This isn't really new to your patch, but it seems like this code should
be cleaned up in general to save the pam error status from the pam_*
functions and pass that status to pam_end().  This applies both to your
new call to pam_set_item as well as the existing calls to
pam_authenticate() and pam_acct_mgmt(), and we likely should be jumping
to out upon a failure in pam_authenticate() rather than calling
pam_acct_mgmt() at all in that case, right?

@@ -562,17 +635,22 @@ int main( int argc, char *argv[] ) {
   }
 
   tty_context = NULL;
-  if (fgetfilecon(fd, &tty_context) < 0)
-	fprintf(stderr, _("Warning!  Could not get current context for %s, not relabeling.\n"), ttyn);
-    
+  if (fgetfilecon(fd, &tty_context) < 0) {
+	fprintf(stderr, _("Error!  Could not get current context for %s, not relabeling tty.\n"), ttyn);
+        if (enforcing)
+	  exit(-1);
+  }

I'm a little concerned that if we report "Error!" rather than "Warning!"
and then proceed (if permissive), then the user could get confused (i.e.
they may think that they are back in the original shell due to the
"Error" message).  So we likely want to distinguish the error message
based on which error handling path we will take (i.e. Error if treating
it as a fatal error and Warning otherwise), and should likely clean up
other error messages to be consistent.  Or perhaps newrole should be
more verbose about successfully launching the new shell.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
