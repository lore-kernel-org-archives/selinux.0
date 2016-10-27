MIME-Version: 1.0
In-Reply-To: <20161026160801.4c1db53b@taliesin-3.local>
References: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
 <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
 <20161026132751.36e45a7d@taliesin-3.local>
 <CAFC8oaeW27J9f4VJTHoCkCS+cD=jb5XA39G46xZBXLOQ74_iYA@mail.gmail.com>
 <20161026134910.5eae6731@taliesin-3.local>
 <CAFC8oaeX5CUVgV_A8hTAGQ7QuWabdw7Zz1geJpB4V_=RWQ3fBg@mail.gmail.com>
 <20161026160801.4c1db53b@taliesin-3.local>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Thu, 27 Oct 2016 05:05:59 +0500
Message-ID: <CAFC8oacJ9vKAmceotYW-q7iN_qLaDD8ivdAcUNVX6V2e85Lfug@mail.gmail.com>
Subject: Re: MLS issue
To: Harry Waddell <waddell@caravan-epub.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Simon Sekidde <ssekidde@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c040d54b1aeb6053fcd81fb
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c040d54b1aeb6053fcd81fb
Content-Type: text/plain; charset=UTF-8

so this time it labelled the system correctly now i was missing the
directory it didn't give me any error that selinux is preventing but it
generate a log

type=AVC msg=audit(1477527661.560:86): avc:  denied  { remove_name } for
 pid=1382 comm="rm" name=".autorelabel" dev="dm-0" ino=274627
scontext=system_u:system_r:init_t:s0-s15:c0.c1023
tcontext=system_u:object_r:root_t:s0 tclass=dir

rest of the directory are now correctly labelled and but issue remain the
same it didn't allow me to login.....


On Thu, Oct 27, 2016 at 4:08 AM, Harry Waddell <waddell@caravan-epub.com>
wrote:

> On Thu, 27 Oct 2016 01:54:02 +0500
> Kashif ali <kashif.ali.9498@gmail.com> wrote:
>
> > i'm using centos server and i'm logging on system locally there is no ssh
> > and another thing i have checked files are labelled with unlabelled_t,
> and
> > i have installed mlc policy i have checked the logs in audit.log file
> >
> > type=AVC msg=audit(1477481078.990:79): avc:  denied  { read } for
> pid=1039
> > comm="audispd" name="ld.so.cache" dev="dm-0" ino=67387328
> > scontext=system_u:system_r:audisp_t:s15:c0.c1023
> > tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file
> >
> > these kinds of logs are generated
> >
> > On Thu, Oct 27, 2016 at 1:49 AM, Harry Waddell <waddell@caravan-epub.com
> >
> > wrote:
> >
> > >
> > > Again, you're being far too vague. Can you login in text mode as root
> > > on the system console? Or are you trying to login to a desktop with a
> > > window
> > > manage, e.g. via xdm? These are completely different things.
> > >
> > > 1. Make sure you have the current and correct rpms installed, e.g. the
> mls
> > > policy.
> > >
> > > 2. Relabel everything again and make sure it completes without errors.
> > >
> > > 3. If you still can't login in text mode as root from the console,
> look at
> > > the
> > > specific causes listed in the auditd log. If you haven't already done
> so,
> > > I would suggest you become good friends with audit2allow, etc...
> > >
> > > HW
> > >
> > >
> > > On Thu, 27 Oct 2016 01:32:36 +0500
> > > Kashif ali <kashif.ali.9498@gmail.com> wrote:
> > >
> > > > i am logging on local machine directly and if i put msl in permissive
> > > mode
> > > > it will just generate logs for the policy violation which is
> expected in
> > > > permissive but if i am unable to use mls in enforcing mode then it is
> > > quit
> > > > wrong behavior
> > > >
> > > > On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell <
> waddell@caravan-epub.com
> > > >
> > > > wrote:
> > > >
> > > > > On Wed, 26 Oct 2016 10:17:27 -0400
> > > > > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > > > >
> > > > > > On 10/26/2016 03:47 AM, Kashif ali wrote:
> > > > > > > Hi
> > > > > > >    Hope you're fine i know your busy but i need your little
> time
> > > if you
> > > > > > > can manage that will be great for me.
> > > > > > > i'm facing an issue in MLS Policy of Selinux when i relabel the
> > > system
> > > > > > > and reboot it it won't allow me to login(i'm signing in my
> machine
> > > ) i
> > > > > > > used these commands
> > > > > > >  * set the selinux to enforcing
> > > > > > >  * touch ./autorelabel for relabeling the system
> > > > > > >  * and then reboot the system and it won't allow me to login
> > > > > > >
> > > > > > > Kindly help in this problem because i'm stuck in it for a while
> > > and it
> > > > > > > will be very greatful. Thanks
> > > > > >
> > > > > > Generally it is a good idea to first bring up the system in
> > > permissive
> > > > > > when switching to MLS, and check that there are no residual
> denials
> > > or
> > > > > > other SELinux errors that need to be addressed before putting it
> into
> > > > > > enforcing mode.  We would need to see the actual error messages
> to
> > > help
> > > > > > debug further.  And it would help to specify your specific
> > > distribution
> > > > > > and version.
> > > > > >
> > > > >
> > > > > Agreed. At this point, I think the only recourse for Kashif is to
> > > > > boot the system into rescue mode, e.g. using the install dvd,
> > > > > mount the filesystem, and edit the /etc/sysconfig/selinux file to
> > > > > change enforcing to permissive.
> > > > >
> > > > > Saying "it won't allow me to login" is too vague. Is "me" root?
> > > > > Is login from the console of via ssh? It could be that a boolean
> > > > > needs to be changed, but that's just speculation at this point.
> > > > > Once it's in permissive mode, hopefully the problem will be
> somewhat
> > > > > obvious.
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > >
>
> I apologize for top-posting earlier. It was momentary insanity on my part.
>
> Look at the tcontext in the error message. ld.so.conf is unlabeled.
>
> I'm not sure what it should be on your system, e.g. ld_so_cache_t, but I
> strongly suspect unlabeled_t is not correct. You've probably skipped a
> step somewhere or
> something failed without being noticed during setup.
>
> I suspect you made a mistake here:
>
> > touch ./autorelabel for relabeling the system
>
> It's "touch /.autorelabel", i.e. the dot comes AFTER the / NOT BEFORE.
>
> Relabel everything. If that doesn't work, consider starting over, paying
> close attention
> to whatever instructions or tutorial you are working from, e.g.
> https://access.redhat.com/documentation/en-US/Red_Hat_
> Enterprise_Linux/6/html/Security-Enhanced_Linux/
> enabling-mls-in-selinux.html
>
> HW
>
>
>

