MIME-Version: 1.0
In-Reply-To: <56707EF9.4070709@android.com>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC56011AD1EC@ORSMSX103.amr.corp.intel.com>
 <56702B25.9010205@tycho.nsa.gov> <56707EF9.4070709@android.com>
Date: Tue, 15 Dec 2015 14:41:50 -0800
Message-ID: <CAFftDdpDbasCGxPrydvOz-3y9_MQbeZJR3+5z5H+2g__5LN+Uw@mail.gmail.com>
Subject: Re: Exposing secid to secctx mapping to user-space
From: William Roberts <bill.c.roberts@gmail.com>
To: Daniel Cashman <dcashman@android.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "Roberts, William C" <william.c.roberts@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "arve@google.com" <arve@google.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>
Content-Type: multipart/alternative; boundary=001a1140a73ad893f60526f77ede
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140a73ad893f60526f77ede
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 15, 2015 at 12:58 PM, Daniel Cashman <dcashman@android.com>
wrote:

> On 12/15/2015 07:00 AM, Stephen Smalley wrote:
> > On 12/14/2015 05:57 PM, Roberts, William C wrote:
> >> <snip>
> >>>>
> >>>> If I understand correctly, the goal here is to avoid the lookup from
> >>>> pid to context. If we somehow Had the context or a token to a context
> >>>> during the ipc transaction to userspace, we could just use that In
> >>>> computing the access decision. If that is correct, then since we have
> >>>> PID, why not just extend the SE Linux compute av decision interface
> >>>> to support
> >>> passing of PID and then it can do the lookup in the Kernel?
> >>>
> >>> That's no less racy than getpidcon().
> >>>
> >>
> >> I got a bounce from when I sent this from gmail, resending.
> >>
> >> True, but in this case the binder transaction would be dead...
> >>
> >> Why not just pass ctx? It's less than ideal, but it might be good
> >> enough for now until contexts get unwieldy big.
> >>
> >> grep -rn '^type ' * | grep domain | cut -d' ' -f 2-2 | sed s/','//g |
> >> awk ' {  thislen=length($0); printf("%-5s %dn", NR, thislen);
> >> totlen+=thislen}
> >> END { printf("average: %dn", totlen/NR); } '
> >>
> >> The avg type length for domain types in external/sepolicy is 7. Add
> >> the full ctx:
> >>
> >> u:r:xxxxxxx:s0(cat)
> >>
> >> 1. We're looking at like 18 or so bytes, how do we know this won't be
> >> "fast enough"?
> >> 2. What's the current perf numbers, and what's agreed upon on what you
> >> need to hit to be fast enough?
> >> 3. I'm assuming the use case is in service manager, but would a
> >> userspace cache of AVD's help? Then you can (possibly) avoid both
> >> kernel trips, and you can invalidate the cache on policy reload and on
> >> PID deaths? In the case of service manager would it always be a miss
> >> based on usage pattern? I'm assuming things would say hey resolve this
> >> once, and be done. However, you could only do the ctx lookup and do
> >> the avd based on the policy in user space, thus avoiding 1 of two trips.
> >
> > 1. I don't think it is the size of the context that is the concern but
> > rather the fact that it is a variable-length string, whereas current
> > binder commands use fixed-size arguments and encode the size in the
> > command value (common for ioctls).  Supporting passing a variable-length
> > string would be a change to the protocol and would complicate the code.
> >  On the performance side, it means generating a context string from the
> > secid and then copying it to userspace on each IPC (versus just getting
> > the secid and putting that in the existing binder_transaction_data that
> > is already copied to userspace).
>
> This is precisely the motivation for the original enquiry. Issue has
> been brought up about changing the protocol, and concern has also been
> strongly expressed about the overhead introduced by the string
> operations, although this has not been measured.  User-space would still
> need to do something intelligent with the secid, which would involve its
> own lookup and caching, but the idea is that this wouldn't be done with
> the binder lock held.
>
> > 2. Don't know; deferring to Daniel to run whatever binder IPC benchmarks
> > might exist with and without the current patch that copies the context
> > string.
>
> Yes, this needs to be done.  This issue was brought up as part of
> discussion regarding a proposed change to the binder driver to add the
> context string to each transaction.  An outcome of that discussion was,
> "before we go too far into this, let's see the reaction upstream to
> exposing the secid."  Based on the reaction here (upstream), I think
> it's my responsibility to push forward the string-based change and get
> the appropriate perf numbers so that a meaningful comparison can be made.
>
> > 3. It is for any binder-based service that wants to apply SELinux access
> > checks, which presently includes servicemanager and keystore.
> > We already have a userspace AVC (in libselinux) that gets used
> > automatically when you use selinux_check_access(), but you still need to
> > get the sender security context in some manner.
> >
>
> The issue this hopes to address is passing the secctx along with a
> binder transaction so that userspace can use it for any access
> appropriate access controls.  Specifically, at the moment, I'm hoping to
> use the receiving process's concept of which service is being invoked
> and what the transaction code represents (neither of which the binder
> driver itself has any concept) to create an SELinux object manager that
> filters service method calls.  This could be seen as a more general
> implementation of the keystore service object manager.
>

