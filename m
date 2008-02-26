Subject: Re: Permissive mode for xace is broken.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <47C36767.7030503@tycho.nsa.gov>
References: <47C2CC18.6080801@redhat.com>
	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>
	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>
	 <47C2D552.8060509@redhat.com>
	 <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil>
	 <47C316EF.5090206@redhat.com> <47C3261C.1070508@tycho.nsa.gov>
	 <47C36767.7030503@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 26 Feb 2008 07:59:12 -0500
Message-Id: <1204030752.2804.282.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-25 at 20:12 -0500, Eamon Walsh wrote:
> Eamon Walsh wrote:
> > The X object manager logs all avc's and status messages (including the 
> > AVC netlink stuff) through the audit system using libaudit calls 
> > (audit_log_user_avc_message, etc.)   I disavow all responsibility for 
> > the messages once they enter libaudit
> 
> It's being black-holed in rawhide.  To see for yourself, add the 
> attached patch to the spec file and rebuild the xserver from SRPM.  It 
> will tee the avc messages into /var/log/Xorg.0.log.

Looking at the corresponding code in dbus, I see that dbus is calling
both audit_log_user_avc_message() (if HAVE_LIBAUDIT) and
vsyslog(LOG_INFO...) with the message.

Can you verify that the X server was able to create the audit socket
successfully?

Things that could go wrong:
- X server uses privilege bracketing (switching uids or capabilities)
and lacks the necessary audit capabilities.
- X server shuts down all descriptors _after_ you've opened the audit
socket, thereby closing it down too.
- Policy doesn't allow X server to write audit messages (requires
audit_write capability and netlink_audit_socket perms).

Dan, what policy are you using?  trunk?  or xselinux branch?
I don't think Chris has merged xselinux branch to trunk yet, or that it
is necessarily safe to work from that branch (i.e. things could change
as part of the merge in an incompatible way).

> Also, pull libselinux from upstream.  The BadWindow error may be fixed.
> 
> You'll have to report to me what you see in the X server output.  I'm 
> seeing tons of avc's: it doesn't appear as though staff_t is even 
> getting X permissions allowed.
> 
> 
> 
> 
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
