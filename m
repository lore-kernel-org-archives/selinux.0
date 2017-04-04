Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v346W7Kc012856
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 02:32:07 -0400
Received: by mail-wr0-f171.google.com with SMTP id k6so194504201wre.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 23:32:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201704041543.24065.russell@coker.com.au>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <201704041252.05196.russell@coker.com.au>
 <CAHFUiBNwBVDZoQr5jiJuTHbyX3iS9L42jRUR9w96qGXSqO3Hvg@mail.gmail.com>
 <201704041543.24065.russell@coker.com.au>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Mon, 3 Apr 2017 23:32:03 -0700
Message-ID: <CAHFUiBOWL7mB3v13DuSEthz1-CyCLa+UO5zbUemy6riZpYRn+g@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f403045f165224914c054c516f35
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045f165224914c054c516f35
Content-Type: text/plain; charset=UTF-8

Alright, I am getting a different error this time after giving permission
to mmap_zero. This is after running java or javac in enforcing mode.

Java HotSpot(TM) Client VM warning: INFO: os::commit_memory(0x740ab000,
163840, 1) failed; error='Permission denied' (errno=13)
#
# There is insufficient memory for the Java Runtime Environment to continue.
# Native memory allocation (mmap) failed to map 163840 bytes for committing
reserved memory.
# An error report file with more information is saved as:
# /home/iotuser/policy/debug/hs_err_pid2878.log

On Mon, Apr 3, 2017 at 10:43 PM, Russell Coker <russell@coker.com.au> wrote:

> On Tue, 4 Apr 2017 02:34:14 PM Rahmadi Trimananda wrote:
> > Umm, how's the easiest way to permit that one? Do I need to create a
> local
> > policy or can I just use a command line? Sorry I am really a newbie. :)
>
> Run "audit2allow -l -R < /var/log/audit/audit.log > local.te", that will
> generate the policy.
>
> policy_module(local,0.0.0)
>
> Edit local.te to remove allow lines that you don't want and also add the
> above
> as the first line.
>
> Create a symlink from the example Makefile (which is
> /usr/share/doc/selinux-
> policy-dev/examples/Makefile on Debian if you have the selinux-policy-dev
> package installed) to the current directory.  Then run "make load" and your
> policy will be compiled and loaded.
>
> > I am using javac 1.8.0_65. It is the same version for the "java" program.
> >
> > java version "1.8.0_65"
> > Java(TM) SE Runtime Environment (build 1.8.0_65-b17)
> > Java HotSpot(TM) Client VM (build 25.65-b01, mixed mode)
>
> I'm using openjdk which doesn't appear to require such access.
>
> $ java -version
> openjdk version "1.8.0_121"
> OpenJDK Runtime Environment (build 1.8.0_121-8u121-b13-4-b13)
> OpenJDK 64-Bit Server VM (build 25.121-b13, mixed mode)
>
> > On Mon, Apr 3, 2017 at 7:52 PM, Russell Coker <russell@coker.com.au>
> wrote:
> > > On Tue, 4 Apr 2017 12:35:47 PM Rahmadi Trimananda wrote:
> > > > I have more error messages from /var/log/audit/audit.log if this is
> of
> > >
> > > any
> > >
> > > > use for you. And yeah, it works in permissive mode (sudo setenforce
> 0).
> > > > BTW, what do you mean by "run javac in strace"?
> > > >
> > > > iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log |
> grep
> > > > javac
> > > > type=AVC msg=audit(1491260813.624:793): avc:  denied  { mmap_zero }
> for
> > > >
> > > >  pid=1656 comm="javac"
> > > >
> > > > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > tclass=memprotect permissive=0
> > >
> > > Try permitting that one and see if it changes things.  What version of
> > > javac
> > > are you using?  Is it an old version?
> > >
> > > Also when posting such things to the list please include the output of
> > > auditallow as well as the raw AVC messages whenever you send more than
> > > 2-3 entries.  When your MUA wraps the lines the result isn't accepted
> by
> > > audit2allow and that makes it less convenient for us to process your
> > > messages
> > > (usually audit2allow output is more useful than reading raw AVC log
> > > entries).
> > >
> > > If there is only a single AVC message then we can all run audit2allow
> in
> > > our
> > > heads.  ;)
> > >
> > > --
> > > My Main Blog         http://etbe.coker.com.au/
> > > My Documents Blog    http://doc.coker.com.au/
>
> --
> My Main Blog         http://etbe.coker.com.au/
> My Documents Blog    http://doc.coker.com.au/
>



-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--f403045f165224914c054c516f35
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Alright, I am getting a different error this time after gi=
ving permission to mmap_zero. This is after running java or javac in enforc=
ing mode.<div><br></div><div><div>Java HotSpot(TM) Client VM warning: INFO:=
 os::commit_memory(0x740ab000, 163840, 1) failed; error=3D&#39;Permission d=
