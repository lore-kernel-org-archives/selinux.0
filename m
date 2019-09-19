Return-Path: <SRS0=jdxV=XO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEB5C3A5A6
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB06521848
	for <selinux@archiver.kernel.org>; Thu, 19 Sep 2019 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkjCSiT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388008AbfISIeE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:34:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387931AbfISIeE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 19 Sep 2019 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568882042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmAQbD/PYZ42TfkduPyVBsrgWjdwfYR2Ioj2dCPOOyE=;
        b=GkjCSiT2sjsAj7npXHY6NkJ7wVnYSAntfzbqdQwgytfB9DzHCsns2D3hnnP5xhCWzlxnpW
        0hPo7NGQQ/LDRSECcTcmetTsoj3L8wvmlojIH0hTmaz4yApFShTXItRdcAxgvFao7J4Q7U
        QalyHZuQc9oWtAI8WKFPkshH5dHuw4I=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-mhBMthmQPfuQSp_IJMTlqw-1; Thu, 19 Sep 2019 04:34:00 -0400
Received: by mail-oi1-f200.google.com with SMTP id i20so1556466oib.5
        for <selinux@vger.kernel.org>; Thu, 19 Sep 2019 01:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=6NAw9GVGokqno4iTG2L92mHB5HaOfyR8/WsH6RBERgs=;
        b=LIfi8T6z++6z18HpU28eURp/YX81AdLqOswK9DlSfZYHUSK8ZD/mD2HCZnU58bqkoC
         jn+CJ5ZiRiQGBhJnfl8JvmllnSLWW8TQyYwE4V/9nKT5LDBgN/YzPlcazMWP1WaSdCmW
         P8JMDvSymkL2gyAz4dZkUHqDfzuetQw5DhJqapr53vDfkWYuvnCw9SiwsroDcQSSQ57E
         ppHKBGVYCXgzogYfau795TA1+EkuO1EEY6m72dHcEz2GDLhplqCod+x5X8vUxEfb4JAq
         klhMyG8U4dH+QljwWicDEwd7nm1npHtteMzNwpz8QvYHBhVMLSymoOdEjHsGdieec4im
         pq+g==
X-Gm-Message-State: APjAAAVCDUZU2XDS1bJLmJEO5R79ntl+uH49zKjU0agXc8NfpuC+3jr3
        7PxChxpVot8dGjJU8CmYxF+pcBl5x+/lgIJYSh0S6er5vVWFVfSgUfsKx3itkcFajMQA6A8jxng
        Q3kNbbCJDcxCpkb0ge6OMYwX4v67rwU+BZA==
X-Received: by 2002:a54:4392:: with SMTP id u18mr1354053oiv.103.1568882039791;
        Thu, 19 Sep 2019 01:33:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyjqnKpxJpqzfZBCoGRdghZAhPDEa60PtSOnE0hf24AZ+utj66yjGQ3WbtoMmLYYlTYD0vPPQ59nu6aZghOHo8=
X-Received: by 2002:a54:4392:: with SMTP id u18mr1354042oiv.103.1568882039459;
 Thu, 19 Sep 2019 01:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190919081058.8860-1-omosnace@redhat.com>
In-Reply-To: <20190919081058.8860-1-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 19 Sep 2019 10:33:48 +0200
Message-ID: <CAFqZXNu30MVUACOkVxZWEvz4FjLQEg2YDfZ_7ZdvxotRtJqNjA@mail.gmail.com>
Subject: Re: [PATCH] policy: fix some build errors under refpolicy
To:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: mhBMthmQPfuQSp_IJMTlqw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 19, 2019 at 10:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrot=
e:
> Replace deprecated macros with new ones. Fedora's policy has both;
> refpolicy just the new ones.
>
> Partially addresses issue #57.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/test_atsecure.te    | 4 ++--
>  policy/test_capable_net.te | 2 +-
>  policy/test_file.te        | 4 ++--
>  policy/test_inherit.te     | 4 ++--
>  policy/test_readlink.te    | 2 +-
>  policy/test_rxdir.te       | 2 +-
>  policy/test_setnice.te     | 4 ++--
>  policy/test_stat.te        | 2 +-
>  policy/test_transition.te  | 2 +-
>  9 files changed, 13 insertions(+), 13 deletions(-)

(Forgot to specify in the subject that this is a testsuite patch -
sorry, testing a new script...)

