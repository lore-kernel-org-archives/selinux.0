MIME-Version: 1.0
In-Reply-To: <20161026132751.36e45a7d@taliesin-3.local>
References: <CAFC8oacRU0fR=0Ynib0Bsdq21MGCgjwttAMXNrmjf9y9pVWE2A@mail.gmail.com>
 <3fb854c4-fdf4-2bbf-8956-c713a17760b8@tycho.nsa.gov>
 <20161026132751.36e45a7d@taliesin-3.local>
From: Kashif ali <kashif.ali.9498@gmail.com>
Date: Thu, 27 Oct 2016 01:32:36 +0500
Message-ID: <CAFC8oaeW27J9f4VJTHoCkCS+cD=jb5XA39G46xZBXLOQ74_iYA@mail.gmail.com>
Subject: Re: MLS issue
To: Harry Waddell <waddell@caravan-epub.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Simon Sekidde <ssekidde@redhat.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113724168b5b15053fca86b8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113724168b5b15053fca86b8
Content-Type: text/plain; charset=UTF-8

i am logging on local machine directly and if i put msl in permissive mode
it will just generate logs for the policy violation which is expected in
permissive but if i am unable to use mls in enforcing mode then it is quit
wrong behavior

On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell <waddell@caravan-epub.com>
wrote:

> On Wed, 26 Oct 2016 10:17:27 -0400
> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> > On 10/26/2016 03:47 AM, Kashif ali wrote:
> > > Hi
> > >    Hope you're fine i know your busy but i need your little time if you
> > > can manage that will be great for me.
> > > i'm facing an issue in MLS Policy of Selinux when i relabel the system
> > > and reboot it it won't allow me to login(i'm signing in my machine ) i
> > > used these commands
> > >  * set the selinux to enforcing
> > >  * touch ./autorelabel for relabeling the system
> > >  * and then reboot the system and it won't allow me to login
> > >
> > > Kindly help in this problem because i'm stuck in it for a while and it
> > > will be very greatful. Thanks
> >
> > Generally it is a good idea to first bring up the system in permissive
> > when switching to MLS, and check that there are no residual denials or
> > other SELinux errors that need to be addressed before putting it into
> > enforcing mode.  We would need to see the actual error messages to help
> > debug further.  And it would help to specify your specific distribution
> > and version.
> >
>
> Agreed. At this point, I think the only recourse for Kashif is to
> boot the system into rescue mode, e.g. using the install dvd,
> mount the filesystem, and edit the /etc/sysconfig/selinux file to
> change enforcing to permissive.
>
> Saying "it won't allow me to login" is too vague. Is "me" root?
> Is login from the console of via ssh? It could be that a boolean
> needs to be changed, but that's just speculation at this point.
> Once it's in permissive mode, hopefully the problem will be somewhat
> obvious.
>
>
>
>
>

--001a113724168b5b15053fca86b8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">i am logging on local machine directly and if i put msl in=
 permissive mode it will just generate logs for the policy violation which =
is expected in permissive but if i am unable to use mls in enforcing mode t=
hen it is quit wrong behavior =C2=A0</div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">On Thu, Oct 27, 2016 at 1:27 AM, Harry Waddell <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:waddell@caravan-epub.com" target=3D"_b=
lank">waddell@caravan-epub.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On Wed, 26 Oct 2016 1=
0:17:27 -0400<br>
Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov<=
/a>&gt; wrote:<br>
<br>
&gt; On 10/26/2016 03:47 AM, Kashif ali wrote:<br>
&gt; &gt; Hi<br>
&gt; &gt;=C2=A0 =C2=A0 Hope you&#39;re fine i know your busy but i need you=
r little time if you<br>
&gt; &gt; can manage that will be great for me.<br>
&gt; &gt; i&#39;m facing an issue in MLS Policy of Selinux when i relabel t=
he system<br>
&gt; &gt; and reboot it it won&#39;t allow me to login(i&#39;m signing in m=
y machine ) i<br>
&gt; &gt; used these commands<br>
&gt; &gt;=C2=A0 * set the selinux to enforcing<br>
&gt; &gt;=C2=A0 * touch ./autorelabel for relabeling the system<br>
&gt; &gt;=C2=A0 * and then reboot the system and it won&#39;t allow me to l=
ogin<br>
&gt; &gt;<br>
&gt; &gt; Kindly help in this problem because i&#39;m stuck in it for a whi=
le and it<br>
&gt; &gt; will be very greatful. Thanks<br>
&gt;<br>
&gt; Generally it is a good idea to first bring up the system in permissive=
<br>
&gt; when switching to MLS, and check that there are no residual denials or=
<br>
&gt; other SELinux errors that need to be addressed before putting it into<=
br>
&gt; enforcing mode.=C2=A0 We would need to see the actual error messages t=
o help<br>
&gt; debug further.=C2=A0 And it would help to specify your specific distri=
bution<br>
&gt; and version.<br>
&gt;<br>
<br>
</div></div>Agreed. At this point, I think the only recourse for Kashif is =
to<br>
boot the system into rescue mode, e.g. using the install dvd,<br>
mount the filesystem, and edit the /etc/sysconfig/selinux file to<br>
change enforcing to permissive.<br>
<br>
Saying &quot;it won&#39;t allow me to login&quot; is too vague. Is &quot;me=
&quot; root?<br>
Is login from the console of via ssh? It could be that a boolean<br>
needs to be changed, but that&#39;s just speculation at this point.<br>
Once it&#39;s in permissive mode, hopefully the problem will be somewhat ob=
vious.<br>
<br>
<br>
<br>
<br>
</blockquote></div><br></div>

--001a113724168b5b15053fca86b8--
