MIME-Version: 1.0
In-Reply-To: <1512402030.20988.22.camel@tycho.nsa.gov>
References: <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
 <20171130201920.GA32637@julius.enp8s0.d30>
 <CAPMH7-9zGFSRz3qPJup2y8=zNo6X1dRgNf8gUWv=d+UK1EdO9A@mail.gmail.com>
 <935734452.20069825.1512155793791.JavaMail.zimbra@redhat.com>
 <1512156497.5144.17.camel@tycho.nsa.gov>
 <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
 <CAPMH7-_-GpDCKmiiJx72jsdbkmviNm3o7QMkE6DpxdQxEP-WYA@mail.gmail.com>
 <1512402030.20988.22.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Mon, 4 Dec 2017 21:31:31 +0530
Message-ID: <CAPMH7--RQXXPH4iWzgi6_OnidDSNYFRBT0aDdV6jxLTZBn-AHg@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Simon Sekidde <ssekidde@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113f8cc40325a5055f85d54c"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113f8cc40325a5055f85d54c
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

I got the below logs from the file .Can you please if these logs are fine
or not :

journalctl | grep selinux
Dec 05 02:55:46 localhost.localdomain kernel: EVM: security.selinux
Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
type=USER_START msg=audit(1512402970.129:107): pid=7145 uid=0 auid=0 ses=2
subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 msg='op=PAM:session_open
grantors=pam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_keyinit,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209 addr=10.97.7.209
terminal=ssh res=success'
Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
type=USER_START msg=audit(1512402970.131:108): pid=7568 uid=0 auid=0 ses=3
subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 msg='op=PAM:session_open
grantors=pam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_keyinit,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209 addr=10.97.7.209
terminal=ssh res=success'

Please let me know if any comments are there.

On Mon, Dec 4, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:
> > Hi All,
> >
> > Thanks for the information.
> >
> > But after resetting the semanage User/login, and moving the targeted
> > folder to old one and then install the default target. then also its
> > still showing the
> > Id context as context=system_u:system_r:unconfined_t:s0-s0:c0.c1023.
> >
> > What I observed is after changing the permission using semanage
> > command also, its still showing the system_u:system_r.
> >
> > Check the semanage login/User output :
> >
> > semanage login -l
> >
> > Login Name           SELinux User         MLS/MCS Range
> > Service
> >
> > __default__          unconfined_u         s0-s0:c0.c1023       *
> > root                 unconfined_u         s0-s0:c0.c1023       *
> > system_u             system_u             s0-s0:c0.c1023       *
> >
> >
> > semanage user -l
> >
> >                 Labeling   MLS/       MLS/
> > SELinux User    Prefix     MCS Level  MCS Range
> > SELinux Roles
> >
> > guest_u         user       s0         s0
> >  guest_r
> > root            user       s0         s0-s0:c0.c1023
> >  staff_r sysadm_r system_r unconfined_r
> > staff_u         user       s0         s0-s0:c0.c1023
> >  staff_r sysadm_r system_r unconfined_r
> > sysadm_u        user       s0         s0-s0:c0.c1023
> >  sysadm_r
> > system_u        user       s0         s0-s0:c0.c1023
> >  system_r unconfined_r
> > unconfined_u    user       s0         s0-s0:c0.c1023
> >  system_r unconfined_r
> > user_u          user       s0         s0
> >  user_r
> > xguest_u        user       s0         s0
> >  xguest_r
> >
> >
> > Looks like its related to some other issue. What you think about
> > this.
>
> Do you have any relevant error messages in /var/log/secure or
> journalctl -rb?  Look for anything that refers to selinux or context.
>
> I'm guessing that pam_selinux is unable to determine a valid context
> for your login for some reason, and this is causing it to fall back to
> this one.  Or something like that.
>
> You could try to emulate this process via selinuxdefcon, although I'm
> not sure how closely it matches pam_selinux anymore.  Sample usage:
>
> 1. See what context sshd is running in.
>
> ps -eZ | grep sshd
>
> It should be:
> system_u:system_r:sshd_t:s0-s0:c0.c1023
>
> 2. Run selinuxdefcon to compute the default context for root when
> logging in from sshd:
>
> # Second argument should be whatever was shown by ps -eZ | grep sshd
> above.
> selinuxdefcon root system_u:system_r:sshd_t:s0-s0.c0123
>
> It should be:
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>
>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113f8cc40325a5055f85d54c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>I got the below logs from t=
he file .Can you please if these logs are fine or not :</div><div><br></div=
><div><div>journalctl | grep selinux</div><div>Dec 05 02:55:46 localhost.lo=
caldomain kernel: EVM: security.selinux</div><div>Dec 04 21:26:10 cucm audi=
spd[569]: node=3Dlocalhost.localdomain type=3DUSER_START msg=3Daudit(151240=
2970.129:107): pid=3D7145 uid=3D0 auid=3D0 ses=3D2 subj=3Dsystem_u:system_r=
:sshd_t:s0-s0:c0.c1023 msg=3D&#39;op=3DPAM:session_open grantors=3Dpam_seli=
nux,pam_loginuid,pam_selinux,pam_namespace,pam_keyinit,pam_keyinit,pam_limi=
ts,pam_systemd,pam_unix,pam_lastlog acct=3D&quot;root&quot; exe=3D&quot;/us=
r/sbin/sshd&quot; hostname=3D10.97.7.209 addr=3D10.97.7.209 terminal=3Dssh =
res=3Dsuccess&#39;</div><div>Dec 04 21:26:10 cucm audispd[569]: node=3Dloca=
lhost.localdomain type=3DUSER_START msg=3Daudit(1512402970.131:108): pid=3D=
7568 uid=3D0 auid=3D0 ses=3D3 subj=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c102=
3 msg=3D&#39;op=3DPAM:session_open grantors=3Dpam_selinux,pam_loginuid,pam_=
selinux,pam_namespace,pam_keyinit,pam_keyinit,pam_limits,pam_systemd,pam_un=
ix,pam_lastlog acct=3D&quot;root&quot; exe=3D&quot;/usr/sbin/sshd&quot; hos=
tname=3D10.97.7.209 addr=3D10.97.7.209 terminal=3Dssh res=3Dsuccess&#39;</d=
iv></div><div><br></div><div>Please let me know if any comments are there.<=
/div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon=
, Dec 4, 2017 at 9:10 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"=
mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; Thanks for the information.<br>
&gt;<br>
&gt; But after resetting the semanage User/login, and moving the targeted<b=
r>
&gt; folder to old one and then install the default target. then also its<b=
r>
&gt; still showing the=C2=A0<br>
&gt; Id context as context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c=
1023.<br>
&gt;<br>
&gt; What I observed is after changing the permission using semanage<br>
&gt; command also, its still showing the system_u:system_r.=C2=A0<br>
&gt;<br>
&gt; Check the semanage login/User output :<br>
&gt;<br>
&gt; semanage login -l<br>
&gt;<br>
&gt; Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux User=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; Service<br>
&gt;<br>
&gt; __default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unconfined_u=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0*<br>
&gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unco=
nfined_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*<br>
&gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0*<br>
&gt;<br>
&gt;<br>
&gt; semanage user -l<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Labeling=C2=A0=
 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0<br>
