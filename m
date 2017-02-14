Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1ECwxHj001803
 for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2017 07:58:59 -0500
Received: by mail-it0-f41.google.com with SMTP id c7so35630368itd.1
 for <selinux@tycho.nsa.gov>; Tue, 14 Feb 2017 04:58:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486149690.4106.5.camel@tycho.nsa.gov>
References: <3837461d-1104-fcd3-eb01-77faf3bb4b0b@redhat.com>
 <1486064676.1887.80.camel@tycho.nsa.gov>
 <20b783f6-ac97-c35a-8384-66e5a8801a3c@redhat.com>
 <1486149690.4106.5.camel@tycho.nsa.gov>
From: Miroslav Vadkerti <mvadkert@redhat.com>
Date: Tue, 14 Feb 2017 13:57:00 +0100
Message-ID: <CAGFJcwyqt0pPsPh522R8vEhTwnJeiKyCSPkV7E0X8NBLaGbXMw@mail.gmail.com>
Subject: Re: possible regression in "semanage user"
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a114fcaaa77e67d05487d1f81
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114fcaaa77e67d05487d1f81
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 3, 2017 at 8:21 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2017-02-03 at 16:25 +0100, Vit Mojzis wrote:
> >
> > On 2.2.2017 20:44, Stephen Smalley wrote:
> > >
> > > On Thu, 2017-02-02 at 18:22 +0100, Vit Mojzis wrote:
> > > >
> > > > Hi list,
> > > > we have a report about a possible regression in "semanage user"
> > > > and
> > > > I'd
> > > > like to hear your opinion on what the correct behaviour should
> > > > be.
> > > >
> > > > Given that local changes have been made to a SELinux user
> > > > definition
> > > > (originally defined in policy)
> > > > e.g. # semanage user -m staff_u -r "s0"
> > > > and the SELinux user is mapped to some Linux user
> > > > # semanage login -a -s staff_u staff
> > > > both
> > > > # semanage user -d staff_u
> > > > and
> > > > # semanage user --deleteall
> > > > will fail to remove the local change with the following message:
> > > > "libsemanage.lookup_seuser: staff_u is being used by staff login
> > > > record
> > > > (Invalid argument)."
> > > >
> > > > Is this the intended behaviour?
> > > >
> > > > I would assume that this error message was intended only for
> > > > locally
> > > > defined SELinux users (in which case "semanage user -d
> > > > selinux_user"
> > > > would remove the only definition of "selinux_user"). If so, is
> > > > there
> > > > any
> > > > way to determine if a SELinux user has been defined only locally
> > > > (as
> > > > opposed to being defined in policy) after some local changes have
> > > > been made?
> > > Looks like this change came in via commit
> > > 56d9d20a647a52146494f0aef4494cafe328dc5d from Dan Walsh (in 2013).
> > > I agree it doesn't make sense for policy-defined users.  Offhand, I
> > > don't see a clean interface for doing what you want; I'm wondering
> > > if
> > > we truly need this check at all.
> > We do, I just tried defining new local SELinux user, assigned it to
> > Linux user and then removed it (after removing the check). You can
> > actually even log in to the account with invalid SELinux user, but
> > "semanage login" and "semanage user" stop working (errors regarding
> > non-existent user).
>
> (restored list and cc)
>
> I don't see any easy way to fix.  Obviously they could remove the login
> entry first and then the user, then re-add the login entry, but that's
> certainly sub-optimal.


=E2=80=8BThat is actually how we currently workaround this, so if semanage
could do this, it would help.


> Is this truly a regression though?


That is a good question. I do not mind keeping the current
functionality, which from a point of view, makes sense. But
we should document this properly in the man page.

Best regards,
/M



>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



--=20
Miroslav Vadkerti :: Senior QE / RHCSS :: BaseOS QE Security
IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087
Desk Phone +420 532 294 129 <+420%20532%20294%20129> :: Mobile +420 773 944
252 <+420%20773%20944%20252>
Red Hat Czech s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR

--001a114fcaaa77e67d05487d1f81
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default"><font size=3D"2" face=3D"mono=
space, monospace">Hi,</font></div><div class=3D"gmail_default"><font size=
=3D"2" face=3D"monospace, monospace"><br></font></div><div class=3D"gmail_d=
efault"><font size=3D"2" face=3D"monospace, monospace">On Fri, Feb 3, 2017 =
at 8:21 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tyc=
ho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br></=
font></div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><font size=3D"2" face=3D"monospace,=
 monospace">On Fri, 2017-02-03 at 16:25 +0100, Vit Mojzis wrote:<br>
</font><div><div class=3D"m_-1629469470329463406gmail-h5"><font size=3D"2" =
face=3D"monospace, monospace">&gt;<br>
&gt; On 2.2.2017 20:44, Stephen Smalley wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 2017-02-02 at 18:22 +0100, Vit Mojzis wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Hi list,<br>
&gt; &gt; &gt; we have a report about a possible regression in &quot;semana=
ge user&quot;<br>
&gt; &gt; &gt; and<br>
&gt; &gt; &gt; I&#39;d<br>
&gt; &gt; &gt; like to hear your opinion on what the correct behaviour shou=
ld<br>
&gt; &gt; &gt; be.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Given that local changes have been made to a SELinux user<br=
>
&gt; &gt; &gt; definition<br>
&gt; &gt; &gt; (originally defined in policy)<br>
&gt; &gt; &gt; e.g. # semanage user -m staff_u -r &quot;s0&quot;<br>
&gt; &gt; &gt; and the SELinux user is mapped to some Linux user<br>
&gt; &gt; &gt; # semanage login -a -s staff_u staff<br>
&gt; &gt; &gt; both<br>
&gt; &gt; &gt; # semanage user -d staff_u<br>
&gt; &gt; &gt; and<br>
&gt; &gt; &gt; # semanage user --deleteall<br>
&gt; &gt; &gt; will fail to remove the local change with the following mess=
age:<br>
&gt; &gt; &gt; &quot;libsemanage.lookup_seuser: staff_u is being used by st=
aff login<br>
&gt; &gt; &gt; record<br>
&gt; &gt; &gt; (Invalid argument).&quot;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Is this the intended behaviour?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I would assume that this error message was intended only for=
<br>
&gt; &gt; &gt; locally<br>
&gt; &gt; &gt; defined SELinux users (in which case &quot;semanage user -d<=
br>
&gt; &gt; &gt; selinux_user&quot;<br>
&gt; &gt; &gt; would remove the only definition of &quot;selinux_user&quot;=
). If so, is<br>
&gt; &gt; &gt; there<br>
&gt; &gt; &gt; any<br>
&gt; &gt; &gt; way to determine if a SELinux user has been defined only loc=
ally<br>
&gt; &gt; &gt; (as<br>
&gt; &gt; &gt; opposed to being defined in policy) after some local changes=
 have<br>
