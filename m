MIME-Version: 1.0
In-Reply-To: <20161026134910.5eae6731@taliesin-3.local>
References: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
 <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
 <20161026132751.36e45a7d@taliesin-3.local>
 <CAFC8oaeW27J9f4VJTHoCkCS+cD=jb5XA39G46xZBXLOQ74_iYA@mail.gmail.com>
 <20161026134910.5eae6731@taliesin-3.local>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Thu, 27 Oct 2016 01:54:02 +0500
Message-ID: <CAFC8oaeX5CUVgV_A8hTAGQ7QuWabdw7Zz1geJpB4V_=RWQ3fBg@mail.gmail.com>
Subject: Re: MLS issue
To: Harry Waddell <waddell@caravan-epub.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Simon Sekidde <ssekidde@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=94eb2c0482b03e5f84053fcad3bc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c0482b03e5f84053fcad3bc
Content-Type: text/plain; charset=UTF-8

i'm using centos server and i'm logging on system locally there is no ssh
and another thing i have checked files are labelled with unlabelled_t, and
i have installed mlc policy i have checked the logs in audit.log file

type=AVC msg=audit(1477481078.990:79): avc:  denied  { read } for  pid=1039
comm="audispd" name="ld.so.cache" dev="dm-0" ino=67387328
scontext=system_u:system_r:audisp_t:s15:c0.c1023
tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=file

these kinds of logs are generated

On Thu, Oct 27, 2016 at 1:49 AM, Harry Waddell <waddell@caravan-epub.com>
wrote:

>
> Again, you're being far too vague. Can you login in text mode as root
> on the system console? Or are you trying to login to a desktop with a
> window
> manage, e.g. via xdm? These are completely different things.
>
> 1. Make sure you have the current and correct rpms installed, e.g. the mls
> policy.
>
> 2. Relabel everything again and make sure it completes without errors.
>
> 3. If you still can't login in text mode as root from the console, look at
> the
> specific causes listed in the auditd log. If you haven't already done so,
> I would suggest you become good friends with audit2allow, etc...
>
> HW
>
>
> On Thu, 27 Oct 2016 01:32:36 +0500
> Kashif ali <kashif.ali.9498@gmail.com> wrote:
>
> > i am logging on local machine directly and if i put msl in permissive
> mode
> > it will just generate logs for the policy violation which is expected in
> > permissive but if i am unable to use mls in enforcing mode then it is
> quit
> > wrong behavior
> >
> > On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell <waddell@caravan-epub.com
> >
> > wrote:
> >
> > > On Wed, 26 Oct 2016 10:17:27 -0400
> > > Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >
> > > > On 10/26/2016 03:47 AM, Kashif ali wrote:
> > > > > Hi
> > > > >    Hope you're fine i know your busy but i need your little time
> if you
> > > > > can manage that will be great for me.
> > > > > i'm facing an issue in MLS Policy of Selinux when i relabel the
> system
> > > > > and reboot it it won't allow me to login(i'm signing in my machine
> ) i
> > > > > used these commands
> > > > >  * set the selinux to enforcing
> > > > >  * touch ./autorelabel for relabeling the system
> > > > >  * and then reboot the system and it won't allow me to login
> > > > >
> > > > > Kindly help in this problem because i'm stuck in it for a while
> and it
> > > > > will be very greatful. Thanks
> > > >
> > > > Generally it is a good idea to first bring up the system in
> permissive
> > > > when switching to MLS, and check that there are no residual denials
> or
> > > > other SELinux errors that need to be addressed before putting it into
> > > > enforcing mode.  We would need to see the actual error messages to
> help
> > > > debug further.  And it would help to specify your specific
> distribution
> > > > and version.
> > > >
> > >
> > > Agreed. At this point, I think the only recourse for Kashif is to
> > > boot the system into rescue mode, e.g. using the install dvd,
> > > mount the filesystem, and edit the /etc/sysconfig/selinux file to
> > > change enforcing to permissive.
> > >
> > > Saying "it won't allow me to login" is too vague. Is "me" root?
> > > Is login from the console of via ssh? It could be that a boolean
> > > needs to be changed, but that's just speculation at this point.
> > > Once it's in permissive mode, hopefully the problem will be somewhat
> > > obvious.
> > >
> > >
> > >
> > >
> > >
>

--94eb2c0482b03e5f84053fcad3bc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i&#39;m using centos server and i&#39;m logging on system =
locally there is no ssh and another thing i have checked files are labelled=
 with unlabelled_t, and i have installed mlc policy i have checked the logs=
 in audit.log file<div><br>type=3DAVC msg=3Daudit(1477481078.990:79): avc: =
