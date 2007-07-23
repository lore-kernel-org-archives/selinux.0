Message-ID: <46A4CFC7.2020407@manicmethod.com>
Date: Mon, 23 Jul 2007 11:56:55 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [patch] libselinux:  fix type mismatch in string_to_security_class
References: <1185200517.1998.14.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1185200517.1998.14.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Fix type mismatch in string_to_security_class, produces seg fault on x86_64.
> For https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249038
>
> Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
>   
Acked-By: Joshua Brindle <method@manicmethod.com>

merged into libselinux 2.0.25
> ---
>
>  stringrep.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: src/stringrep.c
>   
-p0 or -p1 from top of the repo? :)

> ===================================================================
> --- src/stringrep.c	(revision 2496)
> +++ src/stringrep.c	(working copy)
> @@ -236,7 +236,7 @@
>  
>  	dentry = readdir(dir);
>  	while (dentry != NULL) {
> -		size_t value;
> +		unsigned int value;
>  		struct stat m;
>  
>  		snprintf(path, sizeof path, "%s/class/%s/perms/%s", selinux_mnt,s,dentry->d_name);
> @@ -258,7 +258,7 @@
>  		if (ret < 0)
>  			goto err4;
>  
> -		if (sscanf(buf, "%u", (unsigned int *)&value) != 1)
> +		if (sscanf(buf, "%u", &value) != 1)
>  			goto err4;
>  
>  		node->perms[value-1] = strdup(dentry->d_name);
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
