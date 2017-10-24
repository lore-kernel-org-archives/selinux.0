MIME-Version: 1.0
In-Reply-To: <1508875836.22356.6.camel@tycho.nsa.gov>
References: <CAFftDdoa-iO3E62FSefdnARHGVzLE4znzaFfSd2Q=9bhdG3=eQ@mail.gmail.com>
 <1507841294.30307.4.camel@tycho.nsa.gov>
 <CAFftDdpFtE3fDPJxYTb5Q7Ooa3UpEHAHzRJYee60a_QsNxngiw@mail.gmail.com>
 <CAJfZ7=n7j6kbxd2SGW3FjxMr=EZSiYdttG9mfotUt0F3UFEdgQ@mail.gmail.com>
 <CAFftDdqD-tCZrSu2yB37p0BrtKu7avKes_W5OLmEGCO9ofWt0A@mail.gmail.com>
 <1508269837.21073.4.camel@tycho.nsa.gov>
 <CAFftDdqfBkaomb3SpcEv0vt=a1riHzYQEfzPY5W8OiSEmHrYSw@mail.gmail.com>
 <1508861159.22356.4.camel@tycho.nsa.gov>
 <CAFftDdoQ8HDtnSp9aakXFH4VV2kUMtJ6pShau99=YXpiYypgCQ@mail.gmail.com>
 <1508875836.22356.6.camel@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 24 Oct 2017 13:20:49 -0700
Message-ID: <CAFftDdqMNUG256Y_0EnkPog8eabHsL+zqAmSSj_2ztPuBZ2oGA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: multipart/alternative; boundary="f403045d9170d536d9055c50ac3b"
Subject: Re: travis CI
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045d9170d536d9055c50ac3b
Content-Type: text/plain; charset="UTF-8"

On Oct 24, 2017 13:05, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:

On Tue, 2017-10-24 at 09:26 -0700, William Roberts wrote:
> Error 52, which if it lines up with what I am reading is
> CURLE_GOT_NOTHING
> https://curl.haxx.se/libcurl/c/libcurl-errors.html
>
> That url/command combo seems valid, likely a transient issue with
> github.

I restarted the job, and it failed again in the same way (but on
different cases).  Then I restarted it a third time, and this time it
ran to completion.  This seems problematic; we likely need to
reconsider any use of curl from the travis.yml file.


Weird. I wget things from sourceforge all the time. The only time I have
issues is when sourceforge is down.


