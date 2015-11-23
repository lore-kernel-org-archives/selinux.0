Subject: Re: (Userspace) AVC denial generated even if allowed by the policy?
To: Laurent Bigonville <bigon@debian.org>, selinux@tycho.nsa.gov
References: <5652636F.2060609@debian.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56533D07.20508@tycho.nsa.gov>
Date: Mon, 23 Nov 2015 11:21:27 -0500
MIME-Version: 1.0
In-Reply-To: <5652636F.2060609@debian.org>
Content-Type: multipart/mixed; boundary="------------050206080807050000050603"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------050206080807050000050603
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/2015 07:53 PM, Laurent Bigonville wrote:
> Hi,
>
> I'm still looking at adding SELinux support in the "at" daemon and I now
> have the following patch[0].
>
> With this patch, at seems to behave like the cron daemon, as explained
> in the commit log:
>
>      - When cron_userdomain_transition is set to off, a process for an
>        unconfined user will transition to unconfined_cronjob_t. For
> confined
>        user, the job is run as cronjob_t.
>
>      - When cron_userdomain_transition is set to on, the processes are run
>        under the user default context.
>
> But every time an AVC denial is generated (with
> cron_userdomain_transition set to off and the user running as staff_u,
> in permissive with unmodified refpolicy):
>
> avc:  denied  { entrypoint } for scontext=staff_u:staff_r:cronjob_t:s0
> tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file
>
> The job runs as (id -Z): staff_u:staff_r:cronjob_t:s0
>
> But audit2{allow,why} are saying that this is already allowed in the policy
>
> Setting the cron_userdomain_transition boolean to on, I have the
> following avc:
>
> avc:  denied  { entrypoint } for scontext=staff_u:sysadm_r:sysadm_t:s0
> tcontext=staff_u:object_r:user_cron_spool_t:s0 tclass=file
>
> The job runs as (id -Z): staff_u:sysadm_r:sysadm_t:s0
>
> So as said it seems to work, but I'm not sure why this AVC denial is
> generated.
>
> sesearch shows:
>
> $ sesearch -ATSC  -t user_cron_spool_t -c file -p entrypoint
> Found 6 semantic av rules:
>     allow files_unconfined_type file_type : file { ioctl read write
> create getattr setattr lock relabelfrom relabelto append unlink link
> rename execute swapon quotaon mounton execute_no_trans entrypoint open
> audit_access } ;
> DT allow unconfined_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> DT allow user_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> EF allow cronjob_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> DT allow staff_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
> DT allow sysadm_t user_cron_spool_t : file entrypoint ; [
> cron_userdomain_transition ]
>
> Did I overlooked something?

What output do you get from:
$ compute_av staff_u:staff_r:cronjob_t:s0 
staff_u:object_r:user_cron_spool_t:s0 file

Likewise, for the attached trivial program, what output do you get from:
$ ./check_access staff_u:staff_r:cronjob_t:s0 
staff_u:object_r:cronjob_t:s0 file entrypoint

--------------050206080807050000050603
Content-Type: text/plain; charset=UTF-8;
 name="check_access.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="check_access.c"

#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <selinux/selinux.h>

int main(int argc, char **argv)
{
	int ret;

	if (argc != 5) {
		fprintf(stderr, "usage:  %s scontext tcontext tclass permission\n",
			argv[0]);
		exit(1);
	}

	ret = selinux_check_access(argv[1], argv[2], argv[3], argv[4], NULL);
	if (ret < 0) {
		fprintf(stderr, "selinux_check_access failed: %s\n", strerror(errno));
		exit(2);
	}

	printf("allowed\n");
	exit(0);
}

--------------050206080807050000050603--
