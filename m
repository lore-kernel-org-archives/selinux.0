Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vAR5uYfx017395
 for <selinux@tycho.nsa.gov>; Mon, 27 Nov 2017 00:56:35 -0500
Received: by mail-it0-f54.google.com with SMTP id x13so19552788iti.4
 for <selinux@tycho.nsa.gov>; Sun, 26 Nov 2017 21:56:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1586230338.18867075.1511630719751.JavaMail.zimbra@redhat.com>
References: <CAPMH7-9gpgonG5tMJ-yp6Ny5pSZfH5ypEFNffcWc_ypRzERDYw@mail.gmail.com>
 <CAPMH7-_i8y2J217Pp86Evgd8rBB6a4zGRah=nB=gcWb0i+a+Rg@mail.gmail.com>
 <CAPMH7-9WAFhKQN2yeG3CNp+jaa4Rvc6ZnGcyu-zt6GWHys=N8w@mail.gmail.com>
 <CACikiw0K0ospvKt-midzSPYQegd3GR46mVjhwiPc3eUULV4oUg@mail.gmail.com>
 <CAPMH7-9UzFWtpCbJwkh5yvaq7G+wPMsB68gzvjpNVgSNn3j76g@mail.gmail.com>
 <1586230338.18867075.1511630719751.JavaMail.zimbra@redhat.com>
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Mon, 27 Nov 2017 11:26:19 +0530
Message-ID: <CAPMH7-9RbDZgnecrAsoSCGAU5Z4r1uBh97J72yFB8jv4+y7O5Q@mail.gmail.com>
To: Simon Sekidde <ssekidde@redhat.com>
Cc: Ravi Kumar <nxp.ravi@gmail.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a11445d06bc59a0055ef08f76"
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11445d06bc59a0055ef08f76
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

After applying the commands which you mentioned previously is working fine
but its still showing the ID command output as same i.e.



**id*> >> *uid=0(root) gid=0(root) groups=0(root)> >>
context=system_u:system_r:unconfined_t:s0-s0:c0.c1023**

Do you know how to reset this System_u to Unconfined_u i.e. to the default
behavior.

Thanks for the help.

Aman

On Sat, Nov 25, 2017 at 10:55 PM, Simon Sekidde <ssekidde@redhat.com> wrote:

>
>
> ----- Original Message -----
> > From: "Aman Sharma" <amansh.sharma5@gmail.com>
> > To: "Ravi Kumar" <nxp.ravi@gmail.com>
> > Cc: "SELinux" <selinux@tycho.nsa.gov>
> > Sent: Friday, November 24, 2017 2:09:05 AM
> > Subject: Re: Qwery regarding Selinux Change Id context
> >
> > Hi Ravi,
> >
> > Thanks for your reply but SSH and Sysadm_login is already enabled.
> >
> > Actually I need to change the root context
> > from*System_u:system_r:unconfined_t
> > to sysadm_u:sysadm_r or **unconfined_u:**unconfined_r**.*
> >
> > *I found one command (**runcon
> > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 /bin/bash**) but
> that
> > command will not work after reboot . Is there any parmanent solution for
> > this.*
> >
>
> It should be unconfined by default if you are running policy in targeted
> mode
>
>  # cat /etc/selinux/targeted/seusers
> root:unconfined_u:s0-s0:c0.c1023
> system_u:system_u:s0-s0:c0.c1023
> __default__:unconfined_u:s0-s0:c0.c1023
>
> try something like `semanage login -m -s unconfined_u root; restorecon -RF
> /root`
>
>
> > On Fri, Nov 24, 2017 at 12:22 PM, Ravi Kumar <nxp.ravi@gmail.com> wrote:
> >
> > > Based on the config  each type of login ( ssh ,shell  ) will have it
> own
> > > role .  if this is just for testing you can try setting the  bool
> value  if
> > > you are logging via ssh.
> > >
> > > setsebool -P ssh_sysadm_login 1
> > >
> > >
> > >
> > > Regards,
> > > Ravi
> > >
> > > On Fri, Nov 24, 2017 at 10:47 AM, Aman Sharma <
> amansh.sharma5@gmail.com>
> > > wrote:
> > >
> > >>
> > >>
> > >> Hi All,
> > >>
> > >> Currently Working on Cent OS 7.3 and login as a root User and my Id
> > >> command output is :
> > >>
> > >> *id*
> > >> *uid=0(root) gid=0(root) groups=0(root)
> > >> context=system_u:system_r:unconfined_t:s0-s0:c0.c1023*
> > >>
> > >> I want to change *System_u:system_r:unconfined_t to sysadm_u:sysadm_r
> > >> or **unconfined_u:**unconfined_r**. *
> > >>
> > >> *Also showing the output of following command :*
> > >>
> > >> *semanage user -l*
> > >>
> > >> *                Labeling   MLS/       MLS/                          *
> > >> *SELinux User    Prefix     MCS Level  MCS Range
> > >> SELinux Roles*
> > >>
> > >> *admin_u         user       s0         s0-s0:c0.c1023
> > >>  sysadm_r system_r*
> > >> *guest_u         user       s0         s0
> > >>  guest_r*
> > >> *root            user       s0         s0-s0:c0.c1023
> > >>  staff_r sysadm_r*
> > >> *specialuser_u   user       s0         s0
> > >>  sysadm_r system_r*
> > >> *staff_u         user       s0         s0-s0:c0.c1023
> > >>  staff_r sysadm_r system_r*
> > >> *sysadm_u        user       s0         s0-s0:c0.c1023
> > >>  sysadm_r*
> > >> *system_u        user       s0         s0-s0:c0.c1023
> > >>  system_r*
> > >> *unconfined_u    user       s0         s0-s0:c0.c1023
> > >>  system_r unconfined_r*
> > >> *user_u          user       s0         s0
> > >>  user_r*
> > >> *xguest_u        user       s0         s0
> > >>  xguest_r*
> > >>
> > >>
> > >> * semanage login -l*
> > >>
> > >> *Login Name           SELinux User         MLS/MCS Range
> Service*
> > >>
> > >> *__default__          sysadm_u             s0-s0:c0.c1023       **
> > >> *ccmservice           specialuser_u        s0                   **
> > >> *cucm                 admin_u              s0-s0:c0.c1023       **
> > >> *drfkeys              specialuser_u        s0                   **
> > >> *drfuser              specialuser_u        s0                   **
> > >> *informix             specialuser_u        s0                   **
> > >> *pwrecovery           specialuser_u        s0                   **
> > >> *root                 sysadm_u             s0-s0:c0.c1023       **
> > >> *sftpuser             specialuser_u        s0                   **
> > >> *system_u             sysadm_u             s0-s0:c0.c1023       **
> > >>
> > >>
> > >> *Can anybody Please help me.*
> > >>
> > >> --
> > >>
> > >> Thanks
> > >> Aman
> > >> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > >>
> > >>
> > >
> >
> >
> > --
> >
> > Thanks
> > Aman
> > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
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

