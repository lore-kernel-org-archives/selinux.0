MIME-Version: 1.0
In-Reply-To: <1511970015.10464.10.camel@tycho.nsa.gov>
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
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Wed, 29 Nov 2017 21:26:41 +0530
Message-ID: <CAPMH7--q4AUQcyuEiGi-X1RAqukROFkC-ged4aw5aKj8Wwc=gw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113a9a3e81309a055f212e37"
Subject: Re: Fwd: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113a9a3e81309a055f212e37
Content-Type: text/plain; charset="UTF-8"

Hi Stephen,

The output of semanage export is :

cat localchanges
boolean -D
login -D
interface -D
user -D
port -D
node -D
fcontext -D
module -D
boolean -m -1 domain_kernel_load_modules
boolean -m -1 selinuxuser_ping
boolean -m -1 ssh_sysadm_login
boolean -m -1 tomcat_can_network_non_http_port
port -a -t tomcat_shutdown_port_t -p tcp 8005
port -a -t ils_port_t -p tcp 8006
port -a -t clm_port_t -p tcp 8500
port -a -t clm_port_t -p udp 8500
port -a -t snmp_port_t -p udp 61441
fcontext -a -f a -t tomcat_t '/home/tomcat(/.*)?'
fcontext -a -f a -t db_t '/home/informix(/.*)?'
fcontext -a -f a -t ipsec_exec_t '/root/.security/ipsec(/.*)?'
fcontext -a -f a -t tomcat_exec_t
'/root/.security/tomcat/tomcat_diagnostics.sh'
module -d unconfined


On Wed, Nov 29, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Wed, 2017-11-29 at 20:47 +0530, Aman Sharma wrote:
> > Hi Stephen,
> >
> > I tried all the three command i.e.
> > semanage export > localchanges
> >
> > semanage login -D
> > semanage user -D
> >
> > Then I reboot the system and after reboot , still its showing the
> > root User as Same id context i.e.
> >
> > id
> > uid=0(root) gid=0(root) groups=0(root)
> > context=system_u:system_r:unconfined_t:s0-s0:c0.c1023
> >
> >  id -Z
> > system_u:system_r:unconfined_t:s0-s0:c0.c1023
>
> That's interesting.  So what else does semanage export show now as
> local changes?
>
> > Also check the below output :
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
> > [root@cucm ~]# semanage login -l
> >
> > Login Name           SELinux User         MLS/MCS Range
> > Service
> >
> > __default__          unconfined_u         s0-s0:c0.c1023       *
> > root                 unconfined_u         s0-s0:c0.c1023       *
> > system_u             system_u             s0-s0:c0.c1023       *
> >
> > Please let me know your comments on this.
> >
> > Thanks
> > Aman
>



-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--001a113a9a3e81309a055f212e37
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Stephen,<div><br></div><div>The output of semanage expo=
rt is :</div><div><br></div><div><div>cat localchanges=C2=A0</div><div>bool=
ean -D</div><div>login -D</div><div>interface -D</div><div>user -D</div><di=
v>port -D</div><div>node -D</div><div>fcontext -D</div><div>module -D</div>=
<div>boolean -m -1 domain_kernel_load_modules</div><div>boolean -m -1 selin=
uxuser_ping</div><div>boolean -m -1 ssh_sysadm_login</div><div>boolean -m -=
1 tomcat_can_network_non_http_port</div><div>port -a -t tomcat_shutdown_por=
t_t -p tcp 8005</div><div>port -a -t ils_port_t -p tcp 8006</div><div>port =
-a -t clm_port_t -p tcp 8500</div><div>port -a -t clm_port_t -p udp 8500</d=
iv><div>port -a -t snmp_port_t -p udp 61441</div><div>fcontext -a -f a -t t=
omcat_t &#39;/home/tomcat(/.*)?&#39;</div><div>fcontext -a -f a -t db_t &#3=
9;/home/informix(/.*)?&#39;</div><div>fcontext -a -f a -t ipsec_exec_t &#39=
;/root/.security/ipsec(/.*)?&#39;</div><div>fcontext -a -f a -t tomcat_exec=
_t &#39;/root/.security/tomcat/tomcat_diagnostics.sh&#39;</div><div>module =
-d unconfined</div></div><div><br></div></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">On Wed, Nov 29, 2017 at 9:10 PM, Stephen Small=
ey <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_bl=
ank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><span class=3D"">On Wed, 2017-11-29 at 20:47 +0530, Aman Sharma wrote:<=
br>
&gt; Hi Stephen,<br>
&gt;<br>
</span><span class=3D"">&gt; I tried all the three command i.e.<br>
&gt; semanage export &gt; localchanges<br>
&gt;<br>
&gt; semanage login -D<br>
&gt; semanage user -D<br>
&gt;<br>
&gt; Then I reboot the system and after reboot , still its showing the<br>
&gt; root User as Same id context i.e.=C2=A0<br>
&gt;<br>
&gt; id<br>
&gt; uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023<br>
&gt;<br>
&gt; =C2=A0id -Z<br>
&gt; system_u:system_r:unconfined_<wbr>t:s0-s0:c0.c1023<br>
<br>
</span>That&#39;s interesting.=C2=A0 So what else does semanage export show=
 now as<br>
local changes?<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Also check the below output :<br>
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
&gt; [root@cucm ~]# semanage login -l<br>
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
&gt; Please let me know your comments on this.<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 9990=
296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targe=
t=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a113a9a3e81309a055f212e37--
