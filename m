MIME-Version: 1.0
In-Reply-To: <1511971345.10464.14.camel@tycho.nsa.gov>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <1511798379.23941.6.camel@tycho.nsa.gov>
 <CAPMH7-_49TWi5C0U7RsW-24ScdwzNoEq-Gkq=TVvRFO6_yrPHQ@mail.gmail.com>
 <1511963505.10464.2.camel@tycho.nsa.gov>
 <CAPMH7-80BqKG1XB1UDXWAJp1cHKYL3ri_0XjVYdppCNdyom9hQ@mail.gmail.com>
 <1511966833.10464.7.camel@tycho.nsa.gov>
 <CAPMH7-9A6VSCemUGxM_HnH5NOnos4OW3W1Z6uFVL1Ry+a=M92Q@mail.gmail.com>
 <1511970015.10464.10.camel@tycho.nsa.gov>
 <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
 <1511971345.10464.14.camel@tycho.nsa.gov>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 21:39:47 +0530
Message-ID: <CAPMH7-9JxKDOO8dMC_wZwRTm+Z8G4gOPvYZxf3obsB1GBGSMhQ@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11445d06582ff4055f215da6"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11445d06582ff4055f215da6
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

After enabling the unconfined module and after reboot also, Still showing
the same id context.

Is there any way to make the id context to normal state again ?


Thanks
Aman

On Wed, Nov 29, 2017 at 9:32 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-11-29 at 21:26 +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > The output of semanage export is :
> >
> > cat localchanges
> > boolean -D
> > login -D
> > interface -D
> > user -D
> > port -D
> > node -D
> > fcontext -D
> > module -D
> > boolean -m -1 domain_kernel_load_modules
> > boolean -m -1 selinuxuser_ping
> > boolean -m -1 ssh_sysadm_login
> > boolean -m -1 tomcat_can_network_non_http_port
> > port -a -t tomcat_shutdown_port_t -p tcp 8005
> > port -a -t ils_port_t -p tcp 8006
> > port -a -t clm_port_t -p tcp 8500
> > port -a -t clm_port_t -p udp 8500
> > port -a -t snmp_port_t -p udp 61441
> > fcontext -a -f a -t tomcat_t '/home/tomcat(/.*)?'
> > fcontext -a -f a -t db_t '/home/informix(/.*)?'
> > fcontext -a -f a -t ipsec_exec_t '/root/.security/ipsec(/.*)?'
> > fcontext -a -f a -t tomcat_exec_t
> > '/root/.security/tomcat/tomcat_diagnostics.sh'
> > module -d unconfined
>
> Hmmm...someone disabled the unconfined module on your system?
> So if you want to go back to using unconfined, you ought to re-enable
> that, ala semodule -e unconfined.  It looks like someone locked down
> that system and was trying to effectively apply a "strict" policy, but
> it was left in a broken state.
>
> >
> >
> > On Wed, Nov 29, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > > On Wed, 2017-11-29 at 20:47 +0530, Aman Sharma wrote:
> > > > Hi Stephen,
> > > >
> > > > I tried all the three command i.e.
> > > > semanage export > localchanges
> > > >
> > > > semanage login -D
> > > > semanage user -D
> > > >
> > > > Then I reboot the system and after reboot , still its showing the
> > > > root User as Same id context i.e.
> > > >
> > > > id
> > > > uid=0(root) gid=0(root) groups=0(root)
> > > > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> > > >
> > > >  id -Z
> > > > system_u:system_r:unconfined_t:s0-s0:c0.c1023
> > >
> > > That's interesting.  So what else does semanage export show now as
> > > local changes?
> > >
> > > > Also check the below output :
> > > > semanage user -l
> > > >
> > > >                 Labeling   MLS/       MLS/
> > >
> > > > SELinux User    Prefix     MCS Level  MCS Range
> > >
> > > > SELinux Roles
> > > >
> > > > guest_u         user       s0         s0
> > >
> > > >  guest_r
> > > > root            user       s0         s0-s0:c0.c1023
> > >
> > > >  staff_r sysadm_r system_r unconfined_r
> > > > staff_u         user       s0         s0-s0:c0.c1023
> > >
> > > >  staff_r sysadm_r system_r unconfined_r
> > > > sysadm_u        user       s0         s0-s0:c0.c1023
> > >
> > > >  sysadm_r
> > > > system_u        user       s0         s0-s0:c0.c1023
> > >
> > > >  system_r unconfined_r
> > > > unconfined_u    user       s0         s0-s0:c0.c1023
> > >
> > > >  system_r unconfined_r
> > > > user_u          user       s0         s0
> > >
> > > >  user_r
> > > > xguest_u        user       s0         s0
> > >
> > > >  xguest_r
> > > > [root@cucm ~]# semanage login -l
> > > >
> > > > Login Name           SELinux User         MLS/MCS Range
> > > > Service
> > > >
> > > > __default__          unconfined_u         s0-s0:c0.c1023       *
> > > > root                 unconfined_u         s0-s0:c0.c1023       *
> > > > system_u             system_u             s0-s0:c0.c1023       *
> > > >
> > > > Please let me know your comments on this.
> > > >
> > > > Thanks
> > > > Aman
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

