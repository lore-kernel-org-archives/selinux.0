Subject: Re: [Patch 2/2] libsemanage: create a don't audit flag
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A4CD320.2090706@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C17D1.3060208@redhat.com>
	 <1246538797.13464.277.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CBC6C.5090709@redhat.com>
	 <1246544004.13464.299.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CC469.3050805@redhat.com>
	 <1246545328.13464.317.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4CD320.2090706@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 13:09:14 -0400
Message-Id: <1246554554.13464.356.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-07-02 at 11:32 -0400, Christopher Pardy wrote:
> Stephen, Josh: I think this might address all your concerns.
> Changes: No more code in libselinux, new handles have their 
> disable_dontaudit flag set to 0 upon creation (old way), 
> set_disable_dontaudit creates a file in the sandbox to make the setting 
> visible after commits.
> Justification: After turning off dontaudit rules there is currently no 
> way for the system to see that this change has been made, this creates a 
> flag file which can be used as an indicator.

Include the original patch description and then summarize changes or
incorporate into the description.

> Note: still depends on patch 1/2
> 
> Signed-off-by: Christopher Pardy <cpardy@redhat.com>

Add "---" followed by diffstat -p1 output here.

Still getting whitespace mangled by thunderbird - need to configure it.

> diff -urpN selinux.orig2/libsemanage/src/handle.c selinux/libsemanage/src/handle.c
> 
> --- selinux.orig2/libsemanage/src/handle.c    2009-07-01 21:15:17.288238017 -0400
> 
> +++ selinux/libsemanage/src/handle.c    2009-07-02 11:29:20.740267205 -0400
> @@ -75,7 +76,12 @@ semanage_handle_t *semanage_handle_creat
> 
>       /* Set callback */
> 
>       sh->msg_callback = semanage_msg_default_handler;
> 
>       sh->msg_callback_arg = NULL;
> 
> -
> 
> +
> 
> +    /*set the flag to be deleted*/
> 
> +    char path[PATH_MAX];
> 
> +    path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)

Missing semicolon?  And you don't need to allocate a buffer, just a
const char * - semanage_fname() returns a pointer to the pathname.

> 
> +    remove(path);

Unconditional removal of the flag file whenever a handle is created?

>   void semanage_set_disable_dontaudit(semanage_handle_t * sh, int disable_dontaudit)
> 
>   {
> 
> +    char path[PATH_MAX];
> 
> +    path = semanage_fname(SEMANAGE_DISABLE_DONTAUDIT)

Same issue here.

> 
> +        if(disable_dontaudit(sh) == 1){

What is this?

> 
> +            FILE *touch;
> 
> +            touch = fopen(path,"w");
> 
> +            fclose(touch);
> 
> +        }else
> 
> +            remove(path);
> 
>       return;
> 
>   }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