>
>
>
>
> On Tue, Oct 24, 2017 at 9:05 AM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Wed, 2017-10-18 at 19:30 -0700, William Roberts wrote:
> > > On Tue, Oct 17, 2017 at 12:50 PM, Stephen Smalley <sds@tycho.nsa.
> > > gov>
> > > wrote:
> > > > On Tue, 2017-10-17 at 11:49 -0700, William Roberts wrote:
> > > > > On Sun, Oct 15, 2017 at 5:10 AM, Nicolas Iooss <nicolas.iooss
> > > > > @m4x
> > > > > .org
> > > > > > wrote:
> > > > > > On Fri, Oct 13, 2017 at 1:50 AM, William Roberts
> > > > > > <bill.c.roberts@gmail.com> wrote:
> > > > > > > On Thu, Oct 12, 2017 at 1:48 PM, Stephen Smalley <sds@tyc
> > > > > > > ho.n
> > > > > > > sa.g
> > > > > > > ov> wrote:
> > > > > > > > On Thu, 2017-10-12 at 11:29 -0700, William Roberts
> > > > > > > > wrote:
> > > > > > > > > I see a travis.yml file, recently modified by
> > > > > > > > > Nicolas,
> > > > > > > > > but I
> > > > > > > > > failed
> > > > > > > > > to
> > > > > > > > > find the Travis CI instance on travis.org, where is
> > > > > > > > > it?
> > > > > > > > >
> > > > > > > > > We should likely have it running on commits to the
> > > > > > > > > repo
> > > > > > > > > and
> > > > > > > > > PRs so we
> > > > > > > > > can have some independent way of verifying that our
> > > > > > > > > run
> > > > > > > > > of
> > > > > > > > > the tests
> > > > > > > > > was compromised by some env variation or mistake.
> > > > > > > > >
> > > > > > > > > Thoughts?
> > > > > > > >
> > > > > > > > To date he has just run it on his own fork.  Not
> > > > > > > > opposed to
> > > > > > > > enabling
> > > > > > > > it, just haven't looked into that...
> > > > > > >
> > > > > > > I have done it for my some of my projects, Ill go ahead
> > > > > > > and
> > > > > > > set
> > > > > > > this up.
> > > > > >
> > > > > > I configured Travis-CI to test the branches in my Github
> > > > > > repository
> > > > > > a
> > > > > > little more than one year ago, after several build
> > > > > > configurations
> > > > > > got
> > > > > > broken (clang on Linux for example). I later added more
> > > > > > features to
> > > > > > it
> > > > > > (for example warning about missing .gitignore entries,
> > > > > > testing
> > > > > > several
> > > > > > Ruby and Python versions, etc), before I upstreamed my
> > > > > > .travis.yml
> > > > > > file (a few months ago). When I did it, my main motivation
> > > > > > was
> > > > > > to
> > > > > > simplify the job of anyone who would want to configure a CI
> > > > > > system
> > > > > > on
> > > > > > the project (the building rules and dependencies should be
> > > > > > quite
> > > > > > similar). Using a continuous integration system is useful
> > > > > > to
> > > > > > prevent
> > > > > > simple regression issues which would otherwise only be
> > > > > > detected
> > > > > > when
> > > > > > someone running a specific configuration tries to build the
> > > > > > project.
> > > > > >
> > > > > > Before asking to enable Travis-CI on the main SELinux
> > > > > > repository, I
> > > > > > wanted to make sure it was stable/reliable enough. To do
> > > > > > this,
> > > > > > I
> > > > > > created a branch named "travis-upstream" in my repository,
> > > > > > which
> > > > > > tracked the master branch of the main repository. All went
> > > > > > well
> > > > > > for
> > > > > > quite some time, until Travis-CI modified this summer their
> > > > > > environments, introducing some incompatibilities with
> > > > > > projects
> > > > > > which
> > > > > > use several programming languages. Thankfully these changes
> > > > > > have
> > > > > > been
> > > > > > documented in Travis-CI's blog and I updated the config
> > > > > > file to
> > > > > > fix
> > > > > > the builds with commits b1ea8120832d ("Travis-CI: use
> > > > > > sugulite
> > > > > > environment") and 6d9258e5a05f ("Travis-CI: fix
> > > > > > configuration
> > > > > > after
> > > > > > September's update"). As Travis-CI does not seem to want to
> > > > > > support
> > > > > > multi-language projects (cf.
> > > > > > https://github.com/travis-ci/travis-ci/issues/4090 for
> > > > > > example),
> > > > > > more
> > > > > > breaking changes could be introduced as the provided
> > > > > > environment
> > > > > > are
> > > > > > upgraded. Nevertheless I expect that such changes are quite
> > > > > > easily
> > > > > > fixable.
> > > > > >
> > > > > > In short, using a CI platform is useful and Travis-CI is a
> > > > > > free
> > > > > > one
> > > > > > which makes it possible to test several build
> > > > > > configurations (I
> > > > > > also
> > > > > > tried Circle-CI, which did not provide a similar feature)
> > > > > > and
> > > > > > maintaining a working configuration does not require much
> > > > > > effort.
> > > > > > Moreover when a Travis-CI job fails, the log contains the
> > > > > > console
> > > > > > output which usually is very clear about what has gone
> > > > > > wrong.
> > > > > > Travis-CI now also provides Docker images which help
> > > > > > reproducing
> > > > > > issues and understanding their cause without needing to
> > > > > > submit
> > > > > > a
> > > > > > new
> > > > > > job.
> > > > > >
> > > > > > If you want to set this platform up for SELinux userspace
> > > > > > project,
> > > > > > please go ahead :)
> > > > > >
> > > > > > Cheers,
> > > > > > Nicolas
> > > > > >
> > > > >
> > > > > I tried to turn it on in travis, but got the message:
> > > > >
> > > > > This is not an active repository
> > > > >
> > > > > You don't have sufficient rights to enable this repo on
> > > > > Travis.
> > > > > Please contact the admin to enable it or to receive admin
> > > > > rights
> > > > > yourself.
> > > > >
> > > > > Stephen maybe you can do this, or grant me the permissions?
> > > > >
> > > > > You should be able to go here:
> > > > > https://travis-ci.org
> > > > >
> > > > > And login, and then in your organization for selinux flip the
> > > > > switch
> > > > > for travis. Once it's on, and working, we can add the badge
> > > > > to
> > > > > the
> > > > > README
> > > > > file for build status.
> > > >
> > > > Enabled now for the selinux repo.
> > > >
> > >
> > > FYI this is up and running thanks to Nicolas's .travis.yml.
> > >
> > > You can see it verifying this PR
> > > https://github.com/SELinuxProject/selinux/pull/66
> > >
> > > I've submitted that patch to the mailing list as well.
> >
> > Our .travis.yml seems to yield unstable results,
> > https://travis-ci.org/SELinuxProject/selinux/jobs/292128434
> >
> > Don't know if it would help to instead download a refpolicy release
> > and
> > extract it, or if this is just transient.
> >
>
>
>

