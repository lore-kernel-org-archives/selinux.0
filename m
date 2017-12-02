MIME-Version: 1.0
In-Reply-To: <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
References: <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-8Urca69_7SHXjbPP9Re+8SQ9Wykj_+U6yqtSsNXUVQJA@mail.gmail.com>
 <1511976858.10464.20.camel@tycho.nsa.gov>
 <CAPMH7-9GusaaSkfiBcX1+wQM1pdT++jcpz3pku1WQixdWMJ60Q@mail.gmail.com>
 <20171130201920.GA32637@julius.enp8s0.d30>
 <CAPMH7-9zGFSRz3qPJup2y8=zNo6X1dRgNf8gUWv=d+UK1EdO9A@mail.gmail.com>
 <935734452.20069825.1512155793791.JavaMail.zimbra@redhat.com>
 <1512156497.5144.17.camel@tycho.nsa.gov>
 <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Sat, 2 Dec 2017 09:29:22 +0530
Message-ID: <CAPMH7-_-GpDCKmiiJx72jsdbkmviNm3o7QMkE6DpxdQxEP-WYA@mail.gmail.com>
To: Simon Sekidde <ssekidde@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11445d06b81d78055f538243"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11445d06b81d78055f538243
Content-Type: text/plain; charset="UTF-8"

Hi All,

Thanks for the information.

But after resetting the semanage User/login, and moving the targeted folder
to old one and then install the default target. then also its still showing
the
Id context as context=*system_u:system_r:unconfined_t:s0-s0:c0.c1023.*

*What I observed is after changing the permission using semanage command
also, its still showing the system_u:system_r. *

*Check the semanage login/User output :*

*semanage login -l*

*Login Name           SELinux User         MLS/MCS Range        Service*

*__default__          unconfined_u         s0-s0:c0.c1023       **
*root                 unconfined_u         s0-s0:c0.c1023       **
*system_u             system_u             s0-s0:c0.c1023       **


*semanage user -l*

*                Labeling   MLS/       MLS/                          *
*SELinux User    Prefix     MCS Level  MCS Range
SELinux Roles*

*guest_u         user       s0         s0
 guest_r*
*root            user       s0         s0-s0:c0.c1023
 staff_r sysadm_r system_r unconfined_r*
*staff_u         user       s0         s0-s0:c0.c1023
 staff_r sysadm_r system_r unconfined_r*
*sysadm_u        user       s0         s0-s0:c0.c1023
 sysadm_r*
*system_u        user       s0         s0-s0:c0.c1023
 system_r unconfined_r*
*unconfined_u    user       s0         s0-s0:c0.c1023
 system_r unconfined_r*
*user_u          user       s0         s0
 user_r*
*xguest_u        user       s0         s0
 xguest_r*


Looks like its related to some other issue. What you think about this.

Thanks
Aman


