Subject: Re: [PATCH] libselinux: add selinux_snapperd_contexts_path()
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov,
 Paul Moore <paul@paul-moore.com>
References: <1466420991-7209-1-git-send-email-plautrba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <6359b965-b5df-6f13-c536-97b396084625@tycho.nsa.gov>
Date: Mon, 20 Jun 2016 09:38:27 -0400
MIME-Version: 1.0
In-Reply-To: <1466420991-7209-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/20/2016 07:09 AM, Petr Lautrbach wrote:
> Snapper needs a way how to set a proper selinux context on btrfs
> subvolumes originating in snapshot create command. Fs can't handle it on
> its own so snapper will enforce .snapshots subvolume relabeling
> according to a file returned by selinux_snapperd_contexts_path().
> 
> The format of the file will be similar to other contexts file:
> 
> snapperd_data = system_u:object_r:snapperd_data_t:s0
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=1247530
> https://bugzilla.redhat.com/show_bug.cgi?id=1247532

Seems like there is a kernel bug here, if btrfs snapshots are being
created in unlabeled_t initially?  I understand and agree that
ultimately something in userspace will have to assign a specific label,
but they shouldn't be defaulting to unlabeled_t.

> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/include/selinux/selinux.h |  1 +
>  libselinux/src/file_path_suffixes.h  |  1 +
>  libselinux/src/selinux_config.c      | 10 +++++++++-
>  libselinux/src/selinux_internal.h    |  1 +
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index 2262086..3d8673f 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -544,6 +544,7 @@ extern const char *selinux_lxc_contexts_path(void);
>  extern const char *selinux_x_context_path(void);
>  extern const char *selinux_sepgsql_context_path(void);
>  extern const char *selinux_openssh_contexts_path(void);
> +extern const char *selinux_snapperd_contexts_path(void);
>  extern const char *selinux_systemd_contexts_path(void);
>  extern const char *selinux_contexts_path(void);
>  extern const char *selinux_securetty_types_path(void);
> diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_path_suffixes.h
> index d1f9b48..95b228b 100644
> --- a/libselinux/src/file_path_suffixes.h
> +++ b/libselinux/src/file_path_suffixes.h
> @@ -24,6 +24,7 @@ S_(BINPOLICY, "/policy/policy")
>      S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
>      S_(LXC_CONTEXTS, "/contexts/lxc_contexts")
>      S_(OPENSSH_CONTEXTS, "/contexts/openssh_contexts")
> +    S_(SNAPPERD_CONTEXTS, "/contexts/snapperd_contexts")
>      S_(SYSTEMD_CONTEXTS, "/contexts/systemd_contexts")
>      S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
>      S_(FILE_CONTEXT_SUBS_DIST, "/contexts/files/file_contexts.subs_dist")
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
> index bec5f3b..c519a77 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -50,7 +50,8 @@
>  #define BOOLEAN_SUBS      27
>  #define OPENSSH_CONTEXTS  28
>  #define SYSTEMD_CONTEXTS  29
> -#define NEL               30
> +#define SNAPPERD_CONTEXTS 30
> +#define NEL               31
>  
>  /* Part of one-time lazy init */
>  static pthread_once_t once = PTHREAD_ONCE_INIT;
> @@ -499,6 +500,13 @@ const char *selinux_openssh_contexts_path(void)
>  
>  hidden_def(selinux_openssh_contexts_path)
>  
> +const char *selinux_snapperd_contexts_path(void)
> +{
> +    return get_path(SNAPPERD_CONTEXTS);
> +}
> +
> +hidden_def(selinux_snapperd_contexts_path)
> +
>  const char *selinux_systemd_contexts_path(void)
>  {
>  	return get_path(SYSTEMD_CONTEXTS);
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
> index 46566f6..9b9145c 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -84,6 +84,7 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(selinux_x_context_path)
>      hidden_proto(selinux_sepgsql_context_path)
>      hidden_proto(selinux_openssh_contexts_path)
> +    hidden_proto(selinux_snapperd_contexts_path)
>      hidden_proto(selinux_systemd_contexts_path)
>      hidden_proto(selinux_path)
>      hidden_proto(selinux_check_passwd_access)
> 
