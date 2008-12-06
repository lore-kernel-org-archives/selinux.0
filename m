Message-ID: <4939CB81.1030707@tycho.nsa.gov>
Date: Fri, 05 Dec 2008 19:46:57 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: limitations of CONTEXT__CONTAINS interface
Content-Type: multipart/mixed;
 boundary="------------030001010100000608060602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030001010100000608060602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The attached C code uses the CONTEXT__CONTAINS permission check to check
dominance, and produces the following output on my mls box:

staff_u:staff_r:staff_t:s15:c0.c255 dominates staff_u:staff_r:staff_t:s0

system_u:object_r:etc_t:s15:c0.c255 does not dominate system_u:object_r:etc_t:s0


Why doesn't this check work in the second case?

My color translation code has a config file that may contain lines such
as (paraphrasing):
range s0 = green
range s1 = yellow
range s1:c1 = blue
range s15:c0.c255 = red

and so forth, which are matched with incoming contexts using a dominance
check.  The observed behavior above is causing this not to work.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------030001010100000608060602
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <selinux/flask.h>
#include <selinux/av_permissions.h>
#include <selinux/selinux.h>
#include <selinux/context.h>

#define FAKE_LO_RANGE "s0"
#define FAKE_HI_RANGE "s15:c0.c255"

#define CONVENIENT_FILE "/etc/hosts"

static void check_dominance(char *one, char *two)
{
	unsigned int bit = CONTEXT__CONTAINS;
	struct av_decision avd;
	int rc;

	rc = security_compute_av_raw(one, two, SECCLASS_CONTEXT, bit, &avd);
	if (rc)
		printf("security_compute_av_raw() returned error!\n");
	else if ((bit & avd.allowed) == bit)
		printf("%s dominates %s\n", one, two);
	else
		printf("%s does not dominate %s\n", one, two);
}

static int make_fake_contexts(security_context_t proc_ctx,
			      security_context_t file_ctx)
{
	security_context_t proc_hi, proc_lo, file_hi, file_lo;
	context_t proc_con, file_con;
	unsigned int bit = CONTEXT__CONTAINS;
	struct av_decision avd;

	proc_con = context_new(proc_ctx);
	file_con = context_new(file_ctx);

	context_range_set(proc_con, FAKE_HI_RANGE);
	proc_hi = strdup(context_str(proc_con));
	context_range_set(file_con, FAKE_HI_RANGE);
	file_hi = strdup(context_str(file_con));

	context_range_set(proc_con, FAKE_LO_RANGE);
	proc_lo = strdup(context_str(proc_con));
	context_range_set(file_con, FAKE_LO_RANGE);
	file_lo = strdup(context_str(file_con));

	check_dominance(proc_hi, proc_lo);
	check_dominance(file_hi, file_lo);

	freecon(proc_hi);
	freecon(proc_lo);
	context_free(proc_con);
	freecon(file_hi);
	freecon(file_lo);
	context_free(file_con);
	return 0;
}

int main(int argc, char **argv)
{
	security_context_t proc_ctx, file_ctx;

	getcon(&proc_ctx);
	getfilecon(CONVENIENT_FILE, &file_ctx);

	make_fake_contexts(proc_ctx, file_ctx);

	return 0;
}

--------------030001010100000608060602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