--94eb2c040d54b1aeb6053fcd81fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">so this time it labelled the system correctly now i was mi=
ssing the directory it didn&#39;t give me any error that selinux is prevent=
ing but it generate a log=C2=A0<div><br><div><div>type=3DAVC msg=3Daudit(14=
77527661.560:86): avc: =C2=A0denied =C2=A0{ remove_name } for =C2=A0pid=3D1=
382 comm=3D&quot;rm&quot; name=3D&quot;.autorelabel&quot; dev=3D&quot;dm-0&=
quot; ino=3D274627 scontext=3Dsystem_u:system_r:init_t:s0-s15:c0.c1023 tcon=
text=3Dsystem_u:object_r:root_t:s0 tclass=3Ddir</div></div><div><br></div><=
div>rest of the directory are now correctly labelled and but issue remain t=
he same it didn&#39;t allow me to login.....</div><div><br></div></div></di=
v><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Oct 27,=
 2016 at 4:08 AM, Harry Waddell <span dir=3D"ltr">&lt;<a href=3D"mailto:wad=
dell@caravan-epub.com" target=3D"_blank">waddell@caravan-epub.com</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">On Thu, 27 Oct 2016 01:54:02=
 +0500<br>
<div><div class=3D"h5">Kashif ali &lt;<a href=3D"mailto:kashif.ali.9498@gma=
il.com">kashif.ali.9498@gmail.com</a>&gt; wrote:<br>
<br>
&gt; i&#39;m using centos server and i&#39;m logging on system locally ther=
e is no ssh<br>
&gt; and another thing i have checked files are labelled with unlabelled_t,=
 and<br>
&gt; i have installed mlc policy i have checked the logs in audit.log file<=
br>
&gt;<br>
&gt; type=3DAVC msg=3Daudit(1477481078.990:79): avc:=C2=A0 denied=C2=A0 { r=
ead } for=C2=A0 pid=3D1039<br>
&gt; comm=3D&quot;audispd&quot; name=3D&quot;ld.so.cache&quot; dev=3D&quot;=
dm-0&quot; ino=3D67387328<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>audisp_t:s15:c0.c1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>unlabeled_t:s15:c0.c1023 tclass=3Dfi=
le<br>
&gt;<br>
&gt; these kinds of logs are generated<br>
&gt;<br>
&gt; On Thu, Oct 27, 2016 at 1:49 AM, Harry Waddell &lt;<a href=3D"mailto:w=
addell@caravan-epub.com">waddell@caravan-epub.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Again, you&#39;re being far too vague. Can you login in text mode=
 as root<br>
&gt; &gt; on the system console? Or are you trying to login to a desktop wi=
th a<br>
&gt; &gt; window<br>
&gt; &gt; manage, e.g. via xdm? These are completely different things.<br>
&gt; &gt;<br>
&gt; &gt; 1. Make sure you have the current and correct rpms installed, e.g=
. the mls<br>
&gt; &gt; policy.<br>
&gt; &gt;<br>
&gt; &gt; 2. Relabel everything again and make sure it completes without er=
rors.<br>
&gt; &gt;<br>
&gt; &gt; 3. If you still can&#39;t login in text mode as root from the con=
sole, look at<br>
&gt; &gt; the<br>
&gt; &gt; specific causes listed in the auditd log. If you haven&#39;t alre=
ady done so,<br>
&gt; &gt; I would suggest you become good friends with audit2allow, etc...<=
br>
&gt; &gt;<br>
&gt; &gt; HW<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 27 Oct 2016 01:32:36 +0500<br>
&gt; &gt; Kashif ali &lt;<a href=3D"mailto:kashif.ali.9498@gmail.com">kashi=
f.ali.9498@gmail.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; i am logging on local machine directly and if i put msl in p=
ermissive<br>
&gt; &gt; mode<br>
&gt; &gt; &gt; it will just generate logs for the policy violation which is=
 expected in<br>
