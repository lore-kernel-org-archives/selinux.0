Message-ID: <4350131E.8060708@tresys.com>
Date: Fri, 14 Oct 2005 16:20:46 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Add a few direct dbases to handle
References: <434FF612.8010708@cornell.edu>
In-Reply-To: <434FF612.8010708@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Adds a few direct databases to the handle.
> There's still no dangerous code in the main commit path...
> This is just the equivalent to file init.
> 
> diff -Naur libsemanage/src/handle.h libsemanage.new/src/handle.h
> --- libsemanage/src/handle.h	2005-10-14 14:10:54.000000000 -0400
> +++ libsemanage.new/src/handle.h	2005-10-14 14:07:46.000000000 -0400
> @@ -71,12 +71,20 @@
>  	struct semanage_policy_table* funcs;
>  
>  	/* Object databases */
> -#define DBASE_COUNT      5
> +#define DBASE_COUNT      7
> +
>  #define DBASE_USERS      0
>  #define DBASE_PORTS      1
>  #define DBASE_INTERFACES 2
>  #define DBASE_BOOLEANS   3
>  #define DBASE_SEUSERS    4
> +
> +#define DBASE_BASE_USERS      5
> +#define DBASE_BASE_PORTS      6
> +#if 0
> +#define DBASE_BASE_INTERFACES 7
> +#define DBASE_BASE_BOOLEANS   8
> +#endif
>  	dbase_config_t dbase[DBASE_COUNT];
>  };
>  
> @@ -105,5 +113,27 @@
>  	return &handle->dbase[DBASE_SEUSERS];
>  }
>  

I thought we agreed to have a direct only accessible part of the handle, 
  such as

struct semanage_direct_handle {
	semanage_handle_t *handle;
	/* direct stuff goes here */
};

So that this stuff is only exposed to direct api functions? The policy 
server shouldn't be filling out databases that are accessible to the 
user since it needs to mediate access.

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
