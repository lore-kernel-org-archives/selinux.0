Message-ID: <434165E3.5050804@tresys.com>
Date: Mon, 03 Oct 2005 13:09:55 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux-dev@tresys.com, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] mls in modules
References: <1128112952.22583.25.camel@twoface.columbia.tresys.com> <1128353485.26285.119.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1128353485.26285.119.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2005-09-30 at 16:42 -0400, Joshua Brindle wrote:
> 
>>This patch allows both base modules and modules to be built with the -M
>>(MLS) flag. For base modules it adds all the MLS components that are in
>>the normal policy. For modules it sets the MLS flag. The following
>>restrictions are currently placed on the policy:
>>
>>- Users cannot be declared in MLS modules, because levels cannot be
>>'required'
> 
> 
> Will this be addressed soon?  Or are modules in Fedora going to be
> unable to declare users at all?

This is on the list to do but is currently low priority. There are no 
plans to add this for FC5. As long as all users are added through the 
user files (system.user and local.user), it should not be necessary to 
add users in modules. Note, users with levels can be in the base module 
so the failsafe users will still be in the policy. If you disagree with 
the need for this please let us know.


> 
> diff -purN -x .svn libsepol/include/sepol/context.h libsepol/include/sepol/context.h
> --- libsepol/include/sepol/context.h	2005-09-19 09:03:15.000000000 -0400
> +++ libsepol/include/sepol/context.h	2005-09-30 11:16:30.000000000 -0400
> @@ -38,6 +38,10 @@ typedef struct context_struct {
>  static inline void mls_context_init(context_struct_t * c)
>  {
>  	memset(&c->range, 0, sizeof(c->range));
> +	memset(&c->range.level[0], 0, sizeof(c->range.level[0]));
> +	memset(&c->range.level[1], 0, sizeof(c->range.level[1]));
> +	ebitmap_init(&c->range.level[0].cat);
> +	ebitmap_init(&c->range.level[1].cat);
>  }
> 
> Seems a bit redundant?
> 
> @@ -75,12 +73,9 @@ static inline int mls_context_cmp(contex
>  
>  static inline void mls_context_destroy(context_struct_t * c)
>  {
> -	if (!sepol_mls_enabled())
> -		return;
> -
>  	ebitmap_destroy(&c->range.level[0].cat);
>  	ebitmap_destroy(&c->range.level[1].cat);
> -	mls_context_init(c);
> +	memset(&c->range, 0, sizeof(c->range));
>  }
> 
> Seems equivalent.

Yes, I got a little overzealous with the initialization, go ahead and 
remove these.

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
