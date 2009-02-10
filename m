MIME-Version: 1.0
In-Reply-To: <20090210183438.GA14133@us.ibm.com>
References: <cadfc0e40902050908n5391c4b4l417714fe87a47f29@mail.gmail.com>
	 <1233857436.3181.40.camel@localhost.localdomain>
	 <cadfc0e40902061356u466495ccyc471328485e2e80e@mail.gmail.com>
	 <1234188170.28831.10.camel@localhost.localdomain>
	 <cadfc0e40902090842i2a62ab85ucb6bfb0e9ee5a4be@mail.gmail.com>
	 <1234210633.28831.87.camel@localhost.localdomain>
	 <20090209204200.GA25401@us.ibm.com>
	 <cadfc0e40902100900n12d116b2m7b1c5db4ae43c9d@mail.gmail.com>
	 <20090210183438.GA14133@us.ibm.com>
Date: Tue, 10 Feb 2009 14:20:55 -0600
Message-ID: <cadfc0e40902101220o7c7b162v84cbbfb264a7c980@mail.gmail.com>
Subject: Re: problem with capabilities inheritance and auditing in python
From: Xavier Toth <txtoth@gmail.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Feb 10, 2009 at 12:34 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Xavier Toth (txtoth@gmail.com):
>> I was not putting capabilities on the script but rather on a compiled
>> wrapper which execs a python script in which I need to do auditing.
>> Will this not work?
>
> No, because of the way capabilities are re-calculated on exec().
>
>        pI' = pI
>        pP' = (X&fP) | (pI & fI)
>        pE' = fE ? pP' : 0
>
> So since the interpreter has fI=fP=fE=0 and is not setuid root (which
> would fill in fP and/or fE to emulate privileged root), pP' and pE' will
> be empty after exec().
>
> Now you could use a wrapper as follows:  Have the wrapper fill pI,
> and then fill fI on the python interpreter.  Any user who has an
> empty pI (which generally is all users) will execute python scripts
> with no privilege, but when the wrapper execs the script, pP' will
> be filled with (pI&fI) = full.
>
> -serge
>

Thanks for the clarification.
For anyone one that is interested I've included some test code. The
wrapper is a modified version of a wrapper Stephen sent me a link to.
Basic steps to test are:
1) edit the wrapper to set the path to the audit_test.py script
2) compiler the wrapper
    gcc -o audit-wrapper audit-wrapper.c -lcap
3) set the capabilities on the wrapper and python
    setcap cap_audit_write,cap_setfcap=epi audit-wrapper
    setcap cap_audit_write=ei /usr/bin/python
4) run audit-wrapper
5) check audit log for audit records.

I also ran audit_test.py without the wrapper to verify that no audit
would occur.

Ted

------------------------------------------------------------------------------
audit-wrapper.c
------------------------------------------------------------------------

/*
 -------------------------------------------------------------------------
   Copyright 1991-1995 by Stichting Mathematisch Centrum, Amsterdam,
   The Netherlands.

                           All Rights Reserved

   Permission to use, copy, modify, and distribute this software and its
   documentation for any purpose and without fee is hereby granted,
   provided that the above copyright notice appear in all copies and that
   both that copyright notice and this permission notice appear in
   supporting documentation, and that the names of Stichting Mathematisch
   Centrum or CWI or Corporation for National Research Initiatives or
   CNRI not be used in advertising or publicity pertaining to
   distribution of the software without specific, written prior
   permission.

   While CWI is the initial source for this software, a modified version
   is made available by the Corporation for National Research Initiatives
   (CNRI) at the Internet address ftp://ftp.python.org.

   STICHTING MATHEMATISCH CENTRUM AND CNRI DISCLAIM ALL WARRANTIES WITH
   REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF
   MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL STICHTING MATHEMATISCH
   CENTRUM OR CNRI BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL
   DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
   PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
   PERFORMANCE OF THIS SOFTWARE.
 -------------------------------------------------------------------------

   Template for a setuid program that calls a script.

   The script should be in an unwritable directory and should itself
   be unwritable.  In fact all parent directories up to the root
   should be unwritable.  The script must not be setuid, that's what
   this program is for.

   This is a template program.  You need to fill in the name of the
   script that must be executed.  This is done by changing the
   definition of FULL_PATH below.

   There are also some rules that should be adhered to when writing
   the script itself.

   The first and most important rule is to never, ever trust that the
   user of the program will behave properly.  Program defensively.
   Check your arguments for reasonableness.  If the user is allowed to
   create files, check the names of the files.  If the program depends
   on argv[0] for the action it should perform, check it.

   Assuming the script is a Bourne shell script, the first line of the
   script should be
	#!/bin/sh -
   The - is important, don't omit it.  If you're using esh, the first
   line should be
	#!/usr/local/bin/esh -f
   and for ksh, the first line should be
	#!/usr/local/bin/ksh -p
   The script should then set the variable IFS to the string
   consisting of <space>, <tab>, and <newline>.  After this (*not*
   before!), the PATH variable should be set to a reasonable value and
   exported.  Do not expect the PATH to have a reasonable value, so do
   not trust the old value of PATH.  You should then set the umask of
   the program by calling
	umask 077 # or 022 if you want the files to be readable
   If you plan to change directories, you should either unset CDPATH
   or set it to a good value.  Setting CDPATH to just ``.'' (dot) is a
   good idea.
   If, for some reason, you want to use csh, the first line should be
	#!/bin/csh -fb
   You should then set the path variable to something reasonable,
   without trusting the inherited path.  Here too, you should set the
   umask using the command
	umask 077 # or 022 if you want the files to be readable
*/
#define _GNU_SOURCE
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <sys/capability.h>