On Sat, Dec 2, 2017 at 1:05 AM, Simon Sekidde <ssekidde@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: "Stephen Smalley" <sds@tycho.nsa.gov>
> > To: "Simon Sekidde" <ssekidde@redhat.com>, "Aman Sharma" <
> amansh.sharma5@gmail.com>
> > Cc: "SELinux" <selinux@tycho.nsa.gov>
> > Sent: Friday, December 1, 2017 2:28:17 PM
> > Subject: Re: Qwery regarding Selinux Change Id context
> >
> > On Fri, 2017-12-01 at 14:16 -0500, Simon Sekidde wrote:
> > >
> > > ----- Original Message -----
> > > > From: "Aman Sharma" <amansh.sharma5@gmail.com>
> > > > To: "SELinux" <selinux@tycho.nsa.gov>
> > > > Sent: Thursday, November 30, 2017 11:26:21 PM
> > > > Subject: Re: Fwd: Qwery regarding Selinux Change Id context
> > > >
> > > > Hi ,
> > > >
> > > > mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old
> > > >
> > > > This targeted folder is not there.
> > > >
> > > > After searching I got the below result :
> > > >
> > > > find / -type d -name "*targeted" -print
> > > >
> > > > /usr/share/selinux/targeted
> > > > /etc/selinux/targeted
> > > >
> > > > Pleas let me know your comments.
> > > >
> > >
> > > Run
> > >
> > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > yum reinstall selinux-policy-targeted
> >
> > He already tried that and it allegedly didn't help.  It also seems to
> > leave you without a /etc/selinux/targeted/active/seusers file for some
> > reason, such that semanage login -l shows nothing.  But you can recover
> > by copying /etc/selinux/targeted/seusers to
> > /etc/selinux/targeted/active/seusers.  That's a bug.
> >
>
> Interesting. Thanks for spotting this.
>
> > >
> > > Also what does this output show
> > >
> > > ps -aelfZ | grep -i ssh
> > >
> > > >
> > > > On Fri, Dec 1, 2017 at 1:49 AM, Dominick Grift <dac.override@gmail.
> > > > com>
> > > > wrote:
> > > >
> > > > > On Thu, Nov 30, 2017 at 11:10:43AM +0530, Aman Sharma wrote:
> > > > > > Hi Stephen,
> > > > > >
> > > > > > After reseting Selinux targeted folder also (the steps you
> > > > > > mentioned in
> > > > >
> > > > > the
> > > > > > earlier mail), Still its showing the same Id context i.e.
> > > > > >
> > > > > > *id*
> > > > > > *uid=0(root) gid=0(root) groups=0(root)
> > > > > > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > > > > > *[root@cucm2 ~]# id -Z*
> > > > > > *system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > > > > >
> > > > > > *And semanage login -l is showing blank output. *
> > > > > >
> > > > > > *Do you have any idea about this.*
> > > > > >
> > > > > > *Thanks*
> > > > > > *Aman*
> > > > >
> > > > > Try the same procedure again but this time also do before
> > > > > reinstalling:
> > > > >
> > > > > mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old
> > > > >
> > > > > >
> > > > > >
> > > > > > On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley <sds@tycho.ns
> > > > > > a.gov>
> > > > >
> > > > > wrote:
> > > > > >
> > > > > > > On Wed, 2017-11-29 at 22:01 +0530, Aman Sharma wrote:
> > > > > > > > After resetting boolean also, showing the same id context.
> > > > > > >
> > > > > > > And did you try fully resetting your policy as I suggested:
> > > > > > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > > > > > yum reinstall selinux-policy-targeted
> > > > > > > reboot
> > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > On Wed, Nov 29, 2017 at 9:50 PM, Stephen Smalley <sds@tycho
> > > > > > > > .nsa.gov>
> > > > > > > > wrote:
> > > > > > > > > On Wed, 2017-11-29 at 21:39 +0530, Aman Sharma wrote:
> > > > > > > > > > Hi Stephen,
> > > > > > > > > >
> > > > > > > > > > After enabling the unconfined module and after reboot
> > > > > > > > > > also, Still
> > > > > > > > > > showing the same id context.
> > > > > > > > > >
> > > > > > > > > > Is there any way to make the id context to normal state
> > > > > > > > > > again ?
> > > > > > > > >
> > > > > > > > > Hmmm...try resetting all booleans too?  semanage boolean
> > > > > > > > > -D
> > > > > > > > >
> > > > > > > > > Or you could be drastic and completely reset your policy:
> > > > > > > > > mv /etc/selinux/targeted /etc/selinux/targeted.old
> > > > > > > > > yum reinstall selinux-policy-targeted
> > > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > >
> > > > > > > > --
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > Aman
> > > > > > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > >
> > > > > > Thanks
> > > > > > Aman
> > > > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > > >
> > > > > --
> > > > > Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B
> > > > > 6B02
> > > > > https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7
> > > > > B6B02
> > > > > Dominick Grift
> > > > >
> > > >
> > > >
> > > >
> > > > --
> > > >
> > > > Thanks
> > > > Aman
> > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > >
> > >
> > >
> >
>
> --
> Simon Sekidde
> gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
>
>
>


-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a11445d06b81d78055f538243
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>Thanks for the information.</di=
v><div><br></div><div>But after resetting the semanage User/login, and movi=
ng the targeted folder to old one and then install the default target. then=
 also its still showing the=C2=A0</div><div>Id context as context=3D<b>syst=
