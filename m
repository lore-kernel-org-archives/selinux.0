MIME-Version: 1.0
In-Reply-To: <1684020.b5Ioztp7mc@sifl>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
Date: Wed, 20 May 2015 17:39:38 -0700
Message-ID: <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: William Roberts <bill.c.roberts@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=047d7b86de864cabb005168cc78c
Cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, james.l.morris@oracle.com
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b86de864cabb005168cc78c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 1:04 PM, Paul Moore <paul@paul-moore.com> wrote:

> First off, my apologies for such a long delay in providing feedback.  The
> delay wasn't due to any fault of yours, rather just a backlog on my todo
> list.
>
> Comments below ...
>
> On Thursday, April 09, 2015 02:48:50 PM Jeff Vander Stoep wrote:
> > ---- motivation ----
> > Ioctls provide many of the operations necessary for device control. The
> > typical driver supports a device specific set of operations accessible =
by
> > the ioctl system call and specified by the command argument. SELinux
> > provides per operation access control to many system operations e.g.
> chown,
> > kill, setuid, ipc_lock, etc. Ioclts on the other hand are granted on a
> per
> > file descriptor basis using the ioctl permission, meaning that the set =
of
> > operations provided by the driver are granted on an all-or-nothing basi=
s.
>
> ...
>
> > ---- Design constraints ----
> > Policy: Support existing policy, targeted whitelisting. The ioctls
> commands
> > used on a system may not be completely known to a sysadmin/policywriter=
.
> It
> > is not reasonable to enforce that all needed commands be known in order
> to
> > use this feature in a targeted manner. Existing policy using the ioctl
> > permission will continue to work as-is. Policy targeting a specific
> > source/target/class will only be enforced on that particular
> > source/target/class. E.g. continue to allow init to access all ioctls
> > provided by a driver, but only allow the browser to access a subset.
> >
> > Performance: Many ioctl calls are performance sensitive, and some ioctl=
s
> > have a large command set (e.g. sockets support hundreds of commands).
> > Execution time on a filtered ioctl should be similar to execution time =
on
> > an unfiltered one and not related to the number of commands being
> filtered.
> > Performance numbers will be included in a separate document.
> >
> > Command space: The ioctl command is a 32 bit number comprised of four
> > fields, number - sequence number of the command. 8 bits
> > type - magic number assigned to the driver. 8 bits
> > size - size of the user data involved. typically 14 bits (arch dependen=
t)
> > direction - The direction of data transfer. typically 2 bits (arch
> > dependent) The command is uniquely identified by the type and number,
> size
> > and direction are considered to be arguments and are not considered for
> > SELinux whitelisting.
> >
> > ---- Policy format ----
> > allow <source> <target>:<class> { 0x8910-0x8926 0x892A-0x8935 }
> > auditallow <source> <target>:<class> 0x892A
>
> I agree with only specifying the lower 16 bits (command,type) when
> specifying
> the individual ioctls, I even like the '-' shortcut, but I'm a little
> concerned about specifying a number directly in the permission field
> without
> any sort of qualifier.  Specifically I'm worried that it hurts the
> readability
> of the policy and could pose problems with future work.
>
> I'd be much happier if we could add some sort of syntax which would quali=
fy
> the numbers as ioctls, for example:
>
>   allow <source> <target>:<class> { ioctl(0x8910-0x8926) ioctl(0x892A) }
>
>
If you want additional syntax couldn't we move that burden to m4 rather
then making it a part of the compiler core?


> The above is just an example, if you have a better idea for the syntax I'=
m
> open to suggestions.
>
> > ---- Architecture ----
> > policy: Ioctl operations include allow, auditallow and dontaudit
> > permissions.
> >
> > binary policy/avtab: Like AVC permissions, ioctl operations permissions
> are
> > represented by set/cleared bits. Each ioctl operation avtab entry
> represents
> > a single ioctl command type (using =E2=80=9Ctype=E2=80=9D as defined ab=
ove in the
> =E2=80=9Ccommand
> > space=E2=80=9D section) and includes permissions for the 256 operations=
 within