--001a11445d06bc59a0055ef08f76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Simon,<div><br></div><div>After applying the commands w=
hich you mentioned previously is working fine but its still showing the ID =
command output as same i.e.=C2=A0</div><div><b><br></b></div><div><b><span =
style=3D"font-size:12.8px">*id*</span><br style=3D"font-size:12.8px"><span =
style=3D"font-size:12.8px">&gt; &gt;&gt; *uid=3D0(root) gid=3D0(root) group=
s=3D0(root)</span><br style=3D"font-size:12.8px"><span style=3D"font-size:1=
2.8px">&gt; &gt;&gt; context=3Dsystem_u:system_r:</span><wbr style=3D"font-=
size:12.8px"><span style=3D"font-size:12.8px">unconfined_t:s0-s0:c0.c1023*<=
/span></b><br></div><div><b><span style=3D"font-size:12.8px"><br></span></b=
></div><div><span style=3D"font-size:12.8px">Do you know how to reset this =
System_u to Unconfined_u i.e. to the default behavior.=C2=A0</span></div><d=
iv><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"fo=
nt-size:12.8px">Thanks for the help.</span></div><div><span style=3D"font-s=
ize:12.8px"><br></span></div><div><span style=3D"font-size:12.8px">Aman=C2=
=A0</span></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_qu=
ote">On Sat, Nov 25, 2017 at 10:55 PM, Simon Sekidde <span dir=3D"ltr">&lt;=
<a href=3D"mailto:ssekidde@redhat.com" target=3D"_blank">ssekidde@redhat.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">=
<br>
<br>
----- Original Message -----<br>
&gt; From: &quot;Aman Sharma&quot; &lt;<a href=3D"mailto:amansh.sharma5@gma=
il.com">amansh.sharma5@gmail.com</a>&gt;<br>
&gt; To: &quot;Ravi Kumar&quot; &lt;<a href=3D"mailto:nxp.ravi@gmail.com">n=
xp.ravi@gmail.com</a>&gt;<br>
&gt; Cc: &quot;SELinux&quot; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov">s=
elinux@tycho.nsa.gov</a>&gt;<br>
&gt; Sent: Friday, November 24, 2017 2:09:05 AM<br>
&gt; Subject: Re: Qwery regarding Selinux Change Id context<br>
&gt;<br>
&gt; Hi Ravi,<br>
&gt;<br>
&gt; Thanks for your reply but SSH and Sysadm_login is already enabled.<br>
&gt;<br>
&gt; Actually I need to change the root context<br>
</span>&gt; from*System_u:system_r:<wbr>unconfined_t<br>
&gt; to sysadm_u:sysadm_r or **unconfined_u:**unconfined_r*<wbr>*.*<br>
&gt;<br>
&gt; *I found one command (**runcon<br>
&gt; unconfined_u:unconfined_r:<wbr>unconfined_t:s0-s0:c0.c1023 /bin/bash**=
) but that<br>
<span class=3D"">&gt; command will not work after reboot . Is there any par=
manent solution for<br>
</span>&gt; this.*<br>
&gt;<br>
<br>
It should be unconfined by default if you are running policy in targeted mo=
de<br>
<br>
=C2=A0# cat /etc/selinux/targeted/seusers<br>
root:unconfined_u:s0-s0:c0.<wbr>c1023<br>
system_u:system_u:s0-s0:c0.<wbr>c1023<br>
__default__:unconfined_u:s0-<wbr>s0:c0.c1023<br>
<br>
try something like `semanage login -m -s unconfined_u root; restorecon -RF =
/root`<br>
<span class=3D""><br>
<br>
&gt; On Fri, Nov 24, 2017 at 12:22 PM, Ravi Kumar &lt;<a href=3D"mailto:nxp=
.ravi@gmail.com">nxp.ravi@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Based on the config=C2=A0 each type of login ( ssh ,shell=C2=A0 )=
 will have it own<br>
