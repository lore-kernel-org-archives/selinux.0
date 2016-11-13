MIME-Version: 1.0
In-Reply-To: <7ce6bf50-c7e4-965f-e9df-eb5a3d4249dc@ieee.org>
References: <20161107080117.24030-2-bigon@debian.org>
 <20161107095108.22306-1-bigon@debian.org>
 <21527c6a-410d-d819-2e43-a90b2d757694@tycho.nsa.gov>
 <0218ca49-6e92-33e0-cb29-4a792c1b5b7c@tycho.nsa.gov>
 <7ce6bf50-c7e4-965f-e9df-eb5a3d4249dc@ieee.org>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 13 Nov 2016 17:20:26 +0100
Message-ID: <CAJfZ7=k_gUHD1mOA449avb4-J57WM7if6g6QKa+HXAnoQOq7NA@mail.gmail.com>
Subject: Re: [Patch v2 2/2] policycoreutils: Make sepolicy work with python3
To: Chris PeBenito <pebenito@ieee.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Laurent Bigonville <bigon@debian.org>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a1140223ae6ec670541311910
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1140223ae6ec670541311910
Content-Type: text/plain; charset=UTF-8

On Fri, Nov 11, 2016 at 1:58 AM, Chris PeBenito <pebenito@ieee.org> wrote:

> On 11/08/16 10:29, Stephen Smalley wrote:
>
>> On 11/08/2016 10:21 AM, Stephen Smalley wrote:
>>
>>> On 11/07/2016 04:51 AM, Laurent Bigonville wrote:
>>>
>>>> From: Laurent Bigonville <bigon@bigon.be>
>>>>
>>>> Add python3 support for sepolicy
>>>>
>>>> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
>>>> ---
>>>>  policycoreutils/sepolicy/selinux_client.py       |  6 ++--
>>>>  policycoreutils/sepolicy/sepolicy.py             | 38
>>>> ++++++++++++------------
>>>>  policycoreutils/sepolicy/sepolicy/__init__.py    | 16 ++++++----
>>>>  policycoreutils/sepolicy/sepolicy/communicate.py |  4 +--
>>>>  policycoreutils/sepolicy/sepolicy/generate.py    | 30
>>>> +++++++++----------
>>>>  policycoreutils/sepolicy/sepolicy/interface.py   | 14 ++++++---
>>>>  policycoreutils/sepolicy/sepolicy/manpage.py     |  7 +++--
>>>>  7 files changed, 65 insertions(+), 50 deletions(-)
>>>>
>>>
>>> make test doesn't pass in policycoreutils/sepolicy, although I'm not
>>> sure that's new to this patch.  I think the manpage ones were already
>>> failing; I don't recall the network one hanging before though.  But
>>> maybe that is because I wasn't testing with setools3 fully removed
>>> before?
>>>
>>
>> Oh, I guess it is just very slow with setools4.  It did finally complete
>> sepolicy network -d and has moved on (next slow/hanging one is
>> transition -t).
>>
>
> Yes, sadly setools4 is slower.  I haven't spent much time on trying to
> improve the performance yet (preliminary profiling seems to indicate that
> swig is the problem).  However, looking through the sepolicy code, I found
> that it could use the setools code more efficiently (I realize the first
> matter of business was just to get it over to setools4).
>
> The biggest win will be to minimize how many times the code iterates over
> all TE rules.  For example, in the search function, it runs the TERuleQuery
> twice, when it could be done in one query.  Also, for the transition
> command, it seems to manually implement a domain transition analysis.  When
> I compared the sepolicy transition run time to sedta, sedta was a minute
> faster for the same analysis.


