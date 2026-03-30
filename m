Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9563AE6FE
	for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859760; cv=pass; b=Xq+nr4ng+t4nVcVMSL5Na3Ke97GIrH9wFiDxuqQ+ZWgVJf6Y6e8hjPmB2d95qtILWvDWKqd7YGE4cOXF5fbRyYqEFY/ZnDCzghBTFNegP4S95c5airW14yCd6OYQW2fygk3E7r7m28Lj24Uual0gbmSIZD8Sdp2x75ZU5DXWHpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859760; c=relaxed/simple;
	bh=ZltdtDXElYRDDBhSgWCpArK8WSS919ViTlDkmQSKzJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBp5tbu77+mGNTnKq6yD+Sx2UxbRZocpE7DJZeihTkq1zIQXirYulnTnqm2H87ZmwcI9CrEGAPowQyrF9awB+Ape9oFfHwGX4qeHx6olCKoqiYHeONT+UrS3kxXhRdEOiwtJKzuaYKHz4ntj1D6SUWnpEP0TLHbkH0H5Ge8WcGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn8Y1fQ3; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn8Y1fQ3"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-667de793310so6872453a12.0
        for <selinux@vger.kernel.org>; Mon, 30 Mar 2026 01:35:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774859756; cv=none;
        d=google.com; s=arc-20240605;
        b=OHOPCYQn+TLDfwBkJj5NfnIszL69Wh/NNEVmMYGPvWOcEB0yPE0qDeG0UUEcpiaJ5M
         PxwxZV+Q4zl5ra2xIbNwuaSAAPl74xioYlhyjehJ4UjJhMqNTSY8MoJDmV1DiH+asUe0
         Ga7ptFaZyLgFAQzbALfLqY6hHcN5Kg8JSkDzdMZpiPPm59y8rfdn0qHzgnjXIyqbaUbV
         eiNOXi3LcfWQt60ifjfF2JYDvejGeLquJzXldkQVSlXiZV0/IsX7J6gLBJ3hYAO4EGPC
         dQy2HCTT+Yl/ujSz/Nx/IB9JwC68GtFw6sCS1fLl9irBXPS9TL4Sgbi5SE55G766HUHG
         cLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
        fh=3/v+k0dNJZfTJeAqSjq39rLbWj+RNdVribC3FIAB2aI=;
        b=Z0Q+P5NDxmaP8vbjan/dS7r075GXloLbXn36w9eiPrugj0/ox89pdFC6tAb9hicRRw
         dRsFAbjXajpAlczM86LLnK2FayAgjTJY016O7tpTtZHmqzs5DKi/om9WNeCldoPRX5nb
         h4MaDH7s0AaWcmpA2/fd3oSrHe6bn0YwXG6/t/6GlYLIxOSguc+mQJei7TFWmGdIa7dN
         9LbCCI1lpZ9XnRIJNFfI9DYr9GhQA4dvYRk8uFTb95ciIENoppwE6quiCE1rkxaZGZjz
         u7sVw/I8OGKx6/+IpykJIcx1oGgFX7sKsvLznl5S6V5dH/JoM6GVxn1jyGyG6X7AztKk
         JJ0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859756; x=1775464556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
        b=Bn8Y1fQ3HUjh5LRiOoCyB6+JDz4kO7xk98U06FcRdiKJAqtMVmoGv5OxY6Yio4p7KU
         QynNWEmz//VOo4k4ivHj+P4vpsPb5hukdPlqJ/gaow7XiKPHf522DwXxoTNi6VUjGXvk
         JCQ+R/lMROSQA6eHPdGM7fqk6wDdJBA0Pqmf3Ht9UZXTkYcYmq3YBTebClRKFlLXdEPt
         H/u2bfQjDs02J3siLDWwqZo4Ogvvxy5T/3L657NCgPosf+VOttBHaNCna9LHEjihW3LC
         yNOKRUmiteqvcMMxlPAcQMz6QmE/f+urk1QrDHWF4UCyrrrS5qJYvZX2vxoDYxjX45Oz
         gxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859756; x=1775464556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I71iPJR9s5FJ08bq1DVMN2Jfu+xUh4nMv+VKY9J60bg=;
        b=MbVcmpwWlHLGjIBcAM5F1DNJ3YL0PFyJR/whcvT4pt5Qqz/Y/EY8PK1nVaftIHkCwN
         kx2qgg1yENivRzL82F+rHU6Lm3VNBwIbLhNlHVC/noZlQAVcZTVm8K5Xtbo/bKBMV71c
         CEG/pbJZPRR4nJaIrrPfMrcDCfhScWEBAFqnnAYDeLzCmo+2fxax4JfUdfIoy+YFTWwt
         MXxcD0gcBi6K74ek354xGUpuEKfhscH3k7l/VgCnPLttEMi0gbERV1z9TD7ReSNRPcmj
         rwGVGxkPX6WCiSnRdiy3cxndQ0NCBcNNPQBTM6oUuXJQIlhXpBG9vHk3puOB+F6eUuMg
         NeFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvvJ9ntbj4QZw7F0vgNE8C4pBeE9z0+QOOdxIKRPxmeljXNNt97bSVqX03pEcWCxVlOD8p71Lz@vger.kernel.org
