Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BDC0015E
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 12:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjGQMzT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 08:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQMzT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 08:55:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE16B1
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:55:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-262ef07be72so2088278a91.1
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689598517; x=1692190517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UDU4zT42OqOgq2P2PWilMTJrZ5kqai/8Fm3c23x4oHs=;
        b=OxNTEuZpzbYHzrIEHVit+aTt06VoY9wRMnd89iSJwb1f3QWQRTbPXUAnvemMNTZ1Mg
         dlGmbozJJ0rJx9+DgUOwfx9K4ZKnBEqRIPC1J+FfTHzp92YKpjyntu+HbJbXxBSanoUS
         1/rBnO9UH0SeFCJljSxkAWxolPZ3l3RvZFBXIAyDOFLLpcILsipEzDnkya0D81WAutxl
         4DRVoXWg/sv+zs4Tigq6EJ5rMWz1NfThc1j+GRIa+gm3Ji6Mj+d1mO/vW+l+19v+qqIG
         VD++lDXHf0XjhoNVGlTnDtHd9emc95K4C+9SDWOFRxN8APdGvgplq/8PmQJUKS+VsoD2
         jC1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689598517; x=1692190517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDU4zT42OqOgq2P2PWilMTJrZ5kqai/8Fm3c23x4oHs=;
        b=NDDEaRXWD1w63a/D1HiVzPWsVoXjmZmoOf2Di5DeUsqBaWYIQTMwepX4D3+Mrttguj
         FK9eNBzF0gT32LZRv7F2EAtmp5uuqQix8BS9+95A9Bgpafjmedj4tTpwxlBlSn0Y5Gpt
         pzMzVXgwt3HM6MiIjGZvE49G/iYtYwpySsMww5HincaEfdM1lZZE4Bs1Oh1e1O/8OZEi
         KfPka+1xfgc4gCqO2oUpyPcIRI5c/UjtIZ9FzsvwoXi89SVzpzWBGdFek4lj9P7IXJV/
         ju9aXBlZ5CbBo+SfPlUkwuvCIa6UC2OWwBzwAmkNJ7uyEBgQb1PTAaxwxda5zzIWb0Li
         /0hg==
X-Gm-Message-State: ABy/qLYfhaV2cgdgaF7CBTPSwmyJbHUw6VEZuFzbpH4PO024qKZnqbAg
        m38pF3jDaI5gjkbiPeV/YliHjIuQ8QKina3vklaaoTCX
X-Google-Smtp-Source: APBJJlFeT4AZcejDtrCuMw136pN+agaeyMPMZzG9KAE6mfPKSRrV9Gs45XqU8m3JrAEDP1bB2SApctyD9eeOIxKfSaI=
X-Received: by 2002:a17:90a:1b6c:b0:262:c3b3:f8fa with SMTP id
 q99-20020a17090a1b6c00b00262c3b3f8famr7768018pjq.39.1689598517291; Mon, 17
 Jul 2023 05:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230717122800.619345-1-omosnace@redhat.com>
In-Reply-To: <20230717122800.619345-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 17 Jul 2023 08:55:05 -0400
Message-ID: <CAEjxPJ6a8taRLUotfLtq6kyOMeiN28odwmgWh6yFpX3HW6-gDA@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow all test domains to search
 user/admin home directories
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 17, 2023 at 8:28=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The permissions are sometimes needed to resolve paths when running the
> testsuite from a user/admin home directory. To avoid cluttering
> individual policy files with macros that allow it, apply the macros to
> the whole testsuite_domain attribute. Thankfully this doesn't break the
> other tests.
>
> This also fixes the inet_socket test, which started to require these
> permissions after a recent change.
>
> While there, also remove userdom_read_user_tmp_files() from
> test_overlay_mounter_t, which doesn't seem to be needed.
>
> Fixes: 4dcea27ada77 ("tests/inet_socket: cover the MPTCP protocol")
> Inspired-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

All tests pass with this applied, thanks.