--001a11445d06582ff4055f215da6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>After enabling the unconfin=
ed module and after reboot also, Still showing the same id context.</div><d=
iv><br></div><div>Is there any way to make the id context to normal state a=
gain ?=C2=A0<br><div><br></div><div><br></div></div><div>Thanks</div><div>A=
man</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Wed, Nov 29, 2017 at 9:32 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Wed, 20=
17-11-29 at 21:26 +0530, Aman Sharma wrote:<br>
&gt; Hi Stephen,<br>
&gt;<br>
</span><div><div class=3D"h5">&gt; The output of semanage export is :<br>
&gt;<br>
&gt; cat localchanges=C2=A0<br>
&gt; boolean -D<br>
&gt; login -D<br>
&gt; interface -D<br>
&gt; user -D<br>
&gt; port -D<br>
&gt; node -D<br>
&gt; fcontext -D<br>
&gt; module -D<br>
&gt; boolean -m -1 domain_kernel_load_modules<br>
&gt; boolean -m -1 selinuxuser_ping<br>
&gt; boolean -m -1 ssh_sysadm_login<br>
&gt; boolean -m -1 tomcat_can_network_non_http_<wbr>port<br>
&gt; port -a -t tomcat_shutdown_port_t -p tcp 8005<br>
&gt; port -a -t ils_port_t -p tcp 8006<br>
&gt; port -a -t clm_port_t -p tcp 8500<br>
&gt; port -a -t clm_port_t -p udp 8500<br>
&gt; port -a -t snmp_port_t -p udp 61441<br>
&gt; fcontext -a -f a -t tomcat_t &#39;/home/tomcat(/.*)?&#39;<br>
&gt; fcontext -a -f a -t db_t &#39;/home/informix(/.*)?&#39;<br>
&gt; fcontext -a -f a -t ipsec_exec_t &#39;/root/.security/ipsec(/.*)?&#39;=
<br>
&gt; fcontext -a -f a -t tomcat_exec_t<br>
&gt; &#39;/root/.security/tomcat/<wbr>tomcat_diagnostics.sh&#39;<br>
&gt; module -d unconfined<br>
<br>
</div></div>Hmmm...someone disabled the unconfined module on your system?<b=
r>
So if you want to go back to using unconfined, you ought to re-enable<br>
that, ala semodule -e unconfined.=C2=A0 It looks like someone locked down<b=
r>
that system and was trying to effectively apply a &quot;strict&quot; policy=
, but<br>
it was left in a broken state.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; On Wed, Nov 29, 2017 at 9:10 PM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; On Wed, 2017-11-29 at 20:47 +0530, Aman Sharma wrote:<br>
&gt; &gt; &gt; Hi Stephen,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I tried all the three command i.e.<br>
&gt; &gt; &gt; semanage export &gt; localchanges<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; semanage login -D<br>
&gt; &gt; &gt; semanage user -D<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Then I reboot the system and after reboot , still its showin=
g the<br>
&gt; &gt; &gt; root User as Same id context i.e.=C2=A0<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; id<br>
&gt; &gt; &gt; uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; &gt; &gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023=
<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0id -Z<br>
&gt; &gt; &gt; system_u:system_r:unconfined_<wbr>t:s0-s0:c0.c1023<br>
&gt; &gt;<br>
&gt; &gt; That&#39;s interesting.=C2=A0 So what else does semanage export s=
how now as<br>
&gt; &gt; local changes?<br>
&gt; &gt;<br>
&gt; &gt; &gt; Also check the below output :<br>
&gt; &gt; &gt; semanage user -l<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Labe=
ling=C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0=C2=A0<br>
&gt; &gt; &gt; SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =C2=A0MCS Leve=
l=C2=A0 MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0<br>
&gt; &gt; =C2=A0 =C2=A0<br>
&gt; &gt; &gt; SELinux Roles<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0guest_r<br>
&gt; &gt; &gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0staff_r sysadm_r system_r unconfined_r<br>
&gt; &gt; &gt; staff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0staff_r sysadm_r system_r unconfined_r<br>
&gt; &gt; &gt; sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0sysadm_r<br>
&gt; &gt; &gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0system_r unconfined_r<br>
&gt; &gt; &gt; unconfined_u=C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0system_r unconfined_r<br>
&gt; &gt; &gt; user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0user_r<br>
&gt; &gt; &gt; xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; =C2=A0<br>
&gt; &gt; &gt; =C2=A0xguest_r<br>
&gt; &gt; &gt; [root@cucm ~]# semanage login -l<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux U=
ser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=
=A0<br>
&gt; &gt; &gt; Service<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; __default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unconfined_u=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=A0 =C2=A0=
*<br>
&gt; &gt; &gt; root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0unconfined_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt; system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syst=
em_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =
=C2=A0 =C2=A0 =C2=A0*<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Please let me know your comments on this.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thanks<br>
&gt; &gt; &gt; Aman<br>
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

--001a11445d06582ff4055f215da6--
