Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3HKJ9Fp027471
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 16:19:09 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3HKJ3gv011108
	for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 20:19:03 GMT
Received: by fg-out-1718.google.com with SMTP id 16so156784fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 17 Apr 2008 13:19:02 -0700 (PDT)
Message-ID: <cadfc0e40804170933r63ebccd1w14df5c1efb78f697@mail.gmail.com>
Date: Thu, 17 Apr 2008 11:33:11 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: Fwd: adding a new security class
Cc: "SE Linux" <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1208447943.18883.396.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_2456_11838350.1208449991358"
References: <cadfc0e40804161540u2c8796dcr99f67dc7c1aba33d@mail.gmail.com>
	 <48073FC6.6040908@redhat.com>
	 <cadfc0e40804170600g610fb3fdy2f7f416d4d7849ff@mail.gmail.com>
	 <1208438080.18883.361.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170720q56eb623bn22dc7b7af31f671c@mail.gmail.com>
	 <1208442613.18883.386.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170822n2ff34af1lcc92aa2c0a1cfff2@mail.gmail.com>
	 <1208446196.18883.394.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40804170855q25d3e24fw61fa1a45b874c98@mail.gmail.com>
	 <1208447943.18883.396.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_2456_11838350.1208449991358
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, Apr 17, 2008 at 10:59 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>  On Thu, 2008-04-17 at 10:55 -0500, Xavier Toth wrote:
>  > I installed the corresponding selinux-policy-devel rpm. I see
>  > references to my class in
>  > /usr/share/selinux/devel/include/support/all_perms.spt Any other ideas
>  > on what to look at?
>
>  (don't top-post, and don't trim the cc list, please)
>
>  At this point I need to see a copy of the .te file and the precise
>  output from the failed build.
>
>
>
>  > On Thu, Apr 17, 2008 at 10:29 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>  > >
>  > >  On Thu, 2008-04-17 at 10:22 -0500, Xavier Toth wrote:
>  > >  > I appended the class declaration to the security_classes files.
>  > >  >
>  > >  > I have installed the new policy and libselinux. However now when
>  > >  > trying to use this new class in a te file the build fails with an
>  > >  > 'unknown class' error. Do I need to rebuild any other packages before
>  > >  > I can use this class? I tried rebuilding checkpolicy but that didn't
>  > >  > help.
>  > >
>  > >  Rebuilding checkpolicy isn't necessary.  In fact, you don't even really
>  > >  need the rebuilt libselinux if using the dynamic object class/permission
>  > >  discovery support, since that will map the class and permission strings
>  > >  to values via the kernel's selinuxfs interface.
>  > >
>  > >  I'm guessing that you are trying to build a policy module using the
>  > >  policy headers provided by the Fedora policy rather than the ones
>  > >  provided by your rebuilt policy, and those headers lack the new
>  > >  definitions.
>  > >
>  > >
>  > >  >
>  > >  > On Thu, Apr 17, 2008 at 9:30 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>  > >  > >
>  > >  > >  On Thu, 2008-04-17 at 09:20 -0500, Xavier Toth wrote:
>  > >  > >  > If the new security class is a userspace object manager related class
>  > >  > >  > do I still need to rebuild the kernel?
>  > >  > >
>  > >  > >  No.  You should find that the regenerated kernel headers are no
>  > >  > >  different, as they no longer include userspace classes (if annotated as
>  > >  > >  such in the security_classes file).
>  > >  > >
>  > >  > >  I assume though that you are adding your new class to the end of the
>  > >  > >  security_classes list.  Inserting a class before an existing one can
>  > >  > >  perturb the values of the existing classes, which isn't a good idea
>  > >  > >  (forbidden for kernel classes and any userspace object managers that use
>  > >  > >  the old libselinux API; permissible for new userspace object classes
>  > >  > >  when they use the dynamic class/permission discovery support but can
>  > >  > >  still break running applications until we have support for remapping
>  > >  > >  upon reload there).
>  > >  > >
>  > >  > >  --
>  > >  > >
>  > >  > >
>  > >  > > Stephen Smalley
>  > >  > >  National Security Agency
>  > >  > >
>  > >  > >
>  > >  --
>  > >
>  > >
>  > > Stephen Smalley
>  > >  National Security Agency
>  > >
>  > >
>  --
>
>
> Stephen Smalley
>  National Security Agency
>
>

I use gmail

This te file is not the finally resting place for copy/paste policy
simply a convenient place to try out the class.

