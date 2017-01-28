MIME-Version: 1.0
In-Reply-To: <1485528933.12027.5.camel@tycho.nsa.gov>
References: <20170127124749.7527-1-richard_c_haines@btinternet.com>
 <1485528933.12027.5.camel@tycho.nsa.gov>
From: Alan Jenkins <alan.christopher.jenkins@gmail.com>
Date: Sat, 28 Jan 2017 12:21:24 +0000
Message-ID: <CANmMgnF_p7_EYTaTJMVU_F6TYKhD0at7x5A39qMN2n26pUXq2g@mail.gmail.com>
Subject: Re: [PATCH] setfiles: Fix setfiles progress indicator
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Richard Haines <richard_c_haines@btinternet.com>,
 selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a11439e3ef8c7930547269ecc
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11439e3ef8c7930547269ecc
Content-Type: text/plain; charset=UTF-8

On 27 January 2017 at 14:55, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Fri, 2017-01-27 at 12:47 +0000, Richard Haines wrote:
> > This fixes the following bug:
> > UX regression: setfiles progress indicator is now misleading and
> > confusing in fixfiles.
> >
> > The outputting of * is replaced by the number of files in 1k
> > increments
> > as the previous versions. If "/" is specified on the pathname, then
> > this
> > will indicate a mass relabel, an example output will be:
> > restorecon -nRp /etc /tmp /boot /
> > /etc 100.0%
> > /tmp 100.0%
> > /boot 100.0%
> > 3.2%
> >
> > Also setfiles(8) and restorecon(8) versions that are implemented
> > using
> > the selinux_restorecon(3) function do not support the [-o filename]
> > option as this was deprecated. This has now been made clear by
> > displaying
> > a message to stderr.
> >
> > The documentation has also been updated to reflect these changes.
> >
> > Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>
>
On 27/01/2017, stephensmalley <notifications@github.com> wrote:
> Fixed by 454768f56d7a941657d800e303994bca086b7546
> There is a change in the UX with respect to reporting progress
> per-filesystem; hopefully that isn't too noisy.
> Other, separate issue is likely that we ought to exclude more of these
> filesystems in fixfiles, as we used to do before introducing seclabel
mount
> option.

Thanks!  I'm sitting in a youth hostel with duff knees, rain outside, and a
Chromebook.  So I can't test this but I have a couple of comments I can
make.