enied&#39; (errno=3D13)</div><div>#</div><div># There is insufficient memor=
y for the Java Runtime Environment to continue.</div><div># Native memory a=
llocation (mmap) failed to map 163840 bytes for committing reserved memory.=
</div><div># An error report file with more information is saved as:</div><=
div># /home/iotuser/policy/debug/hs_err_pid2878.log</div></div></div><div c=
lass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Apr 3, 2017 at =
10:43 PM, Russell Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@cok=
er.com.au" target=3D"_blank">russell@coker.com.au</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">On Tue, 4 Apr 2017 02:34:14=
 PM Rahmadi Trimananda wrote:<br>
&gt; Umm, how&#39;s the easiest way to permit that one? Do I need to create=
 a local<br>
&gt; policy or can I just use a command line? Sorry I am really a newbie. :=
)<br>
<br>
</span>Run &quot;audit2allow -l -R &lt; /var/log/audit/audit.log &gt; local=
.te&quot;, that will<br>
generate the policy.<br>
<br>
policy_module(local,0.0.0)<br>
<br>
Edit local.te to remove allow lines that you don&#39;t want and also add th=
e above<br>
as the first line.<br>
<br>
Create a symlink from the example Makefile (which is /usr/share/doc/selinux=
-<br>
policy-dev/examples/Makefile on Debian if you have the selinux-policy-dev<b=
r>
package installed) to the current directory.=C2=A0 Then run &quot;make load=
&quot; and your<br>
policy will be compiled and loaded.<br>
<span class=3D""><br>
&gt; I am using javac 1.8.0_65. It is the same version for the &quot;java&q=
uot; program.<br>
&gt;<br>
&gt; java version &quot;1.8.0_65&quot;<br>
&gt; Java(TM) SE Runtime Environment (build 1.8.0_65-b17)<br>
&gt; Java HotSpot(TM) Client VM (build 25.65-b01, mixed mode)<br>
<br>
</span>I&#39;m using openjdk which doesn&#39;t appear to require such acces=
s.<br>
<br>
$ java -version<br>
openjdk version &quot;1.8.0_121&quot;<br>
OpenJDK Runtime Environment (build 1.8.0_121-8u121-b13-4-b13)<br>
OpenJDK 64-Bit Server VM (build 25.121-b13, mixed mode)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Mon, Apr 3, 2017 at 7:52 PM, Russell Coker &lt;<a href=3D"mailto:ru=
ssell@coker.com.au">russell@coker.com.au</a>&gt; wrote:<br>
&gt; &gt; On Tue, 4 Apr 2017 12:35:47 PM Rahmadi Trimananda wrote:<br>
&gt; &gt; &gt; I have more error messages from /var/log/audit/audit.log if =
this is of<br>
&gt; &gt;<br>
&gt; &gt; any<br>
&gt; &gt;<br>
&gt; &gt; &gt; use for you. And yeah, it works in permissive mode (sudo set=
enforce 0).<br>
&gt; &gt; &gt; BTW, what do you mean by &quot;run javac in strace&quot;?<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit=
.log | grep<br>
&gt; &gt; &gt; javac<br>
&gt; &gt; &gt; type=3DAVC msg=3Daudit(1491260813.624:793): avc:=C2=A0 denie=
d=C2=A0 { mmap_zero } for<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 pid=3D1656 comm=3D&quot;javac&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<w=
br>s0:c0.c1023<br>
&gt; &gt; &gt; tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<w=
br>s0:c0.c1023<br>
&gt; &gt; &gt; tclass=3Dmemprotect permissive=3D0<br>
&gt; &gt;<br>
&gt; &gt; Try permitting that one and see if it changes things.=C2=A0 What =
version of<br>
&gt; &gt; javac<br>
&gt; &gt; are you using?=C2=A0 Is it an old version?<br>
&gt; &gt;<br>
&gt; &gt; Also when posting such things to the list please include the outp=
ut of<br>
&gt; &gt; auditallow as well as the raw AVC messages whenever you send more=
 than<br>
&gt; &gt; 2-3 entries.=C2=A0 When your MUA wraps the lines the result isn&#=
39;t accepted by<br>
&gt; &gt; audit2allow and that makes it less convenient for us to process y=
our<br>
&gt; &gt; messages<br>
&gt; &gt; (usually audit2allow output is more useful than reading raw AVC l=
og<br>
&gt; &gt; entries).<br>
&gt; &gt;<br>
&gt; &gt; If there is only a single AVC message then we can all run audit2a=
llow in<br>
&gt; &gt; our<br>
&gt; &gt; heads.=C2=A0 ;)<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://e=
tbe.coker.com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.c=
om.au/</a><br>
&gt; &gt; My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au=
/" rel=3D"noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
<br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D=
. student @ University of California, Irvine</div><div>&quot;Stay hungry, s=
tay foolish!&quot; - Steve Jobs -</div></div></div>
</div>

--f403045f165224914c054c516f35--
