Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kATK6HPN030761
	for <selinux@tycho.nsa.gov>; Wed, 29 Nov 2006 15:06:17 -0500
Subject: Re: XACE policy configuration
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Ted X Toth <txtoth@gmail.com>
Cc: xorg@lists.freedesktop.org, selinux@tycho.nsa.gov
In-Reply-To: <456D944C.2040205@gmail.com>
References: <456D944C.2040205@gmail.com>
Content-Type: multipart/mixed; boundary="=-jDFtwlSsSmxpVZICLwmR"
Date: Wed, 29 Nov 2006 15:06:16 -0500
Message-Id: <1164830776.2794.141.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-jDFtwlSsSmxpVZICLwmR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-11-29 at 08:08 -0600, Ted X Toth wrote:
> I've built the XACE-SELINUX branch and tried to run it but there are 
> types that are required that I don't have in my policy on FC6. Where can 
> I find these definitions ( a .te file?) and how do I add them to my 
> policy? I'm currently running MLS policy.21 in permissive mode.

CC'd selinux mailing list.  Please direct your reply there.

I was planning to start work on policy soon but have to admit that
there's nothing much available right now.  However it's not difficult to
make your own policy.  Instructions are located here:
http://fedora.redhat.com/docs/selinux-faq-fc5/#faq-entry-local.te

You don't need fc or if files, just a local.te like the following:
policy_module(myxpolicy, 1.0)
type foo_t
type bar_t

Where the type names match up with what is in the XSELinuxConfig file.
Once the new module is installed the X server should start.  However
there will be many warnings printed to the X log file; to fix this,
further policy (allow rules) must be added to authorize the types for X
operations such as drawing.

-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-jDFtwlSsSmxpVZICLwmR
Content-Disposition: attachment; filename=XSELinuxConfig
Content-Type: text/plain; name=XSELinuxConfig; charset=UTF-8
Content-Transfer-Encoding: 7bit

#
# Config file for XSELinux extension
#

#
# The nonlocal_context rule defines a context to be used for all clients
# connecting to the server from a remote host.  The nonlocal context must
# be defined, and it must be a valid context according to the SELinux
# security policy.  Only one nonlocal_context rule may be defined.
#
nonlocal_context			system_u:object_r:unconfined_t
root_window_context			system_u:object_r:unconfined_t

#
# Property rules map a property name to a SELinux type.  The type must
# be valid according to the SELinux security policy.  There can be any
# number of property rules.  Additionally, a default property type can be
# defined for all properties not explicitly listed.  The default
# property type may not be omitted.  The default rule may appear in
# any position (it need not be the last property rule listed).
#
property WM_NAME			unconfined_t
property WM_CLASS			unconfined_t
property WM_ICON_NAME			unconfined_t
property WM_HINTS			unconfined_t
property WM_NORMAL_HINTS		unconfined_t
property WM_COMMAND			unconfined_t

property CUT_BUFFER0			unconfined_t
property CUT_BUFFER1			unconfined_t
property CUT_BUFFER2			unconfined_t
property CUT_BUFFER3			unconfined_t
property CUT_BUFFER4			unconfined_t
property CUT_BUFFER5			unconfined_t
property CUT_BUFFER6			unconfined_t
property CUT_BUFFER7			unconfined_t

property default			unconfined_t

#
# Extension rules map an extension name to a SELinux type.  The type must
# be valid according to the SELinux security policy.  There can be any
# number of extension rules.  Additionally, a default extension type can
# be defined for all extensions not explicitly listed.  The default
# extension type may not be omitted.  The default rule may appear in
# any position (it need not be the last extension rule listed).
#
extension BIG-REQUESTS			unconfined_t
extension DOUBLE-BUFFER			unconfined_t
extension DPMS				unconfined_t
extension Extended-Visual-Information	unconfined_t
extension FontCache			unconfined_t
extension GLX				unconfined_t
extension LBX				unconfined_t
extension MIT-SCREEN-SAVER		unconfined_t
extension MIT-SHM			unconfined_t
extension MIT-SUNDRY-NONSTANDARD	unconfined_t
extension NV-CONTROL			unconfined_t
extension NV-GLX			unconfined_t
extension NVIDIA-GLX			unconfined_t
extension RANDR				unconfined_t
extension RECORD			unconfined_t
extension RENDER			unconfined_t
extension SECURITY			unconfined_t
extension SELinux			unconfined_t
extension SHAPE				unconfined_t
extension SYNC				unconfined_t
extension TOG-CUP			unconfined_t
extension X-Resource			unconfined_t
extension XAccessControlExtension	unconfined_t
extension XACEUSR			unconfined_t
extension XC-APPGROUP			unconfined_t
extension XC-MISC			unconfined_t
extension XFree86-Bigfont		unconfined_t
extension XFree86-DGA			unconfined_t
extension XFree86-Misc			unconfined_t
extension XFree86-VidModeExtension	unconfined_t
extension XInputExtension		unconfined_t
extension XKEYBOARD			unconfined_t
extension XpExtension                   unconfined_t
extension XTEST				unconfined_t
extension XVideo			unconfined_t
extension XVideo-MotionCompensation	unconfined_t
extension default			unconfined_t

--=-jDFtwlSsSmxpVZICLwmR--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
