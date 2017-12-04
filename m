MIME-Version: 1.0
In-Reply-To: <CAPMH7--RQXXPH4iWzgi6_OnidDSNYFRBT0aDdV6jxLTZBn-AHg@mail.gmail.com>
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
 <CAPMH7--RQXXPH4iWzgi6_OnidDSNYFRBT0aDdV6jxLTZBn-AHg@mail.gmail.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Mon, 4 Dec 2017 21:36:45 +0530
Message-ID: <CAPMH7-8NDUsrMWUTEnuLpiNu_SjVZgAPXu_mio-WBX9UkuS0tQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Simon Sekidde <ssekidde@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113dbf6abe3b26055f85e794"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113dbf6abe3b26055f85e794
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

Below is my login pam file :

#%PAM-1.0
auth [user_unknown=ignore success=ok ignore=ignore default=bad]
pam_securetty.so
auth       substack     system-auth
auth       include      postlogin
account    required     pam_nologin.so
account    include      system-auth
password   include      system-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
session    optional     pam_console.so
# pam_selinux.so restore should only be followed by sessions to be executed
in the user context
session    required     pam_selinux.so restore
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    include      system-auth
session    include      postlogin
-session   optional     pam_ck_connector.so


Can you Please check if this is fine.



On Mon, Dec 4, 2017 at 9:31 PM, Aman Sharma <amansh.sharma5@gmail.com>
wrote:

> Hi Stephen,
>
> I got the below logs from the file .Can you please if these logs are fine
> or not :
>
> journalctl | grep selinux
> Dec 05 02:55:46 localhost.localdomain kernel: EVM: security.selinux
> Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
> type=USER_START msg=audit(1512402970.129:107): pid=7145 uid=0 auid=0 ses=2
> subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 msg='op=PAM:session_open
> grantors=pam_selinux,pam_loginuid,pam_selinux,pam_
> namespace,pam_keyinit,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209 addr=10.97.7.209
> terminal=ssh res=success'
> Dec 04 21:26:10 cucm audispd[569]: node=localhost.localdomain
> type=USER_START msg=audit(1512402970.131:108): pid=7568 uid=0 auid=0 ses=3
> subj=system_u:system_r:sshd_t:s0-s0:c0.c1023 msg='op=PAM:session_open
> grantors=pam_selinux,pam_loginuid,pam_selinux,pam_
> namespace,pam_keyinit,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> acct="root" exe="/usr/sbin/sshd" hostname=10.97.7.209 addr=10.97.7.209
> terminal=ssh res=success'
>
> Please let me know if any comments are there.
>
> On Mon, Dec 4, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
>> On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:
>> > Hi All,
>> >
>> > Thanks for the information.
>> >
>> > But after resetting the semanage User/login, and moving the targeted
>> > folder to old one and then install the default target. then also its
>> > still showing the
>> > Id context as context=system_u:system_r:unconfined_t:s0-s0:c0.c1023.
>> >
>> > What I observed is after changing the permission using semanage
>> > command also, its still showing the system_u:system_r.
>> >
>> > Check the semanage login/User output :
>> >
>> > semanage login -l
>> >
>> > Login Name           SELinux User         MLS/MCS Range
>> > Service
>> >
>> > __default__          unconfined_u         s0-s0:c0.c1023       *
>> > root                 unconfined_u         s0-s0:c0.c1023       *
>> > system_u             system_u             s0-s0:c0.c1023       *
>> >
>> >
>> > semanage user -l
>> >
>> >                 Labeling   MLS/       MLS/
>> > SELinux User    Prefix     MCS Level  MCS Range
>> > SELinux Roles
>> >
>> > guest_u         user       s0         s0
>> >  guest_r
>> > root            user       s0         s0-s0:c0.c1023
>> >  staff_r sysadm_r system_r unconfined_r
>> > staff_u         user       s0         s0-s0:c0.c1023
>> >  staff_r sysadm_r system_r unconfined_r
>> > sysadm_u        user       s0         s0-s0:c0.c1023
>> >  sysadm_r
>> > system_u        user       s0         s0-s0:c0.c1023
>> >  system_r unconfined_r
>> > unconfined_u    user       s0         s0-s0:c0.c1023
>> >  system_r unconfined_r
>> > user_u          user       s0         s0
>> >  user_r
>> > xguest_u        user       s0         s0
>> >  xguest_r
>> >
>> >
>> > Looks like its related to some other issue. What you think about
>> > this.
>>
>> Do you have any relevant error messages in /var/log/secure or
>> journalctl -rb?  Look for anything that refers to selinux or context.
>>
>> I'm guessing that pam_selinux is unable to determine a valid context
>> for your login for some reason, and this is causing it to fall back to
>> this one.  Or something like that.
>>
>> You could try to emulate this process via selinuxdefcon, although I'm
>> not sure how closely it matches pam_selinux anymore.  Sample usage:
>>
>> 1. See what context sshd is running in.
>>
>> ps -eZ | grep sshd
>>
>> It should be:
>> system_u:system_r:sshd_t:s0-s0:c0.c1023
>>
>> 2. Run selinuxdefcon to compute the default context for root when
>> logging in from sshd:
>>
>> # Second argument should be whatever was shown by ps -eZ | grep sshd
>> above.
>> selinuxdefcon root system_u:system_r:sshd_t:s0-s0.c0123
>>
>> It should be:
>> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>>
>>
>>
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

