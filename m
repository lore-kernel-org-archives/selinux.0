MIME-Version: 1.0
In-Reply-To: <52CC2088.8050809@tycho.nsa.gov>
References: <CAOFt0CSftkNgEVBaM3Hr6eb+ygYyd2JoSATTir1=EOQy5+uQmA@mail.gmail.com>
 <CAFftDdq=R1Ueiz6_SGi0auF0Y8UWUmktNE7Nt8xhtjoUrKX0GQ@mail.gmail.com>
 <52CAFC9C.2040708@tycho.nsa.gov>
 <CAOFt0CS+YFG8HVym1rX-aiKs6=nmLWu0FPyb8L25-VyK3FDh2g@mail.gmail.com>
 <52CC2088.8050809@tycho.nsa.gov>
Date: Tue, 7 Jan 2014 17:00:46 +0100
Message-ID: <CAOFt0CR7xW1+3nzZoLfGLP5Nz++Lq_yvctEU+=gM--nq+tX2eQ@mail.gmail.com>
Subject: Re: Allowing all access in SELinux without permissive mode.
From: Kernel freak <kernelfreak@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=089e01493de0bfc85c04ef637a2a
Cc: "selinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e01493de0bfc85c04ef637a2a
Content-Type: text/plain; charset=ISO-8859-1

The policy is loaded into internal data structures during system

> initialization (see security_load_policy and the functions it calls),
> and the security server consults those data structures (see
> security_compute_av and the functions it calls) to compute the allowed
> permissions.  The decisions are stored in the avd (struct av_decision)
> returned by the security server to the AVC.  You can trace through the
> code, or read English descriptions in:
> http://www.freetechbooks.com/the-selinux-notebook-the-foundations-t785.html
> https://www.imperialviolet.org/2009/07/14/selinux.html
> http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.shtml
>
 Yes. Security_compute_av calls context_struct_compute_av() which does
other checks like MLS constraints, allow_unknown flags, etc. Post that, the
access decisions are relayed. Thinking out loud here, I need to make
changes to security_compute_av() to make changes in how SELinux calls for
policy data structure/policy/pseudo filesystem. Am i correct?

>
> Obviously some of these references are quite out of date but can still
> be helpful in understanding the overall structure and flow.
>
> > Question to mailing list head : While replying to mails in mailing list,
> > should the email reply of people who replied me already be included or
> > not? Thank you.
>
> You can infer it from the way I responded to your email; include the
> _relevant_ portions of the message to which you are responding, and
> "bottom posting" rather than "top posting" is preferred.  However, this
> is increasingly counter to the defaults of modern email clients and
> therefore you will see mixed practice, even by me.
>
Thank you. Will keep this in mind.

I hope this mail was correctly formatted. Thank you for your time.

--089e01493de0bfc85c04ef637a2a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">The policy is loaded into internal=
 data structures during system<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

initialization (see security_load_policy and the functions it calls),<br>
and the security server consults those data structures (see<br>
security_compute_av and the functions it calls) to compute the allowed<br>
permissions. =A0The decisions are stored in the avd (struct av_decision)<br=
>
returned by the security server to the AVC. =A0You can trace through the<br=
>
code, or read English descriptions in:<br>
<a href=3D"http://www.freetechbooks.com/the-selinux-notebook-the-foundation=
s-t785.html" target=3D"_blank">http://www.freetechbooks.com/the-selinux-not=
ebook-the-foundations-t785.html</a><br>
<a href=3D"https://www.imperialviolet.org/2009/07/14/selinux.html" target=
=3D"_blank">https://www.imperialviolet.org/2009/07/14/selinux.html</a><br>
<a href=3D"http://www.nsa.gov/research/_files/selinux/papers/slinux-abs.sht=
ml" target=3D"_blank">http://www.nsa.gov/research/_files/selinux/papers/sli=
nux-abs.shtml</a><br></blockquote><div>=A0Yes. Security_compute_av calls co=
ntext_struct_compute_av() which does other checks like MLS constraints, all=
ow_unknown flags, etc. Post that, the access decisions are relayed. Thinkin=
g out loud here, I need to make changes to security_compute_av() to make ch=
anges in how SELinux calls for policy data structure/policy/pseudo filesyst=
em. Am i correct?<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
Obviously some of these references are quite out of date but can still<br>
be helpful in understanding the overall structure and flow.<br>
<div class=3D"im"><br>
&gt; Question to mailing list head : While replying to mails in mailing lis=
t,<br>
&gt; should the email reply of people who replied me already be included or=
<br>
&gt; not? Thank you.<br>
<br>
</div>You can infer it from the way I responded to your email; include the<=
br>
_relevant_ portions of the message to which you are responding, and<br>
&quot;bottom posting&quot; rather than &quot;top posting&quot; is preferred=
. =A0However, this<br>
is increasingly counter to the defaults of modern email clients and<br>
therefore you will see mixed practice, even by me.<br></blockquote><div>Tha=
nk you. Will keep this in mind.=A0 <br></div></div><br></div><div class=3D"=
gmail_extra">I hope this mail was correctly formatted. Thank you for your t=
ime.<br>
</div></div>

--089e01493de0bfc85c04ef637a2a--
