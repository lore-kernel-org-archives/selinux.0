Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3UFmXDq005077
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 11:48:33 -0400
Received: by mail-wi0-f178.google.com with SMTP id hm4so1225712wib.17
 for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2014 08:48:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAB9W1A1a=mkZmuDpMtF-uhYse4z+ArmStHp9k09mS9YJy6zSPA@mail.gmail.com>
References: <CAB9W1A3BxZ=U=+t4o3q+EomuxK256Ou1EAqyHXrLm59PB=p7kA@mail.gmail.com>
 <1398826782.10979.9.camel@localhost> <5360F3C6.4090501@redhat.com>
 <1734421.ihMzWMu7WD@x2> <5360FC01.9090904@redhat.com>
 <CAB9W1A1=Q7OAv9pDw5oj0Lrj8dt5aAL_t9TffcVPbnsT1zexjQ@mail.gmail.com>
 <CAB9W1A1a=mkZmuDpMtF-uhYse4z+ArmStHp9k09mS9YJy6zSPA@mail.gmail.com>
Date: Wed, 30 Apr 2014 08:48:31 -0700
Message-ID: <CAFftDdrAk75mR6QqCQkq9jV-c2bm9iezsGdF=ug0nt_cDn1EHA@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: Report result in avc messages
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Content-Type: multipart/alternative; boundary=f46d04447e61f8eb4d04f8447a73
Cc: linux-audit@redhat.com, selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d04447e61f8eb4d04f8447a73
Content-Type: text/plain; charset=UTF-8

My only nit would be the variable name result....would it be better named
is_permissive or something?

Otherwise LGTM. From the Android camp, this will be very helpful.
On Apr 30, 2014 8:43 AM, "Stephen Smalley" <stephen.smalley@gmail.com>
wrote:

> Attached patch switches to reporting permissive=0|1 and only does it
> for avc: denied messages.
>
> On Wed, Apr 30, 2014 at 8:18 AM, Stephen Smalley
> <stephen.smalley@gmail.com> wrote:
> > I could make it permissive=0 or permissive=1 if that is less
> > confusing.  It doesn't necessarily correspond to the result of the
> > system call, just the avc_has_perm call, as e.g. the kernel checks
> > CAP_DAC_OVERRIDE and falls back to CAP_DAC_READ_SEARCH if only
> > read/search access was requested, and there are other cases where a
> > permission denial has a side effect rather than preventing the system
> > call (e.g. CAP_FSETID).
> >
> > On Wed, Apr 30, 2014 at 6:34 AM, Daniel J Walsh <dwalsh@redhat.com>
> wrote:
> >>
> >> On 04/30/2014 09:29 AM, Steve Grubb wrote:
> >>> On Wednesday, April 30, 2014 08:59:50 AM Daniel J Walsh wrote:
> >>>> How about permitted rather then allowed.
> >>> I think permitted is already in an AVC.
> >> Not sure where.
> >>>
> >>>> On 04/29/2014 10:59 PM, Eric Paris wrote:
> >>>>> On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wrote:
> >>>>>> Requested for Android in order to distinguish denials that are not
> in
> >>>>>> fact breaking anything yet due to permissive domains versus denials
> >>>>>> that are being enforced, but seems generally useful.  result field
> was
> >>>>>> already in the selinux audit data structure and was being passed to
> >>>>>> avc_audit() but wasn't being used.  Seems to cause no harm to
> ausearch
> >>>>>> or audit2allow to add it as a field.  Comments?
> >>>>> I think it's a great idea, but I'm worried that Steve is going to get
> >>>>> grumpy because an AVC record is going to have a result= field which
> is
> >>>>> similar, but not necessarily related to the res= field of a SYSCALL
> >>>>> record.
> >>> I think that I'll have to parse this field no matter what. Its
> probably that
> >>> important. In the syscall, we use success= to be the final
> determination.
> >>>
> >>>
> >>>>> Seems easily confused (although probably 9999 times out of
> >>>>> 10000 they will be the same)
> >>> Why would this ever not be correct? Are there times when we get an AVC
> with a
> >>> denial _and_ the syscall completes successfully?
> >>>
> >>> I'd suggest using res= since its in the audit dictionary and means
> exactly
> >>> what you are wanting to use it for. In it, 1 is success, 0 is failure.
> >>>
> >> I have seen AVC's where the success=yes in enforcing mode.  Basically
> >> the kernel takes a different code path and the syscall succeeds.  Most
> >> of these end up as dontaudits.
> >>>>> So while I wholeheartedly think we should take the idea, I wonder if
> >>>>> someone can dream up a name that isn't confusingly similar...
> >>>>>
> >>>>> I can't think of anything...
> >>> There is thesaurus.com. :-)
> >>>
> >>> consequence, outcome, effect, reaction,  conclusion, verdict, decision,
> >>> judgement, finding, ruling, answer, solution, recommendation, order,
>  ...
> >>>
> >>> -Steve
> >>
>
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit
>

--f46d04447e61f8eb4d04f8447a73
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">My only nit would be the variable name result....would it be=
 better named is_permissive or something?</p>