A few months ago (in August) I did some profiling on sesearch (from SETools
4) and found that a lot of time was spent in SWIG casting operations (like
qpol_avrule_from_void). A quick patch to remove a cast (
https://github.com/fishilico/setools/commit/461bf0297b950ae40ba5bcb17db0f2a19f14d560)
made sesearch quite faster (I don't have the precise numbers here).
In short I believe the way the SWIG wrappers use objects (and create
objects from pointers) causes a noticeable performance impact, and I have
no opinion on what would be the best approach to improve the code.

Nicolas

--001a1140223ae6ec670541311910
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On F=
ri, Nov 11, 2016 at 1:58 AM, Chris PeBenito <span dir=3D"ltr">&lt;<a href=
=3D"mailto:pebenito@ieee.org" target=3D"_blank">pebenito@ieee.org</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span cla=
ss=3D"gmail-">On 11/08/16 10:29, Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 11/08/2016 10:21 AM, Stephen Smalley wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
On 11/07/2016 04:51 AM, Laurent Bigonville wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
From: Laurent Bigonville &lt;<a href=3D"mailto:bigon@bigon.be" target=3D"_b=
lank">bigon@bigon.be</a>&gt;<br>
<br>
Add python3 support for sepolicy<br>
<br>
Signed-off-by: Laurent Bigonville &lt;<a href=3D"mailto:bigon@bigon.be" tar=
get=3D"_blank">bigon@bigon.be</a>&gt;<br>
---<br>
=C2=A0policycoreutils/sepolicy/seli<wbr>nux_client.py=C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 6 ++--<br>
=C2=A0policycoreutils/sepolicy/sepo<wbr>licy.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 38 ++++++++++++------------<br>
=C2=A0policycoreutils/sepolicy/sepo<wbr>licy/__init__.py=C2=A0 =C2=A0 | 16 =
++++++----<br>
=C2=A0policycoreutils/sepolicy/sepo<wbr>licy/communicate.py |=C2=A0 4 +--<b=
r>
=C2=A0policycoreutils/sepolicy/sepo<wbr>licy/generate.py=C2=A0 =C2=A0 | 30 =
+++++++++----------<br>
=C2=A0policycoreutils/sepolicy/sepo<wbr>licy/interface.py=C2=A0 =C2=A0| 14 =
++++++---<br>
=C2=A0policycoreutils/sepolicy/sepo<wbr>licy/manpage.py=C2=A0 =C2=A0 =C2=A0=
|=C2=A0 7 +++--<br>
=C2=A07 files changed, 65 insertions(+), 50 deletions(-)<br>
</blockquote>
<br>
make test doesn&#39;t pass in policycoreutils/sepolicy, although I&#39;m no=
t<br>
sure that&#39;s new to this patch.=C2=A0 I think the manpage ones were alre=
ady<br>
failing; I don&#39;t recall the network one hanging before though.=C2=A0 Bu=
t<br>
maybe that is because I wasn&#39;t testing with setools3 fully removed befo=
re?<br>
</blockquote>
<br>
Oh, I guess it is just very slow with setools4.=C2=A0 It did finally comple=
te<br>
sepolicy network -d and has moved on (next slow/hanging one is<br>
transition -t).<br>
</blockquote>
<br></span>
Yes, sadly setools4 is slower.=C2=A0 I haven&#39;t spent much time on tryin=
g to improve the performance yet (preliminary profiling seems to indicate t=
hat swig is the problem).=C2=A0 However, looking through the sepolicy code,=
 I found that it could use the setools code more efficiently (I realize the=
 first matter of business was just to get it over to setools4).<br>
<br>
The biggest win will be to minimize how many times the code iterates over a=
ll TE rules.=C2=A0 For example, in the search function, it runs the TERuleQ=
uery twice, when it could be done in one query.=C2=A0 Also, for the transit=
ion command, it seems to manually implement a domain transition analysis.=
=C2=A0 When I compared the sepolicy transition run time to sedta, sedta was=
 a minute faster for the same analysis.</blockquote><div><br></div><div>A f=
ew months ago (in August) I did some profiling on sesearch (from SETools 4)=
 and found that a lot of time was spent in SWIG casting operations (like qp=
ol_avrule_from_void). A quick patch to remove a cast (<a href=3D"https://gi=
thub.com/fishilico/setools/commit/461bf0297b950ae40ba5bcb17db0f2a19f14d560"=
>https://github.com/fishilico/setools/commit/461bf0297b950ae40ba5bcb17db0f2=
a19f14d560</a>) made sesearch quite faster (I don&#39;t have the precise nu=
mbers here).</div><div>In short I believe the way the SWIG wrappers use obj=
ects (and create objects from pointers) causes a noticeable performance imp=
act, and I have no opinion on what would be the best approach to improve th=
e code.<br></div><div><br></div><div>Nicolas</div></div><br></div></div>

--001a1140223ae6ec670541311910--