--f403045d9170d536d9055c50ac3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Oct 24, 2017 13:05, &quot;Stephen Smalley&quot; &lt;<a href=3D=
"mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br type=3D"attr=
ibution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><div class=3D"quoted-text">On Tue, 2017-1=
0-24 at 09:26 -0700, William Roberts wrote:<br>
</div><div class=3D"quoted-text">&gt; Error 52, which if it lines up with w=
hat I am reading is<br>
&gt; CURLE_GOT_NOTHING<br>
&gt; <a href=3D"https://curl.haxx.se/libcurl/c/libcurl-errors.html" rel=3D"=
noreferrer" target=3D"_blank">https://curl.haxx.se/libcurl/<wbr>c/libcurl-e=
rrors.html</a><br>
&gt;<br>
&gt; That url/command combo seems valid, likely a transient issue with<br>
&gt; github.<br>
<br>
</div>I restarted the job, and it failed again in the same way (but on<br>
different cases).=C2=A0 Then I restarted it a third time, and this time it<=
br>
ran to completion.=C2=A0 This seems problematic; we likely need to<br>
reconsider any use of curl from the travis.yml file.<br></blockquote></div>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Weird. I wget thi=
ngs from sourceforge all the time. The only time I have issues is when sour=
ceforge is down.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"elided-text"><br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Tue, Oct 24, 2017 at 9:05 AM, Stephen Smalley &lt;<a href=3D"mailto=
:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;<br>
&gt; wrote:<br>
&gt; &gt; On Wed, 2017-10-18 at 19:30 -0700, William Roberts wrote:<br>
&gt; &gt; &gt; On Tue, Oct 17, 2017 at 12:50 PM, Stephen Smalley &lt;sds@ty=
cho.nsa.<br>
&gt; &gt; &gt; gov&gt;<br>
&gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; On Tue, 2017-10-17 at 11:49 -0700, William Roberts wrot=
e:<br>
&gt; &gt; &gt; &gt; &gt; On Sun, Oct 15, 2017 at 5:10 AM, Nicolas Iooss &lt=
;nicolas.iooss<br>
&gt; &gt; &gt; &gt; &gt; @m4x<br>
&gt; &gt; &gt; &gt; &gt; .org<br>
&gt; &gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; On Fri, Oct 13, 2017 at 1:50 AM, William Robe=
rts<br>
&gt; &gt; &gt; &gt; &gt; &gt; &lt;<a href=3D"mailto:bill.c.roberts@gmail.co=
m">bill.c.roberts@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; On Thu, Oct 12, 2017 at 1:48 PM, Stephen=
 Smalley &lt;sds@tyc<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ho.n<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; sa.g<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; ov&gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; On Thu, 2017-10-12 at 11:29 -0700, =