Tested by running the testuite on Fedora Rawhide along with Stephen's
related patch ("selinux-testsuite: drop use of
userdom_read_inherited_user_tmp_files"):

https://lore.kernel.org/selinux/CAFqZXNt4gtvgLbTj18=3DDW65SnQieaGA=3D++nKd0=
QLhzkQ6fERAg@mail.gmail.com/T/#t

Even with this + Stephen's patch the refpolicy build is still failing
for me on missing 'userdom_search_admin_dir'.

>
> diff --git a/policy/test_atsecure.te b/policy/test_atsecure.te
> index 7255553..486faf6 100644
> --- a/policy/test_atsecure.te
> +++ b/policy/test_atsecure.te
> @@ -32,8 +32,8 @@ corecmd_bin_entry_type(atsecuredomain)
>  corecmd_shell_entry_type(atsecuredomain)
>  corecmd_exec_bin(atsecuredomain)
>  domain_entry_file(test_atsecure_newdomain_t, test_file_t)
> -domain_trans(test_atsecure_denied_t, test_file_t, test_atsecure_newdomai=
n_t)
> -domain_trans(test_atsecure_allowed_t, test_file_t, test_atsecure_newdoma=
in_t)
> +domain_transition_pattern(test_atsecure_denied_t, test_file_t, test_atse=
cure_newdomain_t)
> +domain_transition_pattern(test_atsecure_allowed_t, test_file_t, test_ats=
ecure_newdomain_t)
>  allow test_atsecure_newdomain_t test_atsecure_denied_t:fd use;
>  allow test_atsecure_newdomain_t test_atsecure_allowed_t:fd use;
>  allow_map(atsecuredomain, test_file_t, file)
> diff --git a/policy/test_capable_net.te b/policy/test_capable_net.te
> index fab6650..80559f6 100644
> --- a/policy/test_capable_net.te
> +++ b/policy/test_capable_net.te
> @@ -53,7 +53,7 @@ sysadm_bin_spec_domtrans_to(capabledomain)
>  require {
>         type ifconfig_exec_t;
>  }
> -domain_trans(sysadm_t, ifconfig_exec_t, capabledomain)
> +domain_transition_pattern(sysadm_t, ifconfig_exec_t, capabledomain)
>  domain_entry_file(capabledomain, ifconfig_exec_t)
>
>  # Permissions for the good domain
> diff --git a/policy/test_file.te b/policy/test_file.te
> index 1f1da3a..828c0f4 100644
> --- a/policy/test_file.te
> +++ b/policy/test_file.te
> @@ -67,13 +67,13 @@ corecmd_bin_entry_type(fileopdomain)
>  sysadm_bin_spec_domtrans_to(fileopdomain)
>
>  domain_entry_file(fileop_t, fileop_exec_t)
> -domain_auto_trans(test_fileop_t, fileop_exec_t, fileop_t)
> +domain_auto_transition_pattern(test_fileop_t, fileop_exec_t, fileop_t)
>  allow test_fileop_t fileop_t:fd use;
>  allow fileop_t test_fileop_t:fd use;
>  allow fileop_t test_fileop_t:fifo_file rw_file_perms;
>  allow fileop_t test_fileop_t:process sigchld;
>
> -domain_auto_trans(test_nofileop_t, fileop_exec_t, fileop_t)
> +domain_auto_transition_pattern(test_nofileop_t, fileop_exec_t, fileop_t)
>  allow test_nofileop_t fileop_t:fd use;
>  allow fileop_t test_nofileop_t:fd use;
>  allow fileop_t test_nofileop_t:fifo_file rw_file_perms;
> diff --git a/policy/test_inherit.te b/policy/test_inherit.te
> index 28bfd63..8303fc5 100644
> --- a/policy/test_inherit.te
> +++ b/policy/test_inherit.te
> @@ -47,7 +47,7 @@ userdom_sysadm_entry_spec_domtrans_to(inheritdomain)
>  allow test_inherit_parent_t test_inherit_file_t:file rw_file_perms;
>
>  # Grant the necessary permissions for the child domain.
> -domain_trans(test_inherit_parent_t, test_file_t, test_inherit_child_t)
> +domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inher=
it_child_t)
>  allow test_inherit_parent_t test_inherit_child_t:fd use;
>  allow test_inherit_child_t test_inherit_parent_t:fd use;
>  allow test_inherit_child_t test_inherit_parent_t:fifo_file rw_file_perms=
;
> @@ -60,7 +60,7 @@ allow test_inherit_nouse_t test_file_t:file { read geta=
ttr execute entrypoint };
>  allow test_inherit_nouse_t test_inherit_file_t:file rw_file_perms;
>
>  # Grant the nowrite domain all of the same permissions except for file w=
rite.
> -domain_trans(test_inherit_parent_t, test_file_t, test_inherit_nowrite_t)
> +domain_transition_pattern(test_inherit_parent_t, test_file_t, test_inher=
it_nowrite_t)
>  allow test_inherit_parent_t test_inherit_nowrite_t:fd use;
>  allow test_inherit_nowrite_t test_inherit_parent_t:fd use;
>  allow test_inherit_nowrite_t test_inherit_parent_t:fifo_file rw_file_per=
ms;
> diff --git a/policy/test_readlink.te b/policy/test_readlink.te
> index 1126fd5..b0d8cd5 100644
> --- a/policy/test_readlink.te
> +++ b/policy/test_readlink.te
> @@ -34,5 +34,5 @@ allow test_noreadlink_t test_readlink_link_t:lnk_file {=
 getattr };