I think the path e.g.`/etc` should be visible next to the percentage right
from the start.  Then I think this output would be fine.  (Because fixfiles
already prints the list of filesystems it's going to relabel at the start).

Having the current progress line showing without the path, but completed
progress lines showing with the path, seems less informative and actively
confusing.

I had another concern looking at the commit message though. The example
shown is suspicious.

The implication is it shows reasonable % progress, for each argument in
turn.  E.g. /etc goes from 0% to 100%, then then next argument is
processed.  But I can't see this working in the code.

/etc is never a separate filesystem (fstab is in /etc).  IIRC from comments
or commit messages, progress indication used the number of inodes on the
target filesystem.  In that case it couldn't possibly have shown progress
correctly for /etc, not as a separate line, so this made me curious.

Looking at the commit, accurate progress indication still seems to rely on
the inode count, so I still have this concern.  (`statvfs` and subtracting
# of files from the max inode count for the FS.  I wonder how this works on
btrfs).

I think the API documentation would want to be improved as well. I would
optimistically read it as saying I could set
SELINUX_RESTORECON_MASS_RELABEL anytime I relabel a large number of files
and want some nice % progress indicator.  But this cannot be true.  AFAICS,
the flag SELINUX_RESTORECON_MASS_RELABEL will only work correctly when
relabelling *everything*; all files on all supported filesystems.  That's
what `exclude_non_seclabel_mounts()` is counting.

Also - I've only checked this now, but I think `restorecon -p / /etc /tmp
/boot` is suspicious for a second reason.  Unlike `setfiles`, `restorecon`
does `xdev = 0; /* Follows mounts */`.  So I don't think it's a good
example command to pass other arguments along with `/`; I don't think you
would ever want to do this.

Regards
Alan


> Thanks, applied.
>
> > ---
> >  libselinux/include/selinux/restorecon.h  | 11 +++++++---
> >  libselinux/man/man3/selinux_restorecon.3 | 12 +++++++++--
> >  libselinux/src/selinux_restorecon.c      | 37 ++++++++------------
> > ------------
> >  policycoreutils/setfiles/.gitignore      |  1 -
> >  policycoreutils/setfiles/Makefile        |  7 ++----
> >  policycoreutils/setfiles/restore.c       |  3 ++-
> >  policycoreutils/setfiles/restore.h       |  9 +-------
> >  policycoreutils/setfiles/restorecon.8    |  4 ++--
> >  policycoreutils/setfiles/setfiles.8      |  6 +++---
> >  policycoreutils/setfiles/setfiles.c      | 27 +++++++---------------
> > -
> >  10 files changed, 45 insertions(+), 72 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/restorecon.h
> > b/libselinux/include/selinux/restorecon.h
> > index 7cfdee1..de694cd 100644
> > --- a/libselinux/include/selinux/restorecon.h
> > +++ b/libselinux/include/selinux/restorecon.h
> > @@ -50,9 +50,9 @@ extern int selinux_restorecon(const char *pathname,
> >   */
> >  #define SELINUX_RESTORECON_VERBOSE                   0x0010
> >  /*
> > - * Show progress by printing * to stdout every 1000 files, unless
> > - * relabeling the entire OS, that will then show the approximate
> > - * percentage complete.
> > + * If SELINUX_RESTORECON_PROGRESS is true and
> > + * SELINUX_RESTORECON_MASS_RELABEL is true, then output approx %
> > complete,
> > + * else output the number of files in 1k blocks processed to stdout.
> >   */
> >  #define SELINUX_RESTORECON_PROGRESS                  0x0020
> >  /*
> > @@ -91,6 +91,11 @@ extern int selinux_restorecon(const char
> > *pathname,
> >   * mounts to be excluded from relabeling checks.
> >   */
> >  #define SELINUX_RESTORECON_IGNORE_MOUNTS             0x2000
> > +/*
> > + * Set if there is a mass relabel required.
> > + * See SELINUX_RESTORECON_PROGRESS flag for details.
> > + */
> > +#define SELINUX_RESTORECON_MASS_RELABEL                      0x400
> > 0
> >
> >  /**
> >   * selinux_restorecon_set_sehandle - Set the global fc handle.
> > diff --git a/libselinux/man/man3/selinux_restorecon.3
> > b/libselinux/man/man3/selinux_restorecon.3
> > index d698818..1eac6ed 100644
> > --- a/libselinux/man/man3/selinux_restorecon.3
> > +++ b/libselinux/man/man3/selinux_restorecon.3
> > @@ -88,8 +88,16 @@ will take precedence.
> >  .RE
> >  .sp
> >  .B SELINUX_RESTORECON_PROGRESS
> > -show progress by printing * to stdout every 1000 files unless
> > relabeling the
> > -entire OS, that will then show the approximate percentage complete.
> > +show progress by outputting the number of files in 1k blocks
> > processed
> > +to stdout. If the
> > +.B SELINUX_RESTORECON_MASS_RELABEL
> > +flag is also set then the approximate percentage complete will be
> > shown.
> > +.sp
> > +.B SELINUX_RESTORECON_MASS_RELABEL
> > +generally set when relabeling the entire OS, that will then show the
> > +approximate percentage complete. The
> > +.B SELINUX_RESTORECON_PROGRESS
> > +flag must also be set.
> >  .sp
> >  .B SELINUX_RESTORECON_REALPATH
> >  convert passed-in
> > diff --git a/libselinux/src/selinux_restorecon.c
> > b/libselinux/src/selinux_restorecon.c
> > index 38acbd2..9fdafea 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -41,7 +41,7 @@
> >  #define SYS_PATH "/sys"
> >  #define SYS_PREFIX SYS_PATH "/"
> >
> > -#define STAR_COUNT 1000
> > +#define STAR_COUNT 1024
> >
> >  static struct selabel_handle *fc_sehandle = NULL;
> >  static unsigned char *fc_digest = NULL;
> > @@ -68,18 +68,12 @@ static uint64_t efile_count;      /* Estimated
> > total number of files */
> >  struct dir_xattr *dir_xattr_list;
> >  static struct dir_xattr *dir_xattr_last;
> >
> > -/*
> > - * If SELINUX_RESTORECON_PROGRESS is set and mass_relabel = true,
> > then
> > - * output approx % complete, else output * for every STAR_COUNT
> > files
> > - * processed to stdout.
> > - */
> > -static bool mass_relabel;
> > -
> >  /* restorecon_flags for passing to restorecon_sb() */
> >  struct rest_flags {
> >       bool nochange;
> >       bool verbose;
> >       bool progress;
> > +     bool mass_relabel;
> >       bool set_specctx;
> >       bool add_assoc;
> >       bool ignore_digest;
> > @@ -631,14 +625,14 @@ static int restorecon_sb(const char *pathname,
> > const struct stat *sb,
> >       if (flags->progress) {
> >               fc_count++;
> >               if (fc_count % STAR_COUNT == 0) {
> > -                     if (mass_relabel && efile_count > 0) {
> > +                     if (flags->mass_relabel && efile_count > 0)
> > {
> >                               pc = (fc_count < efile_count) ?
> > (100.0 *
> >                                            fc_count / efile_count)
> > : 100;
> >                               fprintf(stdout, "\r%-.1f%%",
> > (double)pc);
> >                       } else {
> > -                             fprintf(stdout, "*");
> > +                             fprintf(stdout, "\r%luk", fc_count /
> > STAR_COUNT);
> >                       }
> > -             fflush(stdout);
> > +                     fflush(stdout);
> >               }
> >       }
> >
> > @@ -750,6 +744,8 @@ int selinux_restorecon(const char *pathname_orig,
> >                   SELINUX_RESTORECON_VERBOSE) ? true : false;
> >       flags.progress = (restorecon_flags &
> >                   SELINUX_RESTORECON_PROGRESS) ? true : false;
> > +     flags.mass_relabel = (restorecon_flags &
> > +                 SELINUX_RESTORECON_MASS_RELABEL) ? true : false;
> >       flags.recurse = (restorecon_flags &
> >                   SELINUX_RESTORECON_RECURSE) ? true : false;
> >       flags.set_specctx = (restorecon_flags &
> > @@ -904,17 +900,6 @@ int selinux_restorecon(const char
> > *pathname_orig,
> >               }
> >       }
> >
> > -     mass_relabel = false;
> > -     if (!strcmp(pathname, "/")) {
> > -             mass_relabel = true;
> > -             if (flags.set_xdev && flags.progress)
> > -                     /*
> > -                      * Need to recalculate to get accurate %
> > complete
> > -                      * as only root device id will be processed.
> > -                      */
> > -                     efile_count = file_system_count(pathname);
> > -     }
> > -
> >       if (flags.set_xdev)
> >               fts_flags = FTS_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;
> >       else
> > @@ -1009,12 +994,8 @@ int selinux_restorecon(const char
> > *pathname_orig,
> >       }
> >
> >  out:
> > -     if (flags.progress) {
> > -             if (mass_relabel)
> > -                     fprintf(stdout, "\r100.0%%\n");
> > -             else
> > -                     fprintf(stdout, "\n");
> > -     }
> > +     if (flags.progress && flags.mass_relabel)
> > +             fprintf(stdout, "\r%s 100.0%%\n", pathname);
> >
> >       sverrno = errno;
> >       (void) fts_close(fts);
> > diff --git a/policycoreutils/setfiles/.gitignore
> > b/policycoreutils/setfiles/.gitignore
> > index 583eb6c..5e899c9 100644
> > --- a/policycoreutils/setfiles/.gitignore
> > +++ b/policycoreutils/setfiles/.gitignore
> > @@ -1,2 +1 @@
> > -restorecon.8.man
> >  setfiles.8.man
> > diff --git a/policycoreutils/setfiles/Makefile
> > b/policycoreutils/setfiles/Makefile
> > index 43364f9..92300c9 100644
> > --- a/policycoreutils/setfiles/Makefile
> > +++ b/policycoreutils/setfiles/Makefile
> > @@ -5,7 +5,6 @@ MANDIR = $(PREFIX)/share/man
> >  LIBDIR ?= $(PREFIX)/lib
> >  AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
> >
> > -PROGRESS_STEP=$(shell grep "^\#define STAR_COUNT" restore.h | awk -S
> > '{ print $$3 }')
> >  ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c
> > | awk -S '{ print $$3 }')
> >
> >  CFLAGS ?= -g -Werror -Wall -W
> > @@ -28,8 +27,6 @@ restorecon_xattr:  restorecon_xattr.o restore.o
> >
> >  man:
> >       @cp -af setfiles.8 setfiles.8.man
> > -     @cp -af restorecon.8 restorecon.8.man
> > -     @sed -i "s/STAR_COUNT/$(PROGRESS_STEP)/g" setfiles.8.man
> > restorecon.8.man
> >       @sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g"
> > setfiles.8.man
> >
> >  install: all
> > @@ -39,11 +36,11 @@ install: all
> >       (cd $(SBINDIR) && ln -sf setfiles restorecon)
> >       install -m 755 restorecon_xattr $(SBINDIR)
> >       install -m 644 setfiles.8.man $(MANDIR)/man8/setfiles.8
> > -     install -m 644 restorecon.8.man $(MANDIR)/man8/restorecon.8
> > +     install -m 644 restorecon.8 $(MANDIR)/man8/restorecon.8
> >       install -m 644 restorecon_xattr.8
> > $(MANDIR)/man8/restorecon_xattr.8
> >
> >  clean:
> > -     rm -f setfiles restorecon restorecon_xattr *.o
> > setfiles.8.man restorecon.8.man
> > +     rm -f setfiles restorecon restorecon_xattr *.o
> > setfiles.8.man
> >
> >  indent:
> >       ../../scripts/Lindent $(wildcard *.[ch])
> > diff --git a/policycoreutils/setfiles/restore.c
> > b/policycoreutils/setfiles/restore.c
> > index cf04e96..50d192a 100644
> > --- a/policycoreutils/setfiles/restore.c
> > +++ b/policycoreutils/setfiles/restore.c
> > @@ -35,7 +35,8 @@ void restore_init(struct restore_opts *opts)
> >                          r_opts->recurse | r_opts->userealpath |
> >                          r_opts->xdev | r_opts->abort_on_error |
> >                          r_opts->syslog_changes | r_opts-
> > >log_matches |
> > -                        r_opts->ignore_noent | r_opts-
> > >ignore_mounts;
> > +                        r_opts->ignore_noent | r_opts-
> > >ignore_mounts |
> > +                        r_opts->mass_relabel;
> >
> >       /* Use setfiles, restorecon and restorecond own handles */
> >       selinux_restorecon_set_sehandle(r_opts->hnd);
> > diff --git a/policycoreutils/setfiles/restore.h
> > b/policycoreutils/setfiles/restore.h
> > index 97fbdf4..b64042a 100644
> > --- a/policycoreutils/setfiles/restore.h
> > +++ b/policycoreutils/setfiles/restore.h
> > @@ -17,18 +17,12 @@
> >  #include <limits.h>
> >  #include <stdint.h>
> >
> > -/*
> > - * STAR_COUNT is also defined in libselinux/src/selinux_restorecon.c
> > where it
> > - * is used to output "*" for each number of files processed. Defined
> > here for
> > - * inclusion in man pages.
> > -*/
> > -#define STAR_COUNT 1000
> > -
> >  /* Things that need to be init'd */
> >  struct restore_opts {
> >       unsigned int nochange;
> >       unsigned int verbose;
> >       unsigned int progress;
> > +     unsigned int mass_relabel;
> >       unsigned int set_specctx;
> >       unsigned int add_assoc;
> >       unsigned int ignore_digest;
> > @@ -49,7 +43,6 @@ struct restore_opts {
> >       const char *selabel_opt_path;
> >       const char *selabel_opt_digest;
> >       int debug;
> > -     FILE *outfile;
> >  };
> >
> >  void restore_init(struct restore_opts *opts);
> > diff --git a/policycoreutils/setfiles/restorecon.8
> > b/policycoreutils/setfiles/restorecon.8
> > index bd27113..0f81db4 100644
> > --- a/policycoreutils/setfiles/restorecon.8
> > +++ b/policycoreutils/setfiles/restorecon.8
> > @@ -115,10 +115,10 @@ don't change any file labels (passive
> > check).  To display the files whose labels
> >  .BR \-v .
> >  .TP
> >  .BI \-o \ outfilename
> > -Deprecated, SELinux policy will probably block this access.  Use
> > shell redirection to save list of files with incorrect context in
> > filename.
> > +Deprecated - This option is no longer supported.
> >  .TP
> >  .B \-p
> > -show progress by printing * every STAR_COUNT files unless relabeling
> > the entire
> > +show progress by printing the number of files in 1k blocks unless
> > relabeling the entire
> >  OS, that will then show the approximate percentage complete. Note
> > that the
> >  .B \-p
> >  and
> > diff --git a/policycoreutils/setfiles/setfiles.8
> > b/policycoreutils/setfiles/setfiles.8
> > index 6901e13..9501845 100644
> > --- a/policycoreutils/setfiles/setfiles.8
> > +++ b/policycoreutils/setfiles/setfiles.8
> > @@ -106,11 +106,11 @@ seclabel fs mounted on a directory below this.
> >  .B \-n
> >  don't change any file labels (passive check).
> >  .TP
> > -.BI \-o \ filename
> > -Deprecated, SELinux policy will probably block this access.  Use
> > shell redirection to save list of files with incorrect context in
> > filename.
> > +.BI \-o \ outfilename
> > +Deprecated - This option is no longer supported.
> >  .TP
> >  .B \-p
> > -show progress by printing * every STAR_COUNT files unless relabeling
> > the entire
> > +show progress by printing the number of files in 1k blocks unless
> > relabeling the entire
> >  OS, that will then show the approximate percentage complete. Note
> > that the
> >  .B \-p
> >  and
> > diff --git a/policycoreutils/setfiles/setfiles.c
> > b/policycoreutils/setfiles/setfiles.c
> > index d767131..e3df212 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -160,7 +160,7 @@ int main(int argc, char **argv)
> >       char *buf = NULL;
> >       size_t buf_len;
> >       const char *base;
> > -     int mass_relabel = 0, errors = 0;
> > +     int errors = 0;
> >       const char *ropts = "e:f:hiIDlmno:pqrsvFRW0";
> >       const char *sopts = "c:de:f:hiIDlmno:pqr:svFR:W0";
> >       const char *opts;
> > @@ -318,19 +318,8 @@ int main(int argc, char **argv)
> >                       r_opts.nochange =
> > SELINUX_RESTORECON_NOCHANGE;
> >                       break;
> >               case 'o': /* Deprecated */
> > -                     if (strcmp(optarg, "-") == 0) {
> > -                             r_opts.outfile = stdout;
> > -                             break;
> > -                     }
> > -
> > -                     r_opts.outfile = fopen(optarg, "w");
> > -                     if (!r_opts.outfile) {
> > -                             fprintf(stderr, "Error opening %s:
> > %s\n",
> > -                                     optarg, strerror(errno));
> > -
> > -                             usage(argv[0]);
> > -                     }
> > -                     __fsetlocking(r_opts.outfile,
> > FSETLOCKING_BYCALLER);
> > +                     fprintf(stderr, "%s: -o option no longer
> > supported\n",
> > +                             r_opts.progname);
> >                       break;
> >               case 'q':
> >                       /* Deprecated - Was only used to say whether
> > print
> > @@ -394,7 +383,7 @@ int main(int argc, char **argv)
> >
> >       for (i = optind; i < argc; i++) {
> >               if (!strcmp(argv[i], "/"))
> > -                     mass_relabel = 1;
> > +                     r_opts.mass_relabel =
> > SELINUX_RESTORECON_MASS_RELABEL;
> >       }
> >
> >       cb.func_log = log_callback;
> > @@ -466,7 +455,7 @@ int main(int argc, char **argv)
> >               while ((len = getdelim(&buf, &buf_len, delim, f)) >
> > 0) {
> >                       buf[len - 1] = 0;
> >                       if (!strcmp(buf, "/"))
> > -                             mass_relabel = 1;
> > +                             r_opts.mass_relabel =
> > SELINUX_RESTORECON_MASS_RELABEL;
> >                       errors |= process_glob(buf, &r_opts) < 0;
> >               }
> >               if (strcmp(input_filename, "-") != 0)
> > @@ -476,7 +465,7 @@ int main(int argc, char **argv)
> >                       errors |= process_glob(argv[i], &r_opts) <
> > 0;
> >       }
> >
> > -     maybe_audit_mass_relabel(mass_relabel, errors);
> > +     maybe_audit_mass_relabel(r_opts.mass_relabel, errors);
> >
> >       if (warn_no_match)
> >               selabel_stats(r_opts.hnd);
> > @@ -484,8 +473,8 @@ int main(int argc, char **argv)
> >       selabel_close(r_opts.hnd);
> >       restore_finish();
> >
> > -     if (r_opts.outfile)
> > -             fclose(r_opts.outfile);
> > +     if (r_opts.progress)
> > +             fprintf(stdout, "\n");
> >
> >       exit(errors ? -1 : 0);
> >  }
>

--001a11439e3ef8c7930547269ecc
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On 2=
7 January 2017 at 14:55, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D=
"gmail-">On Fri, 2017-01-27 at 12:47 +0000, Richard Haines wrote:<br>
&gt; This fixes the following bug:<br>
&gt; UX regression: setfiles progress indicator is now misleading and<br>
&gt; confusing in fixfiles.<br>
&gt;<br>
&gt; The outputting of * is replaced by the number of files in 1k<br>
&gt; increments<br>
&gt; as the previous versions. If &quot;/&quot; is specified on the pathnam=
e, then<br>
&gt; this<br>
&gt; will indicate a mass relabel, an example output will be:<br>
&gt; restorecon -nRp /etc /tmp /boot /<br>
&gt; /etc 100.0%<br>
&gt; /tmp 100.0%<br>
&gt; /boot 100.0%<br>
&gt; 3.2%<br>
&gt;<br>
&gt; Also setfiles(8) and restorecon(8) versions that are implemented<br>
&gt; using<br>
&gt; the selinux_restorecon(3) function do not support the [-o filename]<br=
>
&gt; option as this was deprecated. This has now been made clear by<br>
&gt; displaying<br>
&gt; a message to stderr.<br>
&gt;<br>
&gt; The documentation has also been updated to reflect these changes.<br>
&gt;<br>
&gt; Reported-by: Alan Jenkins &lt;<a href=3D"mailto:alan.christopher.jenki=
ns@gmail.com">alan.christopher.jenkins@<wbr>gmail.com</a>&gt;<br>
&gt; Signed-off-by: Richard Haines &lt;<a href=3D"mailto:richard_c_haines@b=
tinternet.com">richard_c_haines@btinternet.<wbr>com</a>&gt;<br>
<br></span></blockquote><div><br></div><div><div>On 27/01/2017, stephensmal=
ley &lt;<a href=3D"mailto:notifications@github.com">notifications@github.co=
m</a>&gt; wrote:</div><div>&gt; Fixed by 454768f56d7a941657d800e303994bca08=
6b7546</div><div>&gt; There is a change in the UX with respect to reporting=
 progress</div><div>&gt; per-filesystem; hopefully that isn&#39;t too noisy=
.</div><div>&gt; Other, separate issue is likely that we ought to exclude m=
ore of these</div><div>&gt; filesystems in fixfiles, as we used to do befor=
e introducing seclabel mount</div><div>&gt; option.</div></div><div><br></d=
iv><div><div>Thanks!=C2=A0 I&#39;m sitting in a youth hostel with duff knee=
s, rain outside, and a Chromebook.=C2=A0 So I can&#39;t test this but I hav=
e a couple of comments I can make.</div><div><br></div><div>I think the pat=
h e.g.`/etc` should be visible next to the percentage right from the start.=
=C2=A0 Then I think this output would be fine. =C2=A0(Because fixfiles alre=
ady prints the list of filesystems it&#39;s going to relabel at the start).=
</div><div><br></div><div>Having the current progress line showing without =
the path, but completed progress lines showing with the path, seems less in=
formative and actively confusing.</div><div><br></div><div>I had another co=
ncern looking at the commit message though. The example shown is suspicious=
.</div><div><br></div><div>The implication is it shows reasonable % progres=
s, for each argument in turn.=C2=A0 E.g. /etc goes from 0% to 100%, then th=
en next argument is processed.=C2=A0 But I can&#39;t see this working in th=
e code.</div><div><br></div><div>/etc is never a separate filesystem (fstab=
 is in /etc).=C2=A0 IIRC from comments or commit messages, progress indicat=
ion used the number of inodes on the target filesystem.=C2=A0 In that case =
it couldn&#39;t possibly have shown progress correctly for /etc, not as a s=
eparate line, so this made me curious.<br></div><div><br></div><div>Looking=
 at the commit, accurate progress indication still seems to rely on the ino=
de count, so I still have this concern. =C2=A0(`statvfs` and subtracting # =
of files from the max inode count for the FS.=C2=A0 I wonder how this works=
 on btrfs).</div><div><br></div><div>I think the API documentation would wa=
nt to be improved as well. I would optimistically read it as saying I could=
 set SELINUX_RESTORECON_MASS_RELABEL anytime I relabel a large number of fi=
les and want some nice % progress indicator.=C2=A0 But this cannot be true.=
=C2=A0 AFAICS, the flag SELINUX_RESTORECON_MASS_RELABEL will only work corr=
ectly when relabelling *everything*; all files on all supported filesystems=
.=C2=A0 That&#39;s what `exclude_non_seclabel_mounts()` is counting.</div><=
/div><div><br></div><div>Also - I&#39;ve only checked this now, but I think=
 `restorecon -p / /etc /tmp /boot` is suspicious for a second reason.=C2=A0=
 Unlike `setfiles`, `restorecon` does `xdev =3D 0; /* Follows mounts */`.=
=C2=A0 So I don&#39;t think it&#39;s a good example command to pass other a=
rguments along with `/`; I don&#39;t think you would ever want to do this.<=
br></div><div><br></div><div>Regards</div><div>Alan</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
</span>Thanks, applied.<br>
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt; ---<br>
&gt; =C2=A0libselinux/include/selinux/<wbr>restorecon.h=C2=A0=C2=A0| 11 +++=
++++---<br>
&gt; =C2=A0libselinux/man/man3/selinux_<wbr>restorecon.3 | 12 +++++++++--<b=
r>
&gt; =C2=A0libselinux/src/selinux_<wbr>restorecon.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 37 ++++++++------------<br>
&gt; ------------<br>
&gt; =C2=A0policycoreutils/setfiles/.<wbr>gitignore=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A01 -<br>
&gt; =C2=A0policycoreutils/setfiles/<wbr>Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A07 ++----<br>
&gt; =C2=A0policycoreutils/setfiles/<wbr>restore.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A03 ++-<br>
&gt; =C2=A0policycoreutils/setfiles/<wbr>restore.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A09 +-------<br>
&gt; =C2=A0policycoreutils/setfiles/<wbr>restorecon.8=C2=A0=C2=A0=C2=A0=C2=
=A0|=C2=A0=C2=A04 ++--<br>
&gt; =C2=A0policycoreutils/setfiles/<wbr>setfiles.8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0|=C2=A0=C2=A06 +++---<br>
&gt; =C2=A0policycoreutils/setfiles/<wbr>setfiles.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0| 27 +++++++---------------<br>
&gt; -<br>
&gt; =C2=A010 files changed, 45 insertions(+), 72 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libselinux/include/selinux/<wbr>restorecon.h<br>
&gt; b/libselinux/include/selinux/<wbr>restorecon.h<br>
&gt; index 7cfdee1..de694cd 100644<br>
&gt; --- a/libselinux/include/selinux/<wbr>restorecon.h<br>
&gt; +++ b/libselinux/include/selinux/<wbr>restorecon.h<br>
&gt; @@ -50,9 +50,9 @@ extern int selinux_restorecon(const char *pathname,<=
br>
&gt; =C2=A0 */<br>
&gt; =C2=A0#define SELINUX_RESTORECON_VERBOSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0010<br>
&gt; =C2=A0/*<br>
&gt; - * Show progress by printing * to stdout every 1000 files, unless<br>
&gt; - * relabeling the entire OS, that will then show the approximate<br>
&gt; - * percentage complete.<br>
&gt; + * If SELINUX_RESTORECON_PROGRESS is true and<br>
&gt; + * SELINUX_RESTORECON_MASS_<wbr>RELABEL is true, then output approx %=
<br>
&gt; complete,<br>
&gt; + * else output the number of files in 1k blocks processed to stdout.<=
br>
&gt; =C2=A0 */<br>
&gt; =C2=A0#define SELINUX_RESTORECON_PROGRESS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0020<br>
&gt; =C2=A0/*<br>
&gt; @@ -91,6 +91,11 @@ extern int selinux_restorecon(const char<br>
&gt; *pathname,<br>
&gt; =C2=A0 * mounts to be excluded from relabeling checks.<br>
&gt; =C2=A0 */<br>
&gt; =C2=A0#define SELINUX_RESTORECON_IGNORE_<wbr>MOUNTS=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2000<br>
&gt; +/*<br>
&gt; + * Set if there is a mass relabel required.<br>
&gt; + * See SELINUX_RESTORECON_PROGRESS flag for details.<br>
&gt; + */<br>
&gt; +#define SELINUX_RESTORECON_MASS_<wbr>RELABEL=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x400<br>
&gt; 0<br>
&gt; =C2=A0<br>
&gt; =C2=A0/**<br>
&gt; =C2=A0 * selinux_restorecon_set_<wbr>sehandle - Set the global fc hand=
le.<br>
&gt; diff --git a/libselinux/man/man3/selinux_<wbr>restorecon.3<br>
&gt; b/libselinux/man/man3/selinux_<wbr>restorecon.3<br>
&gt; index d698818..1eac6ed 100644<br>
&gt; --- a/libselinux/man/man3/selinux_<wbr>restorecon.3<br>
&gt; +++ b/libselinux/man/man3/selinux_<wbr>restorecon.3<br>
&gt; @@ -88,8 +88,16 @@ will take precedence.<br>
&gt; =C2=A0.RE<br>
&gt; =C2=A0.sp<br>
&gt; =C2=A0.B SELINUX_RESTORECON_PROGRESS<br>
&gt; -show progress by printing * to stdout every 1000 files unless<br>
&gt; relabeling the<br>
&gt; -entire OS, that will then show the approximate percentage complete.<b=
r>
&gt; +show progress by outputting the number of files in 1k blocks<br>
&gt; processed<br>
&gt; +to stdout. If the<br>
&gt; +.B SELINUX_RESTORECON_MASS_<wbr>RELABEL<br>
&gt; +flag is also set then the approximate percentage complete will be<br>
&gt; shown.<br>
&gt; +.sp<br>
&gt; +.B SELINUX_RESTORECON_MASS_<wbr>RELABEL<br>
&gt; +generally set when relabeling the entire OS, that will then show the<=
br>
&gt; +approximate percentage complete. The<br>
&gt; +.B SELINUX_RESTORECON_PROGRESS<br>
&gt; +flag must also be set.<br>
&gt; =C2=A0.sp<br>
&gt; =C2=A0.B SELINUX_RESTORECON_REALPATH<br>
&gt; =C2=A0convert passed-in<br>
&gt; diff --git a/libselinux/src/selinux_<wbr>restorecon.c<br>
&gt; b/libselinux/src/selinux_<wbr>restorecon.c<br>
&gt; index 38acbd2..9fdafea 100644<br>
&gt; --- a/libselinux/src/selinux_<wbr>restorecon.c<br>
&gt; +++ b/libselinux/src/selinux_<wbr>restorecon.c<br>
&gt; @@ -41,7 +41,7 @@<br>
&gt; =C2=A0#define SYS_PATH &quot;/sys&quot;<br>
&gt; =C2=A0#define SYS_PREFIX SYS_PATH &quot;/&quot;<br>
&gt; =C2=A0<br>
&gt; -#define STAR_COUNT 1000<br>
&gt; +#define STAR_COUNT 1024<br>
&gt; =C2=A0<br>
&gt; =C2=A0static struct selabel_handle *fc_sehandle =3D NULL;<br>
&gt; =C2=A0static unsigned char *fc_digest =3D NULL;<br>
&gt; @@ -68,18 +68,12 @@ static uint64_t efile_count;=C2=A0 =C2=A0 =C2=A0 /=
* Estimated<br>
&gt; total number of files */<br>
&gt; =C2=A0struct dir_xattr *dir_xattr_list;<br>
&gt; =C2=A0static struct dir_xattr *dir_xattr_last;<br>
&gt; =C2=A0<br>
&gt; -/*<br>
&gt; - * If SELINUX_RESTORECON_PROGRESS is set and mass_relabel =3D true,<b=
r>
&gt; then<br>
&gt; - * output approx % complete, else output * for every STAR_COUNT<br>
&gt; files<br>
&gt; - * processed to stdout.<br>
&gt; - */<br>
&gt; -static bool mass_relabel;<br>
&gt; -<br>
&gt; =C2=A0/* restorecon_flags for passing to restorecon_sb() */<br>
&gt; =C2=A0struct rest_flags {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool nochange;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool verbose;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool progress;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool mass_relabel;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool set_specctx;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool add_assoc;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0bool ignore_digest;<br>
&gt; @@ -631,14 +625,14 @@ static int restorecon_sb(const char *pathname,<b=
r>
&gt; const struct stat *sb,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (flags-&gt;progress) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fc_count++;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fc_count % S=
TAR_COUNT =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (mass_relabel &amp;&amp; efile_count &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (flags-&gt;mass_relabel &amp;&amp; efile_count &gt; 0)<br>
&gt; {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pc =3D (fc_count &lt; efile_count)=
 ?<br>
&gt; (100.0 *<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0fc_count / efile_count)<br>
&gt; : 100;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout, &quot;\r%-.1f%%&qu=
ot;,<br>
&gt; (double)pc);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout, &quot;*&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout, &quot;\r%luk&quot;, fc_c=
ount /<br>
&gt; STAR_COUNT);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fflush(stdout);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fflush(stdout);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; @@ -750,6 +744,8 @@ int selinux_restorecon(const char *pathname_orig,<=
br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0SELINUX_RESTORECON_<wbr>VERBOSE) ? true : false;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0flags.progress =3D (restorecon_flags &amp;<b=
r>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0SELINUX_RESTORECON_<wbr>PROGRESS) ? true : false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0flags.mass_relabel =3D (restorecon_flags &amp;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0SELINUX_RESTORECON_MASS_<wbr>RELABEL) ? true : false;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0flags.recurse =3D (restorecon_flags &amp;<br=
>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0SELINUX_RESTORECON_<wbr>RECURSE) ? true : false;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0flags.set_specctx =3D (restorecon_flags &amp=
;<br>
&gt; @@ -904,17 +900,6 @@ int selinux_restorecon(const char<br>
&gt; *pathname_orig,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0mass_relabel =3D false;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (!strcmp(pathname, &quot;/&quot;)) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mass_relabel =3D true=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags.set_xdev &a=
mp;&amp; flags.progress)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/*<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0* Need to recalculate to get accurate %<br>
&gt; complete<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0* as only root device id will be processed.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0efile_count =3D file_system_count(pathname);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (flags.set_xdev)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fts_flags =3D FT=
S_PHYSICAL | FTS_NOCHDIR | FTS_XDEV;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0else<br>
&gt; @@ -1009,12 +994,8 @@ int selinux_restorecon(const char<br>
&gt; *pathname_orig,<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0out:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (flags.progress) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mass_relabel)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fprintf(stdout, &quot;\r100.0%%\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fprintf(stdout, &quot;\n&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (flags.progress &amp;&amp; flags.mass_relabel)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout, &quot=
;\r%s 100.0%%\n&quot;, pathname);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0sverrno =3D errno;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0(void) fts_close(fts);<br>
&gt; diff --git a/policycoreutils/setfiles/.<wbr>gitignore<br>
&gt; b/policycoreutils/setfiles/.<wbr>gitignore<br>
&gt; index 583eb6c..5e899c9 100644<br>
&gt; --- a/policycoreutils/setfiles/.<wbr>gitignore<br>
&gt; +++ b/policycoreutils/setfiles/.<wbr>gitignore<br>
&gt; @@ -1,2 +1 @@<br>
&gt; -restorecon.8.man<br>
&gt; =C2=A0setfiles.8.man<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>Makefile<br>
&gt; b/policycoreutils/setfiles/<wbr>Makefile<br>
&gt; index 43364f9..92300c9 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>Makefile<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>Makefile<br>
&gt; @@ -5,7 +5,6 @@ MANDIR =3D $(PREFIX)/share/man<br>
&gt; =C2=A0LIBDIR ?=3D $(PREFIX)/lib<br>
&gt; =C2=A0AUDITH =3D $(shell ls /usr/include/libaudit.h 2&gt;/dev/null)<br=
>
&gt; =C2=A0<br>
&gt; -PROGRESS_STEP=3D$(shell grep &quot;^\#define STAR_COUNT&quot; restore=
.h | awk -S<br>
&gt; &#39;{ print $$3 }&#39;)<br>
&gt; =C2=A0ABORT_ON_ERRORS=3D$(shell grep &quot;^\#define ABORT_ON_ERRORS&q=
uot; setfiles.c<br>
&gt; | awk -S &#39;{ print $$3 }&#39;)<br>
&gt; =C2=A0<br>
&gt; =C2=A0CFLAGS ?=3D -g -Werror -Wall -W<br>
&gt; @@ -28,8 +27,6 @@ restorecon_xattr:=C2=A0=C2=A0restorecon_<wbr>xattr.o=
 restore.o<br>
&gt; =C2=A0<br>
&gt; =C2=A0man:<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0@cp -af setfiles.8 setfiles.8.man<br>
&gt; -=C2=A0 =C2=A0 =C2=A0@cp -af restorecon.8 restorecon.8.man<br>
&gt; -=C2=A0 =C2=A0 =C2=A0@sed -i &quot;s/STAR_COUNT/$(PROGRESS_STEP)<wbr>/=
g&quot; setfiles.8.man<br>
&gt; restorecon.8.man<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0@sed -i &quot;s/ABORT_ON_ERRORS/$(ABORT_ON_<=
wbr>ERRORS)/g&quot;<br>
&gt; setfiles.8.man<br>
&gt; =C2=A0<br>
&gt; =C2=A0install: all<br>
&gt; @@ -39,11 +36,11 @@ install: all<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0(cd $(SBINDIR) &amp;&amp; ln -sf setfiles re=
storecon)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0install -m 755 restorecon_xattr $(SBINDIR)<b=
r>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0install -m 644 setfiles.8.man $(MANDIR)/man8=
/setfiles.8<br>
&gt; -=C2=A0 =C2=A0 =C2=A0install -m 644 restorecon.8.man $(MANDIR)/man8/re=
storecon.8<br>
&gt; +=C2=A0 =C2=A0 =C2=A0install -m 644 restorecon.8 $(MANDIR)/man8/restor=
econ.8<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0install -m 644 restorecon_xattr.8<br>
&gt; $(MANDIR)/man8/restorecon_<wbr>xattr.8<br>
&gt; =C2=A0<br>
&gt; =C2=A0clean:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm -f setfiles restorecon restorecon_xattr *.o<br=
>
&gt; setfiles.8.man restorecon.8.man<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rm -f setfiles restorecon restorecon_xattr *.o<br=
>
&gt; setfiles.8.man<br>
&gt; =C2=A0<br>
&gt; =C2=A0indent:<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0../../scripts/Lindent $(wildcard *.[ch])<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>restore.c<br>
&gt; b/policycoreutils/setfiles/<wbr>restore.c<br>
&gt; index cf04e96..50d192a 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>restore.c<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>restore.c<br>
&gt; @@ -35,7 +35,8 @@ void restore_init(struct restore_opts *opts)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0r_opts-&gt;recurse | r_opts-&gt;userealpath =
|<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0r_opts-&gt;xdev | r_opts-&gt;abort_on_error =
|<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0r_opts-&gt;syslog_changes | r_opts-<br>
&gt; &gt;log_matches |<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0r_opts-&gt;ignore_noent | r_opts-<br>
&gt; &gt;ignore_mounts;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0r_opts-&gt;ignore_noent | r_opts-<br>
&gt; &gt;ignore_mounts |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=C2=A0=C2=A0=C2=A0r_opts-&gt;mass_relabel;<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0/* Use setfiles, restorecon and restorecond =
own handles */<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0selinux_restorecon_set_<wbr>sehandle(r_opts-=
&gt;hnd);<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>restore.h<br>
&gt; b/policycoreutils/setfiles/<wbr>restore.h<br>
&gt; index 97fbdf4..b64042a 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>restore.h<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>restore.h<br>
&gt; @@ -17,18 +17,12 @@<br>
&gt; =C2=A0#include &lt;limits.h&gt;<br>
&gt; =C2=A0#include &lt;stdint.h&gt;<br>
&gt; =C2=A0<br>
&gt; -/*<br>
&gt; - * STAR_COUNT is also defined in libselinux/src/selinux_<wbr>restorec=
on.c<br>
&gt; where it<br>
&gt; - * is used to output &quot;*&quot; for each number of files processed=
. Defined<br>
&gt; here for<br>
&gt; - * inclusion in man pages.<br>
&gt; -*/<br>
&gt; -#define STAR_COUNT 1000<br>
&gt; -<br>
&gt; =C2=A0/* Things that need to be init&#39;d */<br>
&gt; =C2=A0struct restore_opts {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int nochange;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int verbose;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int progress;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int mass_relabel;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int set_specctx;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int add_assoc;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0unsigned int ignore_digest;<br>
&gt; @@ -49,7 +43,6 @@ struct restore_opts {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const char *selabel_opt_path;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const char *selabel_opt_digest;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0int debug;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0FILE *outfile;<br>
&gt; =C2=A0};<br>
&gt; =C2=A0<br>
&gt; =C2=A0void restore_init(struct restore_opts *opts);<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>restorecon.8<br>
&gt; b/policycoreutils/setfiles/<wbr>restorecon.8<br>
&gt; index bd27113..0f81db4 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>restorecon.8<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>restorecon.8<br>
&gt; @@ -115,10 +115,10 @@ don&#39;t change any file labels (passive<br>
&gt; check).=C2=A0=C2=A0To display the files whose labels<br>
&gt; =C2=A0.BR \-v .<br>
&gt; =C2=A0.TP<br>
&gt; =C2=A0.BI \-o \ outfilename<br>
&gt; -Deprecated, SELinux policy will probably block this access.=C2=A0=C2=
=A0Use<br>
&gt; shell redirection to save list of files with incorrect context in<br>
&gt; filename.<br>
&gt; +Deprecated - This option is no longer supported.<br>
&gt; =C2=A0.TP<br>
&gt; =C2=A0.B \-p<br>
&gt; -show progress by printing * every STAR_COUNT files unless relabeling<=
br>
&gt; the entire<br>
&gt; +show progress by printing the number of files in 1k blocks unless<br>
&gt; relabeling the entire<br>
&gt; =C2=A0OS, that will then show the approximate percentage complete. Not=
e<br>
&gt; that the<br>
&gt; =C2=A0.B \-p<br>
&gt; =C2=A0and<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>setfiles.8<br>
&gt; b/policycoreutils/setfiles/<wbr>setfiles.8<br>
&gt; index 6901e13..9501845 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>setfiles.8<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>setfiles.8<br>
&gt; @@ -106,11 +106,11 @@ seclabel fs mounted on a directory below this.<b=
r>
&gt; =C2=A0.B \-n<br>
&gt; =C2=A0don&#39;t change any file labels (passive check).<br>
&gt; =C2=A0.TP<br>
&gt; -.BI \-o \ filename<br>
&gt; -Deprecated, SELinux policy will probably block this access.=C2=A0=C2=
=A0Use<br>
&gt; shell redirection to save list of files with incorrect context in<br>
&gt; filename.<br>
&gt; +.BI \-o \ outfilename<br>
&gt; +Deprecated - This option is no longer supported.<br>
&gt; =C2=A0.TP<br>
&gt; =C2=A0.B \-p<br>
&gt; -show progress by printing * every STAR_COUNT files unless relabeling<=
br>
&gt; the entire<br>
&gt; +show progress by printing the number of files in 1k blocks unless<br>
&gt; relabeling the entire<br>
&gt; =C2=A0OS, that will then show the approximate percentage complete. Not=
e<br>
&gt; that the<br>
&gt; =C2=A0.B \-p<br>
&gt; =C2=A0and<br>
&gt; diff --git a/policycoreutils/setfiles/<wbr>setfiles.c<br>
&gt; b/policycoreutils/setfiles/<wbr>setfiles.c<br>
&gt; index d767131..e3df212 100644<br>
&gt; --- a/policycoreutils/setfiles/<wbr>setfiles.c<br>
&gt; +++ b/policycoreutils/setfiles/<wbr>setfiles.c<br>
&gt; @@ -160,7 +160,7 @@ int main(int argc, char **argv)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0char *buf =3D NULL;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0size_t buf_len;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const char *base;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0int mass_relabel =3D 0, errors =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int errors =3D 0;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const char *ropts =3D &quot;e:f:hiIDlmno:pqr=
svFRW0&quot;;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const char *sopts =3D &quot;c:de:f:hiIDlmno:=
pqr:svFR:W0&quot;;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0const char *opts;<br>
&gt; @@ -318,19 +318,8 @@ int main(int argc, char **argv)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0r_opts.nochange =3D<br>
&gt; SELINUX_RESTORECON_NOCHANGE;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;o&#39;=
: /* Deprecated */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (strcmp(optarg, &quot;-&quot;) =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_opts.outfile =3D stdout;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0r_opts.outfile =3D fopen(optarg, &quot;w&quot;);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (!r_opts.outfile) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Error opening %s:<=
br>
&gt; %s\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optarg, stre=
rror(errno));<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage(argv[0]);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0__fsetlocking(r_opts.outfile,<br>
&gt; FSETLOCKING_BYCALLER);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0fprintf(stderr, &quot;%s: -o option no longer<br>
&gt; supported\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_opts.progname);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;q&#39;=
:<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* Deprecated - Was only used to say whether<br>
&gt; print<br>
&gt; @@ -394,7 +383,7 @@ int main(int argc, char **argv)<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0for (i =3D optind; i &lt; argc; i++) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(argv=
[i], &quot;/&quot;))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mass_relabel =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0r_opts.mass_relabel =3D<br>
&gt; SELINUX_RESTORECON_MASS_<wbr>RELABEL;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0cb.func_log =3D log_callback;<br>
&gt; @@ -466,7 +455,7 @@ int main(int argc, char **argv)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((len =3D =
getdelim(&amp;buf, &amp;buf_len, delim, f)) &gt;<br>
&gt; 0) {<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0buf[len - 1] =3D 0;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (!strcmp(buf, &quot;/&quot;))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mass_relabel =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_opts.mass_relabel =3D<br>
&gt; SELINUX_RESTORECON_MASS_<wbr>RELABEL;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0errors |=3D process_glob(buf, &amp;r_opts) &lt; 0;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(input=
_filename, &quot;-&quot;) !=3D 0)<br>
&gt; @@ -476,7 +465,7 @@ int main(int argc, char **argv)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0errors |=3D process_glob(argv[i], &amp;r_opts) &lt;<br>
&gt; 0;<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0}<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0maybe_audit_mass_relabel(mass_<wbr>relabel, error=
s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0maybe_audit_mass_relabel(r_<wbr>opts.mass_relabel=
, errors);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0if (warn_no_match)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selabel_stats(r_=
opts.hnd);<br>
&gt; @@ -484,8 +473,8 @@ int main(int argc, char **argv)<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0selabel_close(r_opts.hnd);<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0restore_finish();<br>
&gt; =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (r_opts.outfile)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fclose(r_opts.outfile=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (r_opts.progress)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stdout, &quot=
;\n&quot;);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0 =C2=A0 =C2=A0exit(errors ? -1 : 0);<br>
&gt; =C2=A0}<br>
</div></div></blockquote></div><br></div></div>

--001a11439e3ef8c7930547269ecc--
