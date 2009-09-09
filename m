Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89CCTEr007870
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 08:12:29 -0400
Received: from mail-ew0-f206.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n89CDmkE004939
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 12:13:48 GMT
Received: by ewy2 with SMTP id 2so3802279ewy.41
        for <selinux@tycho.nsa.gov>; Wed, 09 Sep 2009 05:12:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.00.0909090922590.20973@tundra.namei.org>
References: <alpine.LRH.2.00.0909090747110.20344@tundra.namei.org>
	 <alpine.LRH.2.00.0909090922590.20973@tundra.namei.org>
Date: Wed, 9 Sep 2009 14:12:26 +0200
Message-ID: <51af93b70909090512sa1dfdf9jb22c3ce48c11aff9@mail.gmail.com>
Subject: Re: RHEL, RHCS, and Selinux : hype, reality or dream?
From: Elia Pinto <andronicus.spiros@gmail.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Content-Type: multipart/alternative; boundary=0016e6d7e3620185c0047323ff0c
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016e6d7e3620185c0047323ff0c
Content-Type: text/plain; charset=ISO-8859-1

2009/9/9 James Morris <jmorris@namei.org>

>
> > Hi. Sorry in advance for the polemical tone and the topic that is not
> > technical.
>
> Thanks for pointing this out -- I was not aware of this.
>
> This issue is being worked on.
>
> The tracking bz entry for this is:
> https://bugzilla.redhat.com/show_bug.cgi?id=503141
>
>
> Ok, i already know. BUT now, i that have 100+ RHEL 5.4 with RHCS with
Selinux enforced in a critical env AND want a certificated configuration
what i have to do ? Disable it everywhere ? It 'a very bad message, which,
in my opinion, should be resolved VERY quickly.

BTW, with RHEL5.4 no problem, also minor, with RHCS, but the manual tell me
to do something different. It 'a very bad message from a selinux product (
http://magazine.redhat.com/2007/05/04/whats-new-in-selinux-for-red-hat-enterprise-linux-5/
see
the last comment)
, which, in my opinion, should be resolved very quickly. IMHO, should be
preferable that the rhcs daemon go unconfined, if the selinux policy aren't
complete, rather than requiring to disable selinux everywhere.

Just for info : this post is already refenced on other mailing list

http://archives.neohapsis.com/archives/fulldisclosure/2009-09/0105.html
http://lists.immunitysec.com/pipermail/dailydave/2009-September/005892.html


Regards





> - James
> --
> James Morris
> <jmorris@namei.org>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--0016e6d7e3620185c0047323ff0c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2009/9/9 James Morris <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:jmorris@namei.org">jmorris@namei.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im"><br>&gt; Hi. Sorry in advance for the polemical tone and =
the topic that is not<br>&gt; technical.<br><br></div>Thanks for pointing t=
his out -- I was not aware of this.<br><br>This issue is being worked on.<b=
r>
<br>The tracking bz entry for this is:<br><a href=3D"https://bugzilla.redha=
t.com/show_bug.cgi?id=3D503141" target=3D"_blank">https://bugzilla.redhat.c=
om/show_bug.cgi?id=3D503141</a><br><br><br></blockquote>
<div>Ok, i already know. BUT now, i that have 100+ RHEL 5.4 with RHCS with =
Selinux enforced in a critical env AND want a certificated configuration wh=
at i have to do ? Disable it=A0everywhere ? It &#39;a very bad message, whi=
ch, in my opinion, should be resolved=A0VERY quickly.</div>

<div>=A0</div>
<div>BTW, with RHEL5.4 no problem, also minor, with RHCS, but the manual te=
ll me to do something=A0different. It &#39;a very bad message from a selinu=
x product=A0(=20
<div><a href=3D"http://magazine.redhat.com/2007/05/04/whats-new-in-selinux-=
for-red-hat-enterprise-linux-5/">http://magazine.redhat.com/2007/05/04/what=
s-new-in-selinux-for-red-hat-enterprise-linux-5/</a>=A0see the last comment=
)</div>
, which, in my opinion, should be resolved very quickly. IMHO, should be pr=
eferable that the rhcs daemon go unconfined, if the selinux policy aren&#39=
;t complete, rather than requiring to disable selinux everywhere.</div>

<div>=A0</div>
<div>Just for info : this post is already refenced on other mailing list</d=
iv>
<div>=A0</div>
<div><a href=3D"http://archives.neohapsis.com/archives/fulldisclosure/2009-=
09/0105.html">http://archives.neohapsis.com/archives/fulldisclosure/2009-09=
/0105.html</a></div>
<div><a href=3D"http://lists.immunitysec.com/pipermail/dailydave/2009-Septe=
mber/005892.html">http://lists.immunitysec.com/pipermail/dailydave/2009-Sep=
tember/005892.html</a></div>
<div>=A0</div>
<div>=A0</div>
<div>Regards</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>=A0</div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><span id=3D""></span>- James<br>=
--<br>James Morris<br>&lt;<a href=3D"mailto:jmorris@namei.org">jmorris@name=
i.org</a>&gt;<br>
<font color=3D"#888888"><br>--<br>This message was distributed to subscribe=
rs of the selinux mailing list.<br>If you no longer wish to subscribe, send=
 mail to <a href=3D"mailto:majordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov=
</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
></font></blockquote></div><br>

--0016e6d7e3620185c0047323ff0c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