em_u:system_r:unconfined_t:s0-s0:c0.c1023.</b></div><div><b><br></b></div><=
div><b>What I observed is after changing the permission using semanage comm=
and also, its still showing the system_u:system_r.=C2=A0</b></div><div><b><=
br></b></div><div><b>Check the semanage login/User output :</b></div><div><=
b><br></b></div><div><div><b>semanage login -l</b></div><div><b><br></b></d=
iv><div><b>Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux User=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
Service</b></div><div><b><br></b></div><div><b>__default__=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 unconfined_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1=
023=C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div><b>root=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unconfined_u=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0*</b></div><div><b>sy=
stem_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_u=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=
=A0*</b></div><div style=3D"font-weight:bold"><br></div></div><div style=3D=
"font-weight:bold"><br></div><div><div><b>semanage user -l</b></div><div><b=
><br></b></div><div><b>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Labeling=C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0</b></div><div><b>SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =
=C2=A0MCS Level=C2=A0 MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SELinux Roles</b></div><div><b><br></b><=
/div><div><b>guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=
=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0guest_r</b></div><div><b>root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u=
ser=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.=
c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0staff_r =
sysadm_r system_r unconfined_r</b></div><div><b>staff_u=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0staff_r sysadm_r system_r unconfined_r</b></div><div><b>sysadm_u=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sysadm_r</b></div><div><b>system_u=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
system_r unconfined_r</b></div><div><b>unconfined_u=C2=A0 =C2=A0 user=C2=A0=
 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0system_r unconfi=
ned_r</b></div><div><b>user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =
=C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0user_r</b></div><div><b>xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 us=
er=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0xguest_r</b></div><div style=3D"font-weight:bold"><=
br></div></div><div style=3D"font-weight:bold"><br></div><div style=3D"font=
-weight:bold">Looks like its related to some other issue. What you think ab=
out this.</div><div style=3D"font-weight:bold"><br></div><div style=3D"font=
-weight:bold">Thanks</div><div style=3D"font-weight:bold">Aman</div><div><b=
r></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Sat, Dec 2, 2017 at 1:05 AM, Simon Sekidde <span dir=3D"ltr">&lt;<a href=3D=
"mailto:ssekidde@redhat.com" target=3D"_blank">ssekidde@redhat.com</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
----- Original Message -----<br>
&gt; From: &quot;Stephen Smalley&quot; &lt;<a href=3D"mailto:sds@tycho.nsa.=
gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; To: &quot;Simon Sekidde&quot; &lt;<a href=3D"mailto:ssekidde@redhat.co=
m">ssekidde@redhat.com</a>&gt;, &quot;Aman Sharma&quot; &lt;<a href=3D"mail=
to:amansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a>&gt;<br>
&gt; Cc: &quot;SELinux&quot; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov">s=
elinux@tycho.nsa.gov</a>&gt;<br>
</span><div><div class=3D"h5">&gt; Sent: Friday, December 1, 2017 2:28:17 P=
M<br>
&gt; Subject: Re: Qwery regarding Selinux Change Id context<br>
&gt;<br>
&gt; On Fri, 2017-12-01 at 14:16 -0500, Simon Sekidde wrote:<br>
&gt; &gt;<br>
&gt; &gt; ----- Original Message -----<br>
&gt; &gt; &gt; From: &quot;Aman Sharma&quot; &lt;<a href=3D"mailto:amansh.s=
harma5@gmail.com">amansh.sharma5@gmail.com</a>&gt;<br>
&gt; &gt; &gt; To: &quot;SELinux&quot; &lt;<a href=3D"mailto:selinux@tycho.=
nsa.gov">selinux@tycho.nsa.gov</a>&gt;<br>
&gt; &gt; &gt; Sent: Thursday, November 30, 2017 11:26:21 PM<br>
&gt; &gt; &gt; Subject: Re: Fwd: Qwery regarding Selinux Change Id context<=
br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi ,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; mv /var/lib/selinux/targeted /var/lib/selinux/targeted.old<b=
r>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; This targeted folder is not there.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; After searching I got the below result :<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; find / -type d -name &quot;*targeted&quot; -print<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; /usr/share/selinux/targeted<br>
&gt; &gt; &gt; /etc/selinux/targeted<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Pleas let me know your comments.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Run<br>
&gt; &gt;<br>
&gt; &gt; mv /etc/selinux/targeted /etc/selinux/targeted.old<br>
&gt; &gt; yum reinstall selinux-policy-targeted<br>
&gt;<br>
&gt; He already tried that and it allegedly didn&#39;t help.=C2=A0 It also =
seems to<br>
&gt; leave you without a /etc/selinux/targeted/active/<wbr>seusers file for=
 some<br>