Doing this in a general fashion that is enumerable per LSM, for stacking
support,
and making it simple so others can use it. This would be great to have in
FUSE.
I've been looking on and off for awhile of adding controls to sdcardd, and
not
having getpidcon() calls would be nice. I also went down the seccid approach
initially, but moved away from it.


>
> The getpidcon() and  SO_PEERSEC type solutions are, as Stephen pointed
> out, racy such that a process could have changed its context in the
> interim, but also such that they do not address one-way binder
> transactions, in which a process could fire of a request and die before
> it gets processed.  This isn't an issue for the servicemanager's current
> object manager, but could be an issue for other services.
>

Yes the pid is racy, but for things like binder or fuse, the peer would be
dead, however
could be an issue for others (as you mentioned).

It would be interesting if you could register your service into the kernel
portion of binder with
a context, then the look up and enforcement would be soley in the kernel,
but isn't this ala
kdbus (I am so ignorant to kdbus so I might be way off)


> Thank You,
> Dan
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>



-- 
Respectfully,

William C Roberts

--001a1140a73ad893f60526f77ede
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Dec 15, 2015 at 12:58 PM, Daniel Cashman <span dir=3D"ltr">&lt;=
<a href=3D"mailto:dcashman@android.com" target=3D"_blank">dcashman@android.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"H=
OEnZb"><div class=3D"h5">On 12/15/2015 07:00 AM, Stephen Smalley wrote:<br>
&gt; On 12/14/2015 05:57 PM, Roberts, William C wrote:<br>
&gt;&gt; &lt;snip&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If I understand correctly, the goal here is to avoid the l=
ookup from<br>
&gt;&gt;&gt;&gt; pid to context. If we somehow Had the context or a token t=
o a context<br>
&gt;&gt;&gt;&gt; during the ipc transaction to userspace, we could just use=
 that In<br>
&gt;&gt;&gt;&gt; computing the access decision. If that is correct, then si=
nce we have<br>
&gt;&gt;&gt;&gt; PID, why not just extend the SE Linux compute av decision =
interface<br>
&gt;&gt;&gt;&gt; to support<br>
&gt;&gt;&gt; passing of PID and then it can do the lookup in the Kernel?<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; That&#39;s no less racy than getpidcon().<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; I got a bounce from when I sent this from gmail, resending.<br>
&gt;&gt;<br>
&gt;&gt; True, but in this case the binder transaction would be dead...<br>
&gt;&gt;<br>
&gt;&gt; Why not just pass ctx? It&#39;s less than ideal, but it might be g=
ood<br>
&gt;&gt; enough for now until contexts get unwieldy big.<br>
&gt;&gt;<br>
&gt;&gt; grep -rn &#39;^type &#39; * | grep domain | cut -d&#39; &#39; -f 2=
-2 | sed s/&#39;,&#39;//g |<br>
&gt;&gt; awk &#39; {=C2=A0 thislen=3Dlength($0); printf(&quot;%-5s %dn&quot=
;, NR, thislen);<br>
&gt;&gt; totlen+=3Dthislen}<br>
&gt;&gt; END { printf(&quot;average: %dn&quot;, totlen/NR); } &#39;<br>
&gt;&gt;<br>
&gt;&gt; The avg type length for domain types in external/sepolicy is 7. Ad=
d<br>
&gt;&gt; the full ctx:<br>
&gt;&gt;<br>
&gt;&gt; u:r:xxxxxxx:s0(cat)<br>
&gt;&gt;<br>
&gt;&gt; 1. We&#39;re looking at like 18 or so bytes, how do we know this w=
on&#39;t be<br>
&gt;&gt; &quot;fast enough&quot;?<br>
&gt;&gt; 2. What&#39;s the current perf numbers, and what&#39;s agreed upon=
 on what you<br>
&gt;&gt; need to hit to be fast enough?<br>
&gt;&gt; 3. I&#39;m assuming the use case is in service manager, but would =
a<br>
&gt;&gt; userspace cache of AVD&#39;s help? Then you can (possibly) avoid b=
oth<br>
&gt;&gt; kernel trips, and you can invalidate the cache on policy reload an=
d on<br>
&gt;&gt; PID deaths? In the case of service manager would it always be a mi=
ss<br>
&gt;&gt; based on usage pattern? I&#39;m assuming things would say hey reso=
lve this<br>
&gt;&gt; once, and be done. However, you could only do the ctx lookup and d=
o<br>
&gt;&gt; the avd based on the policy in user space, thus avoiding 1 of two =
trips.<br>
&gt;<br>
&gt; 1. I don&#39;t think it is the size of the context that is the concern=
 but<br>
