Subject: Re: Recovering .te and .fc files from modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <456DFCA7.2090500@mentalrootkit.com>
References: <456DEFAD.6040706@mentalrootkit.com>
	 <1164834319.23019.268.camel@moss-spartans.epoch.ncsc.mil>
	 <456DFCA7.2090500@mentalrootkit.com>
Content-Type: multipart/mixed; boundary="=-H/n1Drjn6cgCuJ3Cj1xh"
Date: Thu, 30 Nov 2006 08:51:15 -0500
Message-Id: <1164894675.23019.320.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-H/n1Drjn6cgCuJ3Cj1xh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-11-29 at 16:33 -0500, Karl MacMillan wrote:
> Stephen Smalley wrote:
> > On Wed, 2006-11-29 at 15:38 -0500, Karl MacMillan wrote:
> >> We've been getting requests for a tool to extract the .te and .fc files 
> >> from modules. Red Hat bugzilla for this at 
> >> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=217761.
> >>
> >> I think this is a good idea and the dismod tool (located in 
> >> checkpolicy/test in the sources) is a good start at this. I'm mentioning 
> >> it here in case anyone has time or interest in creating this tool.
> > 
> > You might want to separate the disassembling of a binary module to
> > source policy from unpackaging a policy package, e.g. a
> > semodule_unpackage utility could easily write out the individual
> > components (binary module, file contexts, netfilter contexts), and then
> > a nicer version of dismod could disassemble the binary module to textual
> > representation.
> > 
> 
> Good point - added a note to the bugzilla.

Here is a trivial starting point for semodule_unpackage that I created
from semodule_package a long time ago when I needed to extract a .mod
file from a .pp file.  I also attached it to the bugzilla.   It only
extracts the .mod file right now, not the rest of the .pp contents.


-- 
Stephen Smalley
National Security Agency

--=-H/n1Drjn6cgCuJ3Cj1xh
Content-Disposition: attachment; filename=semodule_unpackage.c
Content-Type: text/x-csrc; name=semodule_unpackage.c; charset=utf-8
Content-Transfer-Encoding: 7bit

/* Authors: Karl MacMillan <kmacmillan@tresys.com>
 *
 * Copyright (C) 2004 Tresys Technology, LLC
 *	This program is free software; you can redistribute it and/or modify
 *  	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, version 2.
 */
 
#include <sepol/module.h>
#include <getopt.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <errno.h>

char *progname = NULL;
extern char *optarg;

static void usage(char *progname)
{
	printf("usage: %s ppfile modfile\n", progname);
	exit(1);
}

static int file_to_policy_file(char *filename, struct sepol_policy_file **pf, char *mode)
{
	FILE *f;
	
	if (sepol_policy_file_create(pf)) {
		fprintf(stderr, "%s:  Out of memory\n", progname);
		return -1;	
	}
	
	f = fopen(filename, mode);
	if (!f) {
		fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, strerror(errno), filename);
		return -1;	
	}
	sepol_policy_file_set_fp(*pf, f);
	return 0;
}

int main(int argc, char **argv)
{
	struct sepol_module_package *pkg;
	struct sepol_policy_file *in, *out;

	progname = argv[0];

	if (argc != 3) {
		usage(argv[0]);
		exit(1);
	}

	if (file_to_policy_file(argv[1], &in, "r"))
		exit(1);
	
	if (sepol_module_package_create(&pkg)) {
                fprintf(stderr, "%s:  Out of memory\n", argv[0]);
                exit(1);		
	}

	if (sepol_module_package_read(pkg, in, 0) == -1) {
                fprintf(stderr, "%s:  Error while reading policy module from %s\n",
			argv[0], argv[1]);
                exit(1);		
	}

	if (file_to_policy_file(argv[2], &out, "w"))
		exit(1);
		
        if (sepol_policydb_write(sepol_module_package_get_policy(pkg), out)) {
                fprintf(stderr, "%s:  Error while writing module to %s\n", argv[0], argv[2]);
                exit(1);
        }

	sepol_policy_file_free(in);
	sepol_policy_file_free(out);
	sepol_module_package_free(pkg);
	exit(0);
}

--=-H/n1Drjn6cgCuJ3Cj1xh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
