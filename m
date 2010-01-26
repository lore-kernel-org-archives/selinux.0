Subject: Re: access decision API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
	 <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 26 Jan 2010 16:56:33 -0500
Message-Id: <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-01-26 at 16:34 -0500, Stephen Smalley wrote:
> On Wed, 2010-01-27 at 00:50 +0330, michel m wrote:
> > Hi,
> > I have some data in userspace that I am keeping its security
> > context.but as I want to write this data on some file in OS, I need to
> > consult with security server if such data is allowed to be written on
> > the file.
> > I would like to know if there is any API that let me do such a
> > scenario, that is input source and destination security context (both
> > of them security context,not a domain context) and returns access
> > decision. I am familiar with avc_has_perm(3), but seems to be not
> > correct solution because it gets domain context as the first argument.
> 
> avc_has_perm() can be used with any pair of security contexts.  Typical
> usage is to pass the security context of a subject/process as the first
> argument, but not always (e.g. there are some permission checks that
> control inter-object relationships), and that is not a requirement.

Example usage of the userspace AVC can be found in the XSELinux
extension, see:
http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hooks.c
http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinuxint.h

The modern usage is to call:
1) selinux_set_callback() to set up the callback functions for
libselinux to use for logging/auditing or to notify the application of
changes to enforcing mode or policy.
2) selinux_set_mapping() to set up a dynamic mapping for the object
classes and permissions so that your application does not depend on
fixed values for them in the policy, and
3) avc_open() to initialize the AVC.

Then you can proceed to call avc_context_to_sid() and avc_has_perm() as
appropriate.

If you don't need caching, you can directly call security_compute_av();
however this pushes responsibility for checking the particular
permission bit, checking for and handling permissive mode/domains, and
generating an avc audit message to your application.   There has been a
prior request to introduce a simpler interface for programs that do not
require caching, see:
https://bugzilla.redhat.com/show_bug.cgi?id=518268

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