X-Gm-Message-State: AOJu0Yygm5ycbzjr4j9DQZapaCJbKU/HIWPrB+5sg/Ut05NUAK6GZizx
	1AYRGsxFWg16UtcPvD79isbRuEpqxdkB9CDqc7Pe3VV2UNenrqG5S9AI32G3FDf7PeWo20wwOG8
	4ykvRnEhcMFxlpygYQ0p1SCwAIxBpVmk=
X-Gm-Gg: ATEYQzwmXE19YiG1SHSFyDEgQErG7veg/BvrrMTXU9ezzJc7qeuXd7Fv4pV/r6rrnzq
	6pHvA8R4bJ43xOKP4a4zbuQsHQU/BFE8IzyYi52nlhSG3WpSLxdWE0ayxPvHywoeCsqC2Qf8tCM
	oMSeegHYpT0IQs+2Fgd+quC9M9+ytJm8hyNylDCJO2uKX3nsuGSWvOhZQv7KKzc/VnJiWvyF9nP
	xaY9f425OpArvUbmedS4Nw9mgZlZAAsmAumen55sXb7TC/QzYqBr4O8LC3ZqYEwo9kp0ndbqcAV
	v/eK4Ra6SSI5t8jKA6GqC4EL9qBWNDaKcfZkOTRkdA==
X-Received: by 2002:a05:6402:23d8:b0:666:d675:e2d9 with SMTP id
 4fb4d7f45d1cf-66b28c711e8mr5369326a12.23.1774859756051; Mon, 30 Mar 2026
 01:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
In-Reply-To: <20260327220446.353103-5-paul@paul-moore.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 30 Mar 2026 10:35:44 +0200
X-Gm-Features: AQROBzBDqnCdh1lsySXMReag-koNqxFZzXRJut44t6M3sk3oI72QO2jo_kKOcqI
Message-ID: <CAOQ4uxgcOCP8cf8KvCsC=5OiuRvULKOf52mc2n9qEBAhPKoUGg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000495a5d064e39bd4e"

--000000000000495a5d064e39bd4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Stacked filesystems such as overlayfs do not currently provide the
> necessary mechanisms for LSMs to properly enforce access controls on the
> mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> security blob is being added to the backing_file struct and the following
> new LSM hooks are being created:
>
>  security_backing_file_alloc()
>  security_backing_file_free()
>  security_mmap_backing_file()
>
> The first two hooks are to manage the lifecycle of the LSM security blob
> in the backing_file struct, while the third provides a new mmap() access
> control point for the underlying backing file.  It is also expected that
> LSMs will likely want to update their security_file_mprotect() callback
> to address issues with their mprotect() controls, but that does not
> require a change to the security_file_mprotect() LSM hook.
>
> There are a two other small changes to support these new LSM hooks.  We
> pass the user file associated with a backing file down to
> alloc_empty_backing_file() so it can be included in the
> security_backing_file_alloc() hook, and we constify the file struct field
> in the LSM common_audit_data struct to better support LSMs that need to
> pass a const file struct pointer into the common LSM audit code.
>
> Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> and supplying a fixup.
>
> Cc: stable@vger.kernel.org
> Acked-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  fs/backing-file.c             |  18 ++++--
>  fs/erofs/ishare.c             |  10 +++-
>  fs/file_table.c               |  21 ++++++-
>  fs/fuse/passthrough.c         |   2 +-
>  fs/internal.h                 |   3 +-
>  fs/overlayfs/dir.c            |   2 +-
>  fs/overlayfs/file.c           |   2 +-
>  include/linux/backing-file.h  |   4 +-
>  include/linux/fs.h            |   1 +
>  include/linux/lsm_audit.h     |   2 +-
>  include/linux/lsm_hook_defs.h |   5 ++
>  include/linux/lsm_hooks.h     |   1 +
>  include/linux/security.h      |  22 ++++++++
>  security/lsm.h                |   1 +
>  security/lsm_init.c           |   9 +++
>  security/security.c           | 100 ++++++++++++++++++++++++++++++++++
>  16 files changed, 187 insertions(+), 16 deletions(-)
>

