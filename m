MIME-Version: 1.0
In-Reply-To: <CAHC9VhSuB2MNS_LQBGQjJHAY0LKx3A9hh7Cq4a_RbD_uqNbeuQ@mail.gmail.com>
References: <1494507551-4643-1-git-send-email-sbuisson@ddn.com>
 <2161c45f-dd29-8269-2bb1-5d5afa78104b@schaufler-ca.com>
 <1494534152.10447.11.camel@tycho.nsa.gov>
 <5d7a2409-db08-b142-c71b-a7a38ecc175d@schaufler-ca.com>
 <CAHC9VhSuB2MNS_LQBGQjJHAY0LKx3A9hh7Cq4a_RbD_uqNbeuQ@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Fri, 12 May 2017 15:51:12 -0700
Message-ID: <CAFftDdqvysgyjLVbLZ2UzTOQRcqrrpNhkKJVfFgNJLnVrwF8yA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: add brief info to policydb
To: Paul Moore <paul@paul-moore.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Sebastien Buisson <sbuisson.ddn@gmail.com>,
 James Morris <james.l.morris@oracle.com>,
 linux-security-module@vger.kernel.org,
 Sebastien Buisson <sbuisson@ddn.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a113caa44d2ddb3054f5b8a00"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113caa44d2ddb3054f5b8a00
Content-Type: text/plain; charset="UTF-8"

On Fri, May 12, 2017 at 3:22 PM, Paul Moore <paul@paul-moore.com> wrote:

