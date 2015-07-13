Message-ID: <1436815248.18955.22.camel@redhat.com>
Subject: Re: [PATCH v2] libselinux: use /proc/thread-self when available
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Date: Mon, 13 Jul 2015 14:20:48 -0500
In-Reply-To: <55A3C3AA.2030103@tycho.nsa.gov>
References: <1436793816-19308-1-git-send-email-sds@tycho.nsa.gov>
 <1436794440.18955.15.camel@redhat.com> <55A3C3AA.2030103@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2015-07-13 at 09:56 -0400, Stephen Smalley wrote:
> On 07/13/2015 09:34 AM, Eric Paris wrote:
> > Looks good to me.
> > 
> > That issue also brings up problems with glibc pid caching, right? 
> > Do we
> > need to rip out my *con cache entirely? I remember there was a
> > measurable perf win with the cache, but it has proved a PITA 
> > multiple
> > times. Keeping the cache and fixing/working around the glibc pid
> > caching would mean a tradeoff using getpid(2) instead of getpid(3),
> > even with this patch. Right? Or maybe storing a ctid instead of 
> > cpid
> > and using gettid(2)...
> > 
> > But this patch is LGTM.
> 
> From the discussion in that issue, it sounded like switching to using
> /proc/thread-self would avoid the problem without needing to switch 
> to
> getpid(2), but I have not tested systemd-nspawn --selinux-context 
> after
> the change to confirm this fact.  Certainly it ensures that we always
> open the right path on Linux 3.17 and later.
> 
> I would love to rip out the cache, but I didn't think we were free to 
> do
> so without first reworking coreutils in some manner to avoid the
> repeated getfscreatecon()...setfscreatecon() calls made when copying
> directory trees.

You might be right, but I'm not so sure. After a direct call to clone
the cache has both a cpid and tid saved. So the (incorrect) cached tid
you just fixed. Certainly possible this was the only problem systemd
was having.

But the {get,set}procattrcon_raw() functions also have that cached
cpid. Which is wrong after clone. Which means they will use the cached
values instead of even getting to openattr()...  So maybe systemd
hasn't caused anything to get cached and it will work by change, but
the library is still busted against some users of clone...

I was going to suggest telling systemd to call free_procattr() after
they call their own clone. But even that is busted since it uses
getpid() and libc is going to cache that result.

Seems like we need to s/getpid(3)/getpid(2)/ in that whole file to make
it right...

> 
> > 
> > On Mon, 2015-07-13 at 09:23 -0400, Stephen Smalley wrote:
> > > Linux 3.17 introduced a /proc/thread-self symlink that can be 
> > > used
> > > to reference the proc files of the current thread without needing 
> > > to
> > > use gettid(2).  Use this symlink when it exists, falling back to
> > > using gettid(2) when it does not.  This is generally beneficial, 
> > > but
> > > was specifically motivated by 
> > > https://github.com/systemd/systemd/issues/475.
> > > 
> > > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > ---
> > > Only change is the patch description: /proc/thread-self was 
> > > introduced in
> > > Linux 3.17, not Linux 3.16.
> > > 
> > >  libselinux/src/procattr.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/libselinux/src/procattr.c 
> > > b/libselinux/src/procattr.c
> > > index f990350..e444571 100644
> > > --- a/libselinux/src/procattr.c
> > > +++ b/libselinux/src/procattr.c
> > > @@ -95,6 +95,12 @@ static int openattr(pid_t pid, const char 
> > > *attr, 
> > > int flags)
> > >  	if (pid > 0)
> > >  		rc = asprintf(&path, "/proc/%d/attr/%s", pid, 
> > > attr);
> > >  	else {
> > > +		rc = asprintf(&path, "/proc/thread
> > > -self/attr/%s", 
> > > attr);
> > > +		if (rc < 0)
> > > +			return -1;
> > > +		fd = open(path, flags | O_CLOEXEC);
> > > +		if (fd >= 0 || errno != ENOENT)
> > > +			goto out;
> > >  		if (!tid)
> > >  			tid = gettid();
> > >  		rc = asprintf(&path, 
> > > "/proc/self/task/%d/attr/%s", 
> > > tid, attr);
> > > @@ -103,6 +109,7 @@ static int openattr(pid_t pid, const char 
> > > *attr, 
> > > int flags)
> > >  		return -1;
> > >  
> > >  	fd = open(path, flags | O_CLOEXEC);
> > > +out:
> > >  	free(path);
> > >  	return fd;
> > >  }
> > 
> > 
> 
