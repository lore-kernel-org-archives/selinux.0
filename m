Message-ID: <43F42724.2010106@cornell.edu>
Date: Thu, 16 Feb 2006 02:17:56 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE/SEPOL] Nodes: fix bug, and add netmask ordering support
References: <43F42612.2050907@cornell.edu>
In-Reply-To: <43F42612.2050907@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> diff -Naurp --exclude-from excludes old/libsepol/include/sepol/policydb/policydb.h new/libsepol/include/sepol/policydb/policydb.h
> --- old/libsepol/include/sepol/policydb/policydb.h	2006-02-16 02:04:52.000000000 -0500
> +++ new/libsepol/include/sepol/policydb/policydb.h	2006-02-16 02:04:29.000000000 -0500
> @@ -152,7 +152,6 @@ typedef struct user_datum {
>  typedef struct level_datum {
>  	mls_level_t *level;	/* sensitivity and associated categories */
>  	unsigned char isalias;  /* is this sensitivity an alias for another? */
> -	unsigned char defined;
>  } level_datum_t;
>  
>  /* Category attributes */
>
>   
Argh.... how did this sneak in there?
I thought I got rid of that...

Please delete that part of the patch.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