Tested-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  policy/test_filesystem.te        | 1 -
>  policy/test_filesystem_notify.te | 1 -
>  policy/test_global.te            | 7 +++++++
>  policy/test_ipc.te               | 2 --
>  policy/test_overlayfs.te         | 7 -------
>  policy/test_policy.if            | 7 -------
>  policy/test_ptrace.te            | 1 -
>  7 files changed, 7 insertions(+), 19 deletions(-)
>
> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index 59eac2b..efe1f4d 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
> @@ -366,7 +366,6 @@ allow test_filesystem_inode_setxattr_no_associate_t t=
est_file_t:file { create re
>  #
>  ############### Rules for NFS mount ##################
>  #
> -userdom_search_user_home_content(filesystemdomain)
>  allow test_filesystem_t test_filesystem_file_t:filesystem { getattr moun=
t remount unmount relabelto relabelfrom };
>  allow test_filesystem_t test_file_t:file { create write relabelfrom };
>  allow test_file_t test_filesystem_file_t:filesystem { associate };
> diff --git a/policy/test_filesystem_notify.te b/policy/test_filesystem_no=
tify.te
> index 30056e4..77d46ae 100644
> --- a/policy/test_filesystem_notify.te
> +++ b/policy/test_filesystem_notify.te
> @@ -16,7 +16,6 @@ allow test_filesystem_t dosfs_t:filesystem { watch };
>  #
>  ############### Rules for NFS mount with rootcontext option ############=
#####
>  #
> -userdom_search_user_home_content(filesystemdomain)
>  allow test_filesystem_no_watch_mount_t nfs_t:filesystem { unmount };
>  allow test_filesystem_no_watch_mount_t test_filesystem_file_t:dir { sear=
ch };
>  allow test_filesystem_no_watch_sb_t nfs_t:filesystem { unmount watch };
> diff --git a/policy/test_global.te b/policy/test_global.te
> index 052c7dd..0078485 100644
> --- a/policy/test_global.te
> +++ b/policy/test_global.te
> @@ -153,6 +153,13 @@ selinux_compute_create_context(testsuite_domain)
>  selinux_compute_relabel_context(testsuite_domain)
>  selinux_compute_user_contexts(testsuite_domain)
>
> +userdom_search_user_home_content(testsuite_domain)
> +# Refpolicy does not have admin_home_t - assume /root will be user_home_=
dir_t,
> +# which is covered by the above call.
> +ifdef(`userdom_search_admin_dir', `
> +    userdom_search_admin_dir(testsuite_domain)
> +')
> +
>  # Reference policy renamed files_list_pids() to files_list_runtime()
>  ifdef(`files_list_pids', `
>      files_list_pids(testsuite_domain)
> diff --git a/policy/test_ipc.te b/policy/test_ipc.te
> index 678eca8..5e26384 100644
> --- a/policy/test_ipc.te
> +++ b/policy/test_ipc.te
> @@ -67,5 +67,3 @@ fs_rw_tmpfs_files(ipcdomain)
>
>  allow test_ipc_base_t self:sem create_sem_perms;
>  allow test_ipc_base_t self:shm create_shm_perms;
> -# ipcrm needs this...
> -userdom_search_user_home_dirs(test_ipc_base_t)
> diff --git a/policy/test_overlayfs.te b/policy/test_overlayfs.te
> index ab589bb..c09b577 100644
> --- a/policy/test_overlayfs.te
> +++ b/policy/test_overlayfs.te
> @@ -45,10 +45,6 @@ kernel_search_proc(test_overlay_mounter_t)
>  fs_relabelfrom_xattr_fs(test_overlay_mounter_t)
>  fs_mount_xattr_fs(test_overlay_mounter_t)
>
> -userdom_search_admin_dir(test_overlay_mounter_t)
> -userdom_search_user_home_content(test_overlay_mounter_t)
> -userdom_read_user_tmp_files(test_overlay_mounter_t)
> -
>  mount_exec(test_overlay_mounter_t)
>  mount_rw_pid_files(test_overlay_mounter_t)
>
> @@ -113,9 +109,6 @@ mcs_constrained(test_overlay_client_t)
>  kernel_read_system_state(test_overlay_client_t)
>  kernel_read_proc_symlinks(test_overlay_client_t)
>
> -userdom_search_admin_dir(test_overlay_client_t)
> -userdom_search_user_home_content(test_overlay_client_t)
> -
>  fs_getattr_xattr_fs(test_overlay_client_t)
>
>  selinux_getattr_fs(test_overlay_client_t)
> diff --git a/policy/test_policy.if b/policy/test_policy.if
> index 5458f6c..b20baad 100644
> --- a/policy/test_policy.if
> +++ b/policy/test_policy.if
> @@ -82,13 +82,6 @@ interface(`mount_rw_pid_files', `
>  ')
>  ')
>
> -# Refpolicy does not have admin_home_t - assume /root will be user_home_=
dir_t.
> -ifdef(`userdom_search_admin_dir', `', ` dnl
> -interface(`userdom_search_admin_dir', `
> -    userdom_search_user_home_content($1)
> -')
> -')
> -
>  # If the macro is not defined, then most probably module_request permiss=
ion
>  # is just not supported (and relevant operations should be just allowed)=
.
>  ifdef(`kernel_request_load_module', `', ` dnl
> diff --git a/policy/test_ptrace.te b/policy/test_ptrace.te
> index 352ead5..1a8a10d 100644
> --- a/policy/test_ptrace.te
> +++ b/policy/test_ptrace.te
> @@ -27,7 +27,6 @@ allow test_ptrace_traced_t test_file_t:fifo_file rw_fil=
e_perms;
>
>  # Allow the tracer domain to trace the traced domain.
>  allow test_ptrace_tracer_t test_ptrace_traced_t:process ptrace;
> -userdom_search_user_home_dirs(test_ptrace_traced_t)
>
>  # Let the tracer wait on the traced domain.
>  allow test_ptrace_traced_t test_ptrace_tracer_t:process sigchld;
> --
> 2.41.0
>
