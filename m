Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6ILTIHm027350
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 17:29:18 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6ILTHdP009895
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 21:29:17 GMT
Received: by py-out-1112.google.com with SMTP id d32so741094pye
        for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 14:29:17 -0700 (PDT)
Message-ID: <469E8622.3070309@gmail.com>
Date: Wed, 18 Jul 2007 16:29:06 -0500
From: Ted X Toth <txtoth@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New test program for libselinux/utils that helped with testing
 MLS/Role/Level coding
References: <45A68F43.3050101@redhat.com>
In-Reply-To: <45A68F43.3050101@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> getdefaultcon.c
> ------------------------------------------------------------------------
>
> diff --exclude-from=exclude -N -u -r nsalibselinux/utils/getdefaultcon.c libselinux-1.33.4/utils/getdefaultcon.c
> --- nsalibselinux/utils/getdefaultcon.c	1969-12-31 19:00:00.000000000 -0500
> +++ libselinux-1.33.4/utils/getdefaultcon.c	2007-01-11 14:24:24.000000000 -0500
> @@ -0,0 +1,75 @@
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <ctype.h>
> +#include <selinux/selinux.h>
> +#include <selinux/get_context_list.h>
> +
> +void usage(char *name, char *detail, int rc)
> +{
> +	fprintf(stderr, "usage:  %s [-l level] user fromcon\n", name);
> +	if (detail)
> +		fprintf(stderr, "%s:  %s\n", name, detail);
> +	exit(rc);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	security_context_t usercon = NULL, cur_context = NULL;
> +	char *user = NULL, *level = NULL, *role=NULL, *seuser=NULL;
> +	int ret, opt;
> +
> +	while ((opt = getopt(argc, argv, "l:r:")) > 0) {
> +		switch (opt) {
> +		case 'l':
> +			level = strdup(optarg);
> +			break;
> +		case 'r':
> +			role = strdup(optarg);
> +			break;
> +		default:
> +			usage(argv[0], "invalid option", 1);
> +		}
> +	}
> +
> +	if (((argc - optind) < 1) || ((argc - optind) > 2))
> +		usage(argv[0], "invalid number of arguments", 2);
> +
> +	/* If selinux isn't available, bail out. */
> +	if (!is_selinux_enabled()) {
> +		fprintf(stderr,
> +			"%s may be used only on a SELinux kernel.\n", argv[0]);
> +		return 1;
> +	}
> +
> +	user = argv[optind];
> +
> +	/* If a context wasn't passed, use the current context. */
> +	if (((argc - optind) < 2)) {
> +		if (getcon(&cur_context) < 0) {
> +			fprintf(stderr, "Couldn't get current context.\n");
> +			return 2;
> +		}
> +	} else
> +		cur_context = argv[optind + 1];
> +
> +	if (getseuserbyname(user, &seuser, &level)==0) {
> +		if (role != NULL && role[0]) 
> +			ret=get_default_context_with_rolelevel(seuser, role, level,cur_context,&usercon);
> +		else
> +			ret=get_default_context_with_level(seuser, level, cur_context,&usercon);
> +	}
> +	if (ret < 0)
> +		perror(argv[0]);
> +	else
> +		printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user, cur_context, seuser, role, level, usercon);
> +
> +
> +	free(usercon);
> +
> +	return 0;
> +}
>   
I tried running this test program on RHEL 5 and 
get_default_context_with_level fails with "Invalid argument". I supplied 
a valid linux user name and verified that getseuserbyname returned 
'user_u' and  's0' for the user and level respectively. I did this 
because some other code which runs on fc6 where  I use 
get_default_context_with_level also failed with the same error when I 
ran it on RHEL 5.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