&gt; &gt; &gt; been made?<br>
&gt; &gt; Looks like this change came in via commit<br>
&gt; &gt; 56d9d20a647a52146494f0aef4494c<wbr>afe328dc5d from Dan Walsh (in =
2013).<br>
&gt; &gt; I agree it doesn&#39;t make sense for policy-defined users.=C2=A0=
=C2=A0Offhand, I<br>
&gt; &gt; don&#39;t see a clean interface for doing what you want; I&#39;m =
wondering<br>
&gt; &gt; if<br>
&gt; &gt; we truly need this check at all.<br>
</font></div></div><font size=3D"2" face=3D"monospace, monospace">&gt; We d=
o, I just tried defining new local SELinux user, assigned it to=C2=A0<br>
&gt; Linux user and then removed it (after removing the check). You can=C2=
=A0<br>
&gt; actually even log in to the account with invalid SELinux user, but=C2=
=A0<br>
&gt; &quot;semanage login&quot; and &quot;semanage user&quot; stop working =
(errors regarding=C2=A0<br>
&gt; non-existent user).<br>
<br>
(restored list and cc)<br>
<br>
I don&#39;t see any easy way to fix.=C2=A0 Obviously they could remove the =
login<br>
entry first and then the user, then re-add the login entry, but that&#39;s<=
br>
certainly sub-optimal.=C2=A0</font></blockquote><div><font size=3D"2" face=
=3D"monospace, monospace"><br></font></div><div><div class=3D"gmail_default=
"><font size=3D"2" face=3D"monospace, monospace">=E2=80=8BThat is actually =
how we currently workaround this, so if semanage</font></div><div class=3D"=
gmail_default"><font size=3D"2" face=3D"monospace, monospace">could do this=
, it would help.</font></div></div><div><font size=3D"2" face=3D"monospace,=
 monospace">=C2=A0</font></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><font size=3D"2" face=3D"monospace, monospace">Is this truly a regres=
sion though?</font></blockquote><div><font size=3D"2" face=3D"monospace, mo=
nospace"><br></font></div><div><div class=3D"gmail_default"><font size=3D"2=
" face=3D"monospace, monospace">That is a good question. I do not mind keep=
ing the current</font></div></div><div class=3D"gmail_default"><font size=
=3D"2" face=3D"monospace, monospace">functionality, which from a point of v=
iew, makes sense. But</font></div><div class=3D"gmail_default"><font size=
=3D"2" face=3D"monospace, monospace">we should document this properly in th=
e man page.</font></div><div class=3D"gmail_default"><font size=3D"2" face=
=3D"monospace, monospace"><br></font></div><div class=3D"gmail_default"><fo=
nt size=3D"2" face=3D"monospace, monospace">Best regards,</font></div><div =
class=3D"gmail_default"><font size=3D"2" face=3D"monospace, monospace">/M</=
font></div><div><font size=3D"2" face=3D"monospace, monospace"><br></font><=
/div><div><font size=3D"2" face=3D"monospace, monospace">=C2=A0</font></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"m_-1629469470329463406gmail-HOEnZb"><div class=3D"m_-16294694=
70329463406gmail-h5"><font size=3D"2" face=3D"monospace, monospace"><br>
______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.</font></div></div></blockquote></div><font size=3D"2" face=3D"mon=
ospace, monospace"><br><br clear=3D"all"></font><div><font size=3D"2" face=
=3D"monospace, monospace"><br></font></div><font size=3D"2" face=3D"monospa=
ce, monospace">-- <br></font><div class=3D"m_-1629469470329463406gmail_sign=
ature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><f=
ont face=3D"monospace, monospace" size=3D"2">Miroslav Vadkerti :: Senior QE=
 / RHCSS :: BaseOS QE Security</font></div><div><font face=3D"monospace, mo=
nospace" size=3D"2">IRC mvadkert #qe #urt #brno #rpmdiff :: GPG 0x25881087<=
br></font></div><div><font face=3D"monospace, monospace" size=3D"2">Desk Ph=
one <a href=3D"tel:+420%20532%20294%20129" value=3D"+420532294129" target=
=3D"_blank">+420 532 294 129</a> :: Mobile <a href=3D"tel:+420%20773%20944%=
20252" value=3D"+420773944252" target=3D"_blank">+420 773 944 252</a><br></=
font></div><div><font size=3D"2" face=3D"monospace, monospace">Red Hat Czec=
h s.r.o, Purky=C5=88ova 99/71, 612 00, Brno, CR<br></font></div><div><br></=
div></div></div></div></div></div></div>
</div></div>

--001a114fcaaa77e67d05487d1f81--