> On Thu, May 11, 2017 at 4:45 PM, Casey Schaufler <casey@schaufler-ca.com>
> wrote:
> > On 5/11/2017 1:22 PM, Stephen Smalley wrote:
> >> On Thu, 2017-05-11 at 08:56 -0700, Casey Schaufler wrote:
> >>> On 5/11/2017 5:59 AM, Sebastien Buisson wrote:
> >>>> Add policybrief field to struct policydb. It holds a brief info
> >>>> of the policydb, in the following form:
> >>>> <0 or 1 for enforce>:<0 or 1 for checkreqprot>:<hashalg>=<checksum>
> >>>> Policy brief is computed every time the policy is loaded, and when
> >>>> enforce or checkreqprot are changed.
> >>>>
> >>>> Add security_policy_brief hook to give access to policy brief to
> >>>> the rest of the kernel. Lustre client makes use of this information
> >>>> to detect changes to the policy, and forward it to Lustre servers.
> >>>> Depending on how the policy is enforced on Lustre client side,
> >>>> Lustre servers can refuse connection.
> >>>>
> >>>> Signed-off-by: Sebastien Buisson <sbuisson@ddn.com>
> >>>> ---
> >>>>  include/linux/lsm_hooks.h           | 16 ++++++++
> >>>>  include/linux/security.h            |  7 ++++
> >>>>  security/security.c                 |  6 +++
> >>>>  security/selinux/hooks.c            |  7 ++++
> >>>>  security/selinux/include/security.h |  2 +
> >>>>  security/selinux/selinuxfs.c        |  2 +
> >>>>  security/selinux/ss/policydb.c      | 76
> >>>> +++++++++++++++++++++++++++++++++++++
> >>>>  security/selinux/ss/policydb.h      |  2 +
> >>>>  security/selinux/ss/services.c      | 62
> >>>> ++++++++++++++++++++++++++++++
> >>>>  9 files changed, 180 insertions(+)
> >>>>
> >>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> >>>> index 080f34e..9cac282 100644
> >>>> --- a/include/linux/lsm_hooks.h
> >>>> +++ b/include/linux/lsm_hooks.h
> >>>> @@ -1336,6 +1336,20 @@
> >>>>   * @inode we wish to get the security context of.
> >>>>   * @ctx is a pointer in which to place the allocated
> >>>> security context.
> >>>>   * @ctxlen points to the place to put the length of @ctx.
> >>>> + *
> >>>> + * Security hooks for policy brief
> >>>> + *
> >>>> + * @policy_brief:
> >>>> + *
> >>>> + * Returns a string containing a brief info of the
> >>>> policydb, in the
> >>>> + * following form:
> >>>> + * <0 or 1 for enforce>:<0 or 1 for
> >>>> checkreqprot>:<hashalg>=<checksum>
> >>>
> >>> This sure looks like SELinux specific information. If the Spiffy
> >>> security module has multiple values for enforcement (e.g. off,
> >>> soft and hard) this interface definition does not work. What is a
> >>> "checkreqprot", and what is it for?
> >>>
> >>> I expect that you have no interest (or incentive) in supporting
> >>> security modules other than SELinux, and that's OK. What's I'm
> >>> after is an interface that another security module could use if
> >>> someone where interested (or inspired) to do so.
> >>>
> >>> Rather than a string with predefined positional values (something
> >>> I was taught not to do when 1 MIPS and 1 MEG was a big computer)
> >>> you might use
> >>> "enforce=<value>:checkreqprot=<value>:hashalg=<checksum>"
> >>
> >> No objection to the above, although it makes his updating code for
> >> enforce/checkreqprot a bit uglier.
> >
> > Sure, but can you imagine trying to use find(1) if the
> > options where positional?
>
> Perhaps I'm suffering from audit induced PTSD, but I think we need to
> operate under the assumption that we are going to need to augment this
> at some point in the future (no good feature goes un-abused) and I'd
> much rather have some sort of name-value pairing to keep my sanity.  I
> also feel rather strongly that we should make it very explicit in the
> comments that the ordering of the fields in the string may change.
>
> >>> for SELinux and define @policy_brief as
> >>>
> >>>      A string containing colon separated name and value pairs
> >>>      that will be parsed and interpreted by the security module
> >>>      or modules.
> >>
> >> Actually, I'm not clear it will be parsed or interpreted by the
> >> security module(s).  I think he is just fetching it and then doing a
> >> simple comparison to check for inconsistencies between clients and the
> >> server, and optionally admins/users can read it and interpret it as
> >> they see fit.
> >
> > OK, in which case human eyes *need* the name as well as the value.
> > That, and strcmp(value, "enforce=0") is no harder than strcmp(value,
> "0").
>
> The initial use case may not require parsing the string, but who knows
> what will end up using this five years from now.  Once again, I agree
> with Casey, let's make sure it easily parsed and readable by admins;
> imagine this as the output of a file under /proc or /sys.
>
> >>> You already have it right for the "hashalg" field. If you want to
> >>> be really forward looking you could use names field names that
> >>> identify the security module that uses them, such as
> >>>
> >>>      "selinux/enforce=1:selinux/checkreqprot=0:selinux/MD5=8675309"
> >> That seems a bit verbose, particularly the duplicated selinux/ bit.
> >
> > True that, on the other hand
> >
> >         "selinux(enforce=1:checkreqprot=0:MD5=8675309)"
> >
> > would be harder to parse. Either works for me.
>
> I'm not sure I care too much about how the name-value pairs get
> namespaced, but considering the LSM stacking work that is happening,
> we should namespace it somehow.
>
>
Darn, i cleaned my inbox out, and forgot to comment. Couldn't you replace
the hex string conversion and kzalloc
with asprintf and the kernel format specifier extension phN as documented
under Documentation/printk-formats.txt.

It looks like asprintf flows down into vsnprintf and into the pointer()
routine properly.

asprintf prototype:
http://elixir.free-electrons.com/linux/latest/source/include/linux/kernel.h#L426

As an aside, I wonder if audit can ditch there hex escaping routine and use
something like *pE
as mentioned in that Documentation under "Raw buffer as an escaped string:"

--001a113caa44d2ddb3054f5b8a00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, May 12, 2017 at 3:22 PM, Paul Moore <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Thu, May 11, 2017 at 4:45 PM, Casey Schaufler &lt;<a href=3D"mailto:casey@s=
chaufler-ca.com">casey@schaufler-ca.com</a>&gt; wrote:<br>
&gt; On 5/11/2017 1:22 PM, Stephen Smalley wrote:<br>
&gt;&gt; On Thu, 2017-05-11 at 08:56 -0700, Casey Schaufler wrote:<br>
&gt;&gt;&gt; On 5/11/2017 5:59 AM, Sebastien Buisson wrote:<br>
&gt;&gt;&gt;&gt; Add policybrief field to struct policydb. It holds a brief=
 info<br>
