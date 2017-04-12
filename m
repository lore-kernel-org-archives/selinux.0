Message-ID: <1492027294.3881.31.camel@tycho.nsa.gov>
Subject: Re: [PATCH 1/2] libselinux: add security_checkreqprot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nick Kralevich <nnk@google.com>, Christian =?ISO-8859-1?Q?G=F6ttsche?=
 <cgzones@googlemail.com>
Cc: selinux <selinux@tycho.nsa.gov>
Date: Wed, 12 Apr 2017 16:01:34 -0400
In-Reply-To: <CAFJ0LnFpio6==BFLr4ztS=SO=5zdinT1Rmm+2Cb6Q+FTVTeFvA@mail.gmail.com>
References: <CAJ2a_DemVQ8X_duwMEQZEAQOr=G1JXUFTAfOxY6retz0xCo3bg@mail.gmail.com>
 <CAFJ0LnFpio6==BFLr4ztS=SO=5zdinT1Rmm+2Cb6Q+FTVTeFvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, 2017-04-12 at 08:49 -0700, Nick Kralevich wrote:
> On Wed, Apr 12, 2017 at 6:41 AM, Christian Göttsche
> <cgzones@googlemail.com> wrote:
> > Add security_checkreqprot() function, returning the current active
> > checkreqprot value
> > 
> > Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> > ---
> >  libselinux/include/selinux/selinux.h      |  3 +++
> >  libselinux/man/man3/security_getenforce.3 |  8 ++++++-
> >  libselinux/man/man3/selinux_status_open.3 | 11 +++++++--
> >  libselinux/src/checkreqprot.c             | 40
> > +++++++++++++++++++++++++++++++
> >  libselinux/src/selinux_internal.h         |  1 +
> >  5 files changed, 60 insertions(+), 3 deletions(-)
> >  create mode 100644 libselinux/src/checkreqprot.c
> > 
> > diff --git a/libselinux/include/selinux/selinux.h
> > b/libselinux/include/selinux/selinux.h
> > index 45dd6ca5..938393f6 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -331,6 +331,9 @@ extern int security_setenforce(int value);
> >  /* Get the behavior for undefined classes/permissions */
> >  extern int security_deny_unknown(void);
> > 
> > +/* Get the checkreqprot value */
> > +extern int security_checkreqprot(void);
> > +
> >  /* Disable SELinux at runtime (must be done prior to initial
> > policy load). */
> >  extern int security_disable(void);
> > 
> > diff --git a/libselinux/man/man3/security_getenforce.3
> > b/libselinux/man/man3/security_getenforce.3
> > index 7658014a..e27b6c80 100644
> > --- a/libselinux/man/man3/security_getenforce.3
> > +++ b/libselinux/man/man3/security_getenforce.3
> > @@ -1,6 +1,6 @@
> >  .TH "security_getenforce" "3" "1 January 2004" "russell@coker.com.
> > au"
> > "SELinux API documentation"
> >  .SH "NAME"
> > -security_getenforce, security_setenforce, security_deny_unknown \-
> > get or set the enforcing state of SELinux
> > +security_getenforce, security_setenforce, security_deny_unknown
> > security_checkreqprot\- get or set the enforcing state of SELinux
> >  .
> >  .SH "SYNOPSIS"
> >  .B #include <selinux/selinux.h>
> > @@ -10,6 +10,8 @@ security_getenforce, security_setenforce,
> > security_deny_unknown \- get or set th
> >  .BI "int security_setenforce(int "value );
> >  .sp
> >  .B int security_deny_unknown(void);
> > +.sp
> > +.B int security_checkreqprot(void);
> >  .
> >  .SH "DESCRIPTION"
> >  .BR security_getenforce ()
> > @@ -24,6 +26,10 @@ returned.
> >  .BR security_deny_unknown ()
> >  returns 0 if SELinux treats policy queries on undefined object
> > classes or
> >  permissions as being allowed, 1 if such queries are denied, and \-
> > 1 on error.
> > +
> > +.BR security_checkreqprot ()
> > +returns 0 if SELinux checks the protection applied by the kernel,
> > 1 if SELinux
> > +checks the protection requested by the application, and \-1 on
> > error.
> >  .
> >  .SH "SEE ALSO"
> >  .BR selinux "(8)"
> > diff --git a/libselinux/man/man3/selinux_status_open.3
> > b/libselinux/man/man3/selinux_status_open.3
> > index 2d44be57..e70ab014 100644
> > --- a/libselinux/man/man3/selinux_status_open.3
> > +++ b/libselinux/man/man3/selinux_status_open.3
> > @@ -1,8 +1,9 @@
> >  .TH "selinux_status_open" "3" "22 January 2011"
> > "kaigai@ak.jp.nec.com" "SELinux API documentation"
> >  .SH "NAME"
> >  selinux_status_open, selinux_status_close, selinux_status_updated,
> > -selinux_status_getenforce, selinux_status_policyload and
> > -selinux_status_deny_unknown \- reference the SELinux kernel status
> > +selinux_status_getenforce, selinux_status_policyload,
> > +selinux_status_deny_unknown and security_checkreqprot \- reference
> > +the SELinux kernel status
> >  without invocation of system calls
> >  .
> >  .SH "SYNOPSIS"
> > @@ -19,6 +20,8 @@ without invocation of system calls
> >  .BI "int selinux_status_policyload(void);"
> >  .sp
> >  .BI "int selinux_status_deny_unknown(void);"
> > +.sp
> > +.BI "int security_checkreqprot(void);"
> >  .
> >  .SH "DESCRIPTION"
> >  Linux 2.6.37 or later provides a SELinux kernel status page; being
> > mostly
> > @@ -78,6 +81,10 @@ Thus, don't use this value to know actual times
> > of
> > policy reloaded.
> >  returns 0 if SELinux treats policy queries on undefined object
> > classes or
> >  permissions as being allowed, 1 if such queries are denied, or \-1 
> > on error.
> >  .sp
> > +.BR security_checkreqprot ()
> > +returns 0 if SELinux checks the protection applied by the kernel,
> > 1 if SELinux
> > +checks the protection requested by the application, and \-1 on
> > error.
> > +.sp
> >  Also note that these interfaces are not thread-safe, so you have
> > to protect
> >  them from concurrent calls using exclusive locks when multiple
> > threads are
> >  performing.
> > diff --git a/libselinux/src/checkreqprot.c
> > b/libselinux/src/checkreqprot.c
> > new file mode 100644
> > index 00000000..38f3bebb
> > --- /dev/null
> > +++ b/libselinux/src/checkreqprot.c
> > @@ -0,0 +1,40 @@
> > +#include <unistd.h>
> > +#include <sys/types.h>
> > +#include <fcntl.h>
> > +#include <stdlib.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include "selinux_internal.h"
> > +#include "policy.h"
> > +#include <stdio.h>
> > +#include <limits.h>
> > +
> > +int security_checkreqprot(void)
> > +{
> > + int fd, ret, checkreqprot = 0;
> > + char path[PATH_MAX];
> > + char buf[20];
> > +
> > + if (!selinux_mnt) {
> > + errno = ENOENT;
> > + return -1;
> > + }
> > +
> > + snprintf(path, sizeof(path), "%s/checkreqprot", selinux_mnt);
> > + fd = open(path, O_RDONLY);
> 
> Please use O_CLOEXEC above.
> 
> > + if (fd < 0)
> > + return -1;
> > +
> > + memset(buf, 0, sizeof(buf));
> > + ret = read(fd, buf, sizeof(buf) - 1);
> 
> Please surround read() calls by TEMP_FAILURE_RETRY
> 
>   ret = TEMP_FAILURE_RETRY(read(fd, buf, sizeof(buf) - 1));

Not sure that's necessary.
http://man7.org/linux/man-pages/man7/signal.7.html says:

       If a blocked call to one of the following interfaces is interrupted
       by a signal handler, then the call will be automatically restarted
       after the signal handler returns if the SA_RESTART flag was used;
       otherwise the call will fail with the error EINTR:

       * read(2), readv(2), write(2), writev(2), and ioctl(2) calls on
         "slow" devices.  A "slow" device is one where the I/O call may
         block for an indefinite time, for example, a terminal, pipe, or
         socket.  If an I/O call on a slow device has already transferred
         some data by the time it is interrupted by a signal handler, then
         the call will return a success status (normally, the number of
         bytes transferred).  Note that a (local) disk is not a slow device
         according to this definition; I/O operations on disk devices are
         not interrupted by signals.

/sys/fs/selinux/checkreqprot is definitely not a "slow" device.

> 
> > + close(fd);
> > + if (ret < 0)
> > + return -1;
> > +
> > + if (sscanf(buf, "%d", &checkreqprot) != 1)
> > + return -1;
> > +
> > + return checkreqprot;
> > +}
> > +
> > +hidden_def(security_checkreqprot);
> > diff --git a/libselinux/src/selinux_internal.h
> > b/libselinux/src/selinux_internal.h
> > index 3d5c9fb4..e4650c92 100644
> > --- a/libselinux/src/selinux_internal.h
> > +++ b/libselinux/src/selinux_internal.h
> > @@ -59,6 +59,7 @@ hidden_proto(selinux_mkload_policy)
> >      hidden_proto(security_getenforce)
> >      hidden_proto(security_setenforce)
> >      hidden_proto(security_deny_unknown)
> > +    hidden_proto(security_checkreqprot)
> >      hidden_proto(selinux_boolean_sub)
> >      hidden_proto(selinux_current_policy_path)
> >      hidden_proto(selinux_binary_policy_path)
> > --
> > 2.11.0
> > 
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tyc
> > ho.nsa.gov.
> 
> 
> 
