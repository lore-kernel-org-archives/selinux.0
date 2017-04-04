Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v344Ycpq014303
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 00:34:38 -0400
Received: by mail-wr0-f176.google.com with SMTP id t20so17609466wra.1
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 21:34:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201704041252.05196.russell@coker.com.au>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdpRxYsMHyDKmRtCswovHRgda1nW2ELUVVKPVtBrL9HL8Q@mail.gmail.com>
 <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
 <201704041252.05196.russell@coker.com.au>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Mon, 3 Apr 2017 21:34:14 -0700
Message-ID: <CAHFUiBNwBVDZoQr5jiJuTHbyX3iS9L42jRUR9w96qGXSqO3Hvg@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11468efec563cf054c4fc9d8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11468efec563cf054c4fc9d8
Content-Type: text/plain; charset=UTF-8

Umm, how's the easiest way to permit that one? Do I need to create a local
policy or can I just use a command line? Sorry I am really a newbie. :)

I am using javac 1.8.0_65. It is the same version for the "java" program.

java version "1.8.0_65"
Java(TM) SE Runtime Environment (build 1.8.0_65-b17)
Java HotSpot(TM) Client VM (build 25.65-b01, mixed mode)

On Mon, Apr 3, 2017 at 7:52 PM, Russell Coker <russell@coker.com.au> wrote:

> On Tue, 4 Apr 2017 12:35:47 PM Rahmadi Trimananda wrote:
> > I have more error messages from /var/log/audit/audit.log if this is of
> any
> > use for you. And yeah, it works in permissive mode (sudo setenforce 0).
> > BTW, what do you mean by "run javac in strace"?
> >
> > iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log | grep
> > javac
> > type=AVC msg=audit(1491260813.624:793): avc:  denied  { mmap_zero } for
> >  pid=1656 comm="javac"
> > scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > tclass=memprotect permissive=0
>
> Try permitting that one and see if it changes things.  What version of
> javac
> are you using?  Is it an old version?
>
> Also when posting such things to the list please include the output of
> auditallow as well as the raw AVC messages whenever you send more than 2-3
> entries.  When your MUA wraps the lines the result isn't accepted by
> audit2allow and that makes it less convenient for us to process your
> messages
> (usually audit2allow output is more useful than reading raw AVC log
> entries).
>
> If there is only a single AVC message then we can all run audit2allow in
> our
> heads.  ;)
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

--001a11468efec563cf054c4fc9d8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Umm, how&#39;s the easiest way to permit that one? Do I ne=
ed to create a local policy or can I just use a command line? Sorry I am re=
ally a newbie. :)<div><br></div><div>I am using=C2=A0javac 1.8.0_65. It is =
the same version for the &quot;java&quot; program.</div><div><br></div><div=
><div>java version &quot;1.8.0_65&quot;</div><div>Java(TM) SE Runtime Envir=
onment (build 1.8.0_65-b17)</div><div>Java HotSpot(TM) Client VM (build 25.=
65-b01, mixed mode)</div></div></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Mon, Apr 3, 2017 at 7:52 PM, Russell Coker <span dir=
=3D"ltr">&lt;<a href=3D"mailto:russell@coker.com.au" target=3D"_blank">russ=
ell@coker.com.au</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><s=
pan class=3D"">On Tue, 4 Apr 2017 12:35:47 PM Rahmadi Trimananda wrote:<br>
&gt; I have more error messages from /var/log/audit/audit.log if this is of=
 any<br>
&gt; use for you. And yeah, it works in permissive mode (sudo setenforce 0)=
.<br>
&gt; BTW, what do you mean by &quot;run javac in strace&quot;?<br>
&gt;<br>
&gt; iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log | gre=
p<br>
&gt; javac<br>
&gt; type=3DAVC msg=3Daudit(1491260813.624:793): avc:=C2=A0 denied=C2=A0 { =
mmap_zero } for<br>
&gt;=C2=A0 pid=3D1656 comm=3D&quot;javac&quot;<br>
&gt; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023<br>
&gt; tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023<br>
&gt; tclass=3Dmemprotect permissive=3D0<br>
<br>
</span>Try permitting that one and see if it changes things.=C2=A0 What ver=
sion of javac<br>
are you using?=C2=A0 Is it an old version?<br>
<br>
Also when posting such things to the list please include the output of<br>
auditallow as well as the raw AVC messages whenever you send more than 2-3<=
br>
entries.=C2=A0 When your MUA wraps the lines the result isn&#39;t accepted =
by<br>
audit2allow and that makes it less convenient for us to process your messag=
es<br>
(usually audit2allow output is more useful than reading raw AVC log entries=
).<br>
<br>
If there is only a single AVC message then we can all run audit2allow in ou=
r<br>
heads.=C2=A0 ;)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.=
D. student @ University of California, Irvine</div><div>&quot;Stay hungry, =
stay foolish!&quot; - Steve Jobs -</div></div></div>
</div>

--001a11468efec563cf054c4fc9d8--
