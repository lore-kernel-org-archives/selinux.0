MIME-Version: 1.0
In-Reply-To: <18456a4e-604b-79f9-d662-646332e37aae@tycho.nsa.gov>
References: <20160915071522.GA6893@meriadoc.perfinion.com>
 <18456a4e-604b-79f9-d662-646332e37aae@tycho.nsa.gov>
From: Dave Quigley <dquigley@gmail.com>
Date: Thu, 15 Sep 2016 12:36:20 -0400
Message-ID: <CAFC+zF1V6katjJrBnU7xd3E_+qeuqUwCSSkbEathJ=ewQ-oMaw@mail.gmail.com>
Subject: Re: NFSv4.2 unlabeled_t on mountpoints
To: Stephen Smalley <sds@tycho.nsa.gov>, steved@redhat.com
Cc: Jason Zaman <jason@perfinion.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1141277221e492053c8e7265
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1141277221e492053c8e7265
Content-Type: text/plain; charset=UTF-8

Its possible that we dropped something when we got the final patch set
which was accepted in the kernel but I don't remember encountering this
problem. I've included Steve Dickson who took over a lot of the porting
work sometime around the 3.27-3.30 timeframe and was the one to dragged
Labeled NFS across the finish line. He might have some more insight. Look
at whats here and what Steve Smalley said I'd agree with that assessment.
We did something with regard to invalidating cached information in the 4.2
spec but I can't remember how it was resolved and how and if we implemented
it in the Linux client/server/

Dave