&gt; &gt; role .=C2=A0 if this is just for testing you can try setting the=
=C2=A0 bool value=C2=A0 if<br>
&gt; &gt; you are logging via ssh.<br>
&gt; &gt;<br>
&gt; &gt; setsebool -P ssh_sysadm_login 1<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; Ravi<br>
&gt; &gt;<br>
&gt; &gt; On Fri, Nov 24, 2017 at 10:47 AM, Aman Sharma &lt;<a href=3D"mail=
to:amansh.sharma5@gmail.com">amansh.sharma5@gmail.com</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi All,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Currently Working on Cent OS 7.3 and login as a root User and=
 my Id<br>
&gt; &gt;&gt; command output is :<br>
&gt; &gt;&gt;<br>
</span>&gt; &gt;&gt; *id*<br>
&gt; &gt;&gt; *uid=3D0(root) gid=3D0(root) groups=3D0(root)<br>
&gt; &gt;&gt; context=3Dsystem_u:system_r:<wbr>unconfined_t:s0-s0:c0.c1023*=
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I want to change *System_u:system_r:unconfined_<wbr>t to sysa=
dm_u:sysadm_r<br>
&gt; &gt;&gt; or **unconfined_u:**unconfined_r*<wbr>*. *<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *Also showing the output of following command :*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *semanage user -l*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Labe=
ling=C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *<br>
&gt; &gt;&gt; *SELinux User=C2=A0 =C2=A0 Prefix=C2=A0 =C2=A0 =C2=A0MCS Leve=
l=C2=A0 MCS Range<br>
&gt; &gt;&gt; SELinux Roles*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *admin_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt;&gt;=C2=A0 sysadm_r system_r*<br>
&gt; &gt;&gt; *guest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt;&gt;=C2=A0 guest_r*<br>
&gt; &gt;&gt; *root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=
=A0 =C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt;&gt;=C2=A0 staff_r sysadm_r*<br>
&gt; &gt;&gt; *specialuser_u=C2=A0 =C2=A0user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt;&gt;=C2=A0 sysadm_r system_r*<br>
&gt; &gt;&gt; *staff_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt;&gt;=C2=A0 staff_r sysadm_r system_r*<br>
&gt; &gt;&gt; *sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt;&gt;=C2=A0 sysadm_r*<br>
&gt; &gt;&gt; *system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt;&gt;=C2=A0 system_r*<br>
&gt; &gt;&gt; *unconfined_u=C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0 =C2=A0s0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023<br>
&gt; &gt;&gt;=C2=A0 system_r unconfined_r*<br>
&gt; &gt;&gt; *user_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =
=C2=A0 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt;&gt;=C2=A0 user_r*<br>
&gt; &gt;&gt; *xguest_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 user=C2=A0 =C2=A0 =C2=A0=
 =C2=A0s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0<br>
&gt; &gt;&gt;=C2=A0 xguest_r*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; * semanage login -l*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *Login Name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SELinux U=
ser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MLS/MCS Range=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Service*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *__default__=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysadm_u=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =C2=A0 =C2=
=A0 =C2=A0**<br>
&gt; &gt;&gt; *ccmservice=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specialus=
er_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *cucm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0admin_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s0-s0:c0.c102=
3=C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *drfkeys=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *drfuser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *informix=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *pwrecovery=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0specialus=
er_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *root=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sysadm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c102=
3=C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *sftpuser=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0spec=
ialuser_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 s0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt; *system_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysa=
dm_u=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s0-s0:c0.c1023=C2=A0 =
=C2=A0 =C2=A0 =C2=A0**<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; *Can anybody Please help me.*<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt; &gt;&gt;<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks<br>
&gt; &gt;&gt; Aman<br>
&gt; &gt;&gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:ama=
nsh.sharma5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Thanks<br>
&gt; Aman<br>
&gt; Cell: +91 9990296404 |=C2=A0 Email ID : <a href=3D"mailto:amansh.sharm=
a5@gmail.com">amansh.sharma5@gmail.com</a><br>
&gt;<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Simon Sekidde<br>
gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E<br>
<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><div>Cell: +91 999=
0296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@gmail.com" targ=
et=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div>

--001a11445d06bc59a0055ef08f76--
