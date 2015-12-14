MIME-Version: 1.0
In-Reply-To: <566F3E8D.3060604@tycho.nsa.gov>
References: <566B17FB.6010405@android.com>
 <CAHC9VhRuVg_gwJbz_NA5ftUHT9gzFR8sx3AXmQkZViXwnq3Sow@mail.gmail.com>
 <566B4ACE.3040301@tycho.nsa.gov> <1834864.RYHtAVZZNX@sifl>
 <566F016B.90002@schaufler-ca.com>
 <476DC76E7D1DF2438D32BFADF679FC56011AD188@ORSMSX103.amr.corp.intel.com>
 <566F3E8D.3060604@tycho.nsa.gov>
Date: Mon, 14 Dec 2015 14:52:50 -0800
Message-ID: <CAFftDdqxHxaeuastZTtTL0dZOmyky+i2=Ci-tZNHAc40QuQung@mail.gmail.com>
Subject: Re: Exposing secid to secctx mapping to user-space
From: William Roberts <bill.c.roberts@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Roberts, William C" <william.c.roberts@intel.com>,
 Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "arve@google.com" <arve@google.com>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 James Morris <james.l.morris@oracle.com>
Content-Type: multipart/alternative; boundary=001a1140a73a57845b0526e38867
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140a73a57845b0526e38867
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 14, 2015 at 2:11 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 12/14/2015 04:29 PM, Roberts, William C wrote:
>
>> <snip>
>>
>>> Subject: Re: Exposing secid to secctx mapping to user-space
>>>
>>> On 12/13/2015 2:06 PM, Paul Moore wrote:
>>>
>>>> On Friday, December 11, 2015 05:14:38 PM Stephen Smalley wrote:
>>>>
>>>>> Perhaps we could provide a new fixed-size tokenized version of the
>>>>> security context string for export to userspace that could be
>>>>> embedded in the binder transaction structure?  This could avoid both
>>>>> the limitations of the current secid (e.g. limited to 32 bits, no
>>>>> stackability) and the overhead of copying context strings on every IPC.
>>>>>
>>>> On Friday, December 11, 2015 04:24:48 PM Casey Schaufler wrote:
>>>>
>>>>> How about this: Provide an alias mechanism for secctx. There would
>>>>> then be a secid (32bits) a secctx (arbitrary text string) and a
>>>>> secalias which could be a limited string of some length. You could
>>>>> use the alias in place of the secctx anywhere you liked.
>>>>>
>>>> My initial reaction to the secalias idea isn't overly positive.  It
>>>> seems like a kludge with a lot of duplication, both in terms of code
>>>> and concept, and a lot of risk for confusion both by users and policy
>>>> writers.  I think if we really wanted to limit the security label
>>>> string format to a small size we should have done that from the start,
>>>> it's too
>>>>
>>> late now.
>>>
>>> The alias would be a user space controlled mapping. The kernel code
>>> would only
>>> be involved at the border. I would never expect policy to be written
>>> using aliases.
>>> As for being a kludge, yeah, there's some of that, but I think that's
>>> true with the
>>> secid, too.
>>>
>>> Assuming we see some binder performance numbers, and the numbers are
>>>> bad, I'm a little more open to doing something with the secid token.
>>>> Up to this point we haven't made any guarantees about the token and we
>>>> haven't exported it outside the kernel so there is some ability to
>>>> change it to fit
>>>>
>>> our needs.
>>>
>>>> Granted, this isn't perfect solution either, and perhaps ultimately we
>>>> would need something else, but I think it is worth looking into this
>>>> first before we introduce another string label.
>>>>
>>>
>>> I agree with getting numbers before someone dashes off to make a
>>> premature
>>> optimization that exposes secids. If the numbers are bad I would hope
>>> that the
>>> developers would look at fixing binder rather than exposing (and forever
>>> requiring) secids.
>>>
>>>
>> If I understand correctly, the goal here is to avoid the lookup from pid
>> to context. If we somehow
>> Had the context or a token to a context during the ipc transaction to
>> userspace, we could just use that
>> In computing the access decision. If that is correct, then since we have
>> PID, why not just extend the
>> SE Linux compute av decision interface to support passing of PID and then
>> it can do the lookup in the
>> Kernel?
>>
>
> That's no less racy than getpidcon().


True, but in this case the binder transaction would be dead...

Why not just copy ctx?

grep -rn '^type ' * | grep domain | cut -d' ' -f 2-2 | sed s/','//g | awk '
{  thislen=length($0); printf("%-5s %dn", NR, thislen); totlen+=thislen}

END { printf("average: %dn", totlen/NR); } '

The avg type length for domain types in external/sepolicy is 7. Add the
full ctx:

u:r:xxxxxxx:s0(cat)

1. Were looking at like 18 or so bytes, how do we know this wont be "fast
enough"?
2. Whats the current perf numbers, and whats agreed upon on what you need
to hit to be fast enough?
3. Im assuming the use case is in service manager, but would a userspace
cache of AVD's help? Then you can (possibly) avoid both kernel trips, and
you can invalidate the cache on policy reload and on PID deaths? In the
case of service manager would it always be a miss based on usage patern? Im
assuming things would say hey resolve this once, and be done. However, you
could only do the ctx lookup and do the avd based on the policy in user
space, thus avoiding 1 of two trips.




