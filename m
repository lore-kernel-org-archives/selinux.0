Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBLHUgXf018929
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 12:30:42 -0500 (EST)
Received: from web51504.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id jBLHTlYr026447
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 17:29:47 GMT
Message-ID: <20051221173042.70775.qmail@web51504.mail.yahoo.com>
Date: Wed, 21 Dec 2005 09:30:42 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: newrole cleanup patch
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1135179370.18223.57.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>+  if( strncmp(ttyn, "/dev/", 5) == 0 )
>+    tty_name = ttyn+5;
>+  else
>+    tty_name = ttyn;
>
>I have seen this idiom before, but am not clear on the rationale.  If
>the tty isn't under /dev, then what are the real implications?  Possibly
>this should just be an error condition?

Its so that we get the tty's name rather than the path.

>+
>+  if( PAM_SUCCESS != pam_set_item( pam_handle, PAM_TTY, tty_name ) ) {
>+    fprintf( stderr, _("failed to set PAM_TTY\n") );
>+    goto out;
>+  }
>+
><snip>
>@@ -199,6 +212,7 @@ int authenticate_via_pam( const struct p
>   }
> 
>   /* We're done with PAM.  Free `pam_handle'. */
>+out:
>   pam_end( pam_handle, PAM_SUCCESS );
>
>This isn't really new to your patch, but it seems like this code should
>be cleaned up in general to save the pam error status from the pam_*
>functions and pass that status to pam_end(). This applies both to your
>new call to pam_set_item as well as the existing calls to
>pam_authenticate() and pam_acct_mgmt(), and we likely should be jumping
>to out upon a failure in pam_authenticate() rather than calling
>pam_acct_mgmt() at all in that case, right?

Right. I'll make those adjustments.

>I'm a little concerned that if we report "Error!" rather than "Warning!"
>and then proceed (if permissive), then the user could get confused

I'll make adjustments to switch between Error & Warning.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