&gt;&gt;&gt;&gt; of the policydb, in the following form:<br>
&gt;&gt;&gt;&gt; &lt;0 or 1 for enforce&gt;:&lt;0 or 1 for checkreqprot&gt;=
:&lt;hashalg&gt;=3D&lt;<wbr>checksum&gt;<br>
&gt;&gt;&gt;&gt; Policy brief is computed every time the policy is loaded, =
and when<br>
&gt;&gt;&gt;&gt; enforce or checkreqprot are changed.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Add security_policy_brief hook to give access to policy br=
ief to<br>
&gt;&gt;&gt;&gt; the rest of the kernel. Lustre client makes use of this in=
formation<br>
&gt;&gt;&gt;&gt; to detect changes to the policy, and forward it to Lustre =
servers.<br>
&gt;&gt;&gt;&gt; Depending on how the policy is enforced on Lustre client s=
ide,<br>
&gt;&gt;&gt;&gt; Lustre servers can refuse connection.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Sebastien Buisson &lt;<a href=3D"mailto:sbu=
isson@ddn.com">sbuisson@ddn.com</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;=C2=A0 include/linux/lsm_hooks.h=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 16 ++++++++<br>
&gt;&gt;&gt;&gt;=C2=A0 include/linux/security.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 7 ++++<br>
&gt;&gt;&gt;&gt;=C2=A0 security/security.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +++<br>
&gt;&gt;&gt;&gt;=C2=A0 security/selinux/hooks.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 7 ++++<br>
&gt;&gt;&gt;&gt;=C2=A0 security/selinux/include/<wbr>security.h |=C2=A0 2 +=
<br>
&gt;&gt;&gt;&gt;=C2=A0 security/selinux/selinuxfs.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +<br>
&gt;&gt;&gt;&gt;=C2=A0 security/selinux/ss/policydb.c=C2=A0 =C2=A0 =C2=A0 |=
 76<br>
&gt;&gt;&gt;&gt; ++++++++++++++++++++++++++++++<wbr>+++++++<br>
&gt;&gt;&gt;&gt;=C2=A0 security/selinux/ss/policydb.h=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 2 +<br>
&gt;&gt;&gt;&gt;=C2=A0 security/selinux/ss/services.c=C2=A0 =C2=A0 =C2=A0 |=
 62<br>
&gt;&gt;&gt;&gt; ++++++++++++++++++++++++++++++<br>
&gt;&gt;&gt;&gt;=C2=A0 9 files changed, 180 insertions(+)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm=
_hooks.h<br>
&gt;&gt;&gt;&gt; index 080f34e..9cac282 100644<br>
&gt;&gt;&gt;&gt; --- a/include/linux/lsm_hooks.h<br>
&gt;&gt;&gt;&gt; +++ b/include/linux/lsm_hooks.h<br>
&gt;&gt;&gt;&gt; @@ -1336,6 +1336,20 @@<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0* @inode we wish to get the security context o=
f.<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0* @ctx is a pointer in which to place the allo=
cated<br>
&gt;&gt;&gt;&gt; security context.<br>
&gt;&gt;&gt;&gt;=C2=A0 =C2=A0* @ctxlen points to the place to put the lengt=
h of @ctx.<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + * Security hooks for policy brief<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + * @policy_brief:<br>
&gt;&gt;&gt;&gt; + *<br>
&gt;&gt;&gt;&gt; + * Returns a string containing a brief info of the<br>
&gt;&gt;&gt;&gt; policydb, in the<br>
&gt;&gt;&gt;&gt; + * following form:<br>
&gt;&gt;&gt;&gt; + * &lt;0 or 1 for enforce&gt;:&lt;0 or 1 for<br>
&gt;&gt;&gt;&gt; checkreqprot&gt;:&lt;hashalg&gt;=3D&lt;<wbr>checksum&gt;<b=
r>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This sure looks like SELinux specific information. If the Spif=
fy<br>
&gt;&gt;&gt; security module has multiple values for enforcement (e.g. off,=
<br>
&gt;&gt;&gt; soft and hard) this interface definition does not work. What i=
s a<br>
&gt;&gt;&gt; &quot;checkreqprot&quot;, and what is it for?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I expect that you have no interest (or incentive) in supportin=
g<br>
&gt;&gt;&gt; security modules other than SELinux, and that&#39;s OK. What&#=
39;s I&#39;m<br>
&gt;&gt;&gt; after is an interface that another security module could use i=
f<br>
&gt;&gt;&gt; someone where interested (or inspired) to do so.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Rather than a string with predefined positional values (someth=
ing<br>
&gt;&gt;&gt; I was taught not to do when 1 MIPS and 1 MEG was a big compute=
r)<br>
&gt;&gt;&gt; you might use<br>
&gt;&gt;&gt; &quot;enforce=3D&lt;value&gt;:checkreqprot=3D<wbr>&lt;value&gt=
;:hashalg=3D&lt;checksum&gt;&quot;<br>
&gt;&gt;<br>
&gt;&gt; No objection to the above, although it makes his updating code for=
<br>
&gt;&gt; enforce/checkreqprot a bit uglier.<br>
&gt;<br>
&gt; Sure, but can you imagine trying to use find(1) if the<br>
&gt; options where positional?<br>
<br>
Perhaps I&#39;m suffering from audit induced PTSD, but I think we need to<b=
r>
operate under the assumption that we are going to need to augment this<br>
at some point in the future (no good feature goes un-abused) and I&#39;d<br=
>
much rather have some sort of name-value pairing to keep my sanity.=C2=A0 I=
<br>
also feel rather strongly that we should make it very explicit in the<br>
comments that the ordering of the fields in the string may change.<br>
<br>
&gt;&gt;&gt; for SELinux and define @policy_brief as<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 A string containing colon separated name a=
nd value pairs<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 that will be parsed and interpreted by the=
 security module<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 or modules.<br>
