Message-ID: <1493644269.24970.4.camel@btinternet.com>
Subject: Re: [PATCH] libselinux: Add permissive= entry to avc audit log
From: Richard Haines <richard_c_haines@btinternet.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Date: Mon, 01 May 2017 14:11:09 +0100
In-Reply-To: <1493303690.2524.10.camel@tycho.nsa.gov>
References: <20170426134721.2501-1-richard_c_haines@btinternet.com>
 <1493303690.2524.10.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-27 at 10:34 -0400, Stephen Smalley wrote:
> On Wed, 2017-04-26 at 14:47 +0100, Richard Haines wrote:
> > Add audit log entry to specify whether the decision was made in
> > permissive mode/permissive domain or enforcing mode.
> > 
> > There are two utilities for testing:
> > utils/avc_has_perm - This can set the AVC mode to follow SELinux,
> > set
> > AVC permissive, or set AVC enforcing.
> > 
> > utils/selinux_check_access - This follows SELinux as it calls
> > selinux_check_access(3).
> > 
> > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> > ---
> >  libselinux/src/avc.c                    |   4 +
> >  libselinux/utils/avc_has_perm.c         | 203
> > ++++++++++++++++++++++++++++++++
> >  libselinux/utils/selinux_check_access.c | 145
> > +++++++++++++++++++++++
> >  3 files changed, 352 insertions(+)
> >  create mode 100644 libselinux/utils/avc_has_perm.c
> >  create mode 100644 libselinux/utils/selinux_check_access.c
> 
> I think the utilities should be in a separate patch since someone may
> want the permissive= logging but not the new utilities.  But maybe we
> ought to reconsider whether these new utilities are helpful or
> not.  Do
> we really need both of them?  If we can get away with just using one
> of
> them, I'd prefer selinux_check_access since we would like to migrate
> most users to that interface instead of directly using the AVC.
I'll send an updated patch for selinux_check_access today.

> 
> We also need to rethink the libselinux utils in general.  Some of
> them
> are actually used by end users and system scripts, but many of them
> are
> more akin to test programs than real utilities.  Maybe we need a
> libselinux/tests or libselinux/samples or something.
I checked the utils and I've added all the selabel_* ones. Not sure if
you count them as utils or test/sample/examples.

I must admit I like examples that show as much variation as possible as
the function man pages only give basic facts. For example
selinux_check_access has an option to add supplementary audit info,
however this does not work unless you add the correct callback. It's
okay for experts but for the rest of us !!!

I guess the main issue for having examples is maintaining them. However
if there is interest, I would be happy to submit some. They could of
course also be used for testing, although I guess you would prefer some
form of test harness instead - like the selinux-testsuite as some
require policy to fully test/demonstrate.


