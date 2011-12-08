Subject: Re: pp2te
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tim <elatllat@gmail.com>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <CA+3zgmsKe+qGsxXksLQtySPuLACEXUAW8qp2NBO_51U3HPH=_g@mail.gmail.com>
References: 
	 <CA+3zgmsKe+qGsxXksLQtySPuLACEXUAW8qp2NBO_51U3HPH=_g@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-Y/OjZ+J55Wjd728OkAe6"
Date: Thu, 08 Dec 2011 08:48:01 -0500
Message-ID: <1323352081.13613.14.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Y/OjZ+J55Wjd728OkAe6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-12-07 at 14:13 -0500, Tim wrote:
> Is there any way to convert targeted policy .pp files to .te files?

Closest approximation would be to use semodule_unpackage to extract the
binary .mod file from the .pp file, and then to use dismod to
disassemble the binary .mod file.  semodule_unpackage.c attached if you
don't have it and dismod is in the checkpolicy source tree (but not
built as part of the Fedora package).

$ gcc -lsepol -o semodule_unpackage semodule_unpackage.c
$ bunzip2 -c /usr/share/selinux/targeted/apache.pp.bz2 > apache.pp
$ ./semodule_unpackage apache.pp apache.mod apache.fc
$ checkpolicy/test/dismod apache.mod

-- 
Stephen Smalley
National Security Agency

--=-Y/OjZ+J55Wjd728OkAe6
Content-Disposition: attachment; filename="semodule_unpackage.c"
Content-Type: text/x-csrc; name="semodule_unpackage.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

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
	printf("usage: %s ppfile modfile [fcfile]\n", progname);
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
	FILE *fp;
	size_t len;
	char *ppfile, *modfile, *fcfile = NULL, *fcdata;

	progname = argv[0];

	if (argc < 3) {
		usage(progname);
		exit(1);
	}

	ppfile = argv[1];
	modfile = argv[2];
	if (argc >= 3)
		fcfile = argv[3];

	if (file_to_policy_file(ppfile, &in, "r"))
		exit(1);
	
	if (sepol_module_package_create(&pkg)) {
                fprintf(stderr, "%s:  Out of memory\n", progname);
                exit(1);		
	}

	if (sepol_module_package_read(pkg, in, 0) == -1) {
                fprintf(stderr, "%s:  Error while reading policy module from %s\n",
			progname, ppfile);
                exit(1);		
	}

	if (file_to_policy_file(modfile, &out, "w"))
		exit(1);
		
        if (sepol_policydb_write(sepol_module_package_get_policy(pkg), out)) {
                fprintf(stderr, "%s:  Error while writing module to %s\n", progname, modfile);
                exit(1);
        }

	sepol_policy_file_free(in);
	sepol_policy_file_free(out);

	len = sepol_module_package_get_file_contexts_len(pkg);
	if (fcfile && len) {
		fp = fopen(fcfile, "w");
		if (!fp) {
			fprintf(stderr, "%s:  Could not open file %s:  %s\n", progname, strerror(errno), fcfile);
			exit(1);
		}
		fcdata = sepol_module_package_get_file_contexts(pkg);
		if (fwrite(fcdata, 1, len, fp) != len) {
			fprintf(stderr, "%s:  Could not write file %s:  %s\n", progname, strerror(errno), fcfile);
			exit(1);
		}
		fclose(fp);
	}

	sepol_module_package_free(pkg);
	exit(0);
}

--=-Y/OjZ+J55Wjd728OkAe6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