&gt; &gt; &gt; permissive but if i am unable to use mls in enforcing mode t=
hen it is<br>
&gt; &gt; quit<br>
&gt; &gt; &gt; wrong behavior<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell &lt;<a href=
=3D"mailto:waddell@caravan-epub.com">waddell@caravan-epub.com</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Wed, 26 Oct 2016 10:17:27 -0400<br>
&gt; &gt; &gt; &gt; Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov=
">sds@tycho.nsa.gov</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On 10/26/2016 03:47 AM, Kashif ali wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; Hi<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 =C2=A0 Hope you&#39;re fine i know your=
 busy but i need your little time<br>
&gt; &gt; if you<br>
&gt; &gt; &gt; &gt; &gt; &gt; can manage that will be great for me.<br>
&gt; &gt; &gt; &gt; &gt; &gt; i&#39;m facing an issue in MLS Policy of Seli=
nux when i relabel the<br>
&gt; &gt; system<br>
&gt; &gt; &gt; &gt; &gt; &gt; and reboot it it won&#39;t allow me to login(=
i&#39;m signing in my machine<br>
&gt; &gt; ) i<br>
&gt; &gt; &gt; &gt; &gt; &gt; used these commands<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * set the selinux to enforcing<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * touch ./autorelabel for relabeling th=
e system<br>
&gt; &gt; &gt; &gt; &gt; &gt;=C2=A0 * and then reboot the system and it won=
&#39;t allow me to login<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Kindly help in this problem because i&#39;m s=
tuck in it for a while<br>
&gt; &gt; and it<br>
&gt; &gt; &gt; &gt; &gt; &gt; will be very greatful. Thanks<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Generally it is a good idea to first bring up the =
system in<br>
&gt; &gt; permissive<br>
&gt; &gt; &gt; &gt; &gt; when switching to MLS, and check that there are no=
 residual denials<br>
&gt; &gt; or<br>
&gt; &gt; &gt; &gt; &gt; other SELinux errors that need to be addressed bef=
ore putting it into<br>
&gt; &gt; &gt; &gt; &gt; enforcing mode.=C2=A0 We would need to see the act=
ual error messages to<br>
&gt; &gt; help<br>
&gt; &gt; &gt; &gt; &gt; debug further.=C2=A0 And it would help to specify =
your specific<br>
&gt; &gt; distribution<br>
&gt; &gt; &gt; &gt; &gt; and version.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Agreed. At this point, I think the only recourse for Ka=
shif is to<br>
&gt; &gt; &gt; &gt; boot the system into rescue mode, e.g. using the instal=
l dvd,<br>
&gt; &gt; &gt; &gt; mount the filesystem, and edit the /etc/sysconfig/selin=
ux file to<br>
&gt; &gt; &gt; &gt; change enforcing to permissive.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Saying &quot;it won&#39;t allow me to login&quot; is to=
o vague. Is &quot;me&quot; root?<br>
&gt; &gt; &gt; &gt; Is login from the console of via ssh? It could be that =
a boolean<br>
&gt; &gt; &gt; &gt; needs to be changed, but that&#39;s just speculation at=
 this point.<br>
&gt; &gt; &gt; &gt; Once it&#39;s in permissive mode, hopefully the problem=
 will be somewhat<br>
&gt; &gt; &gt; &gt; obvious.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;<br>
<br>
</div></div>I apologize for top-posting earlier. It was momentary insanity =
on my part.<br>
<br>
Look at the tcontext in the error message. ld.so.conf is unlabeled.<br>
<br>
I&#39;m not sure what it should be on your system, e.g. ld_so_cache_t, but =
I<br>
strongly suspect unlabeled_t is not correct. You&#39;ve probably skipped a =
step somewhere or<br>
something failed without being noticed during setup.<br>
<br>
I suspect you made a mistake here:<br>
<span class=3D""><br>
&gt; touch ./autorelabel for relabeling the system<br>
<br>
</span>It&#39;s &quot;touch /.autorelabel&quot;, i.e. the dot comes AFTER t=
he / NOT BEFORE.<br>
<br>
Relabel everything. If that doesn&#39;t work, consider starting over, payin=
g close attention<br>
to whatever instructions or tutorial you are working from, e.g.<br>
<a href=3D"https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise=
_Linux/6/html/Security-Enhanced_Linux/enabling-mls-in-selinux.html" rel=3D"=
noreferrer" target=3D"_blank">https://access.redhat.com/<wbr>documentation/=
en-US/Red_Hat_<wbr>Enterprise_Linux/6/html/<wbr>Security-Enhanced_Linux/<wb=
r>enabling-mls-in-selinux.html</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
HW<br>
<br>
<br>
</font></span></blockquote></div><br></div>

--94eb2c040d54b1aeb6053fcd81fb--
