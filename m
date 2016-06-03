Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u53FIrGL016731
 for <selinux@tycho.nsa.gov>; Fri, 3 Jun 2016 11:18:53 -0400
Received: by mail-qg0-f50.google.com with SMTP id p34so13244052qgp.1
 for <selinux@tycho.nsa.gov>; Fri, 03 Jun 2016 08:18:50 -0700 (PDT)
Received: from strange.local ([50.253.7.1])
 by smtp.googlemail.com with ESMTPSA id 125sm1157260qki.30.2016.06.03.08.18.50
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Fri, 03 Jun 2016 08:18:50 -0700 (PDT)
Message-ID: <57519FD9.6080402@quarksecurity.com>
Date: Fri, 03 Jun 2016 11:18:49 -0400
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Correctly detect unknown classes in
 sepol_string_to_security_class
References: <1464966566-14597-2-git-send-email-brindle@quarksecurity.com>
 <1464967076-24170-1-git-send-email-brindle@quarksecurity.com>
In-Reply-To: <1464967076-24170-1-git-send-email-brindle@quarksecurity.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Joshua Brindle wrote:
> Bail before running off the end of the class index
>

This one correctly goes all the way to the end of the classes index, the 
last version did not.

> Change-Id: I47c4eaac3c7d789f8d85047e34e37e3f0bb38b3a
> Signed-off-by: Joshua Brindle<brindle@quarksecurity.com>
> ---
>   libsepol/src/services.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index d64a8e8..665fcaa 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -1155,7 +1155,7 @@ int hidden sepol_string_to_security_class(const char *class_name,
>   	char *class = NULL;
>   	sepol_security_class_t id;
>
> -	for (id = 1;; id++) {
> +	for (id = 1; id<= policydb->p_classes.nprim; id++) {
>   		class = policydb->p_class_val_to_name[id - 1];
>   		if (class == NULL) {
>   			ERR(NULL, "could not convert %s to class id", class_name);
> @@ -1166,6 +1166,8 @@ int hidden sepol_string_to_security_class(const char *class_name,
>   			return STATUS_SUCCESS;
>   		}
>   	}
> +	ERR(NULL, "unrecognized class %s", class_name);
> +	return -EINVAL;
>   }
>
>   /*