>   For example, it
> is likely confusing to have a selinux_restorecon utility in
> libselinux
> when we also have restorecon itself in policycoreutils.  Is there
> still
> value in having selinux_restorecon as a separate utility or can we
> drop
> it now that setfiles/restorecon has been rewritten to use the new
> interface?
I'll send a patch to remove utils/selinux_restorecon.c today.
> 
> > 
> > diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
> > index b1ec57f..5600f80 100644
> > --- a/libselinux/src/avc.c
> > +++ b/libselinux/src/avc.c
> > @@ -723,6 +723,10 @@ void avc_audit(security_id_t ssid,
> > security_id_t
> > tsid,
> >  
> >  	log_append(avc_audit_buf, " ");
> >  	avc_dump_query(ssid, tsid, tclass);
> > +
> > +	log_append(avc_audit_buf, " permissive=%u", avc_enforcing
> > &&
> > +		   !(avd->flags & SELINUX_AVD_FLAGS_PERMISSIVE) ?
> > 0
> > : 1);
> > +
> 
> Looking at the kernel logic, it would seem we could do the following
> instead:
> 	if (denied)
> 		log_append(avc_audit_buf, " permissive=%u", result ? 0
> : 1);
> 
> This has the benefit of only adding it on a denial (no point in
> logging
> it on a granting) and not needing to re-check enforcing/permissive
> mode
> but rather just make use of the fact that the only case where a
> denied
> permission will yield a successful return is if it was permissive.
> 
> >  	log_append(avc_audit_buf, "\n");
> >  	avc_log(SELINUX_AVC, "%s", avc_audit_buf);
> >  
> > diff --git a/libselinux/utils/avc_has_perm.c
> > b/libselinux/utils/avc_has_perm.c
> > new file mode 100644
> > index 0000000..3d4bfc0
> > --- /dev/null
> > +++ b/libselinux/utils/avc_has_perm.c
> > @@ -0,0 +1,203 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <unistd.h>
> > +#include <stdbool.h>
> > +#include <selinux/selinux.h>
> > +#include <selinux/avc.h>
> > +
> > +static void usage(char *progname)
> > +{
> > +	fprintf(stderr, "usage:  %s [-f | -p] [-i] scon tcon class
> > perm\n"
> > +		"\nWhere:\n\t"
> > +		"-f  Follow SELinux permissive or enforcing mode,
> > or\n\t"
> > +		"-p  Set avc_open to permissive mode.\n\t"
> > +		"    The default is to set avc_open to enforcing
> > mode.\n\t"
> 
> Why is that the default for the utility?  The userspace AVC default
> is
> to follow system enforcing mode.
> 
> > +		"-i  Interactive mode. Once displayed first
> > result,
> > can\n\t"
> > +		"    enter additional entries and display AVC
> > cache
> > info.\n",
> > +		progname);
> > +	exit(1);
> > +}
> > +
> > +static void get_entry(char **buffer)
> > +{
> > +	char *buf;
> > +	int len;
> > +#define BUF_LEN 81
> > +
> > +	buf = malloc(BUF_LEN * sizeof(char));
> 
> IMHO, you don't ever need to say sizeof(char), but maybe that's just
> me.
> 
> > +	if (!buf) {
> > +		perror("malloc");
> > +		exit(1);
> > +	}
> > +
> > +	if (fgets(buf, BUF_LEN - 1, stdin) == NULL) {
> > +		perror("fgets");
> > +		exit(1);
> > +	}
> 
> Might be simpler to use getline().  Even Android has it these days.
> 
> > +
> > +	len = strlen(buf);
> > +	if (buf[len - 1] == '\n')
> > +		buf[len - 1] = 0;
> > +
> > +	*buffer = buf;
> > +}
> > +
> > +/*
> > + * Function to print the AVC statistics. Because no audit logging
> > call back
> > + * has been set, the avc_cache_stats will be displayed on stderr.
> 
> I think this comment is stale.
> 
> > + */
> > +static void print_avc_stats(void)
> > +{
> > +	struct avc_cache_stats acs;
> > +
> > +	avc_cache_stats(&acs);
> > +	printf("\nThe avc_cache_stats are as follows:\n");
> > +	printf("entry_hits:     %d\t(Decisions found in aeref)\n",
> > +	       acs.entry_hits);
> > +	printf("entry_misses:   %d\t(Decisions not found in
> > aeref)\n",
> > +	       acs.entry_misses);
> > +	printf("entry_discards: %d\t(Decisions not found in aeref
> > that were "
> > +	       "also non-NULL)\n", acs.entry_discards);
> > +	printf("entry_lookups:  %d\t(Queries made)\n",
> > acs.entry_lookups);
> > +	printf("cav_lookups:    %d\t(Cache lookups)\n",
> > acs.cav_lookups);
> > +	printf("cav_hits:       %d\t(Cache hits)\n",
> > acs.cav_hits);
> > +	printf("cav_probes:     %d\t(Entries examined searching
> > the
> > cache)\n",
> > +	       acs.cav_probes);
> > +	printf("cav_misses:     %d\t(Cache misses)\n\n",
> > acs.cav_misses);
> > +}
> > +
> > +struct avc_entry_ref aeref;
> > +static void exec_func(char *scon, char *tcon, char *class, char
> > *perm)
> 
> This is an oddly named function.
> 
> > +{
> > +	int rc;
> > +	security_id_t scon_id;
> > +	security_id_t tcon_id;
> > +	security_class_t sclass;
> > +	access_vector_t av;
> > +
> > +	rc = avc_context_to_sid(scon, &scon_id);
> > +	if (rc < 0) {
> > +		perror("Error scon avc_context_to_sid");
> > +		exit(1);
> > +	}
> > +
> > +	rc = avc_context_to_sid(tcon, &tcon_id);
> > +	if (rc < 0) {
> > +		perror("Error tcon avc_context_to_sid");
> > +		exit(1);
> > +	}
> > +
> > +	sclass = string_to_security_class(class);
> > +	av = string_to_av_perm(sclass, perm);
> > +
> > +	printf("\nAny avc_log error messages are shown on
> > stderr:\n");
> > +	rc = avc_has_perm(scon_id, tcon_id, sclass, av, &aeref,
> > NULL);
> > +	printf("\nEnd of avc_log error messages.\n\n");
> > +
> > +	if (rc < 0)
> > +		printf("Error avc_has_perm: %s\n",
> > strerror(errno));
> > +	else
> > +		printf("Permission ALLOWED.\n");
> > +}
> 
> This function is almost but not quite the same as
> selinux_check_access().  So do we really need it at all?
> Is the only reason you need/want it in order to be able to decouple
> from system enforcing mode?  If so, then it seems like a better thing
> to do would be to make it possible to alter the enforcing mode
> handling
> for selinux_check_access() in some general way, and then use that
> feature.  Arguably, avc_open() could test avc_running on entry and
> just
> return immediately if already set, as avc_init() already does.  Then
> if
> you truly want to reset the state, you'd call avc_destroy() before
> calling avc_open() again, which is more correct anyway.  Then
> selinux_check_access() would not clobber any previously set enforcing
> mode behavior and you could just do your avc_open() call and then
> call
> selinux_check_access() as is.
> 
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, rc;
> > +	bool interactive = false, follow = false;
> > +	char *scon, *tcon, *class, *perm;
> > +	struct selinux_opt avc_option;
> > +
> > +	avc_option.type = AVC_OPT_SETENFORCE;
> > +	avc_option.value = (char *)1;
> > +
> > +	while ((opt = getopt(argc, argv, "ifp")) != -1) {
> > +		switch (opt) {
> > +		case 'i':
> > +			interactive = true;
> > +			break;
> > +		case 'f':
> > +			follow = true;
> > +			break;
> > +		case 'p':
> > +			avc_option.value = NULL;
> > +			break;
> > +		default:
> > +			usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if ((argc - optind) != 4)
> > +		usage(argv[0]);
> > +
> > +	rc = is_selinux_enabled();
> > +	if (rc == 0) {
> > +		printf("SELinux is not enabled.\n");
> > +		exit(1);
> > +	} else if (rc == 1) {
> > +		printf("SELinux is enabled.\n");
> > +	} else {
> > +		perror("Error is_selinux_enabled");
> > +		exit(1);
> > +	}
> > +
> > +	rc = security_getenforce();
> > +	if (rc == 0)
> > +		printf("SELinux running in PERMISSIVE mode.\n");
> > +	else if (rc == 1)
> > +		printf("SELinux running in ENFORCING mode.\n");
> > +	else {
> > +		perror("Error security_getenforce");
> > +		exit(1);
> > +	}
> > +
> > +	rc = security_deny_unknown();
> > +	if (rc == 0)
> > +		printf("Undefined object classes or permissions:
> > ALLOWED.\n");
> > +	else if (rc == 1)
> > +		printf("Undefined object classes or permissions:
> > DENIED.\n");
> > +	else {
> > +		perror("Error security_deny_unknown");
> > +		exit(1);
> > +	}
> > +
> > +	if (follow) {
> > +		if (avc_open(NULL, 0)) {
> > +			perror("Error avc_open");
> > +			exit(1);
> > +		}
> > +		printf("avc_open - Following SELinux mode.\n");
> > +	} else {
> > +		if (avc_open(&avc_option, 1)) {
> > +			perror("Error avc_open");
> > +			exit(1);
> > +		}
> > +
> > +		if (avc_option.value == NULL)
> > +			printf("avc_open - PERMISSIVE mode.\n");
> > +		else
> > +			printf("avc_open - ENFORCING mode.\n");
> > +	}
> > +
> > +	avc_entry_ref_init(&aeref);
> > +
> > +	exec_func(argv[optind], argv[optind + 1], argv[optind +
> > 2],
> > +		  argv[optind + 3]);
> > +
> > +	while (interactive) {
> > +		printf("\nEnter scon: ");
> > +		get_entry(&scon);
> > +		printf("Enter tcon: ");
> > +		get_entry(&tcon);
> > +		printf("Enter class: ");
> > +		get_entry(&class);
> > +		printf("Enter perm: ");
> > +		get_entry(&perm);
> > +
> > +		exec_func(scon, tcon, class, perm);
> > +		print_avc_stats();
> > +	}
> > +
> > +	exit(0);
> > +}
> > diff --git a/libselinux/utils/selinux_check_access.c
> > b/libselinux/utils/selinux_check_access.c
> > new file mode 100644
> > index 0000000..8e354c1
> > --- /dev/null
> > +++ b/libselinux/utils/selinux_check_access.c
> > @@ -0,0 +1,145 @@
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <unistd.h>
> > +#include <stdbool.h>
> > +#include <selinux/selinux.h>
> > +#include <selinux/avc.h>
> > +
> > +static void usage(char *progname)
> > +{
> > +	fprintf(stderr, "usage:  %s [-i] scon tcon class perm\n"
> > +		"\nWhere:\n\t"
> > +		"-i  Interactive mode. Once displayed first
> > result,
> > can\n\t"
> > +		"    enter additional entries and display AVC
> > cache
> > info.\n",
> > +		progname);
> > +	exit(1);
> > +}
> > +
> > +static void get_entry(char **buffer)
> > +{
> > +	char *buf;
> > +	int len;
> > +#define BUF_LEN 81
> > +
> > +	buf = malloc(BUF_LEN * sizeof(char));
> > +	if (!buf) {
> > +		perror("malloc");
> > +		exit(1);
> > +	}
> > +
> > +	if (fgets(buf, BUF_LEN - 1, stdin) == NULL) {
> > +		perror("fgets");
> > +		exit(1);
> > +	}
> > +
> > +	len = strlen(buf);
> > +	if (buf[len - 1] == '\n')
> > +		buf[len - 1] = 0;
> > +
> > +	*buffer = buf;
> > +}
> > +
> > +/*
> > + * Function to print the AVC statistics. Because no audit logging
> > call back
> > + * has been set, the avc_cache_stats will be displayed on stderr.
> > + * selinux_check_access* sets aeref = NULL, so do not print these
> > stats.
> > + */
> > +static void print_avc_stats(void)
> > +{
> > +	struct avc_cache_stats acs;
> > +
> > +	avc_cache_stats(&acs);
> > +	printf("\nThe avc_cache_stats are as follows:\n");
> > +	printf("entry_lookups:  %d\t(Queries made)\n",
> > acs.entry_lookups);
> > +	printf("cav_lookups:    %d\t(Cache lookups)\n",
> > acs.cav_lookups);
> > +	printf("cav_hits:       %d\t(Cache hits)\n",
> > acs.cav_hits);
> > +	printf("cav_probes:     %d\t(Entries examined searching
> > the
> > cache)\n",
> > +	       acs.cav_probes);
> > +	printf("cav_misses:     %d\t(Cache misses)\n\n",
> > acs.cav_misses);
> > +}
> > +
> > +static void exec_func(char *scon, char *tcon, char *class, char
> > *perm)
> > +{
> > +	int rc;
> > +
> > +	printf("\nAny avc_log error messages are shown on
> > stderr:\n");
> > +	rc = selinux_check_access(scon, tcon, class, perm, NULL);
> > +	printf("\nEnd of avc_log error messages.\n\n");
> > +
> > +	if (rc < 0)
> > +		printf("Error selinux_check_access: %s\n",
> > strerror(errno));
> > +	else
> > +		printf("Permission ALLOWED.\n");
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +	int opt, rc;
> > +	bool interactive = false;
> > +	char *scon, *tcon, *class, *perm;
> > +
> > +	while ((opt = getopt(argc, argv, "i")) != -1) {
> > +		switch (opt) {
> > +		case 'i':
> > +			interactive = true;
> > +			break;
> > +		default:
> > +			usage(argv[0]);
> > +		}
> > +	}
> > +
> > +	if ((argc - optind) != 4)
> > +		usage(argv[0]);
> > +
> > +	rc = is_selinux_enabled();
> > +	if (rc == 0) {
> > +		printf("SELinux is not enabled.\n");
> > +		exit(1);
> > +	} else if (rc == 1) {
> > +		printf("SELinux is enabled.\n");
> > +	} else {
> > +		perror("Error is_selinux_enabled");
> > +		exit(1);
> > +	}
> > +
> > +	rc = security_getenforce();
> > +	if (rc == 0)
> > +		printf("SELinux running in PERMISSIVE mode.\n");
> > +	else if (rc == 1)
> > +		printf("SELinux running in ENFORCING mode.\n");
> > +	else {
> > +		perror("Error security_getenforce");
> > +		exit(1);
> > +	}
> > +
> > +	rc = security_deny_unknown();
> > +	if (rc == 0)
> > +		printf("Undefined object classes or permissions:
> > ALLOWED.\n");
> > +	else if (rc == 1)
> > +		printf("Undefined object classes or permissions:
> > DENIED.\n");
> > +	else {
> > +		perror("Error security_deny_unknown");
> > +		exit(1);
> > +	}
> > +
> > +	exec_func(argv[optind], argv[optind + 1], argv[optind +
> > 2],
> > +		  argv[optind + 3]);
> > +
> > +	while (interactive) {
> > +		printf("\nEnter scon: ");
> > +		get_entry(&scon);
> > +		printf("Enter tcon: ");
> > +		get_entry(&tcon);
> > +		printf("Enter class: ");
> > +		get_entry(&class);
> > +		printf("Enter perm: ");
> > +		get_entry(&perm);
> > +
> > +		exec_func(scon, tcon, class, perm);
> > +		print_avc_stats();
> > +	}
> > +
> > +	exit(0);
> > +}
> 
> As written, these seem more like debugging/testing programs than
> utilities.  They are too verbose for real utilities.  Compare with
> compute_av for example. I don't know of anyone using that aside from
> SELinux developers, but the interface is such that one could use it
> in
> a script to compute the access vectors, extract the desired one, and
> use that without having to discard a bunch of extraneous output.
>  
