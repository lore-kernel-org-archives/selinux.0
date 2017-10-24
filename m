Message-ID: <1508875836.22356.6.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>, Nicolas Iooss
 <nicolas.iooss@m4x.org>
Date: Tue, 24 Oct 2017 16:10:36 -0400
In-Reply-To: <CAFftDdoQ8HDtnSp9aakXFH4VV2kUMtJ6pShau99=YXpiYypgCQ@mail.gmail.com>
References: <CAFftDdoa-iO3E62FSefdnARHGVzLE4znzaFfSd2Q=9bhdG3=eQ@mail.gmail.com>
 <1507841294.30307.4.camel@tycho.nsa.gov>
 <CAFftDdpFtE3fDPJxYTb5Q7Ooa3UpEHAHzRJYee60a_QsNxngiw@mail.gmail.com>
 <CAJfZ7=n7j6kbxd2SGW3FjxMr=EZSiYdttG9mfotUt0F3UFEdgQ@mail.gmail.com>
 <CAFftDdqD-tCZrSu2yB37p0BrtKu7avKes_W5OLmEGCO9ofWt0A@mail.gmail.com>
 <1508269837.21073.4.camel@tycho.nsa.gov>
 <CAFftDdqfBkaomb3SpcEv0vt=a1riHzYQEfzPY5W8OiSEmHrYSw@mail.gmail.com>
 <1508861159.22356.4.camel@tycho.nsa.gov>
 <CAFftDdoQ8HDtnSp9aakXFH4VV2kUMtJ6pShau99=YXpiYypgCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: travis CI
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

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
> > > > > > > > To date he has just run it on his own fork.  Not
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
