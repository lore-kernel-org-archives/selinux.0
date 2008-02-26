Message-ID: <47C36767.7030503@tycho.nsa.gov>
Date: Mon, 25 Feb 2008 20:12:07 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Permissive mode for xace is broken.
References: <47C2CC18.6080801@redhat.com>	 <1203948764.2804.183.camel@moss-spartans.epoch.ncsc.mil>	 <1203949499.2804.188.camel@moss-spartans.epoch.ncsc.mil>	 <47C2D552.8060509@redhat.com> <1203965363.2804.201.camel@moss-spartans.epoch.ncsc.mil> <47C316EF.5090206@redhat.com> <47C3261C.1070508@tycho.nsa.gov>
In-Reply-To: <47C3261C.1070508@tycho.nsa.gov>
Content-Type: multipart/mixed;
 boundary="------------010807040205000300000808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010807040205000300000808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eamon Walsh wrote:
> The X object manager logs all avc's and status messages (including the 
> AVC netlink stuff) through the audit system using libaudit calls 
> (audit_log_user_avc_message, etc.)   I disavow all responsibility for 
> the messages once they enter libaudit

It's being black-holed in rawhide.  To see for yourself, add the 
attached patch to the spec file and rebuild the xserver from SRPM.  It 
will tee the avc messages into /var/log/Xorg.0.log.

Also, pull libselinux from upstream.  The BadWindow error may be fixed.

You'll have to report to me what you see in the X server output.  I'm 
seeing tons of avc's: it doesn't appear as though staff_t is even 
getting X permissions allowed.





-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------010807040205000300000808
Content-Type: text/x-patch;
 name="xserver-1.4.99-xselinux-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xserver-1.4.99-xselinux-debug.patch"


--------------010807040205000300000808--
