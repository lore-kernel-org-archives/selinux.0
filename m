MIME-Version: 1.0
In-Reply-To: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
References: <CAPMH7--1HHC1tj9SYpMp2Mcxo6_kjBRgViA76qbSo4PQ-_dstA@mail.gmail.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 13 Dec 2017 14:44:37 +0530
Message-ID: <CAPMH7-8LyLy3QeFiazgo8dqypfaYn=bsxxrNvsnaQgZdfkCSWA@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
 centos@centos.org
Content-Type: multipart/alternative; boundary="001a113a9a3e5a1bbe056035326f"
Subject: Re: PAM Security related issue
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a9a3e5a1bbe056035326f
Content-Type: text/plain; charset="UTF-8"

Also in the logs, I am getting the below error message :


Dec 13 13:00:00 aman authpriv 3 sshd: pam_selinux(sshd:session): Unable to
get valid context for sftpuser
Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session
opened for user sftpuser by (uid=0)

On Wed, Dec 13, 2017 at 10:17 AM, Aman Sharma <amansh.sharma5@gmail.com>
wrote:

> Hi All,
>
> just wanted to know the meaning of line *session    required
>  pam_selinux.so open env_params *added in */etc/pam.d/sshd *file.
> Actually I am facing one issue related to this. When I changed this *env_params
> to restore *then my Sftp is not working.
>
> Can anybody Please guide me on this.
>
>
> --
>
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113a9a3e5a1bbe056035326f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Also in the logs, I am getting the below error message :<d=
iv><br></div><div><div><br></div><div>Dec 13 13:00:00 aman authpriv 3 sshd:=
 pam_selinux(sshd:session): Unable to get valid context for sftpuser</div><=
div>Dec 13 13:00:00 aman authpriv 6 sshd: pam_unix(sshd:session): session o=
pened for user sftpuser by (uid=3D0)</div></div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Wed, Dec 13, 2017 at 10:17 AM, Aman=
 Sharma <span dir=3D"ltr">&lt;<a href=3D"mailto:amansh.sharma5@gmail.com" t=
arget=3D"_blank">amansh.sharma5@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr">Hi All,<div><br></div><div>just wan=
ted to know the meaning of line=C2=A0<b>session=C2=A0 =C2=A0 required=C2=A0=
 =C2=A0 =C2=A0pam_selinux.so open env_params </b>added in <b>/etc/pam.d/ssh=
d </b>file. Actually I am facing one issue related to this. When I changed =
this <b>env_params to restore </b>then my Sftp is not working.=C2=A0</div><=
div><br></div><div>Can anybody Please guide me on this.</div><span class=3D=
"HOEnZb"><font color=3D"#888888"><div>=C2=A0=C2=A0<br></div><div><div><br><=
/div>-- <br><div class=3D"m_-8342737998594002965gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div></font></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990296404 | =
=C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_bla=
nk">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113a9a3e5a1bbe056035326f--
