Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB594YQI012762
 for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2017 04:04:34 -0500
Received: by mail-it0-f45.google.com with SMTP id u62so19776321ita.2
 for <selinux@tycho.nsa.gov>; Tue, 05 Dec 2017 01:04:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171205084004.GD19951@julius.enp8s0.d30>
References: <935734452.20069825.1512155793791.JavaMail.zimbra@redhat.com>
 <1512156497.5144.17.camel@tycho.nsa.gov>
 <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
 <CAPMH7-_-GpDCKmiiJx72jsdbkmviNm3o7QMkE6DpxdQxEP-WYA@mail.gmail.com>
 <1512402030.20988.22.camel@tycho.nsa.gov>
 <CAPMH7--RQXXPH4iWzgi6_OnidDSNYFRBT0aDdV6jxLTZBn-AHg@mail.gmail.com>
 <1512403784.20988.27.camel@tycho.nsa.gov>
 <CAPMH7--Sow6Pvkti+Dk_yL67CANPSZojRuAvGk8a2-dPonKxPw@mail.gmail.com>
 <1512405482.20988.32.camel@tycho.nsa.gov>
 <CAPMH7-89cWy9SRK9CHBe-j2AHsEeW==SjMAK8qKFvPQmg0DXTg@mail.gmail.com>
 <20171205084004.GD19951@julius.enp8s0.d30>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Tue, 5 Dec 2017 14:34:26 +0530
Message-ID: <CAPMH7-8_h9rChh2j00FjCgqiVA1rYEJiBy+nszy_bkRFa28ZHw@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113dbf6a43086e055f941fd5"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113dbf6a43086e055f941fd5
Content-Type: text/plain; charset="UTF-8"

Is this a bug in cent OS 7.3 ?

On Tue, Dec 5, 2017 at 2:10 PM, Dominick Grift <dac.override@gmail.com>
wrote:

