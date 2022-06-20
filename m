Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5C5C43334
	for <selinux@archiver.kernel.org>; Mon, 20 Jun 2022 18:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243531AbiFTSE0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Jun 2022 14:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbiFTSEZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Jun 2022 14:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C2F818E3B
        for <selinux@vger.kernel.org>; Mon, 20 Jun 2022 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655748262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Dw3q+UtAIcrY99nyvOl4suwhXmLj8Er3gWExG5Sdqw=;
        b=BOpft8lMjxEA3hKEC21Zld7+3Wvktcj7t8oxuwH0mOR4Xi0y3xOwQ64SkrS9FwxqrZADYT
        uqSDtemAkCRof1py4EELq8IFsvSmz1bqiPZQktfVqXu2pP/C5kLm8O/1MdyHW3aQzL1cI4
        o3gjHtv5GBnLCadHWQrvAH0Kg6Hj4OU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-pj_wQ_iMO-iDEUTTM8OcQg-1; Mon, 20 Jun 2022 14:04:18 -0400
X-MC-Unique: pj_wQ_iMO-iDEUTTM8OcQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87E121097AEE;
        Mon, 20 Jun 2022 18:04:18 +0000 (UTC)
Received: from localhost (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33A9F492C3B;
        Mon, 20 Jun 2022 18:04:18 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Elijah Conners <business@elijahpepe.com>,
        selinux <selinux@vger.kernel.org>
Subject: Re: [PATCH] python: remove IOError in certain cases
In-Reply-To: <1816aee4f80.1026d4b311254470.8507588530121880177@elijahpepe.com>
References: <1816aee4f80.1026d4b311254470.8507588530121880177@elijahpepe.com>
Date:   Mon, 20 Jun 2022 20:04:17 +0200
Message-ID: <87letrrz32.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Elijah Conners <business@elijahpepe.com> writes:

> In certain cases, IOError caused the much more general exception OSError
> to be unreachable.
>
> Signed-off-by: Elijah Conners <business@elijahpepe.com>

Could you please provide more details about the certain cases,
preferably with a reproducer?

Thanks,

Petr



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

