Subject: Re: [PATCH] libselinux: new and updated man pages for AVC,
	mapping, label
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: Xavier Toth <txtoth@gmail.com>, SELinux Mail List <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@parisplace.org>,
        KaiGai Kohei <kaigai@kaigai.gr.jp>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1213359860.17842.321.camel@moss-spartans.epoch.ncsc.mil>
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
	 <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>
	 <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>
	 <1213298430.17842.297.camel@moss-spartans.epoch.ncsc.mil>
	 <1213300336.17842.309.camel@moss-spartans.epoch.ncsc.mil>
	 <48518F23.6080406@tycho.nsa.gov>
	 <1213359860.17842.321.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 13 Jun 2008 10:27:06 -0400
Message-Id: <1213367226.17842.346.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-06-13 at 08:24 -0400, Stephen Smalley wrote:
> On Thu, 2008-06-12 at 17:03 -0400, Eamon Walsh wrote:
> > New and updated man pages for AVC, mapping, label.
> > 
> > Includes avc_open() call, deprecated avc_init(), selinux_set_mapping(), 
> > and new options to the selabel X backend.
> 
> Thanks for writing these.  A few minor comments below.
> 
> > Index: libselinux/man/man3/avc_open.3
> > ===================================================================
> > --- libselinux/man/man3/avc_open.3	(revision 0)
> > +++ libselinux/man/man3/avc_open.3	(revision 0)
> > @@ -0,0 +1,70 @@
> > +.\" Hey Emacs! This file is -*- nroff -*- source.
> > +.\"
> > +.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2008
> > +.TH "avc_open" "3" "12 Jun 2008" "" "SELinux API documentation"
> > +.SH "NAME"
> > +avc_open, avc_destroy, avc_reset, avc_cleanup \- userspace SELinux AVC setup and teardown.
> > +.SH "SYNOPSIS"
> > +.B #include <selinux/selinux.h>
> > +
> > +.B #include <selinux/avc.h>
> > +.sp
> > +.BI "int avc_open(struct selinux_opt *" options ", unsigned " nopt ");"
> > +.sp
> > +.BI "void avc_destroy(void);"
> > +.sp
> > +.BI "int avc_reset(void);"
> > +.sp
> > +.BI "void avc_cleanup(void);"
> > +.SH "DESCRIPTION"
> > +.B avc_open
> > +initializes the userspace AVC and must be called before any other AVC operation can be performed.
> > +
> > +.B avc_destroy
> > +destroys the userspace AVC, freeing all internal memory structures.  After this call has been made, 
> > +.B avc_init
> 
> s/avc_init/avc_open/
> 
> > Index: libselinux/man/man3/selinux_set_mapping.3
> > ===================================================================
> > --- libselinux/man/man3/selinux_set_mapping.3	(revision 0)
> > +++ libselinux/man/man3/selinux_set_mapping.3	(revision 0)
> > @@ -0,0 +1,86 @@
> > +.\" Hey Emacs! This file is -*- nroff -*- source.
> > +.\"
> > +.\" Author: Eamon Walsh (ewalsh@tycho.nsa.gov) 2008
> > +.TH "selinux_set_mapping" "3" "12 Jun 2008" "" "SELinux API documentation"
> > +.SH "NAME"
> > +selinux_set_mapping \- establish dynamic object class and permission mapping.
> > +.SH "SYNOPSIS"
> > +.B #include <selinux/selinux.h>
> > +.sp
> > +.nf
> > +struct security_class_mapping {
> > +	const char *name;
> > +	const char *perms[];
> > +};
> > +.fi
> > +.sp
> > +.BI "int selinux_set_mapping(struct security_class_mapping *" map ");"
> > +
> > +.SH "DESCRIPTION"
> > +.B selinux_set_mapping
> > +establishes a mapping from a user-provided ordering of object classes and permissions to the numbers actually used by the loaded system policy.  Use of this function is highly preferred over the generated constants in the libselinux header files, as this method allows the policy's class and permission values to change over time.
> > +
> > +After the mapping is established, all libselinux functions that operate on class and permission values take the user-provided numbers, which are determined as follows:
> > +
> > +The
> > +.I map
> > +argument consists of an array of 
> > +.B security_class_mapping
> > +structures, which must be terminated by a structure having a NULL name field.  Except for this last structure, the
> > +.I name 
> > +field should refer to the string name of an object class, and the corresponding
> > +.I perms
> > +field should refer to an array of permission bit names terminated by a NULL string.
> > +
> > +The object classes named in the mapping and each set of permission bits are numbered in order starting from 1.  These numbers are the values that should be passed to subsequent libselinux calls.
> > +
> > +.SH "RETURN VALUE"
> > +Zero is returned on success.  On error, -1 is returned and
> > +.I errno
> > +is set appropriately.
> > +
> > +.SH "ERRORS"
> > +.TP
> > +.B EINVAL
> > +One of the class or permission names requested in the mapping is not present in the loaded policy.
> > +.TP
> > +.B ENOMEM
> > +An attempt to allocate memory failed.
> > +
> > +.SH "EXAMPLE"
> > +.RS
> > +.ta 4n 10n
> > +.nf
> > +struct security_class_mapping map[] = {
> > +	{ "file", { "create", "rename", "unlink", NULL } },
> > +	{ "socket", { "bind", NULL } },
> > +	{ "process", { "signal", NULL } },
> > +	{ NULL }
> > +};
> > +
> > +if (selinux_set_mapping(map) < 0)
> > +	exit(1);
> > +.fi
> > +.ta
> > +.RE
> > +
> > +In this example, after the call has succeeded, classes
> > +.BR file ,
> > +.BR socket ,
> > +and
> > +.B process
> > +will be identified by 1, 2 and 3, respectively.  Permissions
> > +.IR create ,
> > +.IR rename ,
> > +and
> > +.I unlink
> > +(for the 
> > +.B file
> > +class) will be identified by 1, 2, and 4, respectively.  Classes and permissions not listed in the mapping cannot be used.
> 
> To be clear, the permissions are identified by bits 1, 2, and 4, but
> their actual values as access vectors are 1 << (bit - 1).

Oops, never mind - I misread that.  Although you might want to make it
clear that we are dealing with bit indices for the permissions.

One other question I have is what we should do about the flask.h
definitions and string tables in libselinux.  We obviously need to
retain the legacy definitions for old userspace object managers, but we
also have the old X definitions there and the db definitions.  make
LIBSELINUX_D=/path/to/libselinux tolib from refpolicy/policy/flask will
install updated headers and string tables with the latest definitions
but do we want them all now or just the legacy ones?

I suppose partly that depends on whether we want to use newer object
managers on older kernels that don't support the dynamic class/perm
discovery mechanism.  

> As a separate matter, we may want to discuss whether we are getting the
> flexibility we hoped from this dynamic mapping.  The other day I was
> adding a new kernel class for experimentation purposes and inserted it
> before the new X classes, thinking that this would be ok since they can
> be dynamically looked up and thus don't require fixed indices.  However,
> when booting the resulting kernel with a stock policy, I found that the
> kernel refused to load the policy because it saw a conflict between its
> kernel definition for that class value (the new kernel class) and the
> policy definition for that class value (the X class).  Which would mean
> that new kernels on legacy distros would break.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