William Roberts<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; wrote:<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; I see a travis.yml file, recen=
tly modified by<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Nicolas,<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; but I<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; failed<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; find the Travis CI instance on=
 <a href=3D"http://travis.org" rel=3D"noreferrer" target=3D"_blank">travis.=
org</a>, where is<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; it?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; We should likely have it runni=
ng on commits to the<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; repo<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; PRs so we<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; can have some independent way =
of verifying that our<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; run<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; of<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; the tests<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; was compromised by some env va=
riation or mistake.<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; Thoughts?<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; To date he has just run it on his o=
wn fork.=C2=A0=C2=A0Not<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; opposed to<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; enabling<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; &gt; it, just haven&#39;t looked into th=
at...<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; I have done it for my some of my project=
s, Ill go ahead<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; and<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; set<br>
&gt; &gt; &gt; &gt; &gt; &gt; &gt; this up.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; I configured Travis-CI to test the branches i=
n my Github<br>
&gt; &gt; &gt; &gt; &gt; &gt; repository<br>
&gt; &gt; &gt; &gt; &gt; &gt; a<br>
&gt; &gt; &gt; &gt; &gt; &gt; little more than one year ago, after several =
build<br>
&gt; &gt; &gt; &gt; &gt; &gt; configurations<br>
&gt; &gt; &gt; &gt; &gt; &gt; got<br>
&gt; &gt; &gt; &gt; &gt; &gt; broken (clang on Linux for example). I later =
added more<br>
&gt; &gt; &gt; &gt; &gt; &gt; features to<br>
&gt; &gt; &gt; &gt; &gt; &gt; it<br>
&gt; &gt; &gt; &gt; &gt; &gt; (for example warning about missing .gitignore=
 entries,<br>
&gt; &gt; &gt; &gt; &gt; &gt; testing<br>
&gt; &gt; &gt; &gt; &gt; &gt; several<br>
&gt; &gt; &gt; &gt; &gt; &gt; Ruby and Python versions, etc), before I upst=
reamed my<br>
&gt; &gt; &gt; &gt; &gt; &gt; .travis.yml<br>
&gt; &gt; &gt; &gt; &gt; &gt; file (a few months ago). When I did it, my ma=
in motivation<br>
&gt; &gt; &gt; &gt; &gt; &gt; was<br>
&gt; &gt; &gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; simplify the job of anyone who would want to =
configure a CI<br>
&gt; &gt; &gt; &gt; &gt; &gt; system<br>
&gt; &gt; &gt; &gt; &gt; &gt; on<br>
&gt; &gt; &gt; &gt; &gt; &gt; the project (the building rules and dependenc=
ies should be<br>
&gt; &gt; &gt; &gt; &gt; &gt; quite<br>
&gt; &gt; &gt; &gt; &gt; &gt; similar). Using a continuous integration syst=
em is useful<br>
&gt; &gt; &gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; &gt; prevent<br>
&gt; &gt; &gt; &gt; &gt; &gt; simple regression issues which would otherwis=
e only be<br>
&gt; &gt; &gt; &gt; &gt; &gt; detected<br>
&gt; &gt; &gt; &gt; &gt; &gt; when<br>
&gt; &gt; &gt; &gt; &gt; &gt; someone running a specific configuration trie=
s to build the<br>
&gt; &gt; &gt; &gt; &gt; &gt; project.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Before asking to enable Travis-CI on the main=
 SELinux<br>
