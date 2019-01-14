Return-Path: <SRS0=3kls=PW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0181C43387
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 11:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7147205F4
	for <selinux@archiver.kernel.org>; Mon, 14 Jan 2019 11:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfANLbf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:31:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52262 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbfANLbf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 14 Jan 2019 06:31:35 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEB44637EE;
        Mon, 14 Jan 2019 11:31:34 +0000 (UTC)
Received: from workstation (ovpn-204-251.brq.redhat.com [10.40.204.251])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E57915DEA9;
        Mon, 14 Jan 2019 11:31:33 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     selinux@vger.kernel.org, jwcart2@tycho.nsa.gov
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
Date:   Mon, 14 Jan 2019 12:31:31 +0100
In-Reply-To: <20190110162624.29309-1-sds@tycho.nsa.gov> (Stephen Smalley's
        message of "Thu, 10 Jan 2019 11:26:24 -0500")
Message-ID: <pjda7k3fpbg.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 14 Jan 2019 11:31:34 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <sds@tycho.nsa.gov> writes:

> As reported in #123, setsebool immediately exits with an error if
> SELinux is disabled, preventing its use for setting boolean persistent
> values.  In contrast, semanage boolean -m works on SELinux-disabled
> hosts.  Change setsebool so that it can be used with the -P option
> (persistent changes) even if SELinux is disabled.  In the SELinux-disabled
> case, skip setting of active boolean values, but set the persistent value
> in the policy store.  Policy reload is automatically disabled by libsemanage
> when SELinux is disabled, so we only need to call semanage_set_reload()
> if -N was used.
>

So right now, `setsebool -N` and `semanage boolean -N` have the same effect that
`load_policy` is not run, but the value of the boolean is changed when
SELinux is enabled so it affects the system. Would it make sense to use
-N to just change values in the store and do not change the value in the
running kernel? E.g.

--- a/policycoreutils/setsebool/setsebool.c
+++ b/policycoreutils/setsebool/setsebool.c
@@ -187,11 +187,14 @@ static int semanage_set_boolean_list(size_t boolcnt,
                                                  boolean) < 0)
                        goto err;
 
-               if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
-                       fprintf(stderr, "Failed to change boolean %s: %m\n",
-                               boollist[j].name);
-                       goto err;
-               }
+               if (no_reload)
+                       semanage_set_reload(handle, 0);
+               else
+                       if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
+                               fprintf(stderr, "Failed to change boolean %s: %m\n",
+                                                               boollist[j].name);
+                               goto err;
+                       }


A similar patch would need to be applied to seobject.py as well in this case.



> Fixes: https://github.com/SELinuxProject/selinux/issues/123
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
> v2 changes setsebool to only call semanage_set_reload() if -N was specified;
> otherwise we can use the libsemanage defaults just as we do in semodule
> and semanage.
>  policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
> index 53d3566c..a5157efc 100644
> --- a/policycoreutils/setsebool/setsebool.c
> +++ b/policycoreutils/setsebool/setsebool.c
> @@ -18,7 +18,7 @@
>  #include <errno.h>
>  
>  int permanent = 0;
> -int reload = 1;
> +int no_reload = 0;
>  int verbose = 0;
>  
>  int setbool(char **list, size_t start, size_t end);
> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>  	if (argc < 2)
>  		usage();
>  
> -	if (is_selinux_enabled() <= 0) {
> -		fputs("setsebool:  SELinux is disabled.\n", stderr);
> -		return 1;
> -	}
> -
>  	while (1) {
>  		clflag = getopt(argc, argv, "PNV");
>  		if (clflag == -1)
> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>  			permanent = 1;
>  			break;
>  		case 'N':
> -			reload = 0;
> +			no_reload = 1;
>  			break;
>  		case 'V':
>  			verbose = 1;
> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>  	semanage_bool_key_t *bool_key = NULL;
>  	int managed;
>  	int result;
> +	int enabled = is_selinux_enabled();
>  
>  	handle = semanage_handle_create();
>  	if (handle == NULL) {
> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>  						  boolean) < 0)
>  			goto err;
>  
> -		if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
> +		if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>  			fprintf(stderr, "Failed to change boolean %s: %m\n",
>  				boollist[j].name);
>  			goto err;
> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t boolcnt,
>  		boolean = NULL;
>  	}
>  
> -	semanage_set_reload(handle, reload);
> +	if (no_reload)
> +		semanage_set_reload(handle, 0);
>  	if (semanage_commit(handle) < 0)
>  		goto err;
