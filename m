Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w7JI1Rc6018092
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 14:01:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so22079172oib.6
 for <selinux@tycho.nsa.gov>; Sun, 19 Aug 2018 11:01:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJfZ7=nsH+79FzdmFvkG3iC7hBkQEVWicZym5d_KD0+MwJyB6g@mail.gmail.com>
References: <20180818175033.13100-1-nicolas.iooss@m4x.org>
 <20180818175033.13100-2-nicolas.iooss@m4x.org>
 <CAFftDdr5ZFUUXQZhVDDUTjVRJb6b_zZ4MxHRxTN2d2t5yXXOZA@mail.gmail.com>
 <CAJfZ7=nsH+79FzdmFvkG3iC7hBkQEVWicZym5d_KD0+MwJyB6g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Sun, 19 Aug 2018 11:01:14 -0700
Message-ID: <CAFftDdrcGgr1wxkMOyxfwAUavMB4jKK3YQP5VkF2BtpA1SHpbg@mail.gmail.com>
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="0000000000002bff7e0573cd94d0"
Subject: Re: [PATCH 2/2] libsemanage: make pywrap-test.py compatible
 with Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000002bff7e0573cd94d0
Content-Type: text/plain; charset="UTF-8"

On Sun, Aug 19, 2018 at 1:53 AM, Nicolas Iooss <nicolas.iooss@m4x.org>
wrote:

> On Sat, Aug 18, 2018 at 8:43 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
> >
> > Im assuming with your attention on the python side of the house we're
> going to see a lot of
> > formatting change patches heading the mailing list. I don't have any
> problems with them.
> >
> > Are you using some formatter for these, if so which one is it? Is it
> flake8 still?
>
> I did not use a "formatter" here (I do not consider 2to3 to be a
> formatter). I only looked at pep8 and pylint warnings and modified the
> code with search-and-replace commands on the file (using regular
> expressions). I usually do not like large changes which reindent a
> file or add spaces, because it increases the amount of work needed to
> backport a later bugfix to released versions, for package maintainers.
> Nevertheless when the modified file is not used "in production" (only
> when debugging issues or when testing things), as is the case here, I
> prefer cleaning up the code.
>

This seems reasonable. Clean up flake8 errors while ensuring we don't
introduce
new ones.


> > We should probably document that patches should be sent formatted, ie if
> a patch introduces a delta
> > after applying the patch and running <formatter>, it's an issue.
>
> I upstreamed scripts/run-flake8 with this in mind ;) (and this is why
> I added it to Travis-CI tests too). And one of the reasons that led me
> to disable many warnings was to preserve some flexibility in order not
> to make submitting patches too hard for new contributors.
>
> In the next days, I plan to send some more patches to fix some
> formatting issues I consider important (for example removing
> semicolons at the end of Python statements), but I will not send
> patches which modify the spaces around operators in files where there
> could be bugs which would need to be backported.
>

When I review these I am literally just applying the patches, running the
test and
making sure that flake8 errors go down. I'm thinking for these, since you
have
we have this integrated in the build, send the patches, but if no one
responds
id be ok with you applying them. Albeit this not 100% in line with agreed
practices
these patches are just mostly large noise changes. Does anyone rebuke this?


>
> As always, thanks for your review!
> Nicolas
>
> PS: I am also playing with clang's static analyzer and I am currently
> testing a CircleCI configuration which runs it on every push (using
> scripts/run-scan-build) and publishes the results as HTML build
> artifacts. I will submit a proper patch for this once it is stable
> enough and once all the most important issues reported by the analyzer
> are fixed.
>

Oh the HTML will be interesting. I have scan-build integrated in my Travis
for other projects. Its nice.

--0000000000002bff7e0573cd94d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Aug 19, 2018 at 1:53 AM, Nicolas Iooss <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:nicolas.iooss@m4x.org" target=3D"_blank">nicolas.iooss@m4x.=
org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"=
">On Sat, Aug 18, 2018 at 8:43 PM William Roberts<br>
&lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a=
>&gt; wrote:<br>
&gt;<br>
&gt; Im assuming with your attention on the python side of the house we&#39=
;re going to see a lot of<br>
&gt; formatting change patches heading the mailing list. I don&#39;t have a=
ny problems with them.<br>
&gt;<br>
&gt; Are you using some formatter for these, if so which one is it? Is it f=
lake8 still?<br>
<br>
</span>I did not use a &quot;formatter&quot; here (I do not consider 2to3 t=
o be a<br>
formatter). I only looked at pep8 and pylint warnings and modified the<br>
code with search-and-replace commands on the file (using regular<br>
expressions). I usually do not like large changes which reindent a<br>
file or add spaces, because it increases the amount of work needed to<br>
backport a later bugfix to released versions, for package maintainers.<br>
Nevertheless when the modified file is not used &quot;in production&quot; (=
only<br>
when debugging issues or when testing things), as is the case here, I<br>
prefer cleaning up the code.<br></blockquote><div><br></div><div>This seems=
 reasonable. Clean up flake8 errors while ensuring we don&#39;t introduce</=
div><div>new ones.</div><div><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; We should probably document that patches should be sent formatted, ie =
if a patch introduces a delta<br>
&gt; after applying the patch and running &lt;formatter&gt;, it&#39;s an is=
sue.<br>
<br>
</span>I upstreamed scripts/run-flake8 with this in mind ;) (and this is wh=
y<br>
I added it to Travis-CI tests too). And one of the reasons that led me<br>
to disable many warnings was to preserve some flexibility in order not<br>
to make submitting patches too hard for new contributors.<br>
<br>
In the next days, I plan to send some more patches to fix some<br>
formatting issues I consider important (for example removing<br>
semicolons at the end of Python statements), but I will not send<br>
patches which modify the spaces around operators in files where there<br>
could be bugs which would need to be backported.<br></blockquote><div><br><=
/div><div>When I review these I am literally just applying the patches, run=
ning the test and</div><div>making sure that flake8 errors go down. I&#39;m=
 thinking for these, since you have</div><div>we have this integrated in th=
e build, send the patches, but if no one responds</div><div>id be ok with y=
ou applying them. Albeit this not 100% in line with agreed practices</div><=
div>these patches are just mostly large noise changes. Does anyone rebuke t=
his?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
As always, thanks for your review!<br>
Nicolas<br>
<br>
PS: I am also playing with clang&#39;s static analyzer and I am currently<b=
r>
testing a CircleCI configuration which runs it on every push (using<br>
scripts/run-scan-build) and publishes the results as HTML build<br>
artifacts. I will submit a proper patch for this once it is stable<br>
enough and once all the most important issues reported by the analyzer<br>
are fixed.<br></blockquote><div><br></div><div>Oh the HTML will be interest=
ing. I have scan-build integrated in my Travis</div><div>for other projects=
. Its nice.=C2=A0</div></div><br></div></div>

--0000000000002bff7e0573cd94d0--