--001a113dbf6abe3b26055f85e794
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>Below is my login pam file =
:</div><div><br></div><div><div>#%PAM-1.0</div><div>auth [user_unknown=3Dig=
nore success=3Dok ignore=3Dignore default=3Dbad] pam_securetty.so</div><div=
>auth=C2=A0 =C2=A0 =C2=A0 =C2=A0substack=C2=A0 =C2=A0 =C2=A0system-auth</di=
v><div>auth=C2=A0 =C2=A0 =C2=A0 =C2=A0include=C2=A0 =C2=A0 =C2=A0 postlogin=
</div><div>account=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_nologin.so<=
/div><div>account=C2=A0 =C2=A0 include=C2=A0 =C2=A0 =C2=A0 system-auth</div=
><div>password=C2=A0 =C2=A0include=C2=A0 =C2=A0 =C2=A0 system-auth</div><di=
v># pam_selinux.so close should be the first session rule</div><div>session=
=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_selinux.so close</div><div>se=
ssion=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=A0pam_loginuid.so</div><div>se=
ssion=C2=A0 =C2=A0 optional=C2=A0 =C2=A0 =C2=A0pam_console.so</div><div># p=
am_selinux.so restore should only be followed by sessions to be executed in=
 the user context</div><div>session=C2=A0 =C2=A0 required=C2=A0 =C2=A0 =C2=
=A0pam_selinux.so restore</div><div>session=C2=A0 =C2=A0 required=C2=A0 =C2=
=A0 =C2=A0pam_namespace.so</div><div>session=C2=A0 =C2=A0 optional=C2=A0 =
=C2=A0 =C2=A0pam_keyinit.so force revoke</div><div>session=C2=A0 =C2=A0 inc=
lude=C2=A0 =C2=A0 =C2=A0 system-auth</div><div>session=C2=A0 =C2=A0 include=
=C2=A0 =C2=A0 =C2=A0 postlogin</div><div>-session=C2=A0 =C2=A0optional=C2=
=A0 =C2=A0 =C2=A0pam_ck_connector.so</div></div><div><br></div><div><br></d=
iv><div>Can you Please check if this is fine.</div><div><br></div><div><br>=
</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mo=
n, Dec 4, 2017 at 9:31 PM, Aman Sharma <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:amansh.sharma5@gmail.com" target=3D"_blank">amansh.sharma5@gmail.com</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi S=
tephen,<div><br></div><div>I got the below logs from the file .Can you plea=
se if these logs are fine or not :</div><div><br></div><div><div>journalctl=
 | grep selinux</div><div>Dec 05 02:55:46 localhost.localdomain kernel: EVM=