&gt; rather the fact that it is a variable-length string, whereas current<b=
r>
&gt; binder commands use fixed-size arguments and encode the size in the<br=
>
&gt; command value (common for ioctls).=C2=A0 Supporting passing a variable=
-length<br>
&gt; string would be a change to the protocol and would complicate the code=
.<br>
&gt;=C2=A0 On the performance side, it means generating a context string fr=
om the<br>
&gt; secid and then copying it to userspace on each IPC (versus just gettin=
g<br>
&gt; the secid and putting that in the existing binder_transaction_data tha=
t<br>
&gt; is already copied to userspace).<br>
<br>
</div></div>This is precisely the motivation for the original enquiry. Issu=
e has<br>
been brought up about changing the protocol, and concern has also been<br>
strongly expressed about the overhead introduced by the string<br>
operations, although this has not been measured.=C2=A0 User-space would sti=
ll<br>
need to do something intelligent with the secid, which would involve its<br=
>
own lookup and caching, but the idea is that this wouldn&#39;t be done with=
<br>
the binder lock held.<br>
<span class=3D""><br>
&gt; 2. Don&#39;t know; deferring to Daniel to run whatever binder IPC benc=
hmarks<br>
&gt; might exist with and without the current patch that copies the context=
<br>
&gt; string.<br>
<br>
</span>Yes, this needs to be done.=C2=A0 This issue was brought up as part =
of<br>
discussion regarding a proposed change to the binder driver to add the<br>
context string to each transaction.=C2=A0 An outcome of that discussion was=
,<br>
&quot;before we go too far into this, let&#39;s see the reaction upstream t=
o<br>
exposing the secid.&quot;=C2=A0 Based on the reaction here (upstream), I th=
ink<br>
it&#39;s my responsibility to push forward the string-based change and get<=
br>
the appropriate perf numbers so that a meaningful comparison can be made.<b=
r>
<span class=3D""><br>
&gt; 3. It is for any binder-based service that wants to apply SELinux acce=
ss<br>
&gt; checks, which presently includes servicemanager and keystore.<br>
&gt; We already have a userspace AVC (in libselinux) that gets used<br>
&gt; automatically when you use selinux_check_access(), but you still need =
to<br>
&gt; get the sender security context in some manner.<br>
&gt;<br>
<br>
</span>The issue this hopes to address is passing the secctx along with a<b=
r>
binder transaction so that userspace can use it for any access<br>
appropriate access controls.=C2=A0 Specifically, at the moment, I&#39;m hop=
ing to<br>
use the receiving process&#39;s concept of which service is being invoked<b=
r>
and what the transaction code represents (neither of which the binder<br>
driver itself has any concept) to create an SELinux object manager that<br>
filters service method calls.=C2=A0 This could be seen as a more general<br=
>
implementation of the keystore service object manager.<br></blockquote><div=
><br></div><div>Doing this in a general fashion that is enumerable per LSM,=
 for stacking support,</div><div>and making it simple so others can use it.=
 This would be great to have in FUSE.</div><div>I&#39;ve been looking on an=
d off for awhile of adding controls to sdcardd, and not</div><div>having ge=
tpidcon() calls would be nice. I also went down the seccid approach</div><d=
iv>initially, but moved away from it.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
The getpidcon() and=C2=A0 SO_PEERSEC type solutions are, as Stephen pointed=
<br>
out, racy such that a process could have changed its context in the<br>
interim, but also such that they do not address one-way binder<br>
transactions, in which a process could fire of a request and die before<br>
it gets processed.=C2=A0 This isn&#39;t an issue for the servicemanager&#39=
;s current<br>
object manager, but could be an issue for other services.<br></blockquote><=
div><br></div><div>Yes the pid is racy, but for things like binder or fuse,=
 the peer would be dead, however</div><div>could be an issue for others (as=
 you mentioned).</div><div>=C2=A0</div><div>It would be interesting if you =
could register your service into the kernel portion of binder with</div><di=
v>a context, then the look up and enforcement would be soley in the kernel,=
 but isn&#39;t this ala</div><div>kdbus (I am so ignorant to kdbus so I mig=
ht be way off)</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thank You,<br>
Dan<br>
<div class=3D"HOEnZb"><div class=3D"h5">___________________________________=
____________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><b=
r></div>
</div></div>

--001a1140a73ad893f60526f77ede--
