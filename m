MIME-Version: 1.0
In-Reply-To: <1513192514.25026.5.camel@tycho.nsa.gov>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
 <1513178677.19161.10.camel@tycho.nsa.gov>
 <CAPMH7-_kGWkvWY=YgYMQ5urCparVum4ejytg_ui3n=cgFz7atA@mail.gmail.com>
 <1513192514.25026.5.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Thu, 14 Dec 2017 12:48:42 +0530
Message-ID: <CAPMH7-9F4H_e-VmHqOzdpCq0JkN-y71-ye152yBixZrHHmOd5g@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="94eb2c04e9509f5fdf056047b192"
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c04e9509f5fdf056047b192
Content-Type: text/plain; charset="UTF-8"

Hi All,

Below is the output of semanage USer command output for sftpuser:

*specialuser_u   user       s0         s0
 sysadm_r system_r*

and for command semanage login -l , output is :

*sftpuser             specialuser_u        s0                   **

*and also, after adding the debugging option, its showing the below error
message as :*

Dec 13 15:46:10 cucmSUB authpriv 3 sshd: pam_selinux(sshd:session): Unable
to get valid context for sftpuser

Dec 13 15:46:10 cucmSUB authpriv 5 sshd: pam_selinux(sshd:session): Open
Session

Dec 13 15:46:11 cucmSUB authpriv 7 sshd: pam_selinux(sshd:session):
Username= sftpuser SELinux User= specialuser_u Level= s0

Dec 13 15:46:11 cucmSUB authpriv 3 sshd: pam_selinux(sshd:session): Unable
to get valid context for sftpuser


also Selinuxdefcon command is showing error while running for sftpuser i.e.

*sudo /usr/sbin/selinuxdefcon sftpuser system_u:system_r:sshd_t:s0*

*/usr/sbin/selinuxdefcon: Invalid argument*


*Please let me know your comments on this.*


*Thanks*

*Aman*

On Thu, Dec 14, 2017 at 12:45 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-12-13 at 21:40 +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > Yes , I am using open env_params for it. But for this, my sftp is not
> > working and getting the below error message :
> >
> > Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session):
> > Unable to get valid context for sftpuser
> > Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session
> > opened for user sftpuser by (uid=0)
> >
> > Please let me know if you have any idea on this.
>
> Do you have any semanage login mapping for sftpuser or is it just using
> the __default__ entry? (what does semanage login -l show)  How was
> sftpuser created?
>
> You could add the debug option on the pam_selinux.so line to try to get
> more information.
>
> You could run selinuxdefcon to query what context would be used for
> that user, e.g.
> selinuxdefcon sftpuser system_u:system_r:sshd_t:s0-s0.c0123
>
> >
> > On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > > On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:
> > > > Hi All,
> > > >
> > > > just wanted to know the meaning of line session    required
> > > >  pam_selinux.so open env_params added in /etc/pam.d/sshd file.
> > > > Actually I am facing one issue related to this. When I changed
> > > this
> > > > env_params to restore then my Sftp is not working.
> > > >
> > > > Can anybody Please guide me on this.
> > >
> > > man pam_selinux describes the options and what they mean.
> > > Why did you change it to restore?  Per the man page, restore is to
> > > temporarily restore the contexts and would be a separate entry in
> > > the
> > > PAM stack before the module that needs the original contexts,
> > > followed
> > > by a pam_selinux.so open env_params after that module to set them
> > > up
> > > again.  But don't use restore unless you actually need it for some
> > > reason.
> > >
> > >
> > >
> > >
> >
> >
> >
> > --
> >
> > Thanks
> > Aman
> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--94eb2c04e9509f5fdf056047b192
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>Below is the output of semanage=
 USer command output for sftpuser:</div><div><b><br></b></div><div><b>speci=
aluser_u=C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysadm_r system_r</b><br></div=
><div><br></div><div>and for command semanage login -l , output is :</div><=
div><b><br></b></div><div><b>sftpuser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0specialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*</b><br></div><div><b><br>=
</b></div><div><b>and also, after adding the debugging option, its showing =
the below error message as :</b></div><div><b><br></b></div><div>







<div class=3D"gmail-WordSection1" style=3D"page: WordSection1;">

<p class=3D"gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:normal;fon=
t-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:10pt;f=
ont-family:&quot;Segoe UI&quot;,sans-serif;color:black">Dec 13 15:46:10 cuc=
mSUB
authpriv 3 sshd: pam_selinux(sshd:session): Unable to get valid context for
sftpuser</span></p>

<p class=3D"gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:normal;fon=
t-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:10pt;f=
ont-family:&quot;Segoe UI&quot;,sans-serif;color:black">Dec 13 15:46:10 cuc=
mSUB
authpriv 5 sshd: pam_selinux(sshd:session): Open Session</span></p>

<p class=3D"gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:normal;fon=
t-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:10pt;f=
ont-family:&quot;Segoe UI&quot;,sans-serif;color:black">Dec 13 15:46:11 cuc=
mSUB authpriv
7 sshd: pam_selinux(sshd:session): Username=3D sftpuser SELinux User=3D
specialuser_u Level=3D s0</span></p>