=C2=A0denied =C2=A0{ read } for =C2=A0pid=3D1039 comm=3D&quot;audispd&quot;=
 name=3D&quot;ld.so.cache&quot; dev=3D&quot;dm-0&quot; ino=3D67387328 scont=
ext=3Dsystem_u:system_r:audisp_t:s15:c0.c1023 tcontext=3Dsystem_u:object_r:=
unlabeled_t:s15:c0.c1023 tclass=3Dfile<br><br><div>these kinds of logs are =
generated =C2=A0</div></div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, Oct 27, 2016 at 1:49 AM, Harry Waddell <span dir=
=3D"ltr">&lt;<a href=3D"mailto:waddell@caravan-epub.com" target=3D"_blank">=
waddell@caravan-epub.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><br>
Again, you&#39;re being far too vague. Can you login in text mode as root<b=
r>
on the system console? Or are you trying to login to a desktop with a windo=
w<br>
manage, e.g. via xdm? These are completely different things.<br>
<br>
1. Make sure you have the current and correct rpms installed, e.g. the mls =
policy.<br>
<br>
2. Relabel everything again and make sure it completes without errors.<br>
<br>
3. If you still can&#39;t login in text mode as root from the console, look=
 at the<br>
specific causes listed in the auditd log. If you haven&#39;t already done s=
o,<br>
I would suggest you become good friends with audit2allow, etc...<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
HW<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
On Thu, 27 Oct 2016 01:32:36 +0500<br>
Kashif ali &lt;<a href=3D"mailto:kashif.ali.9498@gmail.com">kashif.ali.9498=
@gmail.com</a>&gt; wrote:<br>
<br>
&gt; i am logging on local machine directly and if i put msl in permissive =
mode<br>
&gt; it will just generate logs for the policy violation which is expected =
in<br>
&gt; permissive but if i am unable to use mls in enforcing mode then it is =
quit<br>
&gt; wrong behavior<br>
&gt;<br>
&gt; On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell &lt;<a href=3D"mailto:w=
addell@caravan-epub.com">waddell@caravan-epub.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
&gt; &gt; On Wed, 26 Oct 2016 10:17:27 -0400<br>
&gt; &gt; Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tych=
o.nsa.gov</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; On 10/26/2016 03:47 AM, Kashif ali wrote:<br>
&gt; &gt; &gt; &gt; Hi<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 Hope you&#39;re fine i know your busy but =
i need your little time if you<br>
&gt; &gt; &gt; &gt; can manage that will be great for me.<br>
&gt; &gt; &gt; &gt; i&#39;m facing an issue in MLS Policy of Selinux when i=
 relabel the system<br>
&gt; &gt; &gt; &gt; and reboot it it won&#39;t allow me to login(i&#39;m si=
gning in my machine ) i<br>
&gt; &gt; &gt; &gt; used these commands<br>
&gt; &gt; &gt; &gt;=C2=A0 * set the selinux to enforcing<br>
&gt; &gt; &gt; &gt;=C2=A0 * touch ./autorelabel for relabeling the system<b=
r>
&gt; &gt; &gt; &gt;=C2=A0 * and then reboot the system and it won&#39;t all=
ow me to login<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Kindly help in this problem because i&#39;m stuck in it=
 for a while and it<br>
&gt; &gt; &gt; &gt; will be very greatful. Thanks<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Generally it is a good idea to first bring up the system in =
permissive<br>
&gt; &gt; &gt; when switching to MLS, and check that there are no residual =
denials or<br>
&gt; &gt; &gt; other SELinux errors that need to be addressed before puttin=
g it into<br>
&gt; &gt; &gt; enforcing mode.=C2=A0 We would need to see the actual error =
messages to help<br>
&gt; &gt; &gt; debug further.=C2=A0 And it would help to specify your speci=
fic distribution<br>
&gt; &gt; &gt; and version.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Agreed. At this point, I think the only recourse for Kashif is to=
<br>
&gt; &gt; boot the system into rescue mode, e.g. using the install dvd,<br>
&gt; &gt; mount the filesystem, and edit the /etc/sysconfig/selinux file to=
<br>
&gt; &gt; change enforcing to permissive.<br>
&gt; &gt;<br>
&gt; &gt; Saying &quot;it won&#39;t allow me to login&quot; is too vague. I=
s &quot;me&quot; root?<br>
&gt; &gt; Is login from the console of via ssh? It could be that a boolean<=
br>
&gt; &gt; needs to be changed, but that&#39;s just speculation at this poin=
t.<br>
&gt; &gt; Once it&#39;s in permissive mode, hopefully the problem will be s=
omewhat<br>
&gt; &gt; obvious.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
</div></div></blockquote></div><br></div>

--94eb2c0482b03e5f84053fcad3bc--