: security.selinux</div><div>Dec 04 21:26:10 cucm audispd[569]: node=3Dloca=
lhost.localdomain type=3DUSER_START msg=3Daudit(1512402970.129:107): pid=3D=
7145 uid=3D0 auid=3D0 ses=3D2 subj=3Dsystem_u:system_r:sshd_t:<wbr>s0-s0:c0=
.c1023 msg=3D&#39;op=3DPAM:session_open grantors=3Dpam_selinux,pam_<wbr>log=
inuid,pam_selinux,pam_<wbr>namespace,pam_keyinit,pam_<wbr>keyinit,pam_limit=
s,pam_<wbr>systemd,pam_unix,pam_lastlog acct=3D&quot;root&quot; exe=3D&quot=
;/usr/sbin/sshd&quot; hostname=3D10.97.7.209 addr=3D10.97.7.209 terminal=3D=
ssh res=3Dsuccess&#39;</div><div>Dec 04 21:26:10 cucm audispd[569]: node=3D=
localhost.localdomain type=3DUSER_START msg=3Daudit(1512402970.131:108): pi=
d=3D7568 uid=3D0 auid=3D0 ses=3D3 subj=3Dsystem_u:system_r:sshd_t:<wbr>s0-s=
0:c0.c1023 msg=3D&#39;op=3DPAM:session_open grantors=3Dpam_selinux,pam_<wbr=
>loginuid,pam_selinux,pam_<wbr>namespace,pam_keyinit,pam_<wbr>keyinit,pam_l=
imits,pam_<wbr>systemd,pam_unix,pam_lastlog acct=3D&quot;root&quot; exe=3D&=
quot;/usr/sbin/sshd&quot; hostname=3D10.97.7.209 addr=3D10.97.7.209 termina=
l=3Dssh res=3Dsuccess&#39;</div></div><span class=3D""><div><br></div><div>=
Please let me know if any comments are there.</div></span></div><div class=
=3D"gmail_extra"><div><div class=3D"h5"><br><div class=3D"gmail_quote">On M=
on, Dec 4, 2017 at 9:10 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=
=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"m_612526540047=
4628674HOEnZb"><div class=3D"m_6125265400474628674h5">On Sat, 2017-12-02 at=
 09:29 +0530, Aman Sharma wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; Thanks for the information.<br>
&gt;<br>
&gt; But after resetting the semanage User/login, and moving the targeted<b=
r>
&gt; folder to old one and then install the default target. then also its<b=
r>
&gt; still showing the=C2=A0<br>
&gt; Id context as context=3Dsystem_u:system_r:unco<wbr>nfined_t:s0-s0:c0.c=
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
<span>system_u:system_r:sshd_t:s0-s0<wbr>:c0.c1023<br>
<br>
</span>2. Run selinuxdefcon to compute the default context for root when<br=
>
logging in from sshd:<br>
<br>
# Second argument should be whatever was shown by ps -eZ | grep sshd<br>
above.<br>
selinuxdefcon root system_u:system_r:sshd_t:s0-s0<wbr>.c0123<br>
<br>
It should be:<br>
<div class=3D"m_6125265400474628674HOEnZb"><div class=3D"m_6125265400474628=
674h5">unconfined_u:unconfined_r:unco<wbr>nfined_t:s0-s0:c0.c1023<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div></div><=
/div><span class=3D"">-- <br><div class=3D"m_6125265400474628674gmail_signa=
ture" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><br></div><d=
iv>Thanks</div><div>Aman</div><div>Cell: +91 9990296404 | =C2=A0Email ID : =
<a href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_blank">amansh.sharma=
5@gmail.com</a></div></div></div>
</span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990296404 | =
=C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" target=3D"_bla=
nk">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113dbf6abe3b26055f85e794--