[tedx@comms hack-policy]$ make rebuild
rm -f /home/tedx/src2/Linux_i386/OED/policy/hack-policy.pp
rm -f *.CKP *.ln *.o core errs ,* *~ .emacs_* tags TAGS make.log *.i
if [ ! -d /usr/share/selinux/devel/include/jcdx ]; then \
		sudo mkdir /usr/share/selinux/devel/include/jcdx; \
		sudo chmod 777 /usr/share/selinux/devel/include/jcdx; \
	fi; \
	cp hack-policy.if /usr/share/selinux/devel/include/jcdx;
rm -f /usr/share/selinux/devel/include/jcdx/hack-policy.if
make -f /usr/share/selinux/devel/Makefile
make[1]: Entering directory `/home/tedx/src2/hack-policy'
Compiling mls hack-policy module
/usr/bin/checkmodule:  loading policy configuration from tmp/hack-policy.tmp
hack-policy.te":30:ERROR 'unknown class x_application_data used in
rule' at token ';' on line 3343:
allow x_rootwindow_t self:x_application_data paste_without_confirm;
;
/usr/bin/checkmodule:  error(s) encountered while parsing configuration
make[1]: *** [tmp/hack-policy.mod] Error 1
make[1]: Leaving directory `/home/tedx/src2/hack-policy'
make: *** [progs] Error 2

------=_Part_2456_11838350.1208449991358
Content-Type: application/octet-stream; name=hack-policy.te
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ff5jmb6c0
Content-Disposition: attachment; filename=hack-policy.te

cG9saWN5X21vZHVsZShoYWNrLXBvbGljeSwxLjAuNikKCiMgbGQuc28gdWdsaW5lc3MKZ2VuX3Jl
cXVpcmUoYHR5cGUgaW5pdHJjX3Q7Jyk7Cm1sc19mZF9zaGFyZV9hbGxfbGV2ZWxzKGluaXRyY190
KSAKCiMgYmVjYXVzZSB3ZSBhcmUgbm90IHVzaW5nIHNwZWNpZmljIHBvcnRzCmdlbl9yZXF1aXJl
KGB0eXBlIGluZXRkX3QsIGh0dHBfcG9ydF90LG1haWxfcG9ydF90LHBvcnRfdDsnKTsKYWxsb3cg
aW5ldGRfdCBwb3J0X3Q6dGNwX3NvY2tldCBuYW1lX2JpbmQ7CmFsbG93IGluZXRkX3QgaHR0cF9w
b3J0X3Q6dGNwX3NvY2tldCBuYW1lX2JpbmQ7CmFsbG93IGluZXRkX3QgbWFpbF9wb3J0X3Q6dGNw
X3NvY2tldCBuYW1lX2JpbmQ7CgojIHdobyByZWFsbHkgb3ducyBpbmV0ZCBzb2NrZXRzPwphbGxv
dyBpbmV0ZF90IHNlbGY6YXNzb2NpYXRpb24gcmVjdmZyb207CgojIGhhY2sgdG8gbGV0IGluaXRy
Y190IHVzZSBydW5jb24gdG8gbGF1bmNoIEAgbGV2ZWwKZ2VuX3JlcXVpcmUoYHR5cGUgc2VjdXJp
dHlfdDsnKTsKYWxsb3cgaW5pdHJjX3Qgc2VjdXJpdHlfdDpzZWN1cml0eSBjaGVja19jb250ZXh0
OwphbGxvdyBpbml0cmNfdCBzZWxmOnByb2Nlc3MgeyBzZXRleGVjIHRyYW5zaXRpb24gc2lnaW5o
IHJsaW1pdGluaCBub2F0c2VjdXJlIH07CmFsbG93IGluaXRyY190IHNlbGY6ZmQgdXNlOwoKIyBy
dW51c2VyCmFsbG93IGluaXRyY190IHNlbGY6a2V5IHdyaXRlOwphbGxvdyBpbml0cmNfdCBzZWxm
Om5ldGxpbmtfYXVkaXRfc29ja2V0IGNyZWF0ZTsKCmdlbl9yZXF1aXJlKGB0eXBlIHNoZWxsX2V4
ZWNfdDsnKTsKYWxsb3cgaW5pdHJjX3Qgc2hlbGxfZXhlY190OmZpbGUgZW50cnlwb2ludDsKCmdl
bl9yZXF1aXJlKGB0eXBlIHhfcm9vdHdpbmRvd190OycpOwphbGxvdyB4X3Jvb3R3aW5kb3dfdCBz
ZWxmOnhfYXBwbGljYXRpb25fZGF0YSBwYXN0ZV93aXRob3V0X2NvbmZpcm07Cg==
------=_Part_2456_11838350.1208449991358--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
