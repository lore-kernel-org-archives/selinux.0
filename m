Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mABKd5C7031526
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 15:39:05 -0500
Received: from manicmethod.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mABKbKBi010935
	for <selinux@tycho.nsa.gov>; Tue, 11 Nov 2008 20:37:20 GMT
Message-ID: <4919ED67.7090605@manicmethod.com>
Date: Tue, 11 Nov 2008 15:39:03 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] homedir_template generation skips USER lines
References: <1226414940.24358.15.camel@gorn>
In-Reply-To: <1226414940.24358.15.camel@gorn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> The current libsemanage code does not correctly add lines which include
> USER in them into the homedir_template, for example:
>
> /tmp/gconfd-USER -d	system_u:object_r:ROLE_tmp_t
>
> This line was included in the past since it has ROLE.  However, with the
> switch to UBAC separations, the line has changed to:
>
> /tmp/gconfd-USER -d	system_u:object_r:user_tmp_t
>
> and is no longer included.  The follwing patch fixes.
>
> diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
> index ab79c28..9f197ed 100644
> --- a/libsemanage/src/semanage_store.c
> +++ b/libsemanage/src/semanage_store.c
> @@ -983,7 +983,8 @@ int semanage_split_fc(semanage_handle_t * sh)
>  
>  	while (fgets_unlocked(buf, PATH_MAX, file_con)) {
>  		if (!strncmp(buf, "HOME_DIR", 8) ||
> -		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE")) {
> +		    !strncmp(buf, "HOME_ROOT", 9) || strstr(buf, "ROLE") ||
> +		    strstr(buf, "USER")) {
>  			/* This contains one of the template variables, write it to homedir.template */
>  			if (write(hd, buf, strlen(buf)) < 0) {
>  				ERR(sh, "Write to %s failed.",
>
>
>
>   


Merged in libsemanage-2.0.29


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