/* CONFIGURATION SECTION */

#ifndef FULL_PATH	/* so that this can be specified from the Makefile */
/* Uncomment the following line: */
#define FULL_PATH	"<your path to>/audit_test.py"
/* Then comment out the #error line.
#error "You must define FULL_PATH somewhere" */
#endif
#ifndef UMASK
#define UMASK		077
#endif

/* END OF CONFIGURATION SECTION */

#if defined(__STDC__) && defined(__sgi)
#define environ _environ
#endif

/* don't change def_IFS */
char def_IFS[] = "IFS= \t\n";
/* you may want to change def_PATH, but you should really change it in */
/* your script */
#ifdef __sgi
char def_PATH[] = "PATH=/usr/bsd:/usr/bin:/bin:/usr/local/bin:/usr/sbin";
#else
char def_PATH[] = "PATH=/usr/bin:/bin:/usr/local/bin";
#endif
/* don't change def_CDPATH */
char def_CDPATH[] = "CDPATH=.";
/* don't change def_ENV */
char def_ENV[] = "ENV=:";

/*
   This function changes all environment variables that start with LD_
   into variables that start with XD_.  This is important since we
   don't want the script that is executed to use any funny shared
   libraries.

   The other changes to the environment are, strictly speaking, not
   needed here.  They can safely be done in the script.  They are done
   here because we don't trust the script writer (just like the script
   writer shouldn't trust the user of the script).
   If IFS is set in the environment, set it to space,tab,newline.
   If CDPATH is set in the environment, set it to ``.''.
   Set PATH to a reasonable default.
*/
void
clean_environ(void)
{
	char **p;
	extern char **environ;

	for (p = environ; *p; p++) {
		if (strncmp(*p, "LD_", 3) == 0)
			**p = 'X';
		else if (strncmp(*p, "_RLD", 4) == 0)
			**p = 'X';
		else if (strncmp(*p, "PYTHON", 6) == 0)
			**p = 'X';
		else if (strncmp(*p, "PERL", 4) == 0)
			**p = 'X';
		else if (strncmp(*p, "IFS=", 4) == 0)
			*p = def_IFS;
		else if (strncmp(*p, "CDPATH=", 7) == 0)
			*p = def_CDPATH;
		else if (strncmp(*p, "ENV=", 4) == 0)
			*p = def_ENV;
	}
	putenv(def_PATH);
}
int
main(int argc, char **argv)
{
        argc = argc;
	struct stat statb;

	uid_t euid = geteuid();

	/*
	   Sanity check #1.
	   This check should be made compile-time, but that's not possible.
	   If you're sure that you specified a full path name for FULL_PATH,
	   you can omit this check.
	*/
	if (FULL_PATH[0] != '/') {
		fprintf(stderr, "%s: %s is not a full path name\n", argv[0],
			FULL_PATH);
		fprintf(stderr, "You can only use this wrapper if you\n");
		fprintf(stderr, "compile it with an absolute path.\n");
		exit(-1);
	}

	/*
	   Sanity check #2.
	   Check that the owner of the script is equal to either the
	   effective uid or the super user.
	*/
	if (stat(FULL_PATH, &statb) < 0) {
		perror("stat");
		exit(-1);
	}
	if (statb.st_uid != 0 && statb.st_uid != euid) {
		fprintf(stderr, "%s: %s has the wrong owner\n", argv[0],
			FULL_PATH);
		fprintf(stderr, "The script should be owned by root,\n");
		fprintf(stderr, "and shouldn't be writeable by anyone.\n");
		exit(-1);
	}

	cap_t cur = cap_from_text("cap_audit_write+i");
	int ret = cap_set_proc(cur);
	if (ret) {
		perror("cap_set_proc");
		return 1;
	}
	cap_free(cur);

	clean_environ();

	umask(UMASK);

	while (**argv == '-')	/* don't let argv[0] start with '-' */
		(*argv)++;
	execv(FULL_PATH, argv);
	perror("execv");
	fprintf(stderr, "%s: could not execute the script %s\n", argv[0], FULL_PATH);
	exit(-1);
}

--------------------------------------------------------------------------
audit_test.py -----------------------------------------------------------------------------

#!/usr/bin/env python
import audit
import traceback
import errno
import sys


def test():
    msg = "foo"
    try:
        audit_fd = audit.audit_open()
        if audit_fd < 0:
            print("Error connecting to audit daemon")
            sys.exit(1)
    except:
        print("Failed to connecting to audit daemon:  %s : %s" % (
sys.exc_info()[0], traceback.format_exc()))
        sys.exit(1)

    try:
        print "call audit_log_user_message"
        rc = audit.audit_log_user_message(audit_fd,
audit.AUDIT_LABEL_LEVEL_CHANGE, str(msg), "", "", "", 0);
        rc = audit.audit_log_user_message(audit_fd,
audit.AUDIT_TRUSTED_APP, str(msg), "", "", "", 0);
        if rc < 0:
            print("Error writing to audit")
            sys.exit(1)
    except:
        print("Failed to write audit:  %s : %s" % ( sys.exc_info()[0],
traceback.format_exc()))
        sys.exit(1)


if __name__ == '__main__':
    test()

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