> On Tue, Dec 05, 2017 at 02:02:37PM +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > Below is the changes which I made in Login and ssh file :
> >
> > cat /etc/pam.d/sshd
> > #%PAM-1.0
> > auth    required pam_sepermit.so
>
> side note: this is a "bug"
> https://src.fedoraproject.org/rpms/openssh/c/
> e044c5cf76618b023a4315f41fe126c80c06b833?branch=master
>
> > auth       include     password-auth
> > # Used with polkit to reauthorize users in remote sessions
> > account    required     pam_nologin.so
> > account    include      password-auth
> > password   include      password-auth
> > # pam_selinux.so close should be the first session rule
> > session    required     pam_selinux.so close
> > session    required     pam_loginuid.so
> > # pam_selinux.so open should only be followed by sessions to be executed
> in
> > the user context
> > session    required     pam_selinux.so open env_params
> > session    required     pam_namespace.so
> > session    optional     pam_keyinit.so force revoke
> > session    include      password-auth
> > # Used with polkit to reauthorize users in remote sessions
> >
> >
> > cat /etc/pam.d/login
> > #%PAM-1.0
> > auth [user_unknown=ignore success=ok ignore=ignore default=bad]
> > pam_securetty.so
> > auth       include      system-auth
> > account    required     pam_nologin.so
> > account    include      system-auth
> > password   include      system-auth
> > # pam_selinux.so close should be the first session rule
> > session    required     pam_selinux.so close
> > session    required     pam_loginuid.so
> > session    optional     pam_console.so
> > # pam_selinux.so restore should only be followed by sessions to be
> executed
> > in the user context
> > session    required     pam_selinux.so open
> > session    required     pam_namespace.so
> > session    optional     pam_keyinit.so force revoke
> > session    include      system-auth
> > -session   optional     pam_ck_connector.so
> >
> > Please Let me know if any comments are there.
> >
> > On Mon, Dec 4, 2017 at 10:08 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> >
> > > On Mon, 2017-12-04 at 22:04 +0530, Aman Sharma wrote:
> > > > Hi Stephen,
> > > >
> > > > Thanks alot for the help.
> > > >
> > > > I got the issue. Its due to the problem in /etc/pam.d/sshd file.
> > > >
> > > > After fixing this, now is working fine. Thanks alot once again.
> > >
> > > Ok, can you explain what exactly what wrong in your /etc/pam.d/sshd
> > > file, so that if someone else encounters this behavior in the future,
> > > they can find a solution in the list archives?
> > >
> > > >
> > > > On Mon, Dec 4, 2017 at 9:39 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > > wrote:
> > > > > On Mon, 2017-12-04 at 21:31 +0530, Aman Sharma wrote:
> > > > > > Hi Stephen,
> > > > > >
> > > > > > I got the below logs from the file .Can you please if these logs
> > > > > are
> > > > > > fine or not :
> > > > > >
> > > > > > journalctl | grep selinux
> > > > > > Dec 05 02:55:46 localhost.localdomain kernel: EVM:
> > > > > security.selinux
> > > > > > Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
> > > > > > type=USER_START msg=audit(1512402970.129:107): pid=7145 uid=0
> > > > > auid=0
> > > > > > ses=2 subj=system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > > > > msg='op=PAM:session_open
> > > > > >
> > > > > grantors=pam_selinux,pam_loginuid,pam_selinux,pam_
> namespace,pam_key
> > > > > in
> > > > > > it,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> > > > > > acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209
> > > > > > addr=10.97.7.209 terminal=ssh res=success'
> > > > > > Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
> > > > > > type=USER_START msg=audit(1512402970.131:108): pid=7568 uid=0
> > > > > auid=0
> > > > > > ses=3 subj=system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > > > > msg='op=PAM:session_open
> > > > > >
> > > > > grantors=pam_selinux,pam_loginuid,pam_selinux,pam_
> namespace,pam_key
> > > > > in
> > > > > > it,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> > > > > > acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209
> > > > > > addr=10.97.7.209 terminal=ssh res=success'
> > > > > >
> > > > > > Please let me know if any comments are there.
> > > > >
> > > > > Those are normal.  Check journalctl and /var/log/secure for any
> > > > > errors
> > > > > from sshd.
> > > > > Also try the selinuxdefcon command I mentioned.
> > > > >
> > > > > >
> > > > > > On Mon, Dec 4, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.go
> > > > > v>
> > > > > > wrote:
> > > > > > > On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:
> > > > > > > > Hi All,
> > > > > > > >
> > > > > > > > Thanks for the information.
> > > > > > > >
> > > > > > > > But after resetting the semanage User/login, and moving the
> > > > > > > targeted
> > > > > > > > folder to old one and then install the default target. then
> > > > > also
> > > > > > > its
> > > > > > > > still showing the
> > > > > > > > Id context as context=system_u:system_r:unconfined_t:s0-
> > > > > > > s0:c0.c1023.
> > > > > > > >
> > > > > > > > What I observed is after changing the permission using
> > > > > semanage
> > > > > > > > command also, its still showing the system_u:system_r.
> > > > > > > >
> > > > > > > > Check the semanage login/User output :
> > > > > > > >
> > > > > > > > semanage login -l
> > > > > > > >
> > > > > > > > Login Name           SELinux User         MLS/MCS Range
> > > > >
> > > > > > > > Service
> > > > > > > >
> > > > > > > > __default__          unconfined_u         s0-s0:c0.c1023
> > > > >  *
> > > > > > > > root                 unconfined_u         s0-s0:c0.c1023
> > > > >  *
> > > > > > > > system_u             system_u             s0-s0:c0.c1023
> > > > >  *
> > > > > > > >
> > > > > > > >
> > > > > > > > semanage user -l
> > > > > > > >
> > > > > > > >                 Labeling   MLS/       MLS/
> > > > >
> > > > > > >
> > > > > > > > SELinux User    Prefix     MCS Level  MCS Range
> > > > >
> > > > > > >
> > > > > > > > SELinux Roles
> > > > > > > >
> > > > > > > > guest_u         user       s0         s0
> > > > >
> > > > > > >
> > > > > > > >  guest_r
> > > > > > > > root            user       s0         s0-s0:c0.c1023
> > > > >
> > > > > > >
> > > > > > > >  staff_r sysadm_r system_r unconfined_r
> > > > > > > > staff_u         user       s0         s0-s0:c0.c1023
> > > > >
> > > > > > >
> > > > > > > >  staff_r sysadm_r system_r unconfined_r
> > > > > > > > sysadm_u        user       s0         s0-s0:c0.c1023
> > > > >
> > > > > > >
> > > > > > > >  sysadm_r
> > > > > > > > system_u        user       s0         s0-s0:c0.c1023
> > > > >
> > > > > > >
> > > > > > > >  system_r unconfined_r
> > > > > > > > unconfined_u    user       s0         s0-s0:c0.c1023
> > > > >
> > > > > > >
> > > > > > > >  system_r unconfined_r
> > > > > > > > user_u          user       s0         s0
> > > > >
> > > > > > >
> > > > > > > >  user_r
> > > > > > > > xguest_u        user       s0         s0
> > > > >
> > > > > > >
> > > > > > > >  xguest_r
> > > > > > > >
> > > > > > > >
> > > > > > > > Looks like its related to some other issue. What you think
> > > > > about
> > > > > > > > this.
> > > > > > >
> > > > > > > Do you have any relevant error messages in /var/log/secure or
> > > > > > > journalctl -rb?  Look for anything that refers to selinux or
> > > > > > > context.
> > > > > > >
> > > > > > > I'm guessing that pam_selinux is unable to determine a valid
> > > > > > > context
> > > > > > > for your login for some reason, and this is causing it to fall
> > > > > back
> > > > > > > to
> > > > > > > this one.  Or something like that.
> > > > > > >
> > > > > > > You could try to emulate this process via selinuxdefcon,
> > > > > although
> > > > > > > I'm
> > > > > > > not sure how closely it matches pam_selinux anymore.  Sample
> > > > > usage:
> > > > > > >
> > > > > > > 1. See what context sshd is running in.
> > > > > > >
> > > > > > > ps -eZ | grep sshd
> > > > > > >
> > > > > > > It should be:
> > > > > > > system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > > > > >
> > > > > > > 2. Run selinuxdefcon to compute the default context for root
> > > > > when
> > > > > > > logging in from sshd:
> > > > > > >
> > > > > > > # Second argument should be whatever was shown by ps -eZ | grep
> > > > > > > sshd
> > > > > > > above.
> > > > > > > selinuxdefcon root system_u:system_r:sshd_t:s0-s0.c0123
> > > > > > >
> > > > > > > It should be:
> > > > > > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > >
> > > > > > Thanks
> > > > > > Aman
> > > > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > > >
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Thanks
> > > > Aman
> > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
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
> --
> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
> Dominick Grift
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113dbf6a43086e055f941fd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Is this a bug in cent OS 7.3 ?</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Tue, Dec 5, 2017 at 2:10 PM, Dominic=
k Grift <span dir=3D"ltr">&lt;<a href=3D"mailto:dac.override@gmail.com" tar=
get=3D"_blank">dac.override@gmail.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex"><span class=3D"">On Tue, Dec 05, 2017 at 02:02:37PM +053=
0, Aman Sharma wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
</span><span class=3D"">&gt; Below is the changes which I made in Login and=
 ssh file :<br>
