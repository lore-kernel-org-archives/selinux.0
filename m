Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CFFC433E0
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B482208BA
	for <selinux@archiver.kernel.org>; Wed, 13 Jan 2021 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbhAMPnM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:43:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbhAMPnM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Jan 2021 10:43:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610552505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSgsXjZH4k7eQ49DcvuPqbkQqnOJIpQSbp2K1LHHRzM=;
        b=SvS2nqUL9tbRbg750r/0jVwmk+fKRCuA6bbFUXWeZT/zVvQqABGcoOQ228jbgLN++6mOSO
        HdiVwgH0W1GTLqNL3eNQKsqm5pcyXXmFWWwe8m1pLslypW90zYccx53QJdihCP++qfxunU
        GD5dxSG3FFYHhG3Ns2dPC3+fYerjC0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-VjuUI3k8MOGbTTgWAd7gTQ-1; Wed, 13 Jan 2021 10:41:41 -0500
X-MC-Unique: VjuUI3k8MOGbTTgWAd7gTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8287A873161;
        Wed, 13 Jan 2021 15:41:40 +0000 (UTC)
Received: from localhost (unknown [10.40.193.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 148CB60D08;
        Wed, 13 Jan 2021 15:41:39 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH] setfiles: Do not abort on labeling error
In-Reply-To: <CAEjxPJ527_NmMn+_gpKMHrq4iDtB2T4UPMEtsBtfzfD6YYF+Vg@mail.gmail.com>
References: <20210113121120.164565-1-plautrba@redhat.com>
 <CAEjxPJ527_NmMn+_gpKMHrq4iDtB2T4UPMEtsBtfzfD6YYF+Vg@mail.gmail.com>
Date:   Wed, 13 Jan 2021 16:41:39 +0100
Message-ID: <8735z4c098.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Jan 13, 2021 at 7:15 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Commit 602347c7422e ("policycoreutils: setfiles - Modify to use
>> selinux_restorecon") changed behavior of setfiles. Original
>> implementation skipped files which it couldn't set context to while the
>> new implementation aborts on them. setfiles should abort only if it
>> can't validate 10 contexts from spec_file.
>>
>> Reproducer:
>>
>>     # mkdir -p r/1 r/2 r/3
>>     # touch r/1/1 r/2/1
>>     # chattr +i r/2/1
>>     # touch r/3/1
>>     # setfiles -r r -v /etc/selinux/targeted/contexts/files/file_contexts r
>>     Relabeled r from unconfined_u:object_r:mnt_t:s0 to unconfined_u:object_r:root_t:s0
>>     Relabeled r/2 from unconfined_u:object_r:mnt_t:s0 to unconfined_u:object_r:default_t:s0
>>     setfiles: Could not set context for r/2/1:  Operation not permitted
>>
>> r/3 and r/1 are not relabeled.
>>
>> Also drop some old unused code in order to prevent future confusion.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  policycoreutils/setfiles/setfiles.c | 49 +----------------------------
>>  1 file changed, 1 insertion(+), 48 deletions(-)
>>
>> diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
>> index 422c3767b845..b96ee814bad2 100644
>> --- a/policycoreutils/setfiles/setfiles.c
>> +++ b/policycoreutils/setfiles/setfiles.c
>> @@ -23,14 +23,6 @@ static int nerr;
>>
>>  #define STAT_BLOCK_SIZE 1
>>
>> -/* setfiles will abort its operation after reaching the
>> - * following number of errors (e.g. invalid contexts),
>> - * unless it is used in "debug" mode (-d option).
>> - */
>> -#ifndef ABORT_ON_ERRORS
>> -#define ABORT_ON_ERRORS        10
>> -#endif
>> -
>>  #define SETFILES "setfiles"
>>  #define RESTORECON "restorecon"
>>  static int iamrestorecon;
>> @@ -56,15 +48,6 @@ static __attribute__((__noreturn__)) void usage(const char *const name)
>>         exit(-1);
>>  }
>>
>> -void inc_err(void)
>> -{
>> -       nerr++;
>> -       if (nerr > ABORT_ON_ERRORS - 1 && !r_opts.debug) {
>> -               fprintf(stderr, "Exiting after %d errors.\n", ABORT_ON_ERRORS);
>> -               exit(-1);
>> -       }
>> -}
>> -
>>  void set_rootpath(const char *arg)
>>  {
>>         if (strlen(arg) == 1 && strncmp(arg, "/", 1) == 0) {
>> @@ -82,27 +65,6 @@ void set_rootpath(const char *arg)
>>         }
>>  }
>>
>> -int canoncon(char **contextp)
>> -{
>> -       char *context = *contextp, *tmpcon;
>> -       int rc = 0;
>> -
>> -       if (policyfile) {
>> -               if (sepol_check_context(context) < 0) {
>> -                       fprintf(stderr, "invalid context %s\n", context);
>> -                       exit(-1);
>> -               }
>> -       } else if (security_canonicalize_context_raw(context, &tmpcon) == 0) {
>> -               free(context);
>> -               *contextp = tmpcon;
>> -       } else if (errno != ENOENT) {
>> -               rc = -1;
>> -               inc_err();
>> -       }
>> -
>> -       return rc;
>> -}
>> -
>>  #ifndef USE_AUDIT
>>  static void maybe_audit_mass_relabel(int mass_relabel __attribute__((unused)),
>>                                 int mass_relabel_errs __attribute__((unused)))
>> @@ -181,6 +143,7 @@ int main(int argc, char **argv)
>>         policyfile = NULL;
>>         nerr = 0;
>>
>> +       r_opts.abort_on_error = 0;
>>         r_opts.progname = strdup(argv[0]);
>>         if (!r_opts.progname) {
>>                 fprintf(stderr, "%s:  Out of memory!\n", argv[0]);
>> @@ -193,7 +156,6 @@ int main(int argc, char **argv)
>>                  * setfiles:
>>                  * Recursive descent,
>>                  * Does not expand paths via realpath,
>> -                * Aborts on errors during the file tree walk,
>>                  * Try to track inode associations for conflict detection,
>>                  * Does not follow mounts (sets SELINUX_RESTORECON_XDEV),
>>                  * Validates all file contexts at init time.
>> @@ -201,7 +163,6 @@ int main(int argc, char **argv)
>>                 iamrestorecon = 0;
>>                 r_opts.recurse = SELINUX_RESTORECON_RECURSE;
>>                 r_opts.userealpath = 0; /* SELINUX_RESTORECON_REALPATH */
>> -               r_opts.abort_on_error = SELINUX_RESTORECON_ABORT_ON_ERROR;
>>                 r_opts.add_assoc = SELINUX_RESTORECON_ADD_ASSOC;
>>                 /* FTS_PHYSICAL and FTS_NOCHDIR are always set by selinux_restorecon(3) */
>>                 r_opts.xdev = SELINUX_RESTORECON_XDEV;
>> @@ -225,7 +186,6 @@ int main(int argc, char **argv)
>>                 iamrestorecon = 1;
>>                 r_opts.recurse = 0;
>>                 r_opts.userealpath = SELINUX_RESTORECON_REALPATH;
>> -               r_opts.abort_on_error = 0;
>>                 r_opts.add_assoc = 0;
>>                 r_opts.xdev = 0;
>>                 r_opts.ignore_mounts = 0;
>> @@ -420,13 +380,6 @@ int main(int argc, char **argv)
>>                                 usage(argv[0]);
>>                 }
>>
>> -               /* Use our own invalid context checking function so that
>> -                * we can support either checking against the active policy or
>> -                * checking against a binary policy file.
>> -                */
>> -               cb.func_validate = canoncon;
>> -               selinux_set_callback(SELINUX_CB_VALIDATE, cb);
>> -
>
> I could be wrong but I think we still need this for setfiles -c.

Looks like you are right. I'll send updated version.