>
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

--001a1140a73a57845b0526e38867
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, Dec 14, 2015 at 2:11 PM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);bo=
rder-left-style:solid;padding-left:1ex"><div class=3D""><div class=3D"h5">O=
n 12/14/2015 04:29 PM, Roberts, William C wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
&lt;snip&gt;<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Subject: Re: Exposing secid to secctx mapping to user-space<br>
<br>
On 12/13/2015 2:06 PM, Paul Moore wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
On Friday, December 11, 2015 05:14:38 PM Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Perhaps we could provide a new fixed-size tokenized version of the<br>
security context string for export to userspace that could be<br>
embedded in the binder transaction structure?=C2=A0 This could avoid both<b=
r>
the limitations of the current secid (e.g. limited to 32 bits, no<br>
stackability) and the overhead of copying context strings on every IPC.<br>
</blockquote>
On Friday, December 11, 2015 04:24:48 PM Casey Schaufler wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
How about this: Provide an alias mechanism for secctx. There would<br>
then be a secid (32bits) a secctx (arbitrary text string) and a<br>
secalias which could be a limited string of some length. You could<br>
use the alias in place of the secctx anywhere you liked.<br>
</blockquote>
My initial reaction to the secalias idea isn&#39;t overly positive.=C2=A0 I=
t<br>
seems like a kludge with a lot of duplication, both in terms of code<br>
and concept, and a lot of risk for confusion both by users and policy<br>
writers.=C2=A0 I think if we really wanted to limit the security label<br>
string format to a small size we should have done that from the start, it&#=
39;s too<br>
</blockquote>
late now.<br>
<br>
The alias would be a user space controlled mapping. The kernel code would o=
nly<br>
be involved at the border. I would never expect policy to be written using =
aliases.<br>
As for being a kludge, yeah, there&#39;s some of that, but I think that&#39=
;s true with the<br>
secid, too.<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Assuming we see some binder performance numbers, and the numbers are<br>
bad, I&#39;m a little more open to doing something with the secid token.<br=
>
Up to this point we haven&#39;t made any guarantees about the token and we<=
br>
haven&#39;t exported it outside the kernel so there is some ability to chan=
ge it to fit<br>
</blockquote>
our needs.<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
Granted, this isn&#39;t perfect solution either, and perhaps ultimately we<=
br>
would need something else, but I think it is worth looking into this<br>
first before we introduce another string label.<br>
</blockquote>
<br>
I agree with getting numbers before someone dashes off to make a premature<=
br>
optimization that exposes secids. If the numbers are bad I would hope that =
the<br>
developers would look at fixing binder rather than exposing (and forever<br=
>
requiring) secids.<br>
<br>
</blockquote>
<br>
If I understand correctly, the goal here is to avoid the lookup from pid to=
 context. If we somehow<br>
Had the context or a token to a context during the ipc transaction to users=
pace, we could just use that<br>
In computing the access decision. If that is correct, then since we have PI=
D, why not just extend the<br>
SE Linux compute av decision interface to support passing of PID and then i=
t can do the lookup in the<br>
Kernel?<br>
</blockquote>
<br></div></div>
That&#39;s no less racy than getpidcon().</blockquote><div><br></div><div>T=
rue, but in this case the binder transaction would be dead...</div><div><br=
></div><div>Why not just copy ctx?</div><div><br></div><div><div>grep -rn &=
#39;^type &#39; * | grep domain | cut -d&#39; &#39; -f 2-2 | sed s/&#39;,&#=
39;//g | awk &#39; { =C2=A0thislen=3Dlength($0); printf(&quot;%-5s %dn&quot=
;, NR, thislen); totlen+=3Dthislen} =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0</div><div>END { printf(&quot;average: %dn&quot;, totlen=
/NR); } &#39;</div></div><div><br></div><div>The avg type length for domain=
 types in external/sepolicy is 7. Add the full ctx:</div><div><br></div><di=
v>u:r:xxxxxxx:s0(cat)</div><div><br></div><div>1. Were looking at like 18 o=
r so bytes, how do we know this wont be &quot;fast enough&quot;?</div><div>=
2. Whats the current perf numbers, and whats agreed upon on what you need t=
o hit to be fast enough?</div><div>3. Im assuming the use case is in servic=
e manager, but would a userspace cache of AVD&#39;s help? Then you can (pos=
sibly) avoid both kernel trips, and you can invalidate the cache on policy =
reload and on PID deaths? In the case of service manager would it always be=
 a miss based on usage patern? Im assuming things would say hey resolve thi=
s once, and be done. However, you could only do the ctx lookup and do the a=
vd based on the policy in user space, thus avoiding 1 of two trips.</div><d=
iv><br></div><div><br></div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div class=3D""=
><div class=3D"h5"><br>
<br>
_______________________________________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature">Respectfully,<br><br>William C Roberts<br><b=
r></div>
</div></div>

--001a1140a73a57845b0526e38867--