&gt;<br>
&gt; cat /etc/pam.d/sshd<br>
&gt; #%PAM-1.0<br>
&gt; auth=C2=A0 =C2=A0 required pam_sepermit.so<br>
<br>
</span>side note: this is a &quot;bug&quot;<br>
<a href=3D"https://src.fedoraproject.org/rpms/openssh/c/e044c5cf76618b023a4=
315f41fe126c80c06b833?branch=3Dmaster" rel=3D"noreferrer" target=3D"_blank"=
>https://src.fedoraproject.org/<wbr>rpms/openssh/c/<wbr>e044c5cf76618b023a4=
315f41fe126<wbr>c80c06b833?branch=3Dmaster</a><br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; auth=C2=A0 =C2=A0 =C2=A0 =C2=A0include=C2=A0 =C2=A0 =C2=A0password-aut=
h<br>
&gt; # Used with polkit to reauthorize users in remote sessions<br>
&gt; account=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_nologin.so<br>
&gt; account=C2=A0 =C2=A0 include=C2=A0 =C2=A0 =C2=A0 password-auth<br>
&gt; password=C2=A0 =C2=A0include=C2=A0 =C2=A0 =C2=A0 password-auth<br>
&gt; # pam_selinux.so close should be the first session rule<br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_selinux.so close<=
br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_loginuid.so<br>
&gt; # pam_selinux.so open should only be followed by sessions to be execut=
ed in<br>
&gt; the user context<br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_selinux.so open e=
nv_params<br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_namespace.so<br>
&gt; session=C2=A0 =C2=A0 optional=C2=A0 =C2=A0 =C2=A0pam_keyinit.so force =
revoke<br>
&gt; session=C2=A0 =C2=A0 include=C2=A0 =C2=A0 =C2=A0 password-auth<br>
&gt; # Used with polkit to reauthorize users in remote sessions<br>
&gt;<br>
&gt;<br>
&gt; cat /etc/pam.d/login<br>
&gt; #%PAM-1.0<br>
&gt; auth [user_unknown=3Dignore success=3Dok ignore=3Dignore default=3Dbad=
]<br>
&gt; pam_securetty.so<br>
&gt; auth=C2=A0 =C2=A0 =C2=A0 =C2=A0include=C2=A0 =C2=A0 =C2=A0 system-auth=
<br>
&gt; account=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_nologin.so<br>
&gt; account=C2=A0 =C2=A0 include=C2=A0 =C2=A0 =C2=A0 system-auth<br>
&gt; password=C2=A0 =C2=A0include=C2=A0 =C2=A0 =C2=A0 system-auth<br>
&gt; # pam_selinux.so close should be the first session rule<br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_selinux.so close<=
br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_loginuid.so<br>
&gt; session=C2=A0 =C2=A0 optional=C2=A0 =C2=A0 =C2=A0pam_console.so<br>
&gt; # pam_selinux.so restore should only be followed by sessions to be exe=
cuted<br>
&gt; in the user context<br>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_selinux.so open<b=
r>
&gt; session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_namespace.so<br>
&gt; session=C2=A0 =C2=A0 optional=C2=A0 =C2=A0 =C2=A0pam_keyinit.so force =
revoke<br>
&gt; session=C2=A0 =C2=A0 include=C2=A0 =C2=A0 =C2=A0 system-auth<br>
&gt; -session=C2=A0 =C2=A0optional=C2=A0 =C2=A0 =C2=A0pam_ck_connector.so<b=
r>
&gt;<br>
&gt; Please Let me know if any comments are there.<br>
&gt;<br>
&gt; On Mon, Dec 4, 2017 at 10:08 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Mon, 2017-12-04 at 22:04 +0530, Aman Sharma wrote:<br>
&gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks alot for the help.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I got the issue. Its due to the problem in /etc/pam.d/sshd f=
ile.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; After fixing this, now is working fine. Thanks alot once aga=
in.<br>
&gt; &gt;<br>
&gt; &gt; Ok, can you explain what exactly what wrong in your /etc/pam.d/ss=
hd<br>
&gt; &gt; file, so that if someone else encounters this behavior in the fut=
ure,<br>
&gt; &gt; they can find a solution in the list archives?<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Mon, Dec 4, 2017 at 9:39 PM, Stephen Smalley &lt;<a href=
=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; On Mon, 2017-12-04 at 21:31 +0530, Aman Sharma wrote:<b=
r>
&gt; &gt; &gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I got the below logs from the file .Can you please=
 if these logs<br>
