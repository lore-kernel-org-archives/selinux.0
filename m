Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8FLJicd009973
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 17:19:44 -0400
Subject: Re: [PATCH] refpolicy: add X object classes to unconfined_t
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
Reply-To: ewalsh@tycho.nsa.gov
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158324416.8680.5.camel@twoface.columbia.tresys.com>
References: <1158088282.7554.95.camel@moss-huskies.epoch.ncsc.mil>
	 <450962DB.7050107@tresys.com>
	 <1158324416.8680.5.camel@twoface.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-mpTw4yZNMlqBfhd495bi"
Date: Fri, 15 Sep 2006 17:19:43 -0400
Message-Id: <1158355183.7554.268.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-mpTw4yZNMlqBfhd495bi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-09-15 at 08:46 -0400, Joshua Brindle wrote:
> On Thu, 2006-09-14 at 10:10 -0400, Joshua Brindle wrote:

[snip]

> It also seems that the XSELinuxConfig in the git repository doesn't have
> all the necessary entries, one for root_window_context needs to be added
> to start the X server up.

I've been using the attached config file, however, without the
unconfined_t patch for targeted, it still won't work unless in
permissive mode.

> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--=-mpTw4yZNMlqBfhd495bi
Content-Disposition: attachment; filename=XSELinuxConfig
Content-Type: text/plain; name=XSELinuxConfig; charset=utf-8
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

--=-mpTw4yZNMlqBfhd495bi--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
