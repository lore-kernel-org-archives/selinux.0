Return-Path: <SRS0=2hro=DQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F683C433DF
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 04:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B772223C
	for <selinux@archiver.kernel.org>; Fri,  9 Oct 2020 04:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602218726;
	bh=bVXxzIKSpfH7ECr3TKrz6YAJfZpJOUC61PsdKmh6low=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pvOAC4pihU6Xsn+XpK90zimLv2Q9vKRtC6RJvKNPEhaDg1/jxbK+G11Bb5uGUuvMW
	 XGjtYcspicF2ZRhMI//BRmJ23LC29deJIvTlONvu4UQlUC1p4vH8wVB4EHaIz7oHfG
	 6rbY3L/D3ZWwSMA7HaM7i1KFYL52+62LNZEnCG8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgJIEpW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Oct 2020 00:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729225AbgJIEpW (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 9 Oct 2020 00:45:22 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1A12224A;
        Fri,  9 Oct 2020 04:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602218721;
        bh=bVXxzIKSpfH7ECr3TKrz6YAJfZpJOUC61PsdKmh6low=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tLGRqw/c8l7VleXD9L/rZ3NH1hiMpxaCGwyfM8OUESAor5SHU1IzGEn49FO4VpNJX
         SwF8MnAjMl8lhBNOy33EtnG1PhrSD3MJ8h9OpQO3/fj39iAz3VzB2qBdgn6OyYKseq
         j9T6NSBc1NXmWU/rFIhIWcWy6EjH3chjQEmcJo+Q=
Date:   Thu, 8 Oct 2020 21:45:19 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v9 1/3] Add a new LSM-supporting anonymous inode interface
Message-ID: <20201009044519.GC854@sol.localdomain>
References: <20200923193324.3090160-1-lokeshgidra@google.com>
 <20200923193324.3090160-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923193324.3090160-2-lokeshgidra@google.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 23, 2020 at 12:33:22PM -0700, Lokesh Gidra wrote:
> +static struct file *_anon_inode_getfile(const char *name,
> +					const struct file_operations *fops,
> +					void *priv, int flags,
> +					const struct inode *context_inode,
> +					bool secure)
> +{

Nit: in Linux kernel code, using double underscore function prefixes is much
more common than single underscores.

> +/**
> + * Like anon_inode_getfd(), but adds the @context_inode argument to
> + * allow security modules to control creation of the new file. Once the
> + * security module makes the decision, this inode is no longer needed
> + * and hence reference to it is not held.
> + */
> +int anon_inode_getfd_secure(const char *name, const struct file_operations *fops,
> +			    void *priv, int flags,
> +			    const struct inode *context_inode)
> +{
> +	return _anon_inode_getfd(name, fops, priv, flags, context_inode, true);
> +}
> +EXPORT_SYMBOL_GPL(anon_inode_getfd_secure);

This new function has two callers, one of which passes context_inode=NULL.

But from the comment, it sounds like the purpose of this function is just to add
the context_inode argument.  So one would expect anon_inode_getfd() to be
equivalent to anon_inode_getfd_secure(..., NULL).

Apparently, that's not actually the case though.  Can you fix the comment to
describe what the function actually does?

- Eric