&gt; SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =C2=A0MCS Level=C2=A0 MC=
S Range=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0<br>
&gt; SELinux Roles<br>
&gt;<br>
&gt; guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0guest_r<br>
&gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0staff_r sysadm_r system_r unconfined_r<br>
&gt; staff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0staff_r sysadm_r system_r unconfined_r<br>
&gt; sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0sysadm_r<br>
&gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0system_r unconfined_r<br>
&gt; unconfined_u=C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0system_r unconfined_r<br>
&gt; user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=
=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0user_r<br>
&gt; xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; =C2=A0xguest_r<br>
&gt;<br>
&gt;<br>
&gt; Looks like its related to some other issue. What you think about<br>
&gt; this.<br>
<br>
</div></div>Do you have any relevant error messages in /var/log/secure or<b=
r>
journalctl -rb?=C2=A0 Look for anything that refers to selinux or context.<=
br>
<br>
I&#39;m guessing that pam_selinux is unable to determine a valid context<br=
>
for your login for some reason, and this is causing it to fall back to<br>
this one.=C2=A0 Or something like that.<br>
<br>
You could try to emulate this process via selinuxdefcon, although I&#39;m<b=
r>
not sure how closely it matches pam_selinux anymore.=C2=A0 Sample usage:<br=
>
<br>
1. See what context sshd is running in.<br>
<br>
ps -eZ | grep sshd<br>
<br>
It should be:<br>
<span class=3D"">system_u:system_r:sshd_t:s0-<wbr>s0:c0.c1023<br>
<br>
</span>2. Run selinuxdefcon to compute the default context for root when<br=
>
logging in from sshd:<br>
<br>
# Second argument should be whatever was shown by ps -eZ | grep sshd<br>
above.<br>
selinuxdefcon root system_u:system_r:sshd_t:s0-<wbr>s0.c0123<br>
<br>
It should be:<br>
<div class=3D"HOEnZb"><div class=3D"h5">unconfined_u:unconfined_r:<wbr>unco=
nfined_t:s0-s0:c0.c1023<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113f8cc40325a5055f85d54c--
