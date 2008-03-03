Message-ID: <47CC7B7F.9060200@tresys.com>
Date: Mon, 03 Mar 2008 17:28:15 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: "Todd C. Miller" <tmiller@tresys.com>
CC: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: PATCH: fix uninitialized use of handle in struct policy_file
References: <200803032220.m23MKUZp003057@cadmus.columbia.tresys.com>
In-Reply-To: <200803032220.m23MKUZp003057@cadmus.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd C. Miller wrote:
> The "handle" member of struct policy_file was being used uninitialized
> in a number of places.  Stephen Smalley noticed that a valgrind of
> dispol reported an uninitialized variable while tracking down a segv.
> I diagnosed the problem and found that there were quite a few instances
> of the bug.
> 
> Consumers of sepol_policy_file_create() are not affected by this since
> it uses calloc().
> 

Hrm. Why aren't we using an initializer for this struct so that this 
sort of thing doesn't happen?

> Signed-off-by: Todd C. Miller <tmiller@tresys.com>
> 
>  checkpolicy/checkmodule.c |    2 ++
>  checkpolicy/checkpolicy.c |    2 ++
>  checkpolicy/test/dismod.c |    1 +
>  checkpolicy/test/dispol.c |    1 +
>  libsepol/src/genbools.c   |    2 ++
>  libsepol/src/services.c   |    3 ++-
>  6 files changed, 10 insertions(+), 1 deletion(-)
> 
> Index: trunk/libsepol/src/services.c
> ===================================================================
> --- trunk/libsepol/src/services.c	(revision 2828)
> +++ trunk/libsepol/src/services.c	(working copy)
> @@ -87,6 +87,7 @@
>  	struct policy_file pf;
>  	pf.fp = fp;
>  	pf.type = PF_USE_STDIO;
> +	pf.handle = NULL;
>  	if (mypolicydb.policy_type)
>  		policydb_destroy(&mypolicydb);
>  	if (policydb_init(&mypolicydb)) {
> @@ -1007,7 +1008,7 @@
>  		.type = PF_USE_MEMORY,
>  		.data = data,
>  		.len = len,
> -		.fp = NULL
> +		.handle = NULL
>  	}, *fp = &file;
>  
>  	if (policydb_init(&newpolicydb))
> Index: trunk/libsepol/src/genbools.c
> ===================================================================
> --- trunk/libsepol/src/genbools.c	(revision 2828)
> +++ trunk/libsepol/src/genbools.c	(working copy)
> @@ -157,6 +157,7 @@
>  	pf.type = PF_USE_MEMORY;
>  	pf.data = data;
>  	pf.len = len;
> +	pf.handle = NULL;
>  	rc = policydb_write(&policydb, &pf);
>  	if (rc) {
>  		ERR(NULL, "unable to write new binary policy image");
> @@ -228,6 +229,7 @@
>  	pf.type = PF_USE_MEMORY;
>  	pf.data = data;
>  	pf.len = len;
> +	pf.handle = NULL;
>  	rc = policydb_write(&policydb, &pf);
>  	if (rc) {
>  		ERR(NULL, "unable to write binary policy");
> Index: trunk/checkpolicy/test/dismod.c
> ===================================================================
> --- trunk/checkpolicy/test/dismod.c	(revision 2828)
> +++ trunk/checkpolicy/test/dismod.c	(working copy)
> @@ -691,6 +691,7 @@
>  	}
>  	f.type = PF_USE_STDIO;
>  	f.fp = in_fp;
> +	f.handle = NULL;
>  
>  	/* peek at the first byte.  if they are indicative of a
>  	   package use the package reader, otherwise use the normal
> Index: trunk/checkpolicy/test/dispol.c
> ===================================================================
> --- trunk/checkpolicy/test/dispol.c	(revision 2828)
> +++ trunk/checkpolicy/test/dispol.c	(working copy)
> @@ -376,6 +376,7 @@
>  	pf.type = PF_USE_MEMORY;
>  	pf.data = map;
>  	pf.len = sb.st_size;
> +	pf.handle = NULL;
>  	if (policydb_init(&policydb)) {
>  		fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
>  		exit(1);
> Index: trunk/checkpolicy/checkmodule.c
> ===================================================================
> --- trunk/checkpolicy/checkmodule.c	(revision 2829)
> +++ trunk/checkpolicy/checkmodule.c	(working copy)
> @@ -74,6 +74,7 @@
>  	f.type = PF_USE_MEMORY;
>  	f.data = map;
>  	f.len = sb.st_size;
> +	f.handle = NULL;
>  	fp = &f;
>  
>  	if (policydb_init(p)) {
> @@ -126,6 +127,7 @@
>  
>  	pf.type = PF_USE_STDIO;
>  	pf.fp = outfp;
> +	pf.handle = NULL;
>  	ret = policydb_write(p, &pf);
>  	if (ret) {
>  		fprintf(stderr, "%s:  error writing %s\n", progname, file);
> Index: trunk/checkpolicy/checkpolicy.c
> ===================================================================
> --- trunk/checkpolicy/checkpolicy.c	(revision 2829)
> +++ trunk/checkpolicy/checkpolicy.c	(working copy)
> @@ -492,6 +492,7 @@
>  		pf.type = PF_USE_MEMORY;
>  		pf.data = map;
>  		pf.len = sb.st_size;
> +		pf.handle = NULL;
>  		if (policydb_init(&policydb)) {
>  			fprintf(stderr, "%s:  policydb_init:  Out of memory!\n",
>  				argv[0]);
> @@ -579,6 +580,7 @@
>  
>  		pf.type = PF_USE_STDIO;
>  		pf.fp = outfp;
> +		pf.handle = NULL;
>  		ret = policydb_write(&policydb, &pf);
>  		if (ret) {
>  			fprintf(stderr, "%s:  error writing %s\n",
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
