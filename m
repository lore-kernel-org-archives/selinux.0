Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k21KxYwA024952
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 15:59:34 -0500
Received: from nproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k21Kw31o024067
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 20:58:03 GMT
Received: by nproxy.gmail.com with SMTP id k27so164702nfc
        for <selinux@tycho.nsa.gov>; Wed, 01 Mar 2006 12:59:32 -0800 (PST)
Message-ID: <d82d6db50603011259s3fe0e80duca501a9c7925c661@mail.gmail.com>
Date: Wed, 1 Mar 2006 15:59:32 -0500
From: "Benjy Grogan" <benjy.grogan@gmail.com>
To: "Erich Schubert" <erich@debian.org>
Subject: Re: FYI SELinux/AppArmor press
Cc: cwarner <cwarner@kernelcode.com>, "SE Linux" <selinux@tycho.nsa.gov>
In-Reply-To: <1141222338.2834.33.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_4515_14306931.1141246772242"
References: <43FF7418.90205@redhat.com>
	 <1141138934.29803.2.camel@wintermute.xmldesign.de>
	 <1141183226.8475.22.camel@localhost.localdomain>
	 <1141222338.2834.33.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_4515_14306931.1141246772242
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 3/1/06, Erich Schubert <erich@debian.org> wrote:
>
> Hello Christopher,
> Well, I'm still not running SELinux reference policy successfully.
> So anything that actually works is easier to use...
> E.g. if the reference policy would include a users_extra file that
> labels /root
> with sysadm prefix... and if that were documented anywhere and wouldn't
> have required me to dive through the source of three packages.
> Now if ssh login as sysadm_r would work, I'd be mostly done.
>
> Albeit the documented interfaces of current RefPolicy are an
> improvement, I don't think that policy writing has become much easier.
> The M4 syntax is still very awkward (backticks, no semicolons), and
> unless you've read all the policy thoroughly (e.g. because you've
> written it), you'll have a hard time finding the right macros to call.
> It's also very unintuitive when to use a macro/call an interface and
> when not.
> The current policy language is still very much "bottom up", i.e. "these
> is our output, how can we generate it a bit easier", and not "top down",
> i.e. "this is how we want to write the policy, how do we get a useful
> output".


How do these new IDEs that Tresys put out in the last week or so fit into
the picture?  Haven't used them, but they appear to be the start of a
higher-level approach to developing policy and perhaps more intuitive.  I'm
talking about SLIDE (SELinux policy IDE) and the CDS framework IDE tool.

Benji

------=_Part_4515_14306931.1141246772242
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<br><br><div><span class=3D"gmail_quote">On 3/1/06, <b class=3D"gmail_sende=
rname">Erich Schubert</b> &lt;<a href=3D"mailto:erich@debian.org">erich@deb=
ian.org</a>&gt; wrote:</span><blockquote class=3D"gmail_quote" style=3D"bor=
der-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-=
left: 1ex;">
Hello Christopher,<br>Well, I'm still not running SELinux reference policy =
successfully.<br>So anything that actually works is easier to use...<br>E.g=
. if the reference policy would include a users_extra file that<br>labels /=
root
<br>with sysadm prefix... and if that were documented anywhere and wouldn't=
<br>have required me to dive through the source of three packages.<br>Now i=
f ssh login as sysadm_r would work, I'd be mostly done.<br><br>Albeit the d=
ocumented interfaces of current RefPolicy are an
<br>improvement, I don't think that policy writing has become much easier.<=
br>The M4 syntax is still very awkward (backticks, no semicolons), and<br>u=
nless you've read all the policy thoroughly (e.g. because you've<br>written=
 it), you'll have a hard time finding the right macros to call.
<br>It's also very unintuitive when to use a macro/call an interface and<br=
>when not.<br>The current policy language is still very much &quot;bottom u=
p&quot;, i.e. &quot;these<br>is our output, how can we generate it a bit ea=
sier&quot;, and not &quot;top down&quot;,
<br>i.e. &quot;this is how we want to write the policy, how do we get a use=
ful<br>output&quot;.</blockquote><div><br>How do these new IDEs that Tresys=
 put out in the last week or so fit into the picture?&nbsp; Haven't used th=
em, but they appear to be the start of a higher-level approach to developin=
g policy and perhaps more intuitive.&nbsp; I'm talking about SLIDE (SELinux=
 policy IDE) and the CDS framework IDE tool.
<br><br>Benji</div></div>

------=_Part_4515_14306931.1141246772242--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
