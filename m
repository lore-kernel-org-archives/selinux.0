Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7QGAFEr025155
 for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2015 12:10:18 -0400
Received: by igcse8 with SMTP id se8so44349252igc.1
 for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2015 09:10:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55DDC373.8030509@tycho.nsa.gov>
References: <476DC76E7D1DF2438D32BFADF679FC56010597CC@ORSMSX103.amr.corp.intel.com>
 <55DDC373.8030509@tycho.nsa.gov>
Date: Wed, 26 Aug 2015 09:10:12 -0700
Message-ID: <CAFJ0LnHj44XVf8BfduXDQtsKmNe+Tdc3CMO4HDCU-4qF6u-F6g@mail.gmail.com>
Subject: Re: kernel access to device comm is kdevtmpfs
From: Nick Kralevich <nnk@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Content-Type: multipart/alternative; boundary=047d7b4140fcde9468051e3915b9
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b4140fcde9468051e3915b9
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 26, 2015 at 6:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> With devtmpfs, the kernel itself automatically populates and maintains a
> device node tree.  The claim is that this provides you with a working
> /dev tree before udev comes up, and that you can even dispense with
> running udev entirely on simple systems (e.g. embedded).  However, it
> seems like everyone continues to run udev on top of devtmpfs in Linux
> distributions.
>
> The problem of course is that the kernel has no clue how to label the
> device nodes, so it is still necessary to have udev or ueventd handle
> that.  And with the kernel creation of the device nodes, we then have a
> race condition where the device node briefly exists in the wrong, most
> likely inaccessible label.
>
>
Do you know how other standard DAC permissions are configured by the
kernel? The kernel must have some knowledge of how to set the
UID/GID/perms/etc...

-- Nick

--047d7b4140fcde9468051e3915b9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Aug 26, 2015 at 6:47 AM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"=
><div class=3D"h5"><span style=3D"color:rgb(34,34,34)">With devtmpfs, the k=
ernel itself automatically populates and maintains a</span><br></div></div>
device node tree.=C2=A0 The claim is that this provides you with a working<=
br>
/dev tree before udev comes up, and that you can even dispense with<br>
running udev entirely on simple systems (e.g. embedded).=C2=A0 However, it<=
br>
seems like everyone continues to run udev on top of devtmpfs in Linux<br>
distributions.<br>
<br>
The problem of course is that the kernel has no clue how to label the<br>
device nodes, so it is still necessary to have udev or ueventd handle<br>
that.=C2=A0 And with the kernel creation of the device nodes, we then have =
a<br>
race condition where the device node briefly exists in the wrong, most<br>
likely inaccessible label.<br><br></blockquote><div><br></div><div>Do you k=
now how other standard DAC permissions are configured by the kernel? The ke=
rnel must have some knowledge of how to set the UID/GID/perms/etc...</div><=
div><br></div><div>-- Nick</div><div>=C2=A0</div></div>
</div></div>

--047d7b4140fcde9468051e3915b9--