<p class=3D"gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:normal;fon=
t-size:11pt;font-family:Calibri,sans-serif"><span style=3D"font-size:10pt;f=
ont-family:&quot;Segoe UI&quot;,sans-serif;color:black">Dec 13 15:46:11 cuc=
mSUB
authpriv 3 sshd: pam_selinux(sshd:session): Unable to get valid context for
sftpuser</span><span style=3D"font-size:10pt;font-family:&quot;Segoe UI&quo=
t;,sans-serif;color:black"> </span></p><p class=3D"gmail-MsoNormal" style=
=3D"margin:2pt 0in;line-height:normal;font-size:11pt;font-family:Calibri,sa=
ns-serif"><span style=3D"font-size:10pt;font-family:&quot;Segoe UI&quot;,sa=
ns-serif;color:black"><br></span></p><p class=3D"gmail-MsoNormal" style=3D"=
margin:2pt 0in;line-height:normal;font-size:11pt;font-family:Calibri,sans-s=
erif"><span style=3D"font-size:10pt;font-family:&quot;Segoe UI&quot;,sans-s=
erif;color:black">also Selinuxdefcon command is showing error while running=
 for sftpuser i.e.=C2=A0</span></p><p class=3D"gmail-MsoNormal" style=3D"ma=
rgin:2pt 0in;line-height:normal"><font color=3D"#000000" face=3D"Segoe UI, =
sans-serif"><span style=3D"font-size:13.3333px"><b>sudo /usr/sbin/selinuxde=
fcon sftpuser system_u:system_r:sshd_t:s0</b></span></font></p><p class=3D"=
gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:normal"><font color=3D=
"#000000" face=3D"Segoe UI, sans-serif"><span style=3D"font-size:13.3333px"=
><b>/usr/sbin/selinuxdefcon: Invalid argument</b></span></font></p><p class=
=3D"gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:normal"><font colo=
r=3D"#000000" face=3D"Segoe UI, sans-serif"><span style=3D"font-size:13.333=
3px"><b><br></b></span></font></p><p class=3D"gmail-MsoNormal" style=3D"mar=
gin:2pt 0in;line-height:normal"><font color=3D"#000000" face=3D"Segoe UI, s=
ans-serif"><span style=3D"font-size:13.3333px"><b>Please let me know your c=
omments on this.</b></span></font></p><p class=3D"gmail-MsoNormal" style=3D=
"margin:2pt 0in;line-height:normal"><font color=3D"#000000" face=3D"Segoe U=
I, sans-serif"><span style=3D"font-size:13.3333px"><b><br></b></span></font=
></p><p class=3D"gmail-MsoNormal" style=3D"margin:2pt 0in;line-height:norma=
l"><font color=3D"#000000" face=3D"Segoe UI, sans-serif"><span style=3D"fon=
t-size:13.3333px"><b>Thanks</b></span></font></p><p class=3D"gmail-MsoNorma=
l" style=3D"margin:2pt 0in;line-height:normal"><font color=3D"#000000" face=
=3D"Segoe UI, sans-serif"><span style=3D"font-size:13.3333px"><b>Aman</b></=
span></font></p>

</div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"=
>On Thu, Dec 14, 2017 at 12:45 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed=
, 2017-12-13 at 21:40 +0530, Aman Sharma wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
&gt; Yes , I am using open env_params for it. But for this, my sftp is not<=
br>
&gt; working and getting the below error message :<br>
&gt;<br>
&gt; Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session):<br>
&gt; Unable to get valid context for sftpuser<br>
&gt; Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session<=
br>
&gt; opened for user sftpuser by (uid=3D0)<br>
&gt;<br>
&gt; Please let me know if you have any idea on this.<br>
<br>
</span>Do you have any semanage login mapping for sftpuser or is it just us=
ing<br>
the __default__ entry? (what does semanage login -l show)=C2=A0 How was<br>
sftpuser created?<br>
<br>
You could add the debug option on the pam_selinux.so line to try to get<br>
more information.<br>
<br>
You could run selinuxdefcon to query what context would be used for<br>
that user, e.g.<br>
selinuxdefcon sftpuser system_u:system_r:sshd_t:s0-<wbr>s0.c0123<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Wed, Dec 13, 2017 at 8:54 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; On Tue, 2017-12-12 at 23:47 -0500, Aman Sharma wrote:<br>
&gt; &gt; &gt; Hi All,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; just wanted to know the meaning of line=C2=A0session=C2=A0 =
=C2=A0 required=C2=A0 =C2=A0<br>
&gt; &gt; &gt; =C2=A0pam_selinux.so open env_params added in /etc/pam.d/ssh=
d file.<br>
&gt; &gt; &gt; Actually I am facing one issue related to this. When I chang=
ed<br>
&gt; &gt; this<br>
&gt; &gt; &gt; env_params to restore then my Sftp is not working.=C2=A0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can anybody Please guide me on this.<br>
&gt; &gt;<br>
&gt; &gt; man pam_selinux describes the options and what they mean.<br>
&gt; &gt; Why did you change it to restore?=C2=A0 Per the man page, restore=
 is to<br>
&gt; &gt; temporarily restore the contexts and would be a separate entry in=
<br>
&gt; &gt; the<br>
&gt; &gt; PAM stack before the module that needs the original contexts,<br>
&gt; &gt; followed<br>
&gt; &gt; by a pam_selinux.so open env_params after that module to set them=
<br>
&gt; &gt; up<br>
&gt; &gt; again.=C2=A0 But don&#39;t use restore unless you actually need i=
t for some<br>
&gt; &gt; reason.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --=C2=A0<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com">amansh.sharma5@gmail.com</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--94eb2c04e9509f5fdf056047b192--
