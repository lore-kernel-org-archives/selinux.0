MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C86DCB.43783BC0"
Subject: RE: Accurately setting Security Context of a  user when ssh-ing in
Date: Tue, 12 Feb 2008 18:01:55 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D045B7B01@de01exm68.ds.mot.com>
In-Reply-To: <1202842666.24250.112.camel@moss-spartans.epoch.ncsc.mil>
References: <4784EFE8.9050106@redhat.com> <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com> <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil> <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon> <47877F43.5030401@redhat.com> <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil> <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil> <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com> <D06FE0A2807BC145B0D38744789D4F5D0451FF16@de01exm68.ds.mot.com> <1201739450.24702.488.camel@moss-terrapins.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D04568692@de01exm68.ds.mot.com> <1202216499.27371.2.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D045B6D09@de01exm68.ds.mot.com> <1202393788.27371.225.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D045B7963@de01exm68.ds.mot.com> <1202842666.24250.112.camel@moss-spartans.epoch.ncsc.mil>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Dave Quigley" <dpquigl@tycho.nsa.gov>, "selinux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C86DCB.43783BC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Here are the outputs of the commands you asked for...

Before restarting sshd, while the problem is exhibited:
------------------------------------------------------------------------
------

root@hapWibbSc2:/> cat /selinux/booleans/ssh_sysadm_login=20
0 0

root@hapWibbSc2:/> grep ssh
/etc/selinux/strict/contexts/default_contexts=20
system_r:sshd_t:s0              user_r:user_t:s0 staff_r:staff_t:s0
sysadm_r:sysadm_t:s0


root@hapWibbSc2:/> ps -eZ | grep sshd
system_u:system_r:kernel_t:s0    1095 ?        00:00:00 sshd=20



And after restarting sshd from the console, where I am
root:sysadm_r:sysadm_t:s0
------------------------------------------------------------------------
--------------------------------------------------

root@hapWibbSc2:/> cat /selinux/booleans/ssh_sysadm_login=20
0 0

root@hapWibbSc2:/> grep ssh
/etc/selinux/strict/contexts/default_contexts=20
system_r:sshd_t:s0              user_r:user_t:s0 staff_r:staff_t:s0
sysadm_r:sysadm_t:s0

root@hapWibbSc2:/> ps -eZ | grep sshd
root:system_r:sshd_t:s0          4819 ?        00:00:00 sshd


Just in case, under the  /etc/selinux/strict/contexts/users/ directory,
I only have one file called "root", and that contains:
------------------------------------------------------------------------
------------------------------------------------------------------------
---------------------------
system_r:local_login_t:s0  sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
user_r:user_t:s0
system_r:crond_t:s0     sysadm_r:sysadm_crond_t:s0
staff_r:staff_crond_t:s0 user_r:user_crond_t:s0
staff_r:staff_su_t:s0   sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
user_r:user_t:s0
sysadm_r:sysadm_su_t:s0 sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
user_r:user_t:s0
user_r:user_su_t:s0     sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
user_r:user_t:s0
#
# Uncomment if you want to automatically login as sysadm_r
#
#system_r:sshd_t:s0 sysadm_r:sysadm_t:s0 staff_r:staff_t:s0
user_r:user_t:s0


*** So given this info, we can see that in the problematic case, context
of sshd is   system_u:system_r:kernel_t:s0,  but restarting sshd on the
console, we get  root:system_r:sshd_t:s0. And after this, everything
works nicely...

So how can I programmatically (e.g. through a script) get sshd to start
in the right context, or force sshd to change context to sshd_t ?

Thanks again for all your help as always  :-)

- Reza.


-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
Sent: Tuesday, February 12, 2008 12:58 PM
To: Hasan Rezaul-CHR010
Cc: Dave Quigley
Subject: RE: Accurately setting Security Context of a user when ssh-ing
in


On Tue, 2008-02-12 at 12:53 -0500, Hasan Rezaul-CHR010 wrote:
> Here is the full story... Apologize for dragging this on...

