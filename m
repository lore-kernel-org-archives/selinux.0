MIME-Version: 1.0
In-Reply-To: <1320409924.1015.7.camel@moss-pluto>
References: <CAGGozWSLxn-SNzpc-jW+tZuEHAxOX0-Sn9PxDuyd7rLvvwempw@mail.gmail.com>
	<1320409924.1015.7.camel@moss-pluto>
Date: Fri, 4 Nov 2011 17:25:20 +0100
Message-ID: <CAGGozWR6yGyQaxgSED+NdAyLYGzkjDhdWmMxnB=B0qEBAEOtLA@mail.gmail.com>
Subject: Re: SELinux on Android
From: Bhargava Shastry <bshas3@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f6428f2be595504b0eb2697
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f6428f2be595504b0eb2697
Content-Type: text/plain; charset=ISO-8859-1

Dear Mr. Smalley,

Thanks for your inputs. I did go through the slides of your recent
presentation on a case for SELinux enhanced Android phone. You have done a
great job re-engineering Android to retrofit SELinux.

I was wondering how much effort it is to actually port a subset of
SELinux's userspace (e.g., loadpolicy, chcon and a few others) tools to
Android? Does it entail major changes to Android's existing toolchain
including modifications to its bionic libc?  Also, I was wondering if you
also undertook a port of coreutils as well (to enable the -Z option for
utils like ps and ls)?

Thanks again,
Bhargava

On Fri, Nov 4, 2011 at 1:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2011-11-04 at 11:16 +0100, Bhargava Shastry wrote:
> > Hello,
> >
> > I am trying to get SELinux running on an Android phone. I did
> > successfully build the kernel with SELinux enabled and mounted
> > selinuxfs on init. Now, I would like to port SELinux user-space tools
> > for policy loading/management. I looked at sebusybox tool-set but ran
> > into problems while compiling. My hunch is that header files related
> > to File System extended attributes are missing in the bionic lib
> > sources that Android builds on. Having said that I have patched the
> > Android YAFFS FS with an Xattr patch and also configured the kernel
> > accordingly.
> >
> > I have sources of libselinux and libsepol checked out and am wondering
> > how to go about building these libraries for Android. Any help in this
> > regard would be much appreciated.
>
> We have been working on enabling the use of SELinux in Android.  I gave
> a talk on this topic at the Linux Security Summit in September; the
> slides are available here:
> http://selinuxproject.org/~jmorris/lss2011_slides/caseforseandroid.pdf
>
> You don't need much of the SELinux userspace on the device unless you
> want to try to support modular policy on the device, which I wouldn't
> recommend (at least in its current form).  You can just build the policy
> on your build host using the build host's checkpolicy, which should be
> available to you on most Linux distributions; I build on Fedora and
> others have built my code on Ubuntu, both of which have checkpolicy
> available.  So you don't need libsepol, checkpolicy, libsemanage, or
> most of policycoreutils on the device.
>
> The only core SELinux userspace components that you need on the device
> are a subset of libselinux (primarily the wrappers for the SELinux
> kernel interfaces that you want to use on the device), and a subset of
> the SELinux utilities (some of which you'll want to implement as init
> built-ins because init.rc is interpreted and executed in-process by
> init, not by exec'ing external programs except for starting services;
> others you may want as additions to the Android toolbox so that you can
> invoke them from an adb shell).  libselinux needs to be ported (i.e.
> modified) and not just re-compiled for Android due to differences in its
> libc (bionic vs glibc).
>
> We plan to release our code once we have integrated SELinux with the
> application layer access controls and can demonstrate a more complete
> solution.
>
> --
> Stephen Smalley
> National Security Agency
>
>


-- 
Bhargava Shastry

--e89a8f6428f2be595504b0eb2697
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dear Mr. Smalley,<br><br>Thanks for your inputs. I did go through the slide=
s of your recent presentation on a case for SELinux enhanced Android phone.=
 You have done a great job re-engineering Android to retrofit SELinux.<br>
<br>I was wondering how much effort it is to actually port a subset of SELi=
nux&#39;s userspace (e.g., loadpolicy, chcon and a few others) tools to And=
roid? Does it entail major changes to Android&#39;s existing toolchain incl=
uding modifications to its bionic libc?=A0 Also, I was wondering if you als=
o undertook a port of coreutils as well (to enable the -Z option for utils =
like ps and ls)?<br>
<br>Thanks again,<br>Bhargava<br><br><div class=3D"gmail_quote">On Fri, Nov=
 4, 2011 at 1:32 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px=
 solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"HOEnZb"><div class=3D"h5">On Fri, 2011-11-04 at 11:16 +0100, =
Bhargava Shastry wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; I am trying to get SELinux running on an Android phone. I did<br>
&gt; successfully build the kernel with SELinux enabled and mounted<br>
&gt; selinuxfs on init. Now, I would like to port SELinux user-space tools<=
br>
&gt; for policy loading/management. I looked at sebusybox tool-set but ran<=
br>
&gt; into problems while compiling. My hunch is that header files related<b=
r>
&gt; to File System extended attributes are missing in the bionic lib<br>
&gt; sources that Android builds on. Having said that I have patched the<br=
>
&gt; Android YAFFS FS with an Xattr patch and also configured the kernel<br=
>
&gt; accordingly.<br>
&gt;<br>
&gt; I have sources of libselinux and libsepol checked out and am wondering=
<br>
&gt; how to go about building these libraries for Android. Any help in this=
<br>
&gt; regard would be much appreciated.<br>
<br>
</div></div>We have been working on enabling the use of SELinux in Android.=
 =A0I gave<br>
a talk on this topic at the Linux Security Summit in September; the<br>
slides are available here:<br>
<a href=3D"http://selinuxproject.org/%7Ejmorris/lss2011_slides/caseforseand=
roid.pdf" target=3D"_blank">http://selinuxproject.org/~jmorris/lss2011_slid=
es/caseforseandroid.pdf</a><br>
<br>
You don&#39;t need much of the SELinux userspace on the device unless you<b=
r>
want to try to support modular policy on the device, which I wouldn&#39;t<b=
r>
recommend (at least in its current form). =A0You can just build the policy<=
br>
on your build host using the build host&#39;s checkpolicy, which should be<=
br>
available to you on most Linux distributions; I build on Fedora and<br>
others have built my code on Ubuntu, both of which have checkpolicy<br>
available. =A0So you don&#39;t need libsepol, checkpolicy, libsemanage, or<=
br>
most of policycoreutils on the device.<br>
<br>
The only core SELinux userspace components that you need on the device<br>
are a subset of libselinux (primarily the wrappers for the SELinux<br>
kernel interfaces that you want to use on the device), and a subset of<br>
the SELinux utilities (some of which you&#39;ll want to implement as init<b=
r>
built-ins because init.rc is interpreted and executed in-process by<br>
init, not by exec&#39;ing external programs except for starting services;<b=
r>
others you may want as additions to the Android toolbox so that you can<br>
invoke them from an adb shell). =A0libselinux needs to be ported (i.e.<br>
modified) and not just re-compiled for Android due to differences in its<br=
>
libc (bionic vs glibc).<br>
<br>
We plan to release our code once we have integrated SELinux with the<br>
application layer access controls and can demonstrate a more complete<br>
solution.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Bhargava =
Shastry<br>

--e89a8f6428f2be595504b0eb2697--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