&gt; &gt; &gt; &gt; &gt; &gt; repository, I<br>
&gt; &gt; &gt; &gt; &gt; &gt; wanted to make sure it was stable/reliable en=
ough. To do<br>
&gt; &gt; &gt; &gt; &gt; &gt; this,<br>
&gt; &gt; &gt; &gt; &gt; &gt; I<br>
&gt; &gt; &gt; &gt; &gt; &gt; created a branch named &quot;travis-upstream&=
quot; in my repository,<br>
&gt; &gt; &gt; &gt; &gt; &gt; which<br>
&gt; &gt; &gt; &gt; &gt; &gt; tracked the master branch of the main reposit=
ory. All went<br>
&gt; &gt; &gt; &gt; &gt; &gt; well<br>
&gt; &gt; &gt; &gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; &gt; quite some time, until Travis-CI modified thi=
s summer their<br>
&gt; &gt; &gt; &gt; &gt; &gt; environments, introducing some incompatibilit=
ies with<br>
&gt; &gt; &gt; &gt; &gt; &gt; projects<br>
&gt; &gt; &gt; &gt; &gt; &gt; which<br>
&gt; &gt; &gt; &gt; &gt; &gt; use several programming languages. Thankfully=
 these changes<br>
&gt; &gt; &gt; &gt; &gt; &gt; have<br>
&gt; &gt; &gt; &gt; &gt; &gt; been<br>
&gt; &gt; &gt; &gt; &gt; &gt; documented in Travis-CI&#39;s blog and I upda=
ted the config<br>
&gt; &gt; &gt; &gt; &gt; &gt; file to<br>
&gt; &gt; &gt; &gt; &gt; &gt; fix<br>
&gt; &gt; &gt; &gt; &gt; &gt; the builds with commits b1ea8120832d (&quot;T=
ravis-CI: use<br>
&gt; &gt; &gt; &gt; &gt; &gt; sugulite<br>
&gt; &gt; &gt; &gt; &gt; &gt; environment&quot;) and 6d9258e5a05f (&quot;Tr=
avis-CI: fix<br>
&gt; &gt; &gt; &gt; &gt; &gt; configuration<br>
&gt; &gt; &gt; &gt; &gt; &gt; after<br>
&gt; &gt; &gt; &gt; &gt; &gt; September&#39;s update&quot;). As Travis-CI d=
oes not seem to want to<br>
&gt; &gt; &gt; &gt; &gt; &gt; support<br>
&gt; &gt; &gt; &gt; &gt; &gt; multi-language projects (cf.<br>
&gt; &gt; &gt; &gt; &gt; &gt; <a href=3D"https://github.com/travis-ci/travi=
s-ci/issues/4090" rel=3D"noreferrer" target=3D"_blank">https://github.com/t=
ravis-ci/<wbr>travis-ci/issues/4090</a> for<br>
&gt; &gt; &gt; &gt; &gt; &gt; example),<br>
&gt; &gt; &gt; &gt; &gt; &gt; more<br>
&gt; &gt; &gt; &gt; &gt; &gt; breaking changes could be introduced as the p=
rovided<br>
&gt; &gt; &gt; &gt; &gt; &gt; environment<br>
&gt; &gt; &gt; &gt; &gt; &gt; are<br>
&gt; &gt; &gt; &gt; &gt; &gt; upgraded. Nevertheless I expect that such cha=
nges are quite<br>
&gt; &gt; &gt; &gt; &gt; &gt; easily<br>
&gt; &gt; &gt; &gt; &gt; &gt; fixable.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; In short, using a CI platform is useful and T=
ravis-CI is a<br>
&gt; &gt; &gt; &gt; &gt; &gt; free<br>
&gt; &gt; &gt; &gt; &gt; &gt; one<br>
&gt; &gt; &gt; &gt; &gt; &gt; which makes it possible to test several build=
<br>
&gt; &gt; &gt; &gt; &gt; &gt; configurations (I<br>
&gt; &gt; &gt; &gt; &gt; &gt; also<br>
&gt; &gt; &gt; &gt; &gt; &gt; tried Circle-CI, which did not provide a simi=
lar feature)<br>
&gt; &gt; &gt; &gt; &gt; &gt; and<br>
&gt; &gt; &gt; &gt; &gt; &gt; maintaining a working configuration does not =
require much<br>
&gt; &gt; &gt; &gt; &gt; &gt; effort.<br>
&gt; &gt; &gt; &gt; &gt; &gt; Moreover when a Travis-CI job fails, the log =
contains the<br>
&gt; &gt; &gt; &gt; &gt; &gt; console<br>
&gt; &gt; &gt; &gt; &gt; &gt; output which usually is very clear about what=
 has gone<br>
&gt; &gt; &gt; &gt; &gt; &gt; wrong.<br>
&gt; &gt; &gt; &gt; &gt; &gt; Travis-CI now also provides Docker images whi=
ch help<br>
&gt; &gt; &gt; &gt; &gt; &gt; reproducing<br>
&gt; &gt; &gt; &gt; &gt; &gt; issues and understanding their cause without =
needing to<br>
&gt; &gt; &gt; &gt; &gt; &gt; submit<br>
&gt; &gt; &gt; &gt; &gt; &gt; a<br>
&gt; &gt; &gt; &gt; &gt; &gt; new<br>
&gt; &gt; &gt; &gt; &gt; &gt; job.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; If you want to set this platform up for SELin=
ux userspace<br>
&gt; &gt; &gt; &gt; &gt; &gt; project,<br>
&gt; &gt; &gt; &gt; &gt; &gt; please go ahead :)<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Cheers,<br>
&gt; &gt; &gt; &gt; &gt; &gt; Nicolas<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I tried to turn it on in travis, but got the messa=
ge:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; This is not an active repository<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; You don&#39;t have sufficient rights to enable thi=
s repo on<br>
&gt; &gt; &gt; &gt; &gt; Travis.<br>
&gt; &gt; &gt; &gt; &gt; Please contact the admin to enable it or to receiv=
e admin<br>
&gt; &gt; &gt; &gt; &gt; rights<br>
&gt; &gt; &gt; &gt; &gt; yourself.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Stephen maybe you can do this, or grant me the per=
missions?<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; You should be able to go here:<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://travis-ci.org" rel=3D"noreferre=
r" target=3D"_blank">https://travis-ci.org</a><br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; And login, and then in your organization for selin=
ux flip the<br>
&gt; &gt; &gt; &gt; &gt; switch<br>
&gt; &gt; &gt; &gt; &gt; for travis. Once it&#39;s on, and working, we can =
add the badge<br>
&gt; &gt; &gt; &gt; &gt; to<br>
&gt; &gt; &gt; &gt; &gt; the<br>
&gt; &gt; &gt; &gt; &gt; README<br>
&gt; &gt; &gt; &gt; &gt; file for build status.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Enabled now for the selinux repo.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; FYI this is up and running thanks to Nicolas&#39;s .travis.y=
ml.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; You can see it verifying this PR<br>
&gt; &gt; &gt; <a href=3D"https://github.com/SELinuxProject/selinux/pull/66=
" rel=3D"noreferrer" target=3D"_blank">https://github.com/<wbr>SELinuxProje=
ct/selinux/pull/66</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I&#39;ve submitted that patch to the mailing list as well.<b=
r>
&gt; &gt;<br>
&gt; &gt; Our .travis.yml seems to yield unstable results,<br>
&gt; &gt; <a href=3D"https://travis-ci.org/SELinuxProject/selinux/jobs/2921=
28434" rel=3D"noreferrer" target=3D"_blank">https://travis-ci.org/<wbr>SELi=
nuxProject/selinux/jobs/<wbr>292128434</a><br>
&gt; &gt;<br>
&gt; &gt; Don&#39;t know if it would help to instead download a refpolicy r=
elease<br>
&gt; &gt; and<br>
&gt; &gt; extract it, or if this is just transient.<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
</div></blockquote></div><br></div></div></div>

--f403045d9170d536d9055c50ac3b--
