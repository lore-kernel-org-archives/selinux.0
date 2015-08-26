MIME-Version: 1.0
In-Reply-To: <55DDE873.5070707@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov>
 <CAFJ0LnHj44XVf8BfduXDQtsKmNe+Tdc3CMO4HDCU-4qF6u-F6g@mail.gmail.com>
 <55DDE873.5070707@tycho.nsa.gov>
Date: Wed, 26 Aug 2015 09:47:53 -0700
Message-ID: <CAFftDdpnV1qbKyBbmwzuqgetFxuMf4MCS330uYkNigy8C2EvEA@mail.gmail.com>
Subject: Re: kernel access to device comm is kdevtmpfs
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Nick Kralevich <nnk@google.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Content-Type: multipart/alternative; boundary=001a1142e2209f79bc051e399c6d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1142e2209f79bc051e399c6d
Content-Type: text/plain; charset=UTF-8

Looks like its a normal tmpfs
<snip>
tmpfs /dev tmpfs rw,seclabel,nosuid,relatime,mode=755 0 0
<snip>

I don't see anything else overlaying /dev mount point.

I currently dont have anything attempting to access it outside of kernel
domain...

One of the best features of SELinux is finding issues in various things,
like DAC perms. Perhaps,
I can get kdevtmpfs dropped, I see no use for it here.

Thanks,
Bill



On Wed, Aug 26, 2015 at 9:25 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 08/26/2015 12:10 PM, Nick Kralevich wrote:
> >
> >
> > On Wed, Aug 26, 2015 at 6:47 AM, Stephen Smalley <sds@tycho.nsa.gov
> > <mailto:sds@tycho.nsa.gov>> wrote:
> >
> >     With devtmpfs, the kernel itself automatically populates and
> maintains a
> >     device node tree.  The claim is that this provides you with a working
> >     /dev tree before udev comes up, and that you can even dispense with
> >     running udev entirely on simple systems (e.g. embedded).  However, it
> >     seems like everyone continues to run udev on top of devtmpfs in Linux
> >     distributions.
> >
> >     The problem of course is that the kernel has no clue how to label the
> >     device nodes, so it is still necessary to have udev or ueventd handle
> >     that.  And with the kernel creation of the device nodes, we then
> have a
> >     race condition where the device node briefly exists in the wrong,
> most
> >     likely inaccessible label.
> >
> >
> > Do you know how other standard DAC permissions are configured by the
> > kernel? The kernel must have some knowledge of how to set the
> > UID/GID/perms/etc...
>
> As per drivers/base/devtmpfs.c, they default to root ownership and mode
> 0600 unless overridden by the driver.  Otherwise it is up to
> udev/ueventd to fix up the permissions afterward.
>
> The situation for SELinux contexts is similar (they will default to
> device type until fixed by udev/ueventd), but we are more likely to run
> afoul of race conditions because we don't allow all root processes to
> access all device nodes. So we can end up denying access that would be
> allowed once the label is correctly set by udev/ueventd.
>
> Fedora currently avoids this via lots of name-based type transitions on
> (kernel, device, chr_file|blk_file) but that is decidedly suboptimal.
>
> We could certainly add devtmpfs to the list of filesystems for which we
> support per-file genfs_contexts-based labeling, and then add /dev
> entries there (prefix match, not regex match).
>
> But I guess the question is why use devtmpfs at all if you are going to
> run udev/ueventd anyway.  What's the practical benefit?
>
> _______________________________________________
> Seandroid-list mailing list
> Seandroid-list@tycho.nsa.gov
> To unsubscribe, send email to Seandroid-list-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Seandroid-list-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--001a1142e2209f79bc051e399c6d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Looks like its a normal tmpfs<div><div>&lt;snip&gt;</div><=
div>tmpfs /dev tmpfs rw,seclabel,nosuid,relatime,mode=3D755 0 0</div></div>=
<div>&lt;snip&gt;</div><div><br></div><div>I don&#39;t see anything else ov=
erlaying /dev mount point.</div><div><br></div><div>I currently dont have a=
nything attempting to access it outside of kernel domain...</div><div><br><=
/div><div>One of the best features of SELinux is finding issues in various =
things, like DAC perms. Perhaps,</div><div>I can get kdevtmpfs dropped, I s=
ee no use for it here.</div><div><br></div><div>Thanks,</div><div>Bill</div=
><div><br></div><div><br></div></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Wed, Aug 26, 2015 at 9:25 AM, Stephen Smalley <span =
dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@=
tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span=
 class=3D"">On 08/26/2015 12:10 PM, Nick Kralevich wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Wed, Aug 26, 2015 at 6:47 AM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a><br>
