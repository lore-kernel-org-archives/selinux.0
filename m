Subject: Re: Fwd: How to extract file context patterns from selinux module
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Karel Srot <ksrot@redhat.com>,
        Steve
 Lawrence <slawrence@tresys.com>
In-Reply-To: <4E32A24A.4000503@redhat.com>
References: <1311941001.7994.4.camel@dhcp-30-102.brq.redhat.com>
	 <4E32A24A.4000503@redhat.com>
Content-Type: multipart/mixed; boundary="=-haF7SC9JmLpTGAB1nf9T"
Date: Fri, 29 Jul 2011 09:29:07 -0400
Message-ID: <1311946147.12720.26.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-haF7SC9JmLpTGAB1nf9T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2011-07-29 at 08:06 -0400, Daniel J Walsh wrote:
> Hi,
> could you please help me with following problem?
> I would like to extract context patterns from a selinux module.
> I know there are placed at the end of the module but I don't know (and
> didn't find) the module structure. Therefore I don't know how to parse
> them (if there are any in the module).
> 
> Thank you in advance
> Karel Srot
> 
> $ tail abrt.pp
> var/cache/abrt-di(/.*)?		system_u:object_r:abrt_var_cache_t:s0
> /var/log/abrt-logger		--	system_u:object_r:abrt_var_log_t:s0
> /var/run/abrt\.pid			--	system_u:object_r:abrt_var_run_t:s0
> /var/run/abrtd?\.lock		--	system_u:object_r:abrt_var_run_t:s0
> /var/run/abrtd?\.socket		-s  system_u:object_r:abrt_var_run_t:s0
> /var/run/abrt(/.*)?		system_u:object_r:abrt_var_run_t:s0
> ...

I created this program a while ago to support unpacking the .mod file
from the .pp file, and just extended it to optionally unpack the .fc
file as well.  If people find it useful, we could perhaps add it to
policycoreutils.

$ gcc -lsepol -o semodule_unpackage semodule_unpackage.c
$ bunzip2 -c /usr/share/selinux/targeted/apache.pp.bz2 > apache.pp
$ semodule_unpackage apache.pp apache.mod apache.fc
$ cat apache.fc

-- 
Stephen Smalley
National Security Agency

--=-haF7SC9JmLpTGAB1nf9T
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

--=-haF7SC9JmLpTGAB1nf9T--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
