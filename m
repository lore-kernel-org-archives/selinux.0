Subject: Re: [Patch 1/2] libsemanage: remember and retrieve dontaudit
 settings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Pardy <cpardy@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4A4C175A.2090100@redhat.com>
References: <4A4B656D.1030004@redhat.com>  <4A4B874E.8020402@redhat.com>
	 <1246467842.13464.192.camel@moss-pluto.epoch.ncsc.mil>
	 <4A4B9FA8.1040606@redhat.com> <4A4C168C.2040900@redhat.com>
	 <4A4C175A.2090100@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Jul 2009 08:39:11 -0400
Message-Id: <1246538351.13464.268.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 22:11 -0400, Christopher Pardy wrote:
> On 07/01/2009 10:08 PM, Christopher Pardy wrote:
> > This is a heavily modified version of the patch I recently submitted. 
> > It provides 3 new functions: in libsepol sepol_get_disable_dontaudit; 
> > in libsemanage semanage_get_disable_dontaudit; in libselinux 
> > is_dontaudit_disabled. It also fixes issues with the previous patch.
> >
> > The justification for this patch is the same as the one I posted 
> > earlier. Simply, there is currently no way to know if dontaudit rules 
> > are  enabled. Additionally once don't audit rules are turned they turn 
> > themselves off after policy rebuild (is that the desired 
> > functionality?) This patch provides  a way to check on both the 
> > current and pending state of the dontaudit rules and it maintains this 
> > state between policy rebuilds.
> >
> > Signed-off-by Christopher Pardy <cpardy@redhat.com>
> Patch 1 implements libsepol function. Including inline and attaching in 
> case thunderbird messes up tabs.

It did.  But allegedly one can configure it to work, e.g. read:
http://lxr.linux.no/linux+v2.6.30/Documentation/email-clients.txt

> 
> diff -urN selinux.orig/libsepol/include/sepol/handle.h 
> selinux/libsepol/include/sepol/handle.h
> --- selinux.orig/libsepol/include/sepol/handle.h    2009-07-01 
> 21:05:26.823235749 -0400
> +++ selinux/libsepol/include/sepol/handle.h    2009-07-01 
> 21:08:33.277237031 -0400
> @@ -7,6 +7,12 @@
>   /* Create and return a sepol handle. */
>   sepol_handle_t *sepol_handle_create(void);
> 
> +/* Get whether or not dontaudits will be disabled, same values as
> + * specified by disable dont audit. This value reflects the state
> + * your system will be set to upon commit, not nessesarily it's
> + * current state.*/
> +int sepol_get_disable_dontaudit(sepol_handle_t * sh);

I don't understand why we would export this, as it is a transient
setting only meaningful within a transaction and the caller should know
whether or not he has set or cleared it already.

> +
>   /* Set whether or not to disable dontaudits, 0 is default and does
>    * not disable dontaudits, 1 disables them */
>   void sepol_set_disable_dontaudit(sepol_handle_t * sh, int 
> disable_dontaudit);
> diff -urN selinux.orig/libsepol/src/handle.c selinux/libsepol/src/handle.c
> --- selinux.orig/libsepol/src/handle.c    2009-07-01 21:05:26.854236864 
> -0400
> +++ selinux/libsepol/src/handle.c    2009-07-01 21:07:15.532236991 -0400
> @@ -21,6 +21,12 @@
>       return sh;
>   }
> 
> +int sepol_get_disable_dontaudit(sepol_handle_t *sh)
> +{
> +    assert(sh !=NULL);
> +    return sh->disable_dontaudit;
> +}
> +
>   void sepol_set_disable_dontaudit(sepol_handle_t * sh, int 
> disable_dontaudit)
>   {
>       assert(sh !=NULL);
> diff -urN selinux.orig/libsepol/src/libsepol.map 
> selinux/libsepol/src/libsepol.map
> --- selinux.orig/libsepol/src/libsepol.map    2009-07-01 
> 21:05:26.848236011 -0400
> +++ selinux/libsepol/src/libsepol.map    2009-07-01 21:07:45.948485729 -0400
> @@ -12,6 +12,7 @@
>       sepol_policydb_*; sepol_set_policydb_from_file;
>       sepol_policy_kern_*;
>       sepol_policy_file_*;
> +    sepol_get_disable_dontaudit;
>       sepol_set_disable_dontaudit;
>       sepol_set_expand_consume_base;
>     local: *;
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