&gt;&gt;<br>
&gt;&gt; Actually, I&#39;m not clear it will be parsed or interpreted by th=
e<br>
&gt;&gt; security module(s).=C2=A0 I think he is just fetching it and then =
doing a<br>
&gt;&gt; simple comparison to check for inconsistencies between clients and=
 the<br>
&gt;&gt; server, and optionally admins/users can read it and interpret it a=
s<br>
&gt;&gt; they see fit.<br>
&gt;<br>
&gt; OK, in which case human eyes *need* the name as well as the value.<br>
&gt; That, and strcmp(value, &quot;enforce=3D0&quot;) is no harder than str=
cmp(value, &quot;0&quot;).<br>
<br>
The initial use case may not require parsing the string, but who knows<br>
what will end up using this five years from now.=C2=A0 Once again, I agree<=
br>
with Casey, let&#39;s make sure it easily parsed and readable by admins;<br=
>
imagine this as the output of a file under /proc or /sys.<br>
<br>
&gt;&gt;&gt; You already have it right for the &quot;hashalg&quot; field. I=
f you want to<br>
&gt;&gt;&gt; be really forward looking you could use names field names that=
<br>
&gt;&gt;&gt; identify the security module that uses them, such as<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 =C2=A0 &quot;selinux/enforce=3D1:selinux/<wbr>che=
ckreqprot=3D0:selinux/MD5=3D<wbr>8675309&quot;<br>
&gt;&gt; That seems a bit verbose, particularly the duplicated selinux/ bit=
.<br>
&gt;<br>
&gt; True that, on the other hand<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;selinux(enforce=3D1:<wbr>checkr=
eqprot=3D0:MD5=3D8675309)&quot;<br>
&gt;<br>
&gt; would be harder to parse. Either works for me.<br>
<br>
I&#39;m not sure I care too much about how the name-value pairs get<br>
namespaced, but considering the LSM stacking work that is happening,<br>
we should namespace it somehow.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div><br></div><div>Darn, i cleaned my inbox out, and forgot to co=
mment. Couldn&#39;t you replace the hex string conversion and kzalloc</div>=
<div>with asprintf and the kernel format specifier extension=C2=A0phN as do=
cumented under Documentation/printk-formats.txt.</div><div><br></div><div>I=
t looks like asprintf flows down into vsnprintf and into the pointer() rout=
ine properly.</div><div><br></div><div>asprintf prototype:</div><div><a hre=
f=3D"http://elixir.free-electrons.com/linux/latest/source/include/linux/ker=
nel.h#L426">http://elixir.free-electrons.com/linux/latest/source/include/li=
nux/kernel.h#L426</a><br></div><div><br></div><div>As an aside, I wonder if=
 audit can ditch there hex escaping routine and use something like *pE</div=
><div>as mentioned in that Documentation under &quot;Raw buffer as an escap=
ed string:&quot;</div></div><div class=3D"gmail_signature"><br></div>
</div></div>

--001a113caa44d2ddb3054f5b8a00--
