MIME-Version: 1.0
In-Reply-To: <555DF171.10805@quarksecurity.com>
References: <1428616130-14570-1-git-send-email-jeffv@google.com>
 <1684020.b5Ioztp7mc@sifl>
 <CAFftDdqfcMGht2JWHzPcBUauD-7RTXio=aTHHNMUKcJPPNLeRg@mail.gmail.com>
 <555D3E20.7050907@quarksecurity.com>
 <CABXk95CESxmfTbmpTyx0_jkj3TXs6EEYeZwo_Jpri0nAVtUCDg@mail.gmail.com>
 <CAFftDdpuSc6qyAo8Zd8At+LodwUbNmdi2LGT7HurAfG68rEruQ@mail.gmail.com>
 <555DF171.10805@quarksecurity.com>
Date: Thu, 21 May 2015 07:56:01 -0700
Message-ID: <CAFftDdpayX=GqssXHxpfq8UTycJSfamGQdzqMWe9wYDfwwegvg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux: add targeted whitelisting of ioctl commands.
From: William Roberts <bill.c.roberts@gmail.com>
To: Joshua Brindle <brindle@quarksecurity.com>
Content-Type: multipart/alternative; boundary=047d7b86de86fafc32051698bd44
Cc: linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--047d7b86de86fafc32051698bd44
Content-Type: text/plain; charset=UTF-8

On May 21, 2015 7:53 AM, "Joshua Brindle" <brindle@quarksecurity.com> wrote:
>
> William Roberts wrote:
>>
>> On Wed, May 20, 2015 at 9:17 PM, Jeffrey Vander Stoep<jeffv@google.com>
>> wrote:
>>
>>> Thanks for all the feedback and suggestions. Agreed that raw numerical
>>> values are confusing. I will fix up the commit message to set a better
>>> precedent for intended use. I included them more to illustrate what is
>>> happening under the hood. I like the idea of a qualifier for clarity.
>>> The qualifier seems necessary for the suggested non-ioctl-specific
>>> approach.
>>>
>>> Individual ioctl labels are only marginally better than raw numbers.
>>> E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK TCXONC
>>> TIOCMBIS }. More helpful...but not much.
>>>
>>> My plan was to group commonly used ioctl sets into macros.
>>>
>>> e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc
>>>
>>
>> This is exactly what I had in mind, just use m4
>>
>
> Even outside of my analysis use case I think this is not a good idea.
>
> Consider the Android base policy defined gpu_op as a set of ioctls, and
there were related rules for gpu users defined there. Then a device variant
policy has additional gpu_op ioctl's. How does it add them? Does it have to
re-add all of the related rules with the new ioctls?

I could define a new macro my_device_GPU_ioctls and include the base macro
in its expansion.

>
> In the ioctl-attibute case the variant policy would just add its specific
ioctls to gpu_op and everything would be taken care of.
>
> Then we just need to preserve the symbols for looking at policies and
we'll all be happy, right?
>
>
>>
>>> After monitoring ioctl use across five different devices I think this
>>> is a good approach as just 10-20 macros would be adequate for a
>>> targeted policy and would provide a clearer explanation of the
>>> permissions given.
>>>
>>
>>
>>
>

--047d7b86de86fafc32051698bd44
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On May 21, 2015 7:53 AM, &quot;Joshua Brindle&quot; &lt;<a href=3D"mailto:b=
rindle@quarksecurity.com">brindle@quarksecurity.com</a>&gt; wrote:<br>
&gt;<br>
&gt; William Roberts wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Wed, May 20, 2015 at 9:17 PM, Jeffrey Vander Stoep&lt;<a href=
=3D"mailto:jeffv@google.com">jeffv@google.com</a>&gt;<br>
&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; Thanks for all the feedback and suggestions. Agreed that raw n=
umerical<br>
&gt;&gt;&gt; values are confusing. I will fix up the commit message to set =
a better<br>
&gt;&gt;&gt; precedent for intended use. I included them more to illustrate=
 what is<br>
&gt;&gt;&gt; happening under the hood. I like the idea of a qualifier for c=
larity.<br>
&gt;&gt;&gt; The qualifier seems necessary for the suggested non-ioctl-spec=
ific<br>
&gt;&gt;&gt; approach.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Individual ioctl labels are only marginally better than raw nu=
mbers.<br>
&gt;&gt;&gt; E.g. { TCSETSF TIOCGWINSZ TCGETA TCSETA TCSETAW TCSETAF TCSBRK=
 TCXONC<br>
&gt;&gt;&gt; TIOCMBIS }. More helpful...but not much.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; My plan was to group commonly used ioctl sets into macros.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; e.g. common_socket_ioc, priv_socket_ioc, tty_ioc, gpu_ioc, etc=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; This is exactly what I had in mind, just use m4<br>
&gt;&gt;<br>
&gt;<br>
&gt; Even outside of my analysis use case I think this is not a good idea.<=
br>
&gt;<br>
&gt; Consider the Android base policy defined gpu_op as a set of ioctls, an=
d there were related rules for gpu users defined there. Then a device varia=
nt policy has additional gpu_op ioctl&#39;s. How does it add them? Does it =
have to re-add all of the related rules with the new ioctls?</p>
<p dir=3D"ltr">I could define a new macro my_device_GPU_ioctls and include =
the base macro in its expansion.</p>
<p dir=3D"ltr">&gt;<br>
&gt; In the ioctl-attibute case the variant policy would just add its speci=
fic ioctls to gpu_op and everything would be taken care of.<br>
&gt;<br>
&gt; Then we just need to preserve the symbols for looking at policies and =
we&#39;ll all be happy, right?<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt; After monitoring ioctl use across five different devices I thi=
nk this<br>
&gt;&gt;&gt; is a good approach as just 10-20 macros would be adequate for =
a<br>
&gt;&gt;&gt; targeted policy and would provide a clearer explanation of the=
<br>
&gt;&gt;&gt; permissions given.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
</p>

--047d7b86de86fafc32051698bd44--