</span><span class=3D"">&gt; &lt;mailto:<a href=3D"mailto:sds@tycho.nsa.gov=
">sds@tycho.nsa.gov</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0With devtmpfs, the kernel itself automatically popu=
lates and maintains a<br>
&gt;=C2=A0 =C2=A0 =C2=A0device node tree.=C2=A0 The claim is that this prov=
ides you with a working<br>
&gt;=C2=A0 =C2=A0 =C2=A0/dev tree before udev comes up, and that you can ev=
en dispense with<br>
&gt;=C2=A0 =C2=A0 =C2=A0running udev entirely on simple systems (e.g. embed=
ded).=C2=A0 However, it<br>
&gt;=C2=A0 =C2=A0 =C2=A0seems like everyone continues to run udev on top of=
 devtmpfs in Linux<br>
&gt;=C2=A0 =C2=A0 =C2=A0distributions.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The problem of course is that the kernel has no clu=
e how to label the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device nodes, so it is still necessary to have udev=
 or ueventd handle<br>
&gt;=C2=A0 =C2=A0 =C2=A0that.=C2=A0 And with the kernel creation of the dev=
ice nodes, we then have a<br>
&gt;=C2=A0 =C2=A0 =C2=A0race condition where the device node briefly exists=
 in the wrong, most<br>
&gt;=C2=A0 =C2=A0 =C2=A0likely inaccessible label.<br>
&gt;<br>
&gt;<br>
&gt; Do you know how other standard DAC permissions are configured by the<b=
r>
&gt; kernel? The kernel must have some knowledge of how to set the<br>
&gt; UID/GID/perms/etc...<br>
<br>
</span>As per drivers/base/devtmpfs.c, they default to root ownership and m=
ode<br>
0600 unless overridden by the driver.=C2=A0 Otherwise it is up to<br>
udev/ueventd to fix up the permissions afterward.<br>
<br>
The situation for SELinux contexts is similar (they will default to<br>
device type until fixed by udev/ueventd), but we are more likely to run<br>
afoul of race conditions because we don&#39;t allow all root processes to<b=
r>
access all device nodes. So we can end up denying access that would be<br>
allowed once the label is correctly set by udev/ueventd.<br>
<br>
Fedora currently avoids this via lots of name-based type transitions on<br>
(kernel, device, chr_file|blk_file) but that is decidedly suboptimal.<br>
<br>
We could certainly add devtmpfs to the list of filesystems for which we<br>
support per-file genfs_contexts-based labeling, and then add /dev<br>
entries there (prefix match, not regex match).<br>
<br>
But I guess the question is why use devtmpfs at all if you are going to<br>
run udev/ueventd anyway.=C2=A0 What&#39;s the practical benefit?<br>
<span class=3D""><br>
_______________________________________________<br>
Seandroid-list mailing list<br>
<a href=3D"mailto:Seandroid-list@tycho.nsa.gov">Seandroid-list@tycho.nsa.go=
v</a><br>
</span>To unsubscribe, send email to <a href=3D"mailto:Seandroid-list-leave=
@tycho.nsa.gov">Seandroid-list-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Seandroid-list-request@tycho.nsa.gov">Seandroid-list-request@tycho.nsa.gov=
</a>.<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><br></div>
</div>

--001a1142e2209f79bc051e399c6d--
