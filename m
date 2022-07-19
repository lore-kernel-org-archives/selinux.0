Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8C4C43334
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 09:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiGSJHn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 05:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGSJHm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 05:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEAF410E2
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658221661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b5/TgW3rk5lLBI4sbBrDrrj/IYb75MvCG2fkoZqEKOQ=;
        b=bIvH0y5NEKTHeFCiNhrDQPYxs9KMEtK3mhcHmCtrJixlMds3okJ244SSyUTQ0Lulv1UE9y
        bgXm7GnOU+fo6MrdutAmlu2XXuDkyksR8QFbUXkXasUCz4ZHBd5IoJ7efSk7/yTqylUgqC
        Olm2u2vS/xhgFuxDFzmr6hXdV6EDUBM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-319-jkmRYCC9PV-Nvrv-snZ7_A-1; Tue, 19 Jul 2022 05:07:37 -0400
X-MC-Unique: jkmRYCC9PV-Nvrv-snZ7_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E08D294EDC5;
        Tue, 19 Jul 2022 09:07:37 +0000 (UTC)
Received: from localhost (unknown [10.40.192.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCF57492C3B;
        Tue, 19 Jul 2022 09:07:36 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Elijah Conners <business@elijahpepe.com>,
        selinux <selinux@vger.kernel.org>
Subject: Re: [PATCH] python: remove IOError in certain cases
In-Reply-To: <1816aee4f80.1026d4b311254470.8507588530121880177@elijahpepe.com>
References: <1816aee4f80.1026d4b311254470.8507588530121880177@elijahpepe.com>
Date:   Tue, 19 Jul 2022 11:07:36 +0200
Message-ID: <875yjtjwrr.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Elijah Conners <business@elijahpepe.com> writes:

> In certain cases, IOError caused the much more general exception OSError
> to be unreachable.
>
> Signed-off-by: Elijah Conners <business@elijahpepe.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  python/semanage/semanage | 7 ++-----
>  sandbox/sandbox          | 2 --
>  2 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 1d828128..c7a35fe4 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -970,8 +970,8 @@ def do_parser():
>          devnull = os.open(os.devnull, os.O_WRONLY)
>          os.dup2(devnull, sys.stdout.fileno())
>          sys.exit(1)
> -    except IOError as e:
> -        sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
> +    except OSError as e:
> +        sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[1]))
>          sys.exit(1)
>      except KeyboardInterrupt:
>          sys.exit(0)
> @@ -981,9 +981,6 @@ def do_parser():
>      except KeyError as e:
>          sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[0]))
>          sys.exit(1)
> -    except OSError as e:
> -        sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[1]))
> -        sys.exit(1)
>      except RuntimeError as e:
>          sys.stderr.write("%s: %s\n" % (e.__class__.__name__, e.args[0]))
>          sys.exit(1)
> diff --git a/sandbox/sandbox b/sandbox/sandbox
> index cd5709fb..1c9379ef 100644
> --- a/sandbox/sandbox
> +++ b/sandbox/sandbox
> @@ -533,8 +533,6 @@ if __name__ == '__main__':
>          error_exit(error.args[0])
>      except KeyError as error:
>          error_exit(_("Invalid value %s") % error.args[0])
> -    except IOError as error:
> -        error_exit(error)
>      except KeyboardInterrupt:
>          rc = 0
>  
> -- 
> 2.29.2.windows.2