&gt; reason, such that semanage login -l shows nothing.=C2=A0 But you can r=
ecover<br>
&gt; by copying /etc/selinux/targeted/seusers to<br>
&gt; /etc/selinux/targeted/active/<wbr>seusers.=C2=A0 That&#39;s a bug.<br>
&gt;<br>
<br>
</div></div>Interesting. Thanks for spotting this.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; &gt;<br>
&gt; &gt; Also what does this output show<br>
&gt; &gt;<br>
&gt; &gt; ps -aelfZ | grep -i ssh<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Fri, Dec 1, 2017 at 1:49 AM, Dominick Grift &lt;dac.overr=
ide@gmail.<br>
&gt; &gt; &gt; com&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Thu, Nov 30, 2017 at 11:10:43AM +0530, Aman Sharma w=
rote:<br>
&gt; &gt; &gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; After reseting Selinux targeted folder also (the s=
teps you<br>
&gt; &gt; &gt; &gt; &gt; mentioned in<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; earlier mail), Still its showing the same Id conte=
xt i.e.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; *id*<br>
&gt; &gt; &gt; &gt; &gt; *uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; &gt; &gt; &gt; &gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s=
0:c0.c1023*<br>
&gt; &gt; &gt; &gt; &gt; *[root@cucm2 ~]# id -Z*<br>
&gt; &gt; &gt; &gt; &gt; *system_u:system_r:unconfined_<wbr>t:s0-s0:c0.c102=
3*<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; *And semanage login -l is showing blank output. *<=
br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; *Do you have any idea about this.*<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; *Thanks*<br>
&gt; &gt; &gt; &gt; &gt; *Aman*<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Try the same procedure again but this time also do befo=
re<br>
&gt; &gt; &gt; &gt; reinstalling:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; mv /var/lib/selinux/targeted /var/lib/selinux/targeted.=
old<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On Wed, Nov 29, 2017 at 11:04 PM, Stephen Smalley =
&lt;sds@tycho.ns<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"http://a.gov" rel=3D"noreferrer" target=
=3D"_blank">a.gov</a>&gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Wed, 2017-11-29 at 22:01 +0530, Aman Sharm=
a wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; After resetting boolean also, showing th=
e same id context.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; And did you try fully resetting your policy a=
s I suggested:<br>
&gt; &gt; &gt; &gt; &gt; &gt; mv /etc/selinux/targeted /etc/selinux/targete=
d.old<br>
&gt; &gt; &gt; &gt; &gt; &gt; yum reinstall selinux-policy-targeted<br>
&gt; &gt; &gt; &gt; &gt; &gt; reboot<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Wed, Nov 29, 2017 at 9:50 PM, Stephen=
 Smalley &lt;sds@tycho<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; .<a href=3D"http://nsa.gov" rel=3D"noref=
errer" target=3D"_blank">nsa.gov</a>&gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Wed, 2017-11-29 at 21:39 +0530, =
Aman Sharma wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; After enabling the unconfined =
module and after reboot<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; also, Still<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; showing the same id context.<b=
r>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Is there any way to make the i=
d context to normal state<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; again ?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Hmmm...try resetting all booleans t=
oo?=C2=A0=C2=A0semanage boolean<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; -D<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Or you could be drastic and complet=
ely reset your policy:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; mv /etc/selinux/targeted /etc/selin=
ux/targeted.old<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; yum reinstall selinux-policy-target=
ed<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0=C2=A0Email =
ID : <a href=3D"mailto:amansh.sharma5@gmail.com">amansh.sharma5@gmail.com</=
a><br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0=C2=A0Email ID : <a hr=
ef=3D"mailto:amansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; --<br>
&gt; &gt; &gt; &gt; Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8=C2=A0=C2=
=A002D5 3B6C 5F1D 2C7B<br>
&gt; &gt; &gt; &gt; 6B02<br>
&gt; &gt; &gt; &gt; <a href=3D"https://sks-keyservers.net/pks/lookup?op=3Dg=
et&amp;search=3D0x3B6C5F1D2C7" rel=3D"noreferrer" target=3D"_blank">https:/=
/sks-keyservers.net/<wbr>pks/lookup?op=3Dget&amp;search=3D<wbr>0x3B6C5F1D2C=
7</a><br>
&gt; &gt; &gt; &gt; B6B02<br>
&gt; &gt; &gt; &gt; Dominick Grift<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Aman<br>
&gt; &gt; &gt; Cell: +91 9990296404 |=C2=A0=C2=A0Email ID : <a href=3D"mail=
to:amansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Simon Sekidde<br>
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E<br>
<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a11445d06b81d78055f538243--