On Thu, Sep 15, 2016 at 10:09 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/15/2016 03:15 AM, Jason Zaman wrote:
> > Hi All,
> >
> > I have kerberized NFSv4 between my laptop and server and when I use
> > vers=4.2 I cannot access the mount. It looks like the fcontext needs to
> > be invalidated or re-checked or something but I'm not familiar with
> > kernel internals so not sure how to fix it (If someone can point me to
> > the place, I'd love to get my hands dirty).
> >
> > Steps to repro:
> > kinit works fine
> > mount /home/jason/bregalad works fine, the fstab line is:
> > bregalad.perfinion.com:/jason /home/jason/bregalad nfs4
> noauto,users,vers=4.2,sec=krb5p,rw,intr,soft,timeo=100,_netdev,fsc 0 0
> >
> > Once mounted as my normal user:
> > $ ls -aldZ /home/jason/bregalad
> > ls: cannot access /home/jason/bregalad: Permission denied
> >
> > I get the following denial:
> > type=AVC msg=audit(1473923050.591:1577): avc:  denied  { getattr } for
> pid=7630 comm="ls" path="/home/jason/bregalad" dev="0:55" ino=4
> scontext=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir permissive=0
> > type=SYSCALL msg=audit(1473923050.591:1577): arch=c000003e syscall=6
> success=no exit=-13 a0=399b2bc22f2 a1=7a03d6e960 a2=7a03d6e960
> a3=7a02aa8d7b items=1 ppid=6440 pid=7630 auid=1000 uid=1000 gid=100
> euid=1000 suid=1000 fsuid=1000 egid=100 sgid=100 fsgid=100 tty=pts3 ses=5
> comm="ls" exe="/bin/ls" subj=staff_u:staff_r:staff_t:s0-s0:c0.c1023
> key=(null)
> > type=CWD msg=audit(1473923050.591:1577):  cwd="/home/jason"
> > type=PATH msg=audit(1473923050.591:1577): item=0
> name="/home/jason/bregalad" inode=4 dev=00:37 mode=040711 ouid=1000
> ogid=100 rdev=00:00 obj=system_u:object_r:unlabeled_t:s0 nametype=NORMAL
> > type=PROCTITLE msg=audit(1473923050.591:1577): proctitle=
> 6C73002D46002D2D636F6C6F723D6175746F002D616C645A002F686F6D65
> 2F6A61736F6E2F62726567616C6164
> >
> > If I ls with sysadm_t (which has permissions for unlabeled_t) then the
> > fcontext swaps to what it should be and everything works after that as
> > staff_t too. I have not had issues with other dirs/files inside the NFS
> > mount, only the mountpoint has this issue.
> >
> > As root / sysadm_t: # ls -aldZ /home/jason/bregalad
> > drwx--x--x. 50 jason users staff_u:object_r:user_home_dir_t:s0 84 Sep
> 13 22:38 /home/jason/bregalad/
> > As jason / staff_t: $ ls -aldZ /home/jason/bregalad
> > drwx--x--x. 50 jason users staff_u:object_r:user_home_dir_t:s0 84 Sep
> 13 22:38 /home/jason/bregalad/
> >
> > $ uname -a
> > Linux meriadoc 4.7.2-hardened-r1 #1 SMP PREEMPT Sat Sep 3 11:27:29 SGT
> 2016 x86_64 Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz GenuineIntel GNU/Linux
> > I'm on gentoo hardened but dont think GRSec is responsible here. I also
> had the same problem back on 4.4.
> >
> > Is there anything else that can help track this down?
> > -- Jason
>
> Maybe we need to add a call to security_inode_invalidate_secctx() in the
> nfs code to invalidate the label on the mountpoint directory and force
> SELinux to re-fetch it upon the next use?  Presently only gfs2 has been
> updated to use that hook.  Technically, NFS should be using it whenever
> the cached information may be invalid (e.g. label change on the server
> from another client).
>

--001a1141277221e492053c8e7265
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Its possible that we dropped something when we got the fin=
al patch set which was accepted in the kernel but I don&#39;t remember enco=
untering this problem. I&#39;ve included Steve Dickson who took over a lot =
of the porting work sometime around the 3.27-3.30 timeframe and was the one=
 to dragged Labeled NFS across the finish line. He might have some more ins=
ight. Look at whats here and what Steve Smalley said I&#39;d agree with tha=
t assessment. We did something with regard to invalidating cached informati=
on in the 4.2 spec but I can&#39;t remember how it was resolved and how and=
 if we implemented it in the Linux client/server/<div><br></div><div>Dave</=
div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu,=
 Sep 15, 2016 at 10:09 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D=
"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On 09/15/2016 03:15 AM, Jason Z=
aman wrote:<br>
&gt; Hi All,<br>
&gt;<br>
&gt; I have kerberized NFSv4 between my laptop and server and when I use<br=
>
&gt; vers=3D4.2 I cannot access the mount. It looks like the fcontext needs=
 to<br>
&gt; be invalidated or re-checked or something but I&#39;m not familiar wit=
h<br>
&gt; kernel internals so not sure how to fix it (If someone can point me to=
<br>
&gt; the place, I&#39;d love to get my hands dirty).<br>
&gt;<br>
&gt; Steps to repro:<br>
&gt; kinit works fine<br>
&gt; mount /home/jason/bregalad works fine, the fstab line is:<br>
&gt; bregalad.perfinion.com:/jason /home/jason/bregalad nfs4 noauto,users,v=
ers=3D4.2,sec=3D<wbr>krb5p,rw,intr,soft,timeo=3D100,_<wbr>netdev,fsc 0 0<br=
>
&gt;<br>
&gt; Once mounted as my normal user:<br>
&gt; $ ls -aldZ /home/jason/bregalad<br>
&gt; ls: cannot access /home/jason/bregalad: Permission denied<br>
&gt;<br>
&gt; I get the following denial:<br>
&gt; type=3DAVC msg=3Daudit(1473923050.591:1577)<wbr>: avc:=C2=A0 denied=C2=
=A0 { getattr } for=C2=A0 pid=3D7630 comm=3D&quot;ls&quot; path=3D&quot;/ho=
me/jason/bregalad&quot; dev=3D&quot;0:55&quot; ino=3D4 scontext=3Dstaff_u:s=
taff_r:<wbr>staff_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:<wbr>unlabe=
led_t:s0 tclass=3Ddir permissive=3D0<br>
&gt; type=3DSYSCALL msg=3Daudit(1473923050.591:1577)<wbr>: arch=3Dc000003e =
syscall=3D6 success=3Dno exit=3D-13 a0=3D399b2bc22f2 a1=3D7a03d6e960 a2=3D7=
a03d6e960 a3=3D7a02aa8d7b items=3D1 ppid=3D6440 pid=3D7630 auid=3D1000 uid=
=3D1000 gid=3D100 euid=3D1000 suid=3D1000 fsuid=3D1000 egid=3D100 sgid=3D10=
0 fsgid=3D100 tty=3Dpts3 ses=3D5 comm=3D&quot;ls&quot; exe=3D&quot;/bin/ls&=
quot; subj=3Dstaff_u:staff_r:staff_t:<wbr>s0-s0:c0.c1023 key=3D(null)<br>
&gt; type=3DCWD msg=3Daudit(1473923050.591:1577)<wbr>:=C2=A0 cwd=3D&quot;/h=
ome/jason&quot;<br>
&gt; type=3DPATH msg=3Daudit(1473923050.591:1577)<wbr>: item=3D0 name=3D&qu=
ot;/home/jason/bregalad&quot; inode=3D4 dev=3D00:37 mode=3D040711 ouid=3D10=
00 ogid=3D100 rdev=3D00:00 obj=3Dsystem_u:object_r:<wbr>unlabeled_t:s0 name=
type=3DNORMAL<br>
&gt; type=3DPROCTITLE msg=3Daudit(1473923050.591:1577)<wbr>: proctitle=3D<w=
br>6C73002D46002D2D636F6C6F723D61<wbr>75746F002D616C645A002F686F6D65<wbr>2F=
6A61736F6E2F62726567616C6164<br>
&gt;<br>
&gt; If I ls with sysadm_t (which has permissions for unlabeled_t) then the=
<br>
&gt; fcontext swaps to what it should be and everything works after that as=
<br>
&gt; staff_t too. I have not had issues with other dirs/files inside the NF=
S<br>
&gt; mount, only the mountpoint has this issue.<br>
&gt;<br>
&gt; As root / sysadm_t: # ls -aldZ /home/jason/bregalad<br>
&gt; drwx--x--x. 50 jason users staff_u:object_r:user_home_<wbr>dir_t:s0 84=
 Sep 13 22:38 /home/jason/bregalad/<br>
&gt; As jason / staff_t: $ ls -aldZ /home/jason/bregalad<br>
&gt; drwx--x--x. 50 jason users staff_u:object_r:user_home_<wbr>dir_t:s0 84=
 Sep 13 22:38 /home/jason/bregalad/<br>
&gt;<br>
&gt; $ uname -a<br>
&gt; Linux meriadoc 4.7.2-hardened-r1 #1 SMP PREEMPT Sat Sep 3 11:27:29 SGT=
 2016 x86_64 Intel(R) Core(TM) i7-4600U CPU @ 2.10GHz GenuineIntel GNU/Linu=
x<br>
&gt; I&#39;m on gentoo hardened but dont think GRSec is responsible here. I=
 also had the same problem back on 4.4.<br>
&gt;<br>
&gt; Is there anything else that can help track this down?<br>
&gt; -- Jason<br>
<br>
Maybe we need to add a call to security_inode_invalidate_<wbr>secctx() in t=
he<br>
nfs code to invalidate the label on the mountpoint directory and force<br>
SELinux to re-fetch it upon the next use?=C2=A0 Presently only gfs2 has bee=
n<br>
updated to use that hook.=C2=A0 Technically, NFS should be using it wheneve=
r<br>
the cached information may be invalid (e.g. label change on the server<br>
from another client).<br>
</blockquote></div><br></div>

--001a1141277221e492053c8e7265--
