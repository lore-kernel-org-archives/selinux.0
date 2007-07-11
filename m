Subject: Re: using semodule_package
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <method@manicmethod.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD01FB6DF2@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD01FB6DF2@blums0008.bluelnk.net>
Content-Type: multipart/mixed; boundary="=-raD5JZnYldDP7rmxRoJt"
Date: Wed, 11 Jul 2007 08:17:21 -0400
Message-Id: <1184156241.3392.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-raD5JZnYldDP7rmxRoJt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2007-07-10 at 19:10 -0700, Clarkson, Mike R (US SSA) wrote:
> The manpage for semodule_package gives examples for how to use it:
> 	semodule_package -o httpd.pp -m httpd.mod -f httpd.fc
> 
> Am I supposed to get the *.mod files for modules when I compile the
> policy? I have a base.mod file, but no *.mod files for the loadable
> modules. The closest that I have is <module_name>.mod.role files under
> the .../policy/tmp directory.
> 
> I'd like to be able to use semodule_package to update file contexts
> without having to recompile.

It appears that the .mod files are removed at the end of the build
process after they have been packaged into .pp files.  Not sure why.
Options, aside from tracking down the relevant makefile rule and
removing it, might include:
- regenerating the .mod via checkmodule on tmp/<name>.tmp, e.g.
	checkmodule -M -m tmp/zebra.tmp -o tmp/zebra.mod
or
- extracting the already built .mod file from the .pp file

I took the semodule_package.c code once and created a
semodule_unpackage.c file from it to unpack the .mod file, but never got
around to generalizing it (e.g. unpacking all of the files) or
committing it.  Attached below for your amusement.
$ gcc -lsepol -o semodule_unpackage semodule_unpackage.c
$ ./semodule_unpackage zebra.pp zebra.mod
 
-- 
Stephen Smalley
National Security Agency

--=-raD5JZnYldDP7rmxRoJt
Content-Disposition: attachment; filename=semodule_unpackage.c
Content-Type: text/x-csrc; name=semodule_unpackage.c; charset=UTF-8
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

--=-raD5JZnYldDP7rmxRoJt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
