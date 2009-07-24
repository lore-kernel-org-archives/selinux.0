Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n6O9klrV028747
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 05:46:47 -0400
Received: from mail-qy0-f202.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n6O9kOgi029080
	for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 09:46:24 GMT
Received: by qyk40 with SMTP id 40so1858356qyk.32
        for <selinux@tycho.nsa.gov>; Fri, 24 Jul 2009 02:46:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com>
References: <97B8FB97-31B2-4D18-A69B-7EBA6C745181@gmail.com>
Date: Fri, 24 Jul 2009 15:46:46 +0600
Message-ID: <7b740b700907240246l28d05097y500a22e478fa018@mail.gmail.com>
Subject: Re: what is an object manager?!
From: Shaz <shazalive@gmail.com>
To: Sebastian Pfaff <sebastian.pfaff@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0016e645b9be91cf2e046f707b82
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e645b9be91cf2e046f707b82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Fri, Jul 24, 2009 at 2:18 PM, Sebastian Pfaff
<sebastian.pfaff@gmail.com>wrote:

> hello,
>
> "Object managers are responsible for enforcing the policy decisions of the
> security server for the set
> of resources they manage. For the kernel, you can think of object managers
> as kernel subsystems that
> create and manage kernel-level objects. Examples of kernel object managers
> include the filesystem,
> process management, and System V interprocess communication (IPC). In the
> LSM architecture, the
> object managers are represented by the LSM hooks (!!!); these hooks are
> scattered throughout the kernel
> subsystems and call the SELinux LSM module for access decisions. The LSM
> hooks then enforce
> those decisions by allowing or denying access to the kernel resource." [1]
>
> this basically says we have dozens of object managers, since every LSM hook
> is one!


I am not sure what you mean here but seems that you are getting things wrong
here. There are many LSM hooks. They are specially used for the kernel while
not sure if user space object managers function to pointers too. The LSM
hooks make the SELinux functionality because the monolithic architecture
forced the flask architecture to get dispersed into the kernel and there are
no clear boundaries for these object manager! Thats why it is stated that
LSM hooks represent the kernel object managers.


>
>
> but here stephen smalley wrote:
>
> An object manager gets access decisions from its AVC, which consults the
> security server when the decision isn't already cached. Meanwhile, if a
> policy change occurs, the security server needs to notify the AVCs of all
> object managers of the change


Now there is one object manager and libselinux exports an interface to the
userspace object managers. Stephen is referening to FLASK/FLUKE a
predecessor of SELinux on micrkernel architecture.


> so that their state can be updated (in simplest form, by flushing the
> caches). There can be any number of object managers. In Linux, the entire
> kernel is really a single object manager, but in earlier microkernel-based
> systems, there were separate object managers for process management,
> filesystems, and networking.
>
> http://marc.info/?l=selinux&m=115955074232032&w=2
>
>
> What is an object manager and who says the truth? ;)


An object manager is the sub-system that manages access control on its own
objects. The kernel will handle access control for its own objects like
files and process.

X server is an object manager for its own resources that it manages and so
is Gconf. Dbus is object manager of its IPC objects. The in kernel security
server is the PDP for all while the PEPs are kernel object managers and the
userspace object manager (some mentioned earlier).

I hope these examples will clear things.


>
>
> "Every LSM hook object manager" vs "1 single Object Manager"
>
> --
> Sebastian Pfaff
>
> [1] SELinux by Example: Using Security Enhanced Linux, 1st Edition.
> (Prentice Hall International, 2006).
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>



-- 
Shaz

--0016e645b9be91cf2e046f707b82
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jul 24, 2009 at 2:18 PM, Sebasti=
an Pfaff <span dir=3D"ltr">&lt;<a href=3D"mailto:sebastian.pfaff@gmail.com"=
>sebastian.pfaff@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
hello,<br>
<br>
&quot;Object managers are responsible for enforcing the policy decisions of=
 the security server for the set<br>
of resources they manage. For the kernel, you can think of object managers =
as kernel subsystems that<br>
create and manage kernel-level objects. Examples of kernel object managers =
include the filesystem,<br>
process management, and System V interprocess communication (IPC). In the L=
SM architecture, the<br>
object managers are represented by the LSM hooks (!!!); these hooks are sca=
ttered throughout the kernel<br>
subsystems and call the SELinux LSM module for access decisions. The LSM ho=
oks then enforce<br>
those decisions by allowing or denying access to the kernel resource.&quot;=
 [1]<br>
<br>
this basically says we have dozens of object managers, since every LSM hook=
 is one!</blockquote><div><br>I am not sure what you mean here but seems th=
at you are getting things wrong here. There are many LSM hooks. They are sp=
ecially used for the kernel while not sure if user space object managers fu=
nction to pointers too. The LSM hooks make the SELinux functionality becaus=
e the monolithic architecture forced the flask architecture to get disperse=
d into the kernel and there are no clear boundaries for these object manage=
r! Thats why it is stated that LSM hooks represent the kernel object manage=
rs.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
but here stephen smalley wrote:<br>
<br>
An object manager gets access decisions from its AVC, which consults the se=
curity server when the decision isn&#39;t already cached. Meanwhile, if a p=
olicy change occurs, the security server needs to notify the AVCs of all ob=
ject managers of the change </blockquote>
<div><br>Now there is one object manager and libselinux exports an interfac=
e to the userspace object managers. Stephen is referening to FLASK/FLUKE a =
predecessor of SELinux on micrkernel architecture.<br>=A0</div><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
so that their state can be updated (in simplest form, by flushing the cache=
s). There can be any number of object managers. In Linux, the entire kernel=
 is really a single object manager, but in earlier microkernel-based system=
s, there were separate object managers for process management, filesystems,=
 and networking.<br>

<br>
<a href=3D"http://marc.info/?l=3Dselinux&amp;m=3D115955074232032&amp;w=3D2"=
 target=3D"_blank">http://marc.info/?l=3Dselinux&amp;m=3D115955074232032&am=
p;w=3D2</a><br>
<br>
<br>
What is an object manager and who says the truth? ;)</blockquote><div><br>A=
n object manager is the sub-system that manages access control on its own o=
bjects. The kernel will handle access control for its own objects like file=
s and process.<br>
<br>X server is an object manager for its own resources that it manages and=
 so is Gconf. Dbus is object manager of its IPC objects. The in kernel secu=
rity server is the PDP for all while the PEPs are kernel object managers an=
d the userspace object manager (some mentioned earlier).<br>
<br>I hope these examples will clear things.<br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<br>
&quot;Every LSM hook object manager&quot; vs &quot;1 single Object Manager&=
quot;<br>
<br>
--<br>
Sebastian Pfaff<br>
<br>
[1] SELinux by Example: Using Security Enhanced Linux, 1st Edition. (Prenti=
ce Hall International, 2006).<br><font color=3D"#888888">
<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov" target=3D"_blank">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Shaz<br><br>

--0016e645b9be91cf2e046f707b82--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