That looks like a nice clean abstraction to me.

...

> diff --git a/fs/file_table.c b/fs/file_table.c
> index aaa5faaace1e..0bdc26cae138 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -50,6 +50,7 @@ struct backing_file {
>                 struct path user_path;
>                 freeptr_t bf_freeptr;
>         };
> +       void *security;

This needs ifdef SECURITY
and the name should be user_security

>  };
>
>  #define backing_file(f) container_of(f, struct backing_file, file)
> @@ -66,6 +67,11 @@ void backing_file_set_user_path(struct file *f, const =
struct path *path)
>  }
>  EXPORT_SYMBOL_GPL(backing_file_set_user_path);
>
> +void *backing_file_security(const struct file *f)
> +{
> +       return backing_file(f)->security;
> +}

I prefer the name backing_file_user_security()

Terminology here is very confusing but when saying
"backing file" it is more natural that one is referring to the
backing xfs file with overlayfs has opened.

The "backing file" already has an LSM blob f->f_security
which is fair the call it the "backing file's LSM blob"

Therefore, I think we need to make a distinction, as we did
with backing_file_user_path() and refer to this as something along
the lines of the "backing file's user LSM blob".

> +
>  static inline void file_free(struct file *f)
>  {
>         security_file_free(f);
> @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
>                 percpu_counter_dec(&nr_files);
>         put_cred(f->f_cred);
>         if (unlikely(f->f_mode & FMODE_BACKING)) {
> -               path_put(backing_file_user_path(f));
> -               kmem_cache_free(bfilp_cachep, backing_file(f));
> +               struct backing_file *ff =3D backing_file(f);
> +
> +               security_backing_file_free(&ff->security);
> +               path_put(&ff->user_path);
> +               kmem_cache_free(bfilp_cachep, ff);

Not directly related to your patch, but as this is growing, IMO
this would look cleaner with backing_file_free() inline helper
(see attached path).

>         } else {
>                 kmem_cache_free(filp_cachep, f);
>         }
> @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, co=
nst struct cred *cred)
>   * This is only for kernel internal use, and the allocate file must not =
be
>   * installed into file tables or such.
>   */
> -struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
)
> +struct file *alloc_empty_backing_file(int flags, const struct cred *cred=
,
> +                                     const struct file *user_file)
>  {
>         struct backing_file *ff;
>         int error;
> @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, con=
st struct cred *cred)
>         }
>
>         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> +       error =3D security_backing_file_alloc(&ff->security, user_file);
> +       if (unlikely(error)) {
> +               fput(&ff->file);
> +               return ERR_PTR(error);
> +       }
>         return &ff->file;
>  }

There is an API issue here.
in order to call fput() we must ensure that user_security was initialized t=
o
NULL (or allocated).

I don't think that we want security_backing_file_alloc() to provide this
semantic and the current patch does not implement it.

Furthermore, user_path is also not initialized in the error case.

Attached UNTESTED fixup patch to suggest a cleanup with
init_backing_file() helper.

It also changes the variable and helper name to user_security
and plays some trick to avoid many ifdef SECURITY.
Feel free to take whichever bits you like with/without attribution.

If you prefer, attached also a proper prep patch.
compile tested only.

Thanks,
Amir.

--000000000000495a5d064e39bd4e
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-backing_file_user_security.patch"
Content-Disposition: attachment; 
	filename="0001-backing_file_user_security.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mncx4u4t0>
X-Attachment-Id: f_mncx4u4t0

