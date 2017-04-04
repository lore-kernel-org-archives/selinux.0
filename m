Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v344rGhD018738
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 00:53:16 -0400
Received: by mail-oi0-f50.google.com with SMTP id f193so150353810oib.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 21:53:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHFUiBNwBVDZoQr5jiJuTHbyX3iS9L42jRUR9w96qGXSqO3Hvg@mail.gmail.com>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdpRxYsMHyDKmRtCswovHRgda1nW2ELUVVKPVtBrL9HL8Q@mail.gmail.com>
 <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
 <201704041252.05196.russell@coker.com.au>
 <CAHFUiBNwBVDZoQr5jiJuTHbyX3iS9L42jRUR9w96qGXSqO3Hvg@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 3 Apr 2017 21:53:08 -0700
Message-ID: <CAFftDdpYbZ9jLc1TRt8Tk18_WrKCg=nQjm6ij15yNocQT686qA@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: Rahmadi Trimananda <rtrimana@uci.edu>
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113ce0f6611a0e054c500d39
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113ce0f6611a0e054c500d39
Content-Type: text/plain; charset=UTF-8

On Apr 3, 2017 21:35, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:

Umm, how's the easiest way to permit that one? Do I need to create a local
policy or can I just use a command line? Sorry I am really a newbie. :)


That would be a command, but the logs you provided should be enough.


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

_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to
Selinux-request@tycho.nsa.gov.

--001a113ce0f6611a0e054c500d39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Apr 3, 2017 21:35, &quot;Rahmadi Trimananda&quot; &lt;<a href=
=3D"mailto:rtrimana@uci.edu">rtrimana@uci.edu</a>&gt; wrote:<br type=3D"att=
ribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Umm, how&#39;s the easi=
est way to permit that one? Do I need to create a local policy or can I jus=
t use a command line? Sorry I am really a newbie. :)</div></blockquote></di=
v></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That would be a=
 command, but the logs you provided should be enough.</div><div dir=3D"auto=
"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr"><div><br></div><div>I am using=C2=A0javac 1.8.0_65=
. It is the same version for the &quot;java&quot; program.</div><div><br></=
div><div><div>java version &quot;1.8.0_65&quot;</div><div>Java(TM) SE Runti=
me Environment (build 1.8.0_65-b17)</div><div>Java HotSpot(TM) Client VM (b=
uild 25.65-b01, mixed mode)</div></div></div><div class=3D"gmail_extra"><di=
v class=3D"quoted-text"><br><div class=3D"gmail_quote">On Mon, Apr 3, 2017 =
at 7:52 PM, Russell Coker <span dir=3D"ltr">&lt;<a href=3D"mailto:russell@c=
oker.com.au" target=3D"_blank">russell@coker.com.au</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><span>On Tue, 4 Apr 2017 12:35:47 PM Rahma=
di Trimananda wrote:<br>
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
&gt; scontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<wbr>c=
1023<br>
&gt; tcontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<wbr>c=
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
<span class=3D"m_-3977188354367668844HOEnZb"><font color=3D"#888888"><br>
--<br>
My Main Blog=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://etbe.coker.=
com.au/" rel=3D"noreferrer" target=3D"_blank">http://etbe.coker.com.au/</a>=
<br>
My Documents Blog=C2=A0 =C2=A0 <a href=3D"http://doc.coker.com.au/" rel=3D"=
noreferrer" target=3D"_blank">http://doc.coker.com.au/</a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div></div=
><div class=3D"quoted-text">-- <br><div class=3D"m_-3977188354367668844gmai=
l_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Kind regar=
ds,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D. student @ Univers=
ity of California, Irvine</div><div>&quot;Stay hungry, stay foolish!&quot; =
- Steve Jobs -</div></div></div>
</div></div>
<br>______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br></blo=
ckquote></div><br></div></div></div>

--001a113ce0f6611a0e054c500d39--