>  require {
>         type ls_exec_t;
>  }
> -domain_trans(sysadm_t, ls_exec_t, test_readlink_domain)
> +domain_transition_pattern(sysadm_t, ls_exec_t, test_readlink_domain)
>  domain_entry_file(test_readlink_domain, ls_exec_t)
> diff --git a/policy/test_rxdir.te b/policy/test_rxdir.te
> index cbe1897..50d5ad1 100644
> --- a/policy/test_rxdir.te
> +++ b/policy/test_rxdir.te
> @@ -33,4 +33,4 @@ require {
>         type ls_exec_t;
>  }
>  domain_entry_file(test_rxdir_domain, ls_exec_t)
> -domain_trans(sysadm_t, ls_exec_t, test_rxdir_domain)
> +domain_transition_pattern(sysadm_t, ls_exec_t, test_rxdir_domain)
> diff --git a/policy/test_setnice.te b/policy/test_setnice.te
> index dac0dc5..d956598 100644
> --- a/policy/test_setnice.te
> +++ b/policy/test_setnice.te
> @@ -38,8 +38,8 @@ libs_exec_lib_files(setnicedomain)
>  # Allow all of these domains to be entered from sysadm domain
>  # via a shell script in the test directory or by....
>  miscfiles_domain_entry_test_files(setnicedomain)
> -domain_trans(sysadm_t, test_file_t, setnicedomain)
> -domain_trans(test_setnice_change_t, test_file_t, {test_setnice_set_t tes=
t_setnice_noset_t})
> +domain_transition_pattern(sysadm_t, test_file_t, setnicedomain)
> +domain_transition_pattern(test_setnice_change_t, test_file_t, {test_setn=
ice_set_t test_setnice_noset_t})
>  allow test_setnice_change_t test_setnice_set_t:fd use;
>  allow test_setnice_set_t test_setnice_change_t:fd use;
>  allow test_setnice_set_t test_setnice_change_t:fifo_file rw_file_perms;
> diff --git a/policy/test_stat.te b/policy/test_stat.te
> index 2e068d1..0204e71 100644
> --- a/policy/test_stat.te
> +++ b/policy/test_stat.te
> @@ -29,5 +29,5 @@ typeattribute test_nostat_t testdomain;
>  require {
>         type ls_exec_t;
>  }
> -domain_trans(sysadm_t, ls_exec_t, test_stat_domain)
> +domain_transition_pattern(sysadm_t, ls_exec_t, test_stat_domain)
>  domain_entry_file(test_stat_domain, ls_exec_t)
> diff --git a/policy/test_transition.te b/policy/test_transition.te
> index c487825..1eee2b4 100644
> --- a/policy/test_transition.te
> +++ b/policy/test_transition.te
> @@ -28,7 +28,7 @@ typeattribute test_transition_todomain_t testdomain;
>
>  # Allow the fromdomain to transition to the new domain.
>  corecmd_bin_entry_type(transitiondomain)
> -domain_trans(test_transition_fromdomain_t,bin_t,test_transition_todomain=
_t)
> +domain_transition_pattern(test_transition_fromdomain_t,bin_t,test_transi=
tion_todomain_t)
>  allow test_transition_fromdomain_t test_transition_todomain_t:fd use;
>  allow test_transition_todomain_t test_transition_fromdomain_t:fd use;
>
> --
> 2.21.0
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

