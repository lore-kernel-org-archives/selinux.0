Message-ID: <69B1CAEF4FC66F4D9A07B903E0265D3F0B4A35@s3cin>
From: "Kratzer, James R." <JamesK@xetron.com>
To: "'SELinux@tycho.nsa.gov'" <SELinux@tycho.nsa.gov>
Subject: Patching SRPM utilities produces rejects on RH9
Date: Thu, 11 Sep 2003 14:27:46 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I'm running Red Hat 9 and I am using the SELinux userland archive
selinux-usr-2003081307.tgz which had been updated for Red Hat 9.

I am applying the patches to the SRPMs.  Both the patches and the SRPMs are
provided with the userland archive downloaded from the SELinux site.  When
applying the patches, I am getting some rejections, where the patch utility
can't find the code to patch.  Most of the hunks succeed but some are
rejected.  The hunks that fail are failing because the code to patch cannot
be found in the source file.  I would like to know if this is normal when
patching the SRPMs with the SELinux patches.  Could it be that the patches
were correct for an earlier version of Red Hat but have not been updated for
RH9?  After patching, the SRPMs build fine even with the rejections.  

Here is an example of one of the reject files produced.

*****************
*** 1148,1153
		sigaction(SIGINT, &sa, NULL);
		while(wait(NULL) == -1 && errno == EINTR);
		openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
		PAM_END;
		exit(0);
	}
--- 1264,1283 ---
		sigaction(SIGINT, &sa, NULL);
		while(wait(NULL) == -1 && errno == EINTR);
		openlog("login", LOG_ODELAY, LOG_AUTHPRIV);
#ifdef WITH_SELINUX
		if (selinux_enabled)
		{
			/* We need to change the context of the terminal
devices back to 
			   the sytem when the user's session ends. */
			security_restorelabel_tty(ttyn,ttyn_context);
#ifdef CHOWNVCS
			if ( consoletty(0) ) {
	
security_restorelabel_tty(vscn,vscn_context);
	
security_restorelabel_tty(vscan.vcsan_context);
			}
#endif
		}
#endif
		PAM_END;
		exit(0);
	}	

James Kratzer



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