<p dir=3D"ltr">Otherwise LGTM. From the Android camp, this will be very hel=
pful.</p>
<div class=3D"gmail_quote">On Apr 30, 2014 8:43 AM, &quot;Stephen Smalley&q=
uot; &lt;<a href=3D"mailto:stephen.smalley@gmail.com">stephen.smalley@gmail=
.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Attached patch switches to reporting permissive=3D0|1 and only does it<br>
for avc: denied messages.<br>
<br>
On Wed, Apr 30, 2014 at 8:18 AM, Stephen Smalley<br>
&lt;<a href=3D"mailto:stephen.smalley@gmail.com">stephen.smalley@gmail.com<=
/a>&gt; wrote:<br>
&gt; I could make it permissive=3D0 or permissive=3D1 if that is less<br>
&gt; confusing. =C2=A0It doesn&#39;t necessarily correspond to the result o=
f the<br>
&gt; system call, just the avc_has_perm call, as e.g. the kernel checks<br>
&gt; CAP_DAC_OVERRIDE and falls back to CAP_DAC_READ_SEARCH if only<br>
&gt; read/search access was requested, and there are other cases where a<br=
>
&gt; permission denial has a side effect rather than preventing the system<=
br>
&gt; call (e.g. CAP_FSETID).<br>
&gt;<br>
&gt; On Wed, Apr 30, 2014 at 6:34 AM, Daniel J Walsh &lt;<a href=3D"mailto:=
dwalsh@redhat.com">dwalsh@redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 04/30/2014 09:29 AM, Steve Grubb wrote:<br>
&gt;&gt;&gt; On Wednesday, April 30, 2014 08:59:50 AM Daniel J Walsh wrote:=
<br>
&gt;&gt;&gt;&gt; How about permitted rather then allowed.<br>
&gt;&gt;&gt; I think permitted is already in an AVC.<br>
&gt;&gt; Not sure where.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On 04/29/2014 10:59 PM, Eric Paris wrote:<br>
&gt;&gt;&gt;&gt;&gt; On Tue, 2014-04-29 at 16:54 -0700, Stephen Smalley wro=
te:<br>
&gt;&gt;&gt;&gt;&gt;&gt; Requested for Android in order to distinguish deni=
als that are not in<br>
&gt;&gt;&gt;&gt;&gt;&gt; fact breaking anything yet due to permissive domai=
ns versus denials<br>
&gt;&gt;&gt;&gt;&gt;&gt; that are being enforced, but seems generally usefu=
l. =C2=A0result field was<br>
&gt;&gt;&gt;&gt;&gt;&gt; already in the selinux audit data structure and wa=
s being passed to<br>
&gt;&gt;&gt;&gt;&gt;&gt; avc_audit() but wasn&#39;t being used. =C2=A0Seems=
 to cause no harm to ausearch<br>
&gt;&gt;&gt;&gt;&gt;&gt; or audit2allow to add it as a field. =C2=A0Comment=
s?<br>
&gt;&gt;&gt;&gt;&gt; I think it&#39;s a great idea, but I&#39;m worried tha=
t Steve is going to get<br>
&gt;&gt;&gt;&gt;&gt; grumpy because an AVC record is going to have a result=
=3D field which is<br>
&gt;&gt;&gt;&gt;&gt; similar, but not necessarily related to the res=3D fie=
ld of a SYSCALL<br>
&gt;&gt;&gt;&gt;&gt; record.<br>
&gt;&gt;&gt; I think that I&#39;ll have to parse this field no matter what.=
 Its probably that<br>
&gt;&gt;&gt; important. In the syscall, we use success=3D to be the final d=
etermination.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Seems easily confused (although probably 9999 times ou=
t of<br>
&gt;&gt;&gt;&gt;&gt; 10000 they will be the same)<br>
&gt;&gt;&gt; Why would this ever not be correct? Are there times when we ge=
t an AVC with a<br>
&gt;&gt;&gt; denial _and_ the syscall completes successfully?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;d suggest using res=3D since its in the audit dictionary=
 and means exactly<br>
&gt;&gt;&gt; what you are wanting to use it for. In it, 1 is success, 0 is =
failure.<br>
&gt;&gt;&gt;<br>
&gt;&gt; I have seen AVC&#39;s where the success=3Dyes in enforcing mode. =
=C2=A0Basically<br>
&gt;&gt; the kernel takes a different code path and the syscall succeeds. =
=C2=A0Most<br>
&gt;&gt; of these end up as dontaudits.<br>
&gt;&gt;&gt;&gt;&gt; So while I wholeheartedly think we should take the ide=
a, I wonder if<br>
&gt;&gt;&gt;&gt;&gt; someone can dream up a name that isn&#39;t confusingly=
 similar...<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; I can&#39;t think of anything...<br>
&gt;&gt;&gt; There is <a href=3D"http://thesaurus.com" target=3D"_blank">th=
esaurus.com</a>. :-)<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; consequence, outcome, effect, reaction, =C2=A0conclusion, verd=
ict, decision,<br>
&gt;&gt;&gt; judgement, finding, ruling, answer, solution, recommendation, =
order, =C2=A0...<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; -Steve<br>
&gt;&gt;<br>
<br>--<br>
Linux-audit mailing list<br>
<a href=3D"mailto:Linux-audit@redhat.com">Linux-audit@redhat.com</a><br>
<a href=3D"https://www.redhat.com/mailman/listinfo/linux-audit" target=3D"_=
blank">https://www.redhat.com/mailman/listinfo/linux-audit</a><br></blockqu=
ote></div>

--f46d04447e61f8eb4d04f8447a73--
