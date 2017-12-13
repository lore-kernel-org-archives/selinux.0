MIME-Version: 1.0
In-Reply-To: <1513178677.19161.10.camel@tycho.nsa.gov>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
 <1513178677.19161.10.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 13 Dec 2017 21:40:25 +0530
Message-ID: <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>, "centos@centos.org" <centos@centos.org>
Content-Type: multipart/alternative; boundary="001a113dbf6a6652bd05603b01ec"
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113dbf6a6652bd05603b01ec
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Yes , I am using open env_params for it. But for this, my sftp is not
working and getting the below error message :

Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session): Unable to
get valid context for sftpuser
Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session
opened for user sftpuser by (uid=0)

Please let me know if you have any idea on this.

On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:
> > Hi All,
> >
> > just wanted to know the meaning of line session    required
> >  pam_selinux.so open env_params added in /etc/pam.d/sshd file.
> > Actually I am facing one issue related to this. When I changed this
> > env_params to restore then my Sftp is not working.
> >
> > Can anybody Please guide me on this.
>
> man pam_selinux describes the options and what they mean.
> Why did you change it to restore?  Per the man page, restore is to
> temporarily restore the contexts and would be a separate entry in the
> PAM stack before the module that needs the original contexts, followed
> by a pam_selinux.so open env_params after that module to set them up
> again.  But don't use restore unless you actually need it for some
> reason.
>
>
>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113dbf6a6652bd05603b01ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>Yes , I am using open env_p=
arams for it. But for this, my sftp is not working and getting the below er=
ror message :</div><div><br></div><div><div style=3D"font-size:12.8px">Dec =
13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session): Unable to get =
valid context for sftpuser</div><div style=3D"font-size:12.8px">Dec 13 13:0=
0:00 aman authpriv 6 sshd: pam_unix(sshd:session): session opened for user =
sftpuser by (uid=3D0)</div></div><div style=3D"font-size:12.8px"><br></div>=
<div style=3D"font-size:12.8px">Please let me know if you have any idea on =
this.</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Tue, =
2017-12-12 at 23:47 -0500, Aman Sharma wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; just wanted to know the meaning of line=C2=A0session=C2=A0 =C2=A0 requ=
ired=C2=A0 =C2=A0<br>
&gt; =C2=A0pam_selinux.so open env_params added in /etc/pam.d/sshd file.<br=
>
&gt; Actually I am facing one issue related to this. When I changed this<br=
>
&gt; env_params to restore then my Sftp is not working.=C2=A0<br>
&gt;<br>
&gt; Can anybody Please guide me on this.<br>
<br>
</span>man pam_selinux describes the options and what they mean.<br>
Why did you change it to restore?=C2=A0 Per the man page, restore is to<br>
temporarily restore the contexts and would be a separate entry in the<br>
PAM stack before the module that needs the original contexts, followed<br>
by a pam_selinux.so open env_params after that module to set them up<br>
again.=C2=A0 But don&#39;t use restore unless you actually need it for some=
<br>
reason.<br>
<br>
<br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990296404 | =
=C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_bla=
nk">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113dbf6a6652bd05603b01ec--
