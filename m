Subject: Re: access decision API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: michel m <michel.mcgregor@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
	 <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
	 <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
	 <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 27 Jan 2010 13:32:23 -0500
Message-Id: <1264617148.17372.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-01-27 at 18:10 +0330, michel m wrote:
> thanks for guidance, but here I am with a question. what should be
> used as object class in avc_has_perm(3) when using it for
> inter-object. is there any sample for inter-object access decision?
> can it be null?

The class value would be the class of the target object.
Example in the kernel:
 return avc_has_perm(newsid, sbsec->sid,
                            SECCLASS_FILESYSTEM,
                            FILESYSTEM__ASSOCIATE, &ad);

This controls the relationship between a file security context and the
security context of the containing filesystem.

> 
> on the other hand, access decision taken by avc_has_perm(), does it
> include MLS too?
> 
> regards.
> 
> On Wed, Jan 27, 2010 at 1:26 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
>         
>         On Tue, 2010-01-26 at 16:34 -0500, Stephen Smalley wrote:
>         > On Wed, 2010-01-27 at 00:50 +0330, michel m wrote:
>         > > Hi,
>         > > I have some data in userspace that I am keeping its
>         security
>         > > context.but as I want to write this data on some file in
>         OS, I need to
>         > > consult with security server if such data is allowed to be
>         written on
>         > > the file.
>         > > I would like to know if there is any API that let me do
>         such a
>         > > scenario, that is input source and destination security
>         context (both
>         > > of them security context,not a domain context) and returns
>         access
>         > > decision. I am familiar with avc_has_perm(3), but seems to
>         be not
>         > > correct solution because it gets domain context as the
>         first argument.
>         >
>         > avc_has_perm() can be used with any pair of security
>         contexts.  Typical
>         > usage is to pass the security context of a subject/process
>         as the first
>         > argument, but not always (e.g. there are some permission
>         checks that
>         > control inter-object relationships), and that is not a
>         requirement.
>         
>         
>         Example usage of the userspace AVC can be found in the
>         XSELinux
>         extension, see:
>         http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hooks.c
>         http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinuxint.h
>         
>         The modern usage is to call:
>         1) selinux_set_callback() to set up the callback functions for
>         libselinux to use for logging/auditing or to notify the
>         application of
>         changes to enforcing mode or policy.
>         2) selinux_set_mapping() to set up a dynamic mapping for the
>         object
>         classes and permissions so that your application does not
>         depend on
>         fixed values for them in the policy, and
>         3) avc_open() to initialize the AVC.
>         
>         Then you can proceed to call avc_context_to_sid() and
>         avc_has_perm() as
>         appropriate.
>         
>         If you don't need caching, you can directly call
>         security_compute_av();
>         however this pushes responsibility for checking the particular
>         permission bit, checking for and handling permissive
>         mode/domains, and
>         generating an avc audit message to your application.   There
>         has been a
>         prior request to introduce a simpler interface for programs
>         that do not
>         require caching, see:
>         https://bugzilla.redhat.com/show_bug.cgi?id=518268
>         
>         
>         --
>         Stephen Smalley
>         National Security Agency
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
