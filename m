Message-ID: <4E3AB236.4000404@redhat.com>
Date: Thu, 04 Aug 2011 10:52:38 -0400
From: Eric Paris <eparis@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH 006/155] libselinux: do not check fcontext duplicates
 on use
References: <4E39B41E.8060801@redhat.com> <1312469298.20973.51.camel@moss-pluto>
In-Reply-To: <1312469298.20973.51.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/04/2011 10:48 AM, Stephen Smalley wrote:
> On Wed, 2011-08-03 at 16:48 -0400, Daniel J Walsh wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>>
>> This patch looks good to me. acked.
> 
>>From 576af10294e14d03660708d3f7eddf49e71897d7 Mon Sep 17 00:00:00 2001
> From: Eric Paris <eparis@redhat.com>
> Date: Tue, 28 Jun 2011 21:37:38 -0400
> Subject: [PATCH 006/155] libselinux: do not check fcontext duplicates on use
> 
> Tools like restorecon or systemd, which load the fcontext database to
> make labeling decisions do not need to check for duplicate rules.  Only
> the first rule will be used.  Instead we should only check for
> duplicates when new rules are added to the database.  And fail the
> transaction if we find one.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
>  libselinux/src/label_file.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index af7fd8f..3b8346d 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -485,7 +485,7 @@ static int init(struct selabel_handle *rec, struct selinux_opt *opts,
>  					 pass, ++lineno) != 0)
>  				goto finish;
>  		}
> -		if (pass == 1) {
> +		if (pass == 1 && rec->validating) {
>  			status = nodups_specs(data, path);
>  			if (status)
>  				goto finish;
> 
> 
> This seems like the wrong fix to me.  rec->validating is set based on
> whether the application passed SELABEL_OPT_VALIDATE in the selinux_opt
> array to selabel_open().  So you should fix the applications that set
> this option if you do not want this behavior.  Not silently ignore what
> they requested while leaving the field and option flag intact.

I don't understand.  Before this patch rec->validating wasn't being used
at all and we always checked for dups.  With this patch we actually pay
attention to what the application set.  As it turns out
restorecon/fixfiles don't set the flag, but semanage fcontext does, so
this is actually a case where the programs were right but the underlying
library was wrong.  I'm fixing the library to pay attention to the flag.
 What am I missing?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