&gt; &gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; &gt; fine or not :<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; journalctl | grep selinux<br>
&gt; &gt; &gt; &gt; &gt; Dec 05 02:55:46 localhost.localdomain kernel: EVM:=
<br>
&gt; &gt; &gt; &gt; security.selinux<br>
&gt; &gt; &gt; &gt; &gt; Dec 04 21:26:10 cucm audispd[569]: node=3Dlocalhos=
t.localdomain<br>
&gt; &gt; &gt; &gt; &gt; type=3DUSER_START msg=3Daudit(1512402970.129:107):=
 pid=3D7145 uid=3D0<br>
&gt; &gt; &gt; &gt; auid=3D0<br>
&gt; &gt; &gt; &gt; &gt; ses=3D2 subj=3Dsystem_u:system_r:sshd_t:<wbr>s0-s0=
:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; msg=3D&#39;op=3DPAM:session_open<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; grantors=3Dpam_selinux,pam_<wbr>loginuid,pam_selinux,pa=
m_<wbr>namespace,pam_key<br>
&gt; &gt; &gt; &gt; in<br>
&gt; &gt; &gt; &gt; &gt; it,pam_keyinit,pam_limits,pam_<wbr>systemd,pam_uni=
x,pam_lastlog<br>
&gt; &gt; &gt; &gt; &gt; acct=3D&quot;root&quot; exe=3D&quot;/usr/sbin/sshd=
&quot; hostname=3D10.97.7.209<br>
&gt; &gt; &gt; &gt; &gt; addr=3D10.97.7.209 terminal=3Dssh res=3Dsuccess&#3=
9;<br>
&gt; &gt; &gt; &gt; &gt; Dec 04 21:26:10 cucm audispd[569]: node=3Dlocalhos=
t.localdomain<br>
&gt; &gt; &gt; &gt; &gt; type=3DUSER_START msg=3Daudit(1512402970.131:108):=
 pid=3D7568 uid=3D0<br>
