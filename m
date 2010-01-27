MIME-Version: 1.0
In-Reply-To: <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
References: <bb74313d1001261320n8694abel857f6eba1066c560@mail.gmail.com>
	 <1264541641.19890.77.camel@moss-pluto.epoch.ncsc.mil>
	 <1264542993.19890.88.camel@moss-pluto.epoch.ncsc.mil>
Date: Wed, 27 Jan 2010 18:10:29 +0330
Message-ID: <bb74313d1001270640s43b6c88dmafdb6aa9d3cf3015@mail.gmail.com>
Subject: Re: access decision API
From: michel m <michel.mcgregor@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001485318beb482466047e2662a7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001485318beb482466047e2662a7
Content-Type: text/plain; charset=ISO-8859-1

thanks for guidance, but here I am with a question. what should be used as
object class in avc_has_perm(3) when using it for inter-object. is there any
sample for inter-object access decision? can it be null?

on the other hand, access decision taken by avc_has_perm(), does it include
MLS too?

regards.

On Wed, Jan 27, 2010 at 1:26 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2010-01-26 at 16:34 -0500, Stephen Smalley wrote:
> > On Wed, 2010-01-27 at 00:50 +0330, michel m wrote:
> > > Hi,
> > > I have some data in userspace that I am keeping its security
> > > context.but as I want to write this data on some file in OS, I need to
> > > consult with security server if such data is allowed to be written on
> > > the file.
> > > I would like to know if there is any API that let me do such a
> > > scenario, that is input source and destination security context (both
> > > of them security context,not a domain context) and returns access
> > > decision. I am familiar with avc_has_perm(3), but seems to be not
> > > correct solution because it gets domain context as the first argument.
> >
> > avc_has_perm() can be used with any pair of security contexts.  Typical
> > usage is to pass the security context of a subject/process as the first
> > argument, but not always (e.g. there are some permission checks that
> > control inter-object relationships), and that is not a requirement.
>
> Example usage of the userspace AVC can be found in the XSELinux
> extension, see:
> http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hooks.c
> http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinuxint.h
>
> The modern usage is to call:
> 1) selinux_set_callback() to set up the callback functions for
> libselinux to use for logging/auditing or to notify the application of
> changes to enforcing mode or policy.
> 2) selinux_set_mapping() to set up a dynamic mapping for the object
> classes and permissions so that your application does not depend on
> fixed values for them in the policy, and
> 3) avc_open() to initialize the AVC.
>
> Then you can proceed to call avc_context_to_sid() and avc_has_perm() as
> appropriate.
>
> If you don't need caching, you can directly call security_compute_av();
> however this pushes responsibility for checking the particular
> permission bit, checking for and handling permissive mode/domains, and
> generating an avc audit message to your application.   There has been a
> prior request to introduce a simpler interface for programs that do not
> require caching, see:
> https://bugzilla.redhat.com/show_bug.cgi?id=518268
>
> --
> Stephen Smalley
> National Security Agency
>
>

--001485318beb482466047e2662a7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

thanks for guidance, but here I am with a question. what should be used as =
object class in avc_has_perm(3) when using it for inter-object. is there an=
y sample for inter-object access decision? can it be null?<br><br>on the ot=
her hand, access decision taken by avc_has_perm(), does it include MLS too?=
<br>
<br>regards.<br><br><div class=3D"gmail_quote">On Wed, Jan 27, 2010 at 1:26=
 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.=
gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt =
0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Tue, 2010-01-26 at 16:34 -0500, Stephe=
n Smalley wrote:<br>
&gt; On Wed, 2010-01-27 at 00:50 +0330, michel m wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt; I have some data in userspace that I am keeping its security<br>
&gt; &gt; context.but as I want to write this data on some file in OS, I ne=
ed to<br>
&gt; &gt; consult with security server if such data is allowed to be writte=
n on<br>
&gt; &gt; the file.<br>
&gt; &gt; I would like to know if there is any API that let me do such a<br=
>
&gt; &gt; scenario, that is input source and destination security context (=
both<br>
&gt; &gt; of them security context,not a domain context) and returns access=
<br>
&gt; &gt; decision. I am familiar with avc_has_perm(3), but seems to be not=
<br>
&gt; &gt; correct solution because it gets domain context as the first argu=
ment.<br>
&gt;<br>
&gt; avc_has_perm() can be used with any pair of security contexts. =A0Typi=
cal<br>
&gt; usage is to pass the security context of a subject/process as the firs=
t<br>
&gt; argument, but not always (e.g. there are some permission checks that<b=
r>
&gt; control inter-object relationships), and that is not a requirement.<br=
>
<br>
</div></div>Example usage of the userspace AVC can be found in the XSELinux=
<br>
extension, see:<br>
<a href=3D"http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinux_hook=
s.c" target=3D"_blank">http://cgit.freedesktop.org/xorg/xserver/tree/Xext/x=
selinux_hooks.c</a><br>
<a href=3D"http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xselinuxint.h=
" target=3D"_blank">http://cgit.freedesktop.org/xorg/xserver/tree/Xext/xsel=
inuxint.h</a><br>
<br>
The modern usage is to call:<br>
1) selinux_set_callback() to set up the callback functions for<br>
libselinux to use for logging/auditing or to notify the application of<br>
changes to enforcing mode or policy.<br>
2) selinux_set_mapping() to set up a dynamic mapping for the object<br>
classes and permissions so that your application does not depend on<br>
fixed values for them in the policy, and<br>
3) avc_open() to initialize the AVC.<br>
<br>
Then you can proceed to call avc_context_to_sid() and avc_has_perm() as<br>
appropriate.<br>
<br>
If you don&#39;t need caching, you can directly call security_compute_av();=
<br>
however this pushes responsibility for checking the particular<br>
permission bit, checking for and handling permissive mode/domains, and<br>
generating an avc audit message to your application. =A0 There has been a<b=
r>
prior request to introduce a simpler interface for programs that do not<br>
require caching, see:<br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D518268" target=3D"=
_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D518268</a><br>
<div><div></div><div class=3D"h5"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</div></div></blockquote></div><br>

--001485318beb482466047e2662a7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