> that
> > type ...
>
> I like the work you did expanding the policy/AVC, especially since it is
> rather generic.  Sure, there are some ioctl specific quirks, e.g. the
> type/number handling, but in general, the "operations" concept could be
> used
> for any number of things where the existing 32 choices are too limiting.
> The
> netfilter command handling is one such example.
>
> While what you've submitted here is just fine for ioctl handling, I'd lik=
e
> to
> see us tweak things a bit, and move around some of the ioctl specific
> quirks,
> so that we can leverage some of the underlying avtab and avc code for
> future
> expansion (if/when we get there).
>
> The unfortunate side effect of doing your job too well is that I ask you
> to do
> more ;)
>
> > AVC: A pointer to an operations structure has been added to the avc_nod=
e
> > such that general avc_lookup also returns the allowed ioctl operations.
>
> More on this when I send my comments on the patches themselves, but I fou=
nd
> the term "operations" a bit ... misleading?  Overly generic?  Odd
> considering
> my desire to make this more generic, I know.
>
> How about "extops" or something similar?  I would much prefer struct/type
> names and function names that help indicate that it relates to the extend=
ed
> permissions/operations and not the original 32 permissions; "operations"
> doesn't in my mind, but "extops" or something similar helps.  Once again,
> if
> you have a better idea I'm open to suggestions.
>
> Nitpicky, I know ...
>
> > The structure flags the ioctl types that are allowed and only looks up
> the
> > permissions within that type from the avtab when they are first used.
> After
> > the initial lookup of a type it is added to a list of types that are
> > allowed for the source/target/class being retrieved.
>
> More on this in the individual patch comments.  I have no argument with
> your
> logic from an ioctl perspective, I'd just like to see some slight changes
> so
> we can recycle your work later.
>
> --
> paul moore
> www.paul-moore.com
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.




--=20
Respectfully,

William C Roberts

--047d7b86de864cabb005168cc78c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, May 20, 2015 at 1:04 PM, Paul Moore <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">First off, my apologie=
s for such a long delay in providing feedback.=C2=A0 The<br>
delay wasn&#39;t due to any fault of yours, rather just a backlog on my tod=
o list.<br>
<br>
Comments below ...<br>
<br>
On Thursday, April 09, 2015 02:48:50 PM Jeff Vander Stoep wrote:<br>
&gt; ---- motivation ----<br>
&gt; Ioctls provide many of the operations necessary for device control. Th=
e<br>
&gt; typical driver supports a device specific set of operations accessible=
 by<br>
&gt; the ioctl system call and specified by the command argument. SELinux<b=
r>
&gt; provides per operation access control to many system operations e.g. c=
hown,<br>
&gt; kill, setuid, ipc_lock, etc. Ioclts on the other hand are granted on a=
 per<br>
&gt; file descriptor basis using the ioctl permission, meaning that the set=
 of<br>
&gt; operations provided by the driver are granted on an all-or-nothing bas=
is.<br>
<br>
...<br>
<br>
&gt; ---- Design constraints ----<br>
&gt; Policy: Support existing policy, targeted whitelisting. The ioctls com=
mands<br>
&gt; used on a system may not be completely known to a sysadmin/policywrite=
r. It<br>
&gt; is not reasonable to enforce that all needed commands be known in orde=
r to<br>
&gt; use this feature in a targeted manner. Existing policy using the ioctl=
<br>
&gt; permission will continue to work as-is. Policy targeting a specific<br=
>
&gt; source/target/class will only be enforced on that particular<br>
&gt; source/target/class. E.g. continue to allow init to access all ioctls<=
br>
&gt; provided by a driver, but only allow the browser to access a subset.<b=
r>
&gt;<br>
&gt; Performance: Many ioctl calls are performance sensitive, and some ioct=
ls<br>
&gt; have a large command set (e.g. sockets support hundreds of commands).<=
br>
&gt; Execution time on a filtered ioctl should be similar to execution time=
 on<br>
&gt; an unfiltered one and not related to the number of commands being filt=
ered.<br>
&gt; Performance numbers will be included in a separate document.<br>
&gt;<br>
&gt; Command space: The ioctl command is a 32 bit number comprised of four<=
br>
&gt; fields, number - sequence number of the command. 8 bits<br>
&gt; type - magic number assigned to the driver. 8 bits<br>
&gt; size - size of the user data involved. typically 14 bits (arch depende=
nt)<br>
&gt; direction - The direction of data transfer. typically 2 bits (arch<br>
&gt; dependent) The command is uniquely identified by the type and number, =
size<br>
&gt; and direction are considered to be arguments and are not considered fo=
r<br>
&gt; SELinux whitelisting.<br>
&gt;<br>
&gt; ---- Policy format ----<br>
&gt; allow &lt;source&gt; &lt;target&gt;:&lt;class&gt; { 0x8910-0x8926 0x89=
2A-0x8935 }<br>
&gt; auditallow &lt;source&gt; &lt;target&gt;:&lt;class&gt; 0x892A<br>
<br>
I agree with only specifying the lower 16 bits (command,type) when specifyi=
ng<br>
the individual ioctls, I even like the &#39;-&#39; shortcut, but I&#39;m a =
little<br>
concerned about specifying a number directly in the permission field withou=
t<br>
any sort of qualifier.=C2=A0 Specifically I&#39;m worried that it hurts the=
 readability<br>