RnJvbSA0ODU4ZjYxMGQ5NjA0NTRhYjRkZTBmMjlmMzU1NzAxNmU4MDg0OGJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDMwIE1hciAyMDI2IDA4OjI2OjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gYmFj
a2luZ19maWxlX3VzZXJfc2VjdXJpdHkKCi0tLQogZnMvZmlsZV90YWJsZS5jICAgIHwgNDcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogaW5jbHVkZS9saW51
eC9mcy5oIHwgIDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMvZmlsZV90YWJsZS5j
CmluZGV4IDBiZGMyNmNhZTEzODkuLjQ2NjZlODhiYTY4N2QgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGVf
dGFibGUuYworKysgYi9mcy9maWxlX3RhYmxlLmMKQEAgLTQzLDE0ICs0MywxOSBAQCBzdGF0aWMg
c3RydWN0IGttZW1fY2FjaGUgKmJmaWxwX2NhY2hlcCBfX3JvX2FmdGVyX2luaXQ7CiAKIHN0YXRp
YyBzdHJ1Y3QgcGVyY3B1X2NvdW50ZXIgbnJfZmlsZXMgX19jYWNoZWxpbmVfYWxpZ25lZF9pbl9z
bXA7CiAKLS8qIENvbnRhaW5lciBmb3IgYmFja2luZyBmaWxlIHdpdGggb3B0aW9uYWwgdXNlciBw
YXRoICovCisvKiBDb250YWluZXIgZm9yIGJhY2tpbmcgZmlsZSB3aXRoIG9wdGlvbmFsIHVzZXIg
cGF0aCBhbmQgc2VjdXJpdHkgYmxvYiAqLwogc3RydWN0IGJhY2tpbmdfZmlsZSB7CiAJc3RydWN0
IGZpbGUgZmlsZTsKIAl1bmlvbiB7CiAJCXN0cnVjdCBwYXRoIHVzZXJfcGF0aDsKIAkJZnJlZXB0
cl90IGJmX2ZyZWVwdHI7CisJCXZvaWQgKmR1bW15X3NlY3VyaXR5OwogCX07Ci0Jdm9pZCAqc2Vj
dXJpdHk7CisjaWZkZWYgQ09ORklHX1NFQ1VSSVRZCisJdm9pZCAqdXNlcl9zZWN1cml0eTsKKyNl
bHNlCisjZGVmaW5lIHVzZXJfc2VjdXJpdHkgZHVtbXlfc2VjdXJpdHkKKyNlbmRpZgogfTsKIAog
I2RlZmluZSBiYWNraW5nX2ZpbGUoZikgY29udGFpbmVyX29mKGYsIHN0cnVjdCBiYWNraW5nX2Zp
bGUsIGZpbGUpCkBAIC02Nyw5ICs3MiwxNiBAQCB2b2lkIGJhY2tpbmdfZmlsZV9zZXRfdXNlcl9w
YXRoKHN0cnVjdCBmaWxlICpmLCBjb25zdCBzdHJ1Y3QgcGF0aCAqcGF0aCkKIH0KIEVYUE9SVF9T
WU1CT0xfR1BMKGJhY2tpbmdfZmlsZV9zZXRfdXNlcl9wYXRoKTsKIAotdm9pZCAqYmFja2luZ19m
aWxlX3NlY3VyaXR5KGNvbnN0IHN0cnVjdCBmaWxlICpmKQordm9pZCAqYmFja2luZ19maWxlX3Vz
ZXJfc2VjdXJpdHkoc3RydWN0IGZpbGUgKmYpCiB7Ci0JcmV0dXJuIGJhY2tpbmdfZmlsZShmKS0+
c2VjdXJpdHk7CisJcmV0dXJuIGJhY2tpbmdfZmlsZShmKS0+dXNlcl9zZWN1cml0eTsKK30KKwor
c3RhdGljIGlubGluZSB2b2lkIGJhY2tpbmdfZmlsZV9mcmVlKHN0cnVjdCBiYWNraW5nX2ZpbGUg
KmZmKQoreworCXNlY3VyaXR5X2JhY2tpbmdfZmlsZV9mcmVlKCZmZi0+dXNlcl9zZWN1cml0eSk7
CisJcGF0aF9wdXQoJmZmLT51c2VyX3BhdGgpOworCWttZW1fY2FjaGVfZnJlZShiZmlscF9jYWNo
ZXAsIGZmKTsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkIGZpbGVfZnJlZShzdHJ1Y3QgZmlsZSAq
ZikKQEAgLTc5LDExICs5MSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBmaWxlX2ZyZWUoc3RydWN0
IGZpbGUgKmYpCiAJCXBlcmNwdV9jb3VudGVyX2RlYygmbnJfZmlsZXMpOwogCXB1dF9jcmVkKGYt
PmZfY3JlZCk7CiAJaWYgKHVubGlrZWx5KGYtPmZfbW9kZSAmIEZNT0RFX0JBQ0tJTkcpKSB7Ci0J
CXN0cnVjdCBiYWNraW5nX2ZpbGUgKmZmID0gYmFja2luZ19maWxlKGYpOwotCi0JCXNlY3VyaXR5
X2JhY2tpbmdfZmlsZV9mcmVlKCZmZi0+c2VjdXJpdHkpOwotCQlwYXRoX3B1dCgmZmYtPnVzZXJf
cGF0aCk7Ci0JCWttZW1fY2FjaGVfZnJlZShiZmlscF9jYWNoZXAsIGZmKTsKKwkJYmFja2luZ19m
aWxlX2ZyZWUoYmFja2luZ19maWxlKGYpKTsKIAl9IGVsc2UgewogCQlrbWVtX2NhY2hlX2ZyZWUo
ZmlscF9jYWNoZXAsIGYpOwogCX0KQEAgLTI5Miw2ICszMDAsMjMgQEAgc3RydWN0IGZpbGUgKmFs
bG9jX2VtcHR5X2ZpbGVfbm9hY2NvdW50KGludCBmbGFncywgY29uc3Qgc3RydWN0IGNyZWQgKmNy
ZWQpCiAJcmV0dXJuIGY7CiB9CiAKK3N0YXRpYyBpbnQgaW5pdF9iYWNraW5nX2ZpbGUoc3RydWN0
IGJhY2tpbmdfZmlsZSAqZmYsCisJCQkgICAgIGNvbnN0IHN0cnVjdCBmaWxlICp1c2VyX2ZpbGUp
Cit7CisJaW50IGVycm9yOworCisJbWVtc2V0KCZmZi0+dXNlcl9wYXRoLCAwLCBzaXplb2YoZmYt
PnVzZXJfcGF0aCkpOworCWZmLT51c2VyX3NlY3VyaXR5ID0gTlVMTDsKKworCWVycm9yID0gc2Vj
dXJpdHlfYmFja2luZ19maWxlX2FsbG9jKCZmZi0+dXNlcl9zZWN1cml0eSwgdXNlcl9maWxlKTsK
KwlpZiAodW5saWtlbHkoZXJyb3IpKSB7CisJCWZwdXQoJmZmLT5maWxlKTsKKwkJcmV0dXJuIEVS
Ul9QVFIoZXJyb3IpOworCX0KKworCXJldHVybiAwOworfQorCiAvKgogICogVmFyaWFudCBvZiBh
bGxvY19lbXB0eV9maWxlKCkgdGhhdCBhbGxvY2F0ZXMgYSBiYWNraW5nX2ZpbGUgY29udGFpbmVy
CiAgKiBhbmQgZG9lc24ndCBjaGVjayBhbmQgbW9kaWZ5IG5yX2ZpbGVzLgpAQCAtMzE1LDEyICsz
NDAsMTQgQEAgc3RydWN0IGZpbGUgKmFsbG9jX2VtcHR5X2JhY2tpbmdfZmlsZShpbnQgZmxhZ3Ms
IGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkLAogCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CiAJfQog
CisJLy8gVGhlIGZfbW9kZSBmbGFncyBtdXN0IGJlIHNldCBiZWZvcmUgZnB1dCgpCiAJZmYtPmZp
bGUuZl9tb2RlIHw9IEZNT0RFX0JBQ0tJTkcgfCBGTU9ERV9OT0FDQ09VTlQ7Ci0JZXJyb3IgPSBz
ZWN1cml0eV9iYWNraW5nX2ZpbGVfYWxsb2MoJmZmLT5zZWN1cml0eSwgdXNlcl9maWxlKTsKKwll
cnJvciA9IGluaXRfYmFja2luZ19maWxlKGZmLCB1c2VyX2ZpbGUpOwogCWlmICh1bmxpa2VseShl
cnJvcikpIHsKIAkJZnB1dCgmZmYtPmZpbGUpOwogCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CiAJ
fQorCiAJcmV0dXJuICZmZi0+ZmlsZTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGFsbG9jX2VtcHR5
X2JhY2tpbmdfZmlsZSk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRl
L2xpbnV4L2ZzLmgKaW5kZXggOGY1NzAyY2ZiNWUwYi4uNjA0NTBhMDc5MGFkZCAxMDA2NDQKLS0t
IGEvaW5jbHVkZS9saW51eC9mcy5oCisrKyBiL2luY2x1ZGUvbGludXgvZnMuaApAQCAtMjQ3NCw3
ICsyNDc0LDcgQEAgc3RydWN0IGZpbGUgKmRlbnRyeV9vcGVuX25vbm90aWZ5KGNvbnN0IHN0cnVj
dCBwYXRoICpwYXRoLCBpbnQgZmxhZ3MsCiBzdHJ1Y3QgZmlsZSAqZGVudHJ5X2NyZWF0ZShzdHJ1
Y3QgcGF0aCAqcGF0aCwgaW50IGZsYWdzLCB1bW9kZV90IG1vZGUsCiAJCQkgICBjb25zdCBzdHJ1
Y3QgY3JlZCAqY3JlZCk7CiBjb25zdCBzdHJ1Y3QgcGF0aCAqYmFja2luZ19maWxlX3VzZXJfcGF0
aChjb25zdCBzdHJ1Y3QgZmlsZSAqZik7Ci12b2lkICpiYWNraW5nX2ZpbGVfc2VjdXJpdHkoY29u
c3Qgc3RydWN0IGZpbGUgKmYpOwordm9pZCAqYmFja2luZ19maWxlX3VzZXJfc2VjdXJpdHkoY29u
c3Qgc3RydWN0IGZpbGUgKmYpOwogCiAvKgogICogV2hlbiBtbWFwcGluZyBhIGZpbGUgb24gYSBz
dGFja2FibGUgZmlsZXN5c3RlbSAoZS5nLiwgb3ZlcmxheWZzKSwgdGhlIGZpbGUKLS0gCjIuNTMu
MAoK
--000000000000495a5d064e39bd4e
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fs-prepare-for-adding-user_security-block-to-backing.patch"
Content-Disposition: attachment; 
	filename="0001-fs-prepare-for-adding-user_security-block-to-backing.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mncxnnsn1>
