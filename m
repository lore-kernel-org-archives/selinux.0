MIME-Version: 1.0
In-Reply-To: <52CAFC9C.2040708@tycho.nsa.gov>
References: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>
 <CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>
 <52CAFC9C.2040708@tycho.nsa.gov>
Date: Tue, 7 Jan 2014 16:06:52 +0100
Message-ID: <CAOFt0CS+YFG8HVym1rX-aiKs6=nmLWu0FPyb8L25-VyK3FDh2g@mail.gmail.com>
Subject: Re: Allowing all access in SELinux without permissive mode.
From: Kernel freak <kernelfreak@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11c26b26fd7bcb04ef62b9d8
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c26b26fd7bcb04ef62b9d8
Content-Type: text/plain; charset=ISO-8859-1

Hello,
        Thank you so much for the information. Sorry for the delay in
replying. I guess I was a bit wrong in understanding the call. What I am
looking for is the function which decides the access decision regardless
the policy is loaded or not. So, the function/s where it reads the policy
file, and depending upon the rule from the policy file returns the decision
and logs that decision in AVC. I would not like to use permissive mode for
this as I am searching for the way access decisions are made in SELinux. As
Security Server(ss) is responsible for relaying the access decisions and
not enforcing them, I was searching for them in ss. Kindly point me if I am
thinking in a wrong manner. Thank you so much for your time.

Question to mailing list head : While replying to mails in mailing list,
should the email reply of people who replied me already be included or not?
Thank you.


On Mon, Jan 6, 2014 at 7:57 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 01/06/2014 11:32 AM, William Roberts wrote:
> > On Mon, Jan 6, 2014 at 4:08 AM, Kernel freak <kernelfreak@gmail.com>
> wrote:
> >> Hello Friends,
> >>                       I am currently working on SELinux and as a part
> of it,
> >> I need to make some changes to it. Basically, I would like to allow all
> >> access requests, but not by enabling permissive mode.
> >
> > That's what permissive mode is. It logs all requests not granted and
> > allows them to
> > happen. Why would you need to modify the code?
> >
> > If you need finer granularity, you can use the permissive attribute on
> domains
> > so in global enforcing mode, domains declared with this will run in
> > permissive mode.
>
> Also, note that the default behavior of security_compute_av() is to
> allow everything until you load a policy (until ss_initialized is set).
>
> If you want to allow everything and collect avc messages, you want
> permissive mode (either global permissive mode or per-domain permissive
> mode).  That logic however is in the AVC (security/selinux/avc.c) not in
> the security server (security/selinux/ss/*).
>
> If you want to allow everything and not generate avc messages, you can
> just not load a policy.  security_compute_av will already allow
> everything by default until you load a policy, just by setting
> avd->allowed to all-bits-set.
>
>
>

--001a11c26b26fd7bcb04ef62b9d8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hello,<br></div>=A0=A0=A0=A0=A0=A0=A0 Thank you =
so much for the information. Sorry for the delay in replying. I guess I was=
 a bit wrong in understanding the call. What I am looking for is the functi=
on which decides the access decision regardless the policy is loaded or not=
. So, the function/s where it reads the policy file, and depending upon the=
 rule from the policy file returns the decision and logs that decision in A=
VC. I would not like to use permissive mode for this as I am searching for =
the way access decisions are made in SELinux. As Security Server(ss) is res=
ponsible for relaying the access decisions and not enforcing them, I was se=
arching for them in ss. Kindly point me if I am thinking in a wrong manner.=
 Thank you so much for your time. <br>
<br></div>Question to mailing list head : While replying to mails in mailin=
g list, should the email reply of people who replied me already be included=
 or not? Thank you.<br></div><div class=3D"gmail_extra"><br><br><div class=
=3D"gmail_quote">
On Mon, Jan 6, 2014 at 7:57 PM, Stephen Smalley <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"im">On 01/06/2014 11:32 AM, William Roberts wrote:<br>
&gt; On Mon, Jan 6, 2014 at 4:08 AM, Kernel freak &lt;<a href=3D"mailto:ker=
nelfreak@gmail.com">kernelfreak@gmail.com</a>&gt; wrote:<br>
&gt;&gt; Hello Friends,<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I am currently working=
 on SELinux and as a part of it,<br>
&gt;&gt; I need to make some changes to it. Basically, I would like to allo=
w all<br>
&gt;&gt; access requests, but not by enabling permissive mode.<br>
&gt;<br>
&gt; That&#39;s what permissive mode is. It logs all requests not granted a=
nd<br>
&gt; allows them to<br>
&gt; happen. Why would you need to modify the code?<br>
&gt;<br>
&gt; If you need finer granularity, you can use the permissive attribute on=
 domains<br>
&gt; so in global enforcing mode, domains declared with this will run in<br=
>
&gt; permissive mode.<br>
<br>
</div>Also, note that the default behavior of security_compute_av() is to<b=
r>
allow everything until you load a policy (until ss_initialized is set).<br>
<br>
If you want to allow everything and collect avc messages, you want<br>
permissive mode (either global permissive mode or per-domain permissive<br>
mode). =A0That logic however is in the AVC (security/selinux/avc.c) not in<=
br>
the security server (security/selinux/ss/*).<br>
<br>
If you want to allow everything and not generate avc messages, you can<br>
just not load a policy. =A0security_compute_av will already allow<br>
everything by default until you load a policy, just by setting<br>
avd-&gt;allowed to all-bits-set.<br>
<br>
<br>
</blockquote></div><br></div>

--001a11c26b26fd7bcb04ef62b9d8--