of the policy and could pose problems with future work.<br>
<br>
I&#39;d be much happier if we could add some sort of syntax which would qua=
lify<br>
the numbers as ioctls, for example:<br>
<br>
=C2=A0 allow &lt;source&gt; &lt;target&gt;:&lt;class&gt; { ioctl(0x8910-0x8=
926) ioctl(0x892A) }<br>
<br></blockquote><div><br></div><div>If you want additional syntax couldn&#=
39;t we move that burden to m4 rather then making it a part of the compiler=
 core?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The above is just an example, if you have a better idea for the syntax I&#3=
9;m<br>
open to suggestions.<br>
<br>
&gt; ---- Architecture ----<br>
&gt; policy: Ioctl operations include allow, auditallow and dontaudit<br>
&gt; permissions.<br>
&gt;<br>
&gt; binary policy/avtab: Like AVC permissions, ioctl operations permission=
s are<br>
&gt; represented by set/cleared bits. Each ioctl operation avtab entry repr=
esents<br>
&gt; a single ioctl command type (using =E2=80=9Ctype=E2=80=9D as defined a=
bove in the =E2=80=9Ccommand<br>
&gt; space=E2=80=9D section) and includes permissions for the 256 operation=
s within that<br>
&gt; type ...<br>
<br>
I like the work you did expanding the policy/AVC, especially since it is<br=
>
rather generic.=C2=A0 Sure, there are some ioctl specific quirks, e.g. the<=
br>
type/number handling, but in general, the &quot;operations&quot; concept co=
uld be used<br>
for any number of things where the existing 32 choices are too limiting.=C2=
=A0 The<br>
netfilter command handling is one such example.<br>
<br>
While what you&#39;ve submitted here is just fine for ioctl handling, I&#39=
;d like to<br>
see us tweak things a bit, and move around some of the ioctl specific quirk=
s,<br>
so that we can leverage some of the underlying avtab and avc code for futur=
e<br>
expansion (if/when we get there).<br>
<br>
The unfortunate side effect of doing your job too well is that I ask you to=
 do<br>
more ;)<br>
<br>
&gt; AVC: A pointer to an operations structure has been added to the avc_no=
de<br>
&gt; such that general avc_lookup also returns the allowed ioctl operations=
.<br>
<br>
More on this when I send my comments on the patches themselves, but I found=
<br>
the term &quot;operations&quot; a bit ... misleading?=C2=A0 Overly generic?=
=C2=A0 Odd considering<br>
my desire to make this more generic, I know.<br>
<br>
How about &quot;extops&quot; or something similar?=C2=A0 I would much prefe=
r struct/type<br>
names and function names that help indicate that it relates to the extended=
<br>
permissions/operations and not the original 32 permissions; &quot;operation=
s&quot;<br>
doesn&#39;t in my mind, but &quot;extops&quot; or something similar helps.=
=C2=A0 Once again, if<br>
you have a better idea I&#39;m open to suggestions.<br>
<br>
Nitpicky, I know ...<br>
<br>
&gt; The structure flags the ioctl types that are allowed and only looks up=
 the<br>
&gt; permissions within that type from the avtab when they are first used. =
After<br>
&gt; the initial lookup of a type it is added to a list of types that are<b=
r>
&gt; allowed for the source/target/class being retrieved.<br>
<br>
More on this in the individual patch comments.=C2=A0 I have no argument wit=
h your<br>
logic from an ioctl perspective, I&#39;d just like to see some slight chang=
es so<br>
we can recycle your work later.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
paul moore<br>
<a href=3D"http://www.paul-moore.com" target=3D"_blank">www.paul-moore.com<=
/a><br>
<br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.</font></=
span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cl=
ass=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><br></div=
>
</div></div>

--047d7b86de864cabb005168cc78c--
