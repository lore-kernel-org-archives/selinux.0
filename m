Message-ID: <1495816382.4586.5.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] all: use ./tools/check-syntax to fix the existing code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@tycho.nsa.gov
Date: Fri, 26 May 2017 12:33:02 -0400
In-Reply-To: <CAHC9VhS7OY5TQtUw=7ECw1k1SZAnb5HUGbvX7GeoP8t7GfvPnQ@mail.gmail.com>
References: <149581413266.13714.10451742889870299166.stgit@sifl>
 <149581428964.13714.3317522790537623046.stgit@sifl>
 <1495815354.4586.3.camel@tycho.nsa.gov>
 <CAHC9VhS7OY5TQtUw=7ECw1k1SZAnb5HUGbvX7GeoP8t7GfvPnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-26 at 12:16 -0400, Paul Moore wrote:
> On Fri, May 26, 2017 at 12:15 PM, Stephen Smalley <sds@tycho.nsa.gov>
> wrote:
> > On Fri, 2017-05-26 at 11:58 -0400, Paul Moore wrote:
> > > From: Paul Moore <paul@paul-moore.com>
> > > 
> > > The results of running './tools/check-syntax -f' across the repo.
> > > 
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > ---
> > >  tests/cap_userns/userns_child_exec.c |  455 ++++++++++++++++++
> > > ----
> > > ------------
> > >  tests/mmap/mprotect_stack_thread.c   |    3
> > >  tests/mmap/shmat.c                   |    2
> > >  tests/unix_socket/client.c           |   14 +
> > >  tests/unix_socket/server.c           |    8 -
> > >  5 files changed, 253 insertions(+), 229 deletions(-)
> 
> ...
> 
> > > diff --git a/tests/mmap/shmat.c b/tests/mmap/shmat.c
> > > index 4467d64..56baaca 100644
> > > --- a/tests/mmap/shmat.c
> > > +++ b/tests/mmap/shmat.c
> > > @@ -15,7 +15,7 @@ int main(void)
> > >               exit(1);
> > >       }
> > >       execmem = shmat(shmid, 0, SHM_EXEC);
> > > -     if (execmem == ((void *) -1)) {
> > > +     if (execmem == ((void *) - 1)) {
> > 
> > That doesn't seem like an improvement.
> 
> I agree that astyle sometimes makes some odd choices, but I think the
> occasional oddity is far outweighed by having an automated style
> verification.  If you can figure out the magic astyle command line to
> fix the above that would be great, I tried some time ago and couldn't
> find anything.
> 
> I haven't pushed these two patches yet because I realize they could
> be
> a bit contentious, I can drop them if you prefer.

No, that's fine.  Just seems like a bug in astyle.
