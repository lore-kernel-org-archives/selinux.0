Message-ID: <1508938017.10107.2.camel@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, William Roberts
 <bill.c.roberts@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Wed, 25 Oct 2017 09:26:57 -0400
In-Reply-To: <CAJfZ7=kpJj=cz4UHZmd2gjuxOWHXsg0obg6btk6BMQ_VrVXpsw@mail.gmail.com>
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
 <CAFftDdqMNUG256Y_0EnkPog8eabHsL+zqAmSSj_2ztPuBZ2oGA@mail.gmail.com>
 <CAJfZ7=kpJj=cz4UHZmd2gjuxOWHXsg0obg6btk6BMQ_VrVXpsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: travis CI
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-10-24 at 23:00 +0200, Nicolas Iooss wrote:
> On Tue, Oct 24, 2017 at 10:20 PM, William Roberts
> <bill.c.roberts@gmail.com> wrote:
> > On Oct 24, 2017 13:05, "Stephen Smalley" <sds@tycho.nsa.gov> wrote:
> > 
> > On Tue, 2017-10-24 at 09:26 -0700, William Roberts wrote:
> > > Error 52, which if it lines up with what I am reading is
> > > CURLE_GOT_NOTHING
> > > https://curl.haxx.se/libcurl/c/libcurl-errors.html
> > > 
> > > That url/command combo seems valid, likely a transient issue with
> > > github.
> > 
> > I restarted the job, and it failed again in the same way (but on
> > different cases).  Then I restarted it a third time, and this time
> > it
> > ran to completion.  This seems problematic; we likely need to
> > reconsider any use of curl from the travis.yml file.
> > 
> > 
> > Weird. I wget things from sourceforge all the time. The only time I
> > have
> > issues is when sourceforge is down.
> > 
> > > On Tue, Oct 24, 2017 at 9:05 AM, Stephen Smalley <sds@tycho.nsa.g
> > > ov>
> > > wrote:
> 
> [[...]]
> > > > Our .travis.yml seems to yield unstable results,
> > > > https://travis-ci.org/SELinuxProject/selinux/jobs/292128434
> > > > 
> > > > Don't know if it would help to instead download a refpolicy
> > > > release
> > > > and
> > > > extract it, or if this is just transient.
> > > > 
> 
> It looks like transient networking issues between Travis-CI and
> Github. A possible fix would consists in using the Ubuntu package
> which provides refpolicy files: selinux-policy-dev. This however
> introduces the drawback that the package pulls in Ubuntu's version of
> checkpolicy, policycoreutils, libsepol... which may introduce
> incorrect test success if they happen to be used instead of the
> programs from the tested build. So I am not convinced by this.
> 
> I am wondering whether using curl's --retry option would help to work
> around the networking issues which occurred. I am testing this in my
> "curl-retry" branch on Github [1] and will submit a patch if you
> think
> this may work.

Sounds reasonable to me as a quick fix.  Another alternative would be
to include a copy of these files in the selinux repo itself to remove
external dependencies, although that doesn't help with python.

A separate issue with the current travis-ci testing is that it doesn't
exercise any of the python component tests.  On the one hand, it could
be argued that is a bug in the python/Makefile in not propagating down
make test to the sudirs, but only some of those tests can be run as
non-root.  One of the audit2allow tests presently is invoked via sudo
(probably could be changed though to pass -o to sepolgen-ifgen to avoid
requiring root), and the semanage tests operate on the system policy
store and thus require root (possibly could be redirected to an
alternate root, but doesn't look like semanage provides such an option,
unlike semodule -p).  We have this strange inconsistency with the
current tests where some of them can only be run as non-root and others
can only be run as root; likely should be fixed in the tests
themselves.

> 
> Nicolas
> 
> [1] https://github.com/fishilico/selinux/commits/curl-retry
> 