&gt; &gt; &gt; &gt; auid=3D0<br>
&gt; &gt; &gt; &gt; &gt; ses=3D3 subj=3Dsystem_u:system_r:sshd_t:<wbr>s0-s0=
:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; msg=3D&#39;op=3DPAM:session_open<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; grantors=3Dpam_selinux,pam_<wbr>loginuid,pam_selinux,pa=
m_<wbr>namespace,pam_key<br>
&gt; &gt; &gt; &gt; in<br>
&gt; &gt; &gt; &gt; &gt; it,pam_keyinit,pam_limits,pam_<wbr>systemd,pam_uni=
x,pam_lastlog<br>
&gt; &gt; &gt; &gt; &gt; acct=3D&quot;root&quot; exe=3D&quot;/usr/sbin/sshd=
&quot; hostname=3D10.97.7.209<br>
&gt; &gt; &gt; &gt; &gt; addr=3D10.97.7.209 terminal=3Dssh res=3Dsuccess&#3=
9;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Please let me know if any comments are there.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Those are normal.=C2=A0 Check journalctl and /var/log/s=
ecure for any<br>
&gt; &gt; &gt; &gt; errors<br>
&gt; &gt; &gt; &gt; from sshd.<br>
&gt; &gt; &gt; &gt; Also try the selinuxdefcon command I mentioned.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Mon, Dec 4, 2017 at 9:10 PM, Stephen Smalley &l=
t;sds@tycho.nsa.go<br>
&gt; &gt; &gt; &gt; v&gt;<br>
&gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Sat, 2017-12-02 at 09:29 +0530, Aman Sharm=
a wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Hi All,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks for the information.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; But after resetting the semanage User/lo=
gin, and moving the<br>
&gt; &gt; &gt; &gt; &gt; &gt; targeted<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; folder to old one and then install the d=
efault target. then<br>
&gt; &gt; &gt; &gt; also<br>
&gt; &gt; &gt; &gt; &gt; &gt; its<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; still showing the<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Id context as context=3Dsystem_u:system_=
r:<wbr>unconfined_t:s0-<br>
&gt; &gt; &gt; &gt; &gt; &gt; s0:c0.c1023.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; What I observed is after changing the pe=
rmission using<br>
&gt; &gt; &gt; &gt; semanage<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; command also, its still showing the syst=
em_u:system_r.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Check the semanage login/User output :<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; semanage login -l<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0SELinux User=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range<br=
>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Service<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; __default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 unconfined_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt; &gt;=C2=A0 *<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0unconfined_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
-s0:c0.c1023<br>
&gt; &gt; &gt; &gt;=C2=A0 *<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
-s0:c0.c1023<br>
&gt; &gt; &gt; &gt;=C2=A0 *<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; semanage user -l<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0Labeling=C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0ML=
S/<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =
=C2=A0 =C2=A0MCS Level=C2=A0 MCS Range<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; SELinux Roles<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br=
>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 guest_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
0-s0:c0.c1023<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 staff_r sysadm_r system_r unconfin=
ed_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; staff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0=
:c0.c1023<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 staff_r sysadm_r system_r unconfin=
ed_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=
=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c10=
23<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 sysadm_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=
=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c10=
23<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 system_r unconfined_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; unconfined_u=C2=A0 =C2=A0 user=C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 system_r unconfined_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 user_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=
=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 xguest_r<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Looks like its related to some other iss=
ue. What you think<br>
&gt; &gt; &gt; &gt; about<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; this.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Do you have any relevant error messages in /v=
ar/log/secure or<br>
&gt; &gt; &gt; &gt; &gt; &gt; journalctl -rb?=C2=A0 Look for anything that =
refers to selinux or<br>
&gt; &gt; &gt; &gt; &gt; &gt; context.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; I&#39;m guessing that pam_selinux is unable t=
o determine a valid<br>
&gt; &gt; &gt; &gt; &gt; &gt; context<br>
&gt; &gt; &gt; &gt; &gt; &gt; for your login for some reason, and this is c=
ausing it to fall<br>
&gt; &gt; &gt; &gt; back<br>
&gt; &gt; &gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; this one.=C2=A0 Or something like that.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; You could try to emulate this process via sel=
inuxdefcon,<br>
&gt; &gt; &gt; &gt; although<br>
&gt; &gt; &gt; &gt; &gt; &gt; I&#39;m<br>
&gt; &gt; &gt; &gt; &gt; &gt; not sure how closely it matches pam_selinux a=
nymore.=C2=A0 Sample<br>
&gt; &gt; &gt; &gt; usage:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; 1. See what context sshd is running in.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; ps -eZ | grep sshd<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; It should be:<br>
&gt; &gt; &gt; &gt; &gt; &gt; system_u:system_r:sshd_t:s0-<wbr>s0:c0.c1023<=
br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; 2. Run selinuxdefcon to compute the default c=
ontext for root<br>
&gt; &gt; &gt; &gt; when<br>
&gt; &gt; &gt; &gt; &gt; &gt; logging in from sshd:<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; # Second argument should be whatever was show=
n by ps -eZ | grep<br>
&gt; &gt; &gt; &gt; &gt; &gt; sshd<br>
&gt; &gt; &gt; &gt; &gt; &gt; above.<br>
&gt; &gt; &gt; &gt; &gt; &gt; selinuxdefcon root system_u:system_r:sshd_t:s=
0-<wbr>s0.c0123<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; It should be:<br>
&gt; &gt; &gt; &gt; &gt; &gt; unconfined_u:unconfined_r:<wbr>unconfined_t:s=
0-s0:c0.c1023<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D=
"mailto:amansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:am=
ansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com">amansh.sharma5@gmail.com</a><br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0 02D5 3B6C 5F1D 2C7B 6B02=
<br>
<a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dget&amp;search=3D0x3B=
6C5F1D2C7B6B02" rel=3D"noreferrer" target=3D"_blank">https://sks-keyservers=
.net/<wbr>pks/lookup?op=3Dget&amp;search=3D<wbr>0x3B6C5F1D2C7B6B02</a><br>
Dominick Grift<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113dbf6a43086e055f941fd5--
