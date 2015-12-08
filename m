Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB8GLKSL012823
 for <selinux@tycho.nsa.gov>; Tue, 8 Dec 2015 11:21:21 -0500
Received: by oige206 with SMTP id e206so11903472oig.2
 for <selinux@tycho.nsa.gov>; Tue, 08 Dec 2015 08:21:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5666F8A8.3040703@tycho.nsa.gov>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
 <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
 <5666F8A8.3040703@tycho.nsa.gov>
Date: Tue, 8 Dec 2015 17:21:17 +0100
Message-ID: <CAL8PO=2TMsT=DUJ-1oKKC+OutuHWVH1VqTsNDqKxKRVwon7Urw@mail.gmail.com>
Subject: Re: Performance issues - huge amount of AVC misses
From: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a113d444afc1eab0526655c2c
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113d444afc1eab0526655c2c
Content-Type: text/plain; charset=UTF-8

Hi,

there are neither categories nor MLS used on the system. I'll get the
amount of different types used by the system (I need to do some digging,
will get the data tomorrow). Most of classes will be regular file,
directories and some symbolic links. There will be a lots of files as AFAIK
vertica uses lots of smaller files.

I'll try to reduce amount of dontaudit rules and I'll see how much this
reduces cache misses. The hard truth is, that vertica is looking at many
places during the run, most of which it does not need. Maybe the way we
have rules defined is creating a lot of stress on the amount of rules in
the policy, I'll try to get the data on that.

On Tue, Dec 8, 2015 at 4:35 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 12/08/2015 09:56 AM, Michal Marciniszyn wrote:
>
>> Hi Dominic,
>>
>> while there is quite a lot of dontaudit rules around, the amount for
>> domains running on this node is not high. Is there any way how to
>> monitor which rules are loaded and released from the cache? Anything
>> better than plain aggregated stats? We would bot care about performance
>> of such monitoring tool if it provides some useful answer. For instance,
>> is there a way how to use system tap or similar kernel profiling to get
>> the data?
>>
>> I'll do a profiling on how many rules actually apply for the domains on
>> the node (i.e. use sesearch to find out). If doing so, does the rule in
>> cache hold whole vector (i.e. A is allowed to do X, Y, Z on B or is one
>> cache entry A can do X on B)?
>>
>
> One cache entry holds the entire access vector.  However, they are unique
> per (source context, target context, target class) triple.
>
> Are you using categories on this system (i.e. running processes in
> specific category sets, assigning specific categories to files), or just
> types?
>
> How many unique domains are running in your workload?  How many file types
> are typically accessed by your workload?  How many different kinds of files
> (regular, directory, symbolic link, block device, ...) are part of your
> workload?
>
>
>
>

--001a113d444afc1eab0526655c2c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>there are neither categories nor ML=
S used on the system. I&#39;ll get the amount of different types used by th=
e system (I need to do some digging, will get the data tomorrow). Most of c=
lasses will be regular file, directories and some symbolic links. There wil=
l be a lots of files as AFAIK vertica uses lots of smaller files.</div><div=
><br></div><div>I&#39;ll try to reduce amount of dontaudit rules and I&#39;=
ll see how much this reduces cache misses. The hard truth is, that vertica =
is looking at many places during the run, most of which it does not need. M=
aybe the way we have rules defined is creating a lot of stress on the amoun=
t of rules in the policy, I&#39;ll try to get the data on that.</div></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Dec 8, 20=
15 at 4:35 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@=
tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex"><span class=3D"">On 12/08/2015 09:56 AM, Mi=
chal Marciniszyn wrote:<br>
</span><span class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Dominic,<br>
<br>
while there is quite a lot of dontaudit rules around, the amount for<br>
domains running on this node is not high. Is there any way how to<br>
monitor which rules are loaded and released from the cache? Anything<br>
better than plain aggregated stats? We would bot care about performance<br>
of such monitoring tool if it provides some useful answer. For instance,<br=
>
is there a way how to use system tap or similar kernel profiling to get<br>
the data?<br>
<br>
I&#39;ll do a profiling on how many rules actually apply for the domains on=
<br>
the node (i.e. use sesearch to find out). If doing so, does the rule in<br>
cache hold whole vector (i.e. A is allowed to do X, Y, Z on B or is one<br>
cache entry A can do X on B)?<br>
</blockquote>
<br></span>
One cache entry holds the entire access vector.=C2=A0 However, they are uni=
que per (source context, target context, target class) triple.<br>
<br>
Are you using categories on this system (i.e. running processes in specific=
 category sets, assigning specific categories to files), or just types?<br>
<br>
How many unique domains are running in your workload?=C2=A0 How many file t=
ypes are typically accessed by your workload?=C2=A0 How many different kind=
s of files (regular, directory, symbolic link, block device, ...) are part =
of your workload?<br>
<br>
<br>
<br>
</blockquote></div><br></div>

--001a113d444afc1eab0526655c2c--