X-Attachment-Id: f_mncxnnsn1

RnJvbSBjYWQxZGYyODBiY2M5MzUyODljNzg3ZjVmNGRlYjRhMjNlYTIwZmNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBNb24sIDMwIE1hciAyMDI2IDEwOjI3OjUxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZnM6
IHByZXBhcmUgZm9yIGFkZGluZyB1c2VyX3NlY3VyaXR5IGJsb2NrIHRvIGJhY2tpbmdfZmlsZQoK
SW4gcHJlcGFyYXRpb24gdG8gYWRkaW5nIHVzZXJfc2VjdXJpdHkgYmxvYiB0byBiYWNraW5nX2Zp
bGUgc3RydWN0LApmYWN0b3Igb3V0IGhlbHBlcnMgaW5pdF9iYWNraW5nX2ZpbGUoKSBhbmQgYmFj
a2luZ19maWxlX2ZyZWUoKS4KClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+Ci0tLQogZnMvZmlsZV90YWJsZS5jIHwgMjIgKysrKysrKysrKysrKysrKysr
KystLQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZnMvZmlsZV90YWJsZS5jIGIvZnMvZmlsZV90YWJsZS5jCmluZGV4IGFhYTVm
YWFhY2UxZTkuLjllMDJjMWYxNmRiM2MgMTAwNjQ0Ci0tLSBhL2ZzL2ZpbGVfdGFibGUuYworKysg
Yi9mcy9maWxlX3RhYmxlLmMKQEAgLTY2LDYgKzY2LDEyIEBAIHZvaWQgYmFja2luZ19maWxlX3Nl
dF91c2VyX3BhdGgoc3RydWN0IGZpbGUgKmYsIGNvbnN0IHN0cnVjdCBwYXRoICpwYXRoKQogfQog
RVhQT1JUX1NZTUJPTF9HUEwoYmFja2luZ19maWxlX3NldF91c2VyX3BhdGgpOwogCitzdGF0aWMg
aW5saW5lIHZvaWQgYmFja2luZ19maWxlX2ZyZWUoc3RydWN0IGJhY2tpbmdfZmlsZSAqZmYpCit7
CisJcGF0aF9wdXQoJmZmLT51c2VyX3BhdGgpOworCWttZW1fY2FjaGVfZnJlZShiZmlscF9jYWNo
ZXAsIGZmKTsKK30KKwogc3RhdGljIGlubGluZSB2b2lkIGZpbGVfZnJlZShzdHJ1Y3QgZmlsZSAq
ZikKIHsKIAlzZWN1cml0eV9maWxlX2ZyZWUoZik7CkBAIC03Myw4ICs3OSw3IEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBmaWxlX2ZyZWUoc3RydWN0IGZpbGUgKmYpCiAJCXBlcmNwdV9jb3VudGVyX2Rl
YygmbnJfZmlsZXMpOwogCXB1dF9jcmVkKGYtPmZfY3JlZCk7CiAJaWYgKHVubGlrZWx5KGYtPmZf
bW9kZSAmIEZNT0RFX0JBQ0tJTkcpKSB7Ci0JCXBhdGhfcHV0KGJhY2tpbmdfZmlsZV91c2VyX3Bh
dGgoZikpOwotCQlrbWVtX2NhY2hlX2ZyZWUoYmZpbHBfY2FjaGVwLCBiYWNraW5nX2ZpbGUoZikp
OworCQliYWNraW5nX2ZpbGVfZnJlZShiYWNraW5nX2ZpbGUoZikpOwogCX0gZWxzZSB7CiAJCWtt
ZW1fY2FjaGVfZnJlZShmaWxwX2NhY2hlcCwgZik7CiAJfQpAQCAtMjgzLDYgKzI4OCwxMiBAQCBz
dHJ1Y3QgZmlsZSAqYWxsb2NfZW1wdHlfZmlsZV9ub2FjY291bnQoaW50IGZsYWdzLCBjb25zdCBz
dHJ1Y3QgY3JlZCAqY3JlZCkKIAlyZXR1cm4gZjsKIH0KIAorc3RhdGljIGludCBpbml0X2JhY2tp
bmdfZmlsZShzdHJ1Y3QgYmFja2luZ19maWxlICpmZikKK3sKKwltZW1zZXQoJmZmLT51c2VyX3Bh
dGgsIDAsIHNpemVvZihmZi0+dXNlcl9wYXRoKSk7CisJcmV0dXJuIDA7Cit9CisKIC8qCiAgKiBW
YXJpYW50IG9mIGFsbG9jX2VtcHR5X2ZpbGUoKSB0aGF0IGFsbG9jYXRlcyBhIGJhY2tpbmdfZmls
ZSBjb250YWluZXIKICAqIGFuZCBkb2Vzbid0IGNoZWNrIGFuZCBtb2RpZnkgbnJfZmlsZXMuCkBA
IC0zMDUsNyArMzE2LDE0IEBAIHN0cnVjdCBmaWxlICphbGxvY19lbXB0eV9iYWNraW5nX2ZpbGUo
aW50IGZsYWdzLCBjb25zdCBzdHJ1Y3QgY3JlZCAqY3JlZCkKIAkJcmV0dXJuIEVSUl9QVFIoZXJy
b3IpOwogCX0KIAorCS8vIFRoZSBmX21vZGUgZmxhZ3MgbXVzdCBiZSBzZXQgYmVmb3JlIGZwdXQo
KQogCWZmLT5maWxlLmZfbW9kZSB8PSBGTU9ERV9CQUNLSU5HIHwgRk1PREVfTk9BQ0NPVU5UOwor
CWVycm9yID0gaW5pdF9iYWNraW5nX2ZpbGUoZmYpOworCWlmICh1bmxpa2VseShlcnJvcikpIHsK
KwkJZnB1dCgmZmYtPmZpbGUpOworCQlyZXR1cm4gRVJSX1BUUihlcnJvcik7CisJfQorCiAJcmV0
dXJuICZmZi0+ZmlsZTsKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGFsbG9jX2VtcHR5X2JhY2tpbmdf
ZmlsZSk7Ci0tIAoyLjUzLjAKCg==
--000000000000495a5d064e39bd4e--
