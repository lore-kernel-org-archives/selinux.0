From: "Roberts, William C" <william.c.roberts@intel.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>, "seandroid-list@tycho.nsa.gov"
 <seandroid-list@tycho.nsa.gov>, "jwcart2@tycho.nsa.gov"
 <jwcart2@tycho.nsa.gov>
Subject: RE: [PATCH v2] libselinux: clean up process file
Date: Thu, 8 Sep 2016 19:53:10 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC5601290193@ORSMSX103.amr.corp.intel.com>
References: <1473206821-30222-1-git-send-email-william.c.roberts@intel.com>
 <513c68e1-06e5-570d-3106-cf033b1e3040@tycho.nsa.gov>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

<snip>
> > > +static FILE *open_file(const char *path, const char *suffix,
> > > +        char *save_path, size_t len, struct stat *sb) {
> > > +	unsigned i;
> > > +	int rc;
> > > +	char stack_path[len];
> >
> > Ew, what is this?  C99 magic.  Probably just make it PATH_MAX and be
> > done with it.
> 
> You already have C99 magic with mixed code and data declarations, so I don't see
> the problem.
> https://gcc.gnu.org/onlinedocs/gcc/Mixed-Declarations.html
> https://gcc.gnu.org/onlinedocs/gcc/Variable-Length.html
> 

You also seem to have more magic with inline, when passing
CFLAGS='-std=c90' to make it complains about:

cc -std=c90 -I../include -I/usr/include -D_GNU_SOURCE   -c -o booleans.o booleans.c
In file included from avc.c:14:0:
avc_internal.h:36:15: error: expected ‘=’, ‘,’, ‘;’, ‘asm’ or ‘__attribute__’ before ‘void’
 static inline void set_callbacks(const struct avc_memory_callback *mem_cb,

Looking at:
https://gcc.gnu.org/onlinedocs/gcc/Inline.html
http://stackoverflow.com/questions/12151168/does-ansi-c-not-know-the-inline-keyword

It appears you need something like __inline__

If this code base was met to compile C90, it already failed and is only C99 compliant + GNUC extensions.
So I don't see the harm in using the C99 capabilities.

<snip>