any reason you didn't cc the list?

> I have SELinux running on a Linux Card.
> The Card is partitioned into 2 halves! One half (the active side)
> running software and a set of SELinux policies already.=20
> And another half, the inactive side, which is usually empty.
>=20
> I have a software upgrade procedure, where software is first
downloaded
> and populated on the 2nd half (/inactive/ side), and then the card is
> rebooted to come up on the newly populated side. This way software
> upgrade is done with minimal downtime.
>=20
> As part of the software_upgrade procedure, I place new software, and a
> collection of SELinux policies on the inactive side.
>    So basically I populate everything under the
> /inactive/etc/selinux/*** =20
>    as well as create and mount the selinuxfs  at  /inactive/selinux
>=20
> After the /inactive  side is appropriately populated with new software
> and new policies, 'sidesel' is modified,
> and the Linux card is REBOOTED !
>=20
> The card then starts coming up on the new side, kernel recognizes new
> SELinux policies, and loads the new policy !
> By the way, I removed the /.autorelabel  file, because I didn't want
> kernel to reboot the Card again !?!
>=20
> So I have an init script that runs during bootup, and the script does
> "restorecon -rF /"
>=20
> So after this point, when the Card is fully up, the card is running
with
> new SELinux policies, and filesystem labeled appropriately!
>=20
> My login mappings at this time are defined as follows:
>=20
> root@hapWibbSc2:/etc> semanage login -l
>=20
> Login Name                SELinux User              MLS/MCS Range
>=20
>=20
> __default__               user_u                    s0
>=20
> Admin                     staff_u                   s0
>=20
> root                      root                      s0-s0:c0.c1023
>=20
> system_u                  system_u                  s0-s0:c0.c1023

>=20
>=20
> At this time:=20
>=20
> 1. If I login as root on the console, I expect, and I do get,
> root:sysadm_r:sysadm_t:s0
> 2. If I ssh in as Admin, I expect to get   staff_u:staff_r:staff_t,
but
> instead, I get  staff_u:sysadm_r:sysadm_t  !!

What do the following commands show?
# getsebool ssh_sysadm_login
# grep ssh /etc/selinux/$SELINUXTYPE/contexts/default_contexts

> 3. Also If I ssh in as a regular user, like Reza, I should get
> user_u:user_r:user_t,  but I get   system_u:system_r:system_t  !!

Strange.=20

> As you suggested in your previous mail(s), perhaps the sshd process
> wasn't started under the right contexts ???

Yep, what does ps -eZ | grep sshd show?

> So, here is the interesting part:
>=20
> - While I am logged in as root on the console, and my context is
> root:sysadm_r:sysadm_t,  if I type  /sbin/service sshd restart,
>   and then try to ssh in as Admin or Reza, after that, I do get the
> correct contexts, and everything is golden :-)=20

And what does ps -eZ | grep sshd show now?

> - OR another thing that works is: while I am logged in as root on the
> console (as sysadm), I execute a script that has 'service sshd
restart'
> in it. This also fixes the problem
>=20
> BUT, I need to find an automatic/programmatic way to do this, because
> the software_upgrade procedure must be automatic ! It cant involve
> someone manually logging in to do something on the console.
>=20
> - So in my init script that runs during bootup, where I relabel the
> filesystem, after relabelling, I put  /sbin/service sshd restart
>   but after that script ran, I still have this problem  :-(   That's
> probably because the init script is being run as "system" during
bootup,
> whereas when I manually typed on the console, I am "sysadm".
>=20
> - I tried many different things, e.g. ssh-ing in as Admin or Reza,
then
> su - root, and then restarting sshd, but nothing works !!!
>   The only thing that resolves this problem, is executing  "service
sshd
> restart" at the console, where my context is root:sysadm_r:sysadm_t.
>=20
> - Of course, the other thing that works, is rebooting the Card a
second
> time, which I cant afford, due to availability requirements.
>=20
>=20
> Do you have any suggestions of how I can restart the sshd process
> programmatically (e.g. through my init script), to achieve the same
> results as running the 'service sshd restart' manually on the console
?
> Is there a way my init script could temporarily assume sysadm, or a
way
> that my init script can be run as sysadm during bootup ?

Well, you can always force it into a certain context via runcon (if
permitted by your policy).  But I'd rather fix the real problem, and
that requires knowing what context sshd is running in initially and then
what context is it running in after the restart from the console.

> Thanks again for all your help...

--=20
Stephen Smalley
National Security Agency


------_=_NextPart_001_01C86DCB.43783BC0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: Accurately setting Security Context of a  user when ssh-ing =
in</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/rtf format -->

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Hi =
Stephen,</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Here are the =
outputs of the commands you asked for...</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Before restarting =
sshd, while the problem is exhibited:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">--------------------------------------------------------</=
FONT><FONT SIZE=3D2 FACE=3D"Arial">----------------------</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc2:/&gt; cat =
/selinux/booleans/ssh_sysadm_login </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">0 0</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc2:/&gt; grep ssh =
/etc/selinux/strict/contexts/default_contexts </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">system_r:sshd_t:s0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_r:user_t:s0 =
staff_r:staff_t:s0 sysadm_r:sysadm_t:s0</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc2:/&gt; ps -eZ | grep sshd</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 =
FACE=3D"Arial">system_u:system_r:kernel_t</FONT></B><FONT SIZE=3D2 =
FACE=3D"Arial">:s0&nbsp;&nbsp;&nbsp; 1095 =
?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 sshd </FONT></SPAN>
</P>
<BR>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">And after =
restarting sshd from the console, where I am&nbsp; =
root:sysadm_r:sysadm_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">----------------------------------------------------------=
-------------------------</FONT><FONT SIZE=3D2 =
FACE=3D"Arial">---------------------------------------</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc2:/&gt; cat =
/selinux/booleans/ssh_sysadm_login </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">0 0</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc2:/&gt; grep ssh =
/etc/selinux/strict/contexts/default_contexts </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">system_r:sshd_t:s0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; user_r:user_t:s0 =
staff_r:staff_t:s0 sysadm_r:sysadm_t:s0</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">root@hapWibbSc2:/&gt; ps -eZ | grep sshd</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><B><FONT SIZE=3D2 =
FACE=3D"Arial">root:system_r:sshd_t</FONT></B><FONT SIZE=3D2 =
FACE=3D"Arial">:s0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
4819 ?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 00:00:00 =
sshd</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Just in case, =
under the&nbsp; /etc/selinux/strict/contexts/users/ directory, I only =
have one file called &quot;root&quot;, and that =
contains:</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">----------------------------------------------------------=
-------------------------------------------------------------------------=
----------------------------------------</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">system_r:local_login_t:s0&nbsp; sysadm_r:sysadm_t:s0 =
staff_r:staff_t:s0 user_r:user_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">system_r:crond_t:s0&nbsp;&nbsp;&nbsp;&nbsp; =
sysadm_r:sysadm_crond_t:s0 staff_r:staff_crond_t:s0 =
user_r:user_crond_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">staff_r:staff_su_t:s0&nbsp;&nbsp; sysadm_r:sysadm_t:s0 =
staff_r:staff_t:s0 user_r:user_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">sysadm_r:sysadm_su_t:s0 sysadm_r:sysadm_t:s0 =
staff_r:staff_t:s0 user_r:user_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">user_r:user_su_t:s0&nbsp;&nbsp;&nbsp;&nbsp; =
sysadm_r:sysadm_t:s0 staff_r:staff_t:s0 user_r:user_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># Uncomment if =
you want to automatically login as sysadm_r</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">#</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">#system_r:sshd_t:s0 sysadm_r:sysadm_t:s0 =
staff_r:staff_t:s0 user_r:user_t:s0</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">*** So given this =
info, we can see that in the problematic case, context of sshd =
is&nbsp;&nbsp; system_u:system_r:</FONT><B><FONT SIZE=3D2 =
FACE=3D"Arial">kernel_t</FONT></B><FONT SIZE=3D2 =
FACE=3D"Arial">:s0,&nbsp; but restarting sshd</FONT><FONT SIZE=3D2 =
FACE=3D"Arial"> on the console</FONT><FONT SIZE=3D2 FACE=3D"Arial">, we =
get&nbsp; root:system_r:</FONT><B><FONT SIZE=3D2 =
FACE=3D"Arial">sshd_t</FONT></B><FONT SIZE=3D2 =
FACE=3D"Arial">:s0.</FONT><FONT SIZE=3D2 FACE=3D"Arial"> And after this, =
everything works nicely...</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">So how can I =
programmatically (e.g. through a script) get sshd to start in the right =
context</FONT><FONT SIZE=3D2 FACE=3D"Arial">, or force sshd to change =
context to sshd_t</FONT><FONT SIZE=3D2 FACE=3D"Arial"> =
?</FONT></SPAN></P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Thanks again for =
all your help as always&nbsp; :-)</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">- =
Reza.</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">-----Original =
Message-----</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">From: Stephen =
Smalley [</FONT></SPAN><A HREF=3D"mailto:sds@tycho.nsa.gov"><SPAN =
LANG=3D"en-us"><U><FONT COLOR=3D"#0000FF" SIZE=3D2 =
FACE=3D"Arial">mailto:sds@tycho.nsa.gov</FONT></U></SPAN></A><SPAN =
LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">] </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Sent: Tuesday, =
February 12, 2008 12:58 PM</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">To: Hasan =
Rezaul-CHR010</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Cc: Dave =
Quigley</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Subject: RE: =
Accurately setting Security Context of a user when ssh-ing =
in</FONT></SPAN>
</P>
<BR>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">On Tue, 2008-02-12 =
at 12:53 -0500, Hasan Rezaul-CHR010 wrote:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Here is the =
full story... Apologize for dragging this on...</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">any reason you =
didn't cc the list?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; I have =
SELinux running on a Linux Card.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; The Card is =
partitioned into 2 halves! One half (the active side)</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; running =
software and a set of SELinux policies already. </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; And another =
half, the inactive side, which is usually empty.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; I have a =
software upgrade procedure, where software is first =
downloaded</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; and =
populated on the 2nd half (/inactive/ side), and then the card =
is</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; rebooted to =
come up on the newly populated side. This way software</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; upgrade is =
done with minimal downtime.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; As part of =
the software_upgrade procedure, I place new software, and =
a</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; collection =
of SELinux policies on the inactive side.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&gt;&nbsp;&nbsp;&nbsp; So basically I populate everything =
under the</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
/inactive/etc/selinux/***&nbsp; </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 =
FACE=3D"Arial">&gt;&nbsp;&nbsp;&nbsp; as well as create and mount the =
selinuxfs&nbsp; at&nbsp; /inactive/selinux</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; After the =
/inactive&nbsp; side is appropriately populated with new =
software</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; and new =
policies, 'sidesel' is modified,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; and the =
Linux card is REBOOTED !</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; The card =
then starts coming up on the new side, kernel recognizes =
new</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; SELinux =
policies, and loads the new policy !</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; By the way, =
I removed the /.autorelabel&nbsp; file, because I didn't =
want</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; kernel to =
reboot the Card again !?!</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; So I have an =
init script that runs during bootup, and the script does</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
&quot;restorecon -rF /&quot;</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; So after =
this point, when the Card is fully up, the card is running =
with</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; new SELinux =
policies, and filesystem labeled appropriately!</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; My login =
mappings at this time are defined as follows:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
root@hapWibbSc2:/etc&gt; semanage login -l</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Login =
Name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SELinux =
User&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; MLS/MCS Range</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
__default__&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; =
user_u&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
Admin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
staff_u&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
root&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
s0-s0:c0.c1023</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
system_u&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
system_u&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
s0-s0:c0.c1023&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; At this =
time: </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; 1. If I =
login as root on the console, I expect, and I do get,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
root:sysadm_r:sysadm_t:s0</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; 2. If I ssh =
in as Admin, I expect to get&nbsp;&nbsp; staff_u:staff_r:staff_t,&nbsp; =
but</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; instead, I =
get&nbsp; staff_u:sysadm_r:sysadm_t&nbsp; !!</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">What do the =
following commands show?</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># getsebool =
ssh_sysadm_login</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial"># grep ssh =
/etc/selinux/$SELINUXTYPE/contexts/default_contexts</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; 3. Also If I =
ssh in as a regular user, like Reza, I should get</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
user_u:user_r:user_t,&nbsp; but I get&nbsp;&nbsp; =
system_u:system_r:system_t&nbsp; !!</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Strange. =
</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; As you =
suggested in your previous mail(s), perhaps the sshd =
process</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; wasn't =
started under the right contexts ???</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Yep, what does ps =
-eZ | grep sshd show?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; So, here is =
the interesting part:</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; - While I am =
logged in as root on the console, and my context is</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
root:sysadm_r:sysadm_t,&nbsp; if I type&nbsp; /sbin/service sshd =
restart,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt;&nbsp;&nbsp; =
and then try to ssh in as Admin or Reza, after that, I do get =
the</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; correct =
contexts, and everything is golden :-) </FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">And what does ps =
-eZ | grep sshd show now?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; - OR another =
thing that works is: while I am logged in as root on the</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; console (as =
sysadm), I execute a script that has 'service sshd =
restart'</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; in it. This =
also fixes the problem</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; BUT, I need =
to find an automatic/programmatic way to do this, because</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; the =
software_upgrade procedure must be automatic ! It cant =
involve</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; someone =
manually logging in to do something on the console.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; - So in my =
init script that runs during bootup, where I relabel the</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; filesystem, =
after relabelling, I put&nbsp; /sbin/service sshd restart</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt;&nbsp;&nbsp; =
but after that script ran, I still have this problem&nbsp; =
:-(&nbsp;&nbsp; That's</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; probably =
because the init script is being run as &quot;system&quot; during =
bootup,</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; whereas when =
I manually typed on the console, I am &quot;sysadm&quot;.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; - I tried =
many different things, e.g. ssh-ing in as Admin or Reza, =
then</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; su - root, =
and then restarting sshd, but nothing works !!!</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt;&nbsp;&nbsp; =
The only thing that resolves this problem, is executing&nbsp; =
&quot;service sshd</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
restart&quot; at the console, where my context is =
root:sysadm_r:sysadm_t.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; - Of course, =
the other thing that works, is rebooting the Card a second</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; time, which =
I cant afford, due to availability requirements.</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Do you have =
any suggestions of how I can restart the sshd process</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; =
programmatically (e.g. through my init script), to achieve the =
same</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; results as =
running the 'service sshd restart' manually on the console =
?</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Is there a =
way my init script could temporarily assume sysadm, or a =
way</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; that my init =
script can be run as sysadm during bootup ?</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Well, you can =
always force it into a certain context via runcon (if</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">permitted by your =
policy).&nbsp; But I'd rather fix the real problem, and</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">that requires =
knowing what context sshd is running in initially and then</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">what context is =
it running in after the restart from the console.</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">&gt; Thanks again =
for all your help...</FONT></SPAN>
</P>

<P><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">-- </FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">Stephen =
Smalley</FONT></SPAN>

<BR><SPAN LANG=3D"en-us"><FONT SIZE=3D2 FACE=3D"Arial">National Security =
Agency</FONT></SPAN>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C86DCB.43783BC0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
