Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6IMv6Eb012910
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 18:57:06 -0400
Received: from mail-ew0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6IMuApe024566
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 22:56:11 GMT
Received: by ewy19 with SMTP id 19so1294467ewy.12
        for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 15:57:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimp0ovSSxGPRZ9YkRotD1h16WcGSUpdu0YnI61T@mail.gmail.com>
References: <1279319518.464844.26726.nullmailer@UDistro.exmeritus.com.>
	<AANLkTimxfftX2x0P7o5N5rWQyJIt0MRStwmBk1U9kdUF@mail.gmail.com>
	<D0A03833-468D-435F-A5FC-28377903BF34@nall.com>
	<AANLkTimp0ovSSxGPRZ9YkRotD1h16WcGSUpdu0YnI61T@mail.gmail.com>
Date: Sun, 18 Jul 2010 18:57:04 -0400
Message-ID: <AANLkTil6B2weEKOMnFz_X1wMUXBeHQzGfZ9ODqWXnS8O@mail.gmail.com>
Subject: Re: [PATCH] Improve loading performance by 80% using dynamic resizing
From: Kyle Moffett <kyle@moffetthome.net>
To: Joe Nall <joe@nall.com>
Cc: John Livingston <John.A.Livingston@boeing.com>,
        Kyle Moffett <Kyle.D.Moffett@boeing.com>,
        Matthew Robertson <Matthew.L.Robertson@boeing.com>,
        selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=0015174c12d6e80b95048bb15eb2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0015174c12d6e80b95048bb15eb2
Content-Type: text/plain; charset=UTF-8

Sorry if this top-posts or something, sent from my phone while waiting
around in the airport...

We investigated fiddling with the default hash table sizes and were able to
improve throughput rather dramatically (~50%, vs the 80% from this patch).
Matt may remember better, but I believe the problem was significant memory
overhead.

Specifically, each module (and I believe the base policy is also treated as
a "module") gets its own set of 8 hash tables.  Unfortunately the module
complexity varies rather wildly... as a result you either spend eons
iterating over mostly empty hash tables in each module or you spend eons
doing strcmp while performing lookups.

I'm just going from memory, of course, but that was our first course of
action and it had some noticable downsides.

Cheers,
Kyle Moffett

On Jul 18, 2010 5:39 PM, "Joe Nall" <joe@nall.com> wrote:


On Jul 18, 2010, at 4:11 PM, Kyle Moffett wrote:

> Hmm, it looks like this email never made it to ...
Am I interpreting the code correctly, that a hashtable with with 512 buckets
is used to lookup types?

On my development machine:
seinfo -t | wc -l
WARNING: This policy contained disabled aliases; they have been removed.
4820

Average bucket depth of 9.4 seems kind of high. Is there any harm in raising
the #buckets while this patch is discussed on the list?

joe



>
> Cheers,
> Kyle Moffett
>
> On Fri, Jul 16, 2010 at 17:50, Matthew Robertson
> <Matthew.L.Rob...
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.

--0015174c12d6e80b95048bb15eb2
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p>Sorry if this top-posts or something, sent from my phone while waiting a=
round in the airport...</p>
<p>We investigated fiddling with the default hash table sizes and were able=
 to improve throughput rather dramatically (~50%, vs the 80% from this patc=
h).=C2=A0 Matt may remember better, but I believe the problem was significa=
nt memory overhead.</p>

<p>Specifically, each module (and I believe the base policy is also treated=
 as a &quot;module&quot;) gets its own set of 8 hash tables.=C2=A0 Unfortun=
ately the module complexity varies rather wildly... as a result you either =
spend eons iterating over mostly empty hash tables in each module or you sp=
end eons doing strcmp while performing lookups.</p>

<p>I&#39;m just going from memory, of course, but that was our first course=
 of action and it had some noticable downsides.</p>
<p>Cheers,<br>
Kyle Moffett</p>
<p><blockquote type=3D"cite">On Jul 18, 2010 5:39 PM, &quot;Joe Nall&quot; =
&lt;<a href=3D"mailto:joe@nall.com">joe@nall.com</a>&gt; wrote:<br><br><p><=
font color=3D"#500050"><br>On Jul 18, 2010, at 4:11 PM, Kyle Moffett wrote:=
<br>
<br>&gt; Hmm, it looks like this email never made it to ...</font></p>Am I =
interpreting the code correctly, that a hashtable with with 512 buckets is =
used to lookup types?<br>
<br>
On my development machine:<br>
seinfo -t | wc -l<br>
WARNING: This policy contained disabled aliases; they have been removed.<br=
>
4820<br>
<br>
Average bucket depth of 9.4 seems kind of high. Is there any harm in raisin=
g the #buckets while this patch is discussed on the list?<br>
<br>
joe<br>
<p><font color=3D"#500050"><br><br>&gt; <br>&gt; Cheers,<br>&gt; Kyle Moffe=
tt<br>&gt; <br>&gt; On Fri, Jul 16, 2010 at 17:50, Matthew Robertson<br>&gt=
; &lt;Matthew.L.Rob...</font></p>&gt; --<br>
&gt; This message was distributed to subscribers of the selinux mailing lis=
t.<br>
&gt; If you no longer wish to subscribe, send mail to <a href=3D"mailto:maj=
ordomo@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
&gt; the words &quot;unsubscribe selinux&quot; without quotes as the messag=
e.<br>
<br>
</blockquote></p>

--0015174c12d6e80b95048bb15eb2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
