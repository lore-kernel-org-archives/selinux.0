Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811457;
	b=PvaZjRh5erPJKsvkxn1ZTj6R5LDxCj/W9RmsQklAyzINT5LKKUMILIrjK82TZsabjWAj
	 6SayKkoN+tHLsBmuCtNN5nSmJf55xhDVzUidCbNTM/EJwphGn3u/oD7/Ghng4LqTLtOLP
	 +1c6sASPJENR/+NUSxBkIqkWe+1UJWgbRRbzO57yLMPTKiYdfBNYldJa11jhY0AfD1yx7
	 izT0Eg1G/na3qzC76WspIQ7ntUpOBsGo9klRCHYvbQ2x+bvOJ8a9yneWd4c3oYGSiyVEE
	 U95Uk+0/Fy7hqHWlnQhv+2ohKLlXeZYMTLq9M0wlbkKGOk8nXF9vkxzSQpVki3no29Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811457;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
	 X-Scanned-By;
	bh=eNIIodvQGs1YyVXXek3ZQiDvHWcAkjdUXyHCnmBJ76k=;
	b=MsytqYX5Ej22qK30jtbfjbGtGAhSQk5WR9kOwi+UEMULlfPX5YpQ2fauvoA+omvnBJoH
	 1xZhKIo9Yw62XCrY858eaFDdDLujaOjBgrhwlktHGTg9dlqhE0v2DZHu1Pp8VjiGM+paD
	 gQo9oCMv5FmIeMZT/vBe+pTHJIMmuzk1AZC/b3F9a1OlIy3GwDmWo34MnjtgooQku5Bm+
	 SlowpsglFOlD3sNyu8HPez4BIQhXohE4gELU3AbkG7+bTd92JNwYTU7NF3cT3OO8u5mPd
	 QGALw2tU1eRX2oO10W6b2hdbUuJVlnDYZVh9529ss5YqLxDjBxK4JuQWd9cDounDc3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EvoA20zu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193B606EE80
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 16:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2193B606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EvoA20zu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793811454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eNIIodvQGs1YyVXXek3ZQiDvHWcAkjdUXyHCnmBJ76k=;
	b=EvoA20zu8LwmkmTzMjDNGMWLnxtaoErKIm5njR6xQUjVeSACb0ohzpMbbot3h5XKVbcAOA
	bxSEmtkVMVfuvrCcEG8wow2Jg4JnwhWKSSR2G0Uo6GhGm8HL/jfVOWeysBHEIkfIfJTn4b
	a1gSbJ56sVrLwCFrlJ0ZcNUm8243kZo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-2bfjmZqHMymr2be3bpOsrA-1; Wed,
 04 Nov 2026 11:57:29 -0500
X-MC-Unique: 2bfjmZqHMymr2be3bpOsrA-1
X-Mimecast-MFC-AGG-ID: 2bfjmZqHMymr2be3bpOsrA_1793811446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7FB941956095;
	Wed,  4 Nov 2026 16:57:26 +0000 (UTC)
Received: from plautrba-thinkpadp16vgen1.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5CA87195608A;
	Wed,  4 Nov 2026 16:57:23 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, selinux@vger.kernel.org
Cc: omosnacek@gmail.com, jason@perfinion.com, jwcart2@gmail.com,
 cahu@suse.de, jsegitz@suse.de, tweek@google.com, Stephen Smalley
 <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v3 20/20] libselinux: free shared regex contexts on
 library unload
In-Reply-To: <20261104150915.175923-20-stephen.smalley.work@gmail.com>
References: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
 <20261104150915.175923-20-stephen.smalley.work@gmail.com>
Date: Wed, 04 Nov 2026 17:57:20 +0100
Message-ID: <pjdh5hwpma7.fsf@plautrba-thinkpadp16vgen1.rmtcz.csb>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> The PCRE2 compile and match contexts are allocated once and shared across
> regexes, but neither is freed when libselinux is unloaded. Repeatedly
> loading the library, performing lookups and unloading it leaks one of each
> context per cycle, even when all lookup threads exit before unload.
>
> Free both shared contexts in the existing PCRE2 destructor. The PCRE2 free
> functions accept NULL, including when initialization was never attempted
> or allocation failed. Leave thread-local match-data ownership unchanged.
>
> Add a full-library dlopen regression test covering repeated lookups and
> unloads, unused loads, failed shared-context allocations, per-call compile
> context fallback, and JIT on/off. Join workers before dlclose so thread-local
> destructors run while the library is still loaded.
>
> Fixes: 92af7f1b61db ("libselinux: prevent ReDoS in file context regex matching")
> Fixes: c42116d304b6 ("libselinux: fix incorrect regexp anchoring")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>

This series has been merged.

> ---
>  libselinux/src/regex.c                        |   2 +
>  libselinux/tests/.gitignore                   |   1 +
>  libselinux/tests/Makefile                     |   7 +-
>  .../tests/test_regex_context_lifetime.c       | 192 ++++++++++++++++++
>  4 files changed, 201 insertions(+), 1 deletion(-)
>  create mode 100644 libselinux/tests/test_regex_context_lifetime.c
>
> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
> index 352767c9..3891610a 100644
> --- a/libselinux/src/regex.c
> +++ b/libselinux/src/regex.c
> @@ -292,6 +292,8 @@ static void match_data_key_init(void)
>  
>  static void __attribute__((destructor)) match_data_key_destroy(void)
>  {
> +	pcre2_compile_context_free(compile_context);
> +	pcre2_match_context_free(match_context);
>  	if (match_data_key_created) {
>  		__selinux_key_delete(match_data_key);
>  		match_data_key_created = 0;
> diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
> index deaac265..6cc9309b 100644
> --- a/libselinux/tests/.gitignore
> +++ b/libselinux/tests/.gitignore
> @@ -18,3 +18,4 @@ test-restorecon-digest
>  /test-match-limit
>  /test-avc-lock-failure
>  /test-descendant-oom
> +/test-regex-context-lifetime
> diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
> index 6c146b07..c229e540 100644
> --- a/libselinux/tests/Makefile
> +++ b/libselinux/tests/Makefile
> @@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
>  
>  .PHONY: test clean
> -test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure test-descendant-oom
> +test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure test-descendant-oom test-regex-context-lifetime
>  	./test-restorecon-digest
>  	./test-restorecon-errors
>  	./test-restorecon-errno
> @@ -42,6 +42,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
>  	./test-match-limit
>  	./test-avc-lock-failure
>  	./test-descendant-oom
> +	./test-regex-context-lifetime ../src/libselinux.so.1
>  
>  clean:
>  	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
> @@ -53,6 +54,7 @@ clean:
>  	rm -f test-match-limit
>  	rm -f test-avc-lock-failure
>  	rm -f test-descendant-oom
> +	rm -f test-regex-context-lifetime
>  
>  test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
> @@ -103,3 +105,6 @@ test-avc-lock-failure: test_avc_lock_failure.c ../src/libselinux.a
>  
>  test-descendant-oom: test_descendant_oom.c ../src/libselinux.a
>  	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=malloc,--wrap=free,--wrap=getxattr $(PCRE_LDLIBS) -ldl -pthread
> +
> +test-regex-context-lifetime: test_regex_context_lifetime.c
> +	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< -Wl,--export-dynamic,--no-as-needed $(PCRE_LDLIBS) -ldl -pthread
> diff --git a/libselinux/tests/test_regex_context_lifetime.c b/libselinux/tests/test_regex_context_lifetime.c
> new file mode 100644
> index 00000000..71a0bf87
> --- /dev/null
> +++ b/libselinux/tests/test_regex_context_lifetime.c
> @@ -0,0 +1,192 @@
> +#define _GNU_SOURCE
> +#define PCRE2_CODE_UNIT_WIDTH 8
> +#include <assert.h>
> +#include <dlfcn.h>
> +#include <errno.h>
> +#include <pcre2.h>
> +#include <pthread.h>
> +#include <selinux/label.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +static void *live[32];
> +static unsigned kinds[32], allocated[2], freed[2], failures[2];
> +static unsigned fail_compile, fail_match, jit;
> +static void *library;
> +static const char *file;
> +
> +static void track(void *ptr, unsigned kind)
> +{
> +	unsigned i;
> +	assert(ptr);
> +	for (i = 0; i < 32 && live[i]; i++) {
> +	}
> +	assert(i < 32);
> +	live[i] = ptr;
> +	kinds[i] = kind;
> +	allocated[kind]++;
> +}
> +
> +static void untrack(void *ptr, unsigned kind)
> +{
> +	if (!ptr)
> +		return;
> +	unsigned i;
> +	for (i = 0; i < 32 && live[i] != ptr; i++) {
> +	}
> +	assert(i < 32 && kinds[i] == kind);
> +	live[i] = NULL;
> +	freed[kind]++;
> +}
> +
> +pcre2_compile_context *
> +pcre2_compile_context_create_8(pcre2_general_context *ctx);
> +pcre2_match_context *pcre2_match_context_create_8(pcre2_general_context *ctx);
> +void pcre2_compile_context_free_8(pcre2_compile_context *ptr);
> +void pcre2_match_context_free_8(pcre2_match_context *ptr);
> +
> +pcre2_compile_context *
> +pcre2_compile_context_create_8(pcre2_general_context *ctx)
> +{
> +	if (fail_compile) {
> +		fail_compile--;
> +		failures[0]++;
> +		errno = ENOMEM;
> +		return NULL;
> +	}
> +	pcre2_compile_context *(*fn)(pcre2_general_context *) =
> +		dlsym(RTLD_NEXT, "pcre2_compile_context_create_8");
> +	assert(fn);
> +	pcre2_compile_context *ptr = fn(ctx);
> +	track(ptr, 0);
> +	return ptr;
> +}
> +
> +pcre2_match_context *pcre2_match_context_create_8(pcre2_general_context *ctx)
> +{
> +	if (fail_match) {
> +		fail_match--;
> +		failures[1]++;
> +		errno = ENOMEM;
> +		return NULL;
> +	}
> +	pcre2_match_context *(*fn)(pcre2_general_context *) =
> +		dlsym(RTLD_NEXT, "pcre2_match_context_create_8");
> +	assert(fn);
> +	pcre2_match_context *ptr = fn(ctx);
> +	track(ptr, 1);
> +	return ptr;
> +}
> +
> +void pcre2_compile_context_free_8(pcre2_compile_context *ptr)
> +{
> +	void (*fn)(pcre2_compile_context *) =
> +		dlsym(RTLD_NEXT, "pcre2_compile_context_free_8");
> +	assert(fn);
> +	untrack(ptr, 0);
> +	fn(ptr);
> +}
> +
> +void pcre2_match_context_free_8(pcre2_match_context *ptr)
> +{
> +	void (*fn)(pcre2_match_context *) =
> +		dlsym(RTLD_NEXT, "pcre2_match_context_free_8");
> +	assert(fn);
> +	untrack(ptr, 1);
> +	fn(ptr);
> +}
> +
> +static void *worker(void *unused)
> +{
> +	(void)unused;
> +	struct selabel_handle *(*openfn)(unsigned, const struct selinux_opt *,
> +					 unsigned) =
> +		dlsym(library, "selabel_open");
> +	int (*lookupfn)(struct selabel_handle *, char **, const char *, int) =
> +		dlsym(library, "selabel_lookup_raw");
> +	void (*closefn)(struct selabel_handle *) =
> +		dlsym(library, "selabel_close");
> +	assert(openfn && lookupfn && closefn);
> +	struct selinux_opt opts[] = {
> +		{ SELABEL_OPT_PATH, file },
> +		{ SELABEL_OPT_BASEONLY, "1" },
> +		{ SELABEL_OPT_JIT, jit ? "1" : NULL },
> +	};
> +	struct selabel_handle *h = openfn(SELABEL_CTX_FILE, opts, 3);
> +	assert(h);
> +	for (unsigned i = 0; i < 3; i++) {
> +		char *ctx = NULL;
> +		assert(lookupfn(h, &ctx, "/test/leaf", 0) == 0);
> +		assert(!strcmp(ctx, "system_u:object_r:test_t:s0"));
> +		free(ctx);
> +	}
> +	closefn(h);
> +	return NULL;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	assert(argc == 2);
> +	char path[] = "/tmp/selinux-regex-context-XXXXXX";
> +	int fd = mkstemp(path);
> +	assert(fd >= 0);
> +	FILE *fp = fdopen(fd, "we");
> +	assert(fp && fputs("/test/.* system_u:object_r:test_t:s0\n", fp) >= 0 &&
> +	       fclose(fp) == 0);
> +	file = path;
> +	unsigned cases = 0;
> +	for (jit = 0; jit < 2; jit++) {
> +		for (unsigned mode = 0; mode < 5; mode++) {
> +			for (unsigned cycle = 0; cycle < 3; cycle++) {
> +				memset(allocated, 0, sizeof(allocated));
> +				memset(freed, 0, sizeof(freed));
> +				memset(failures, 0, sizeof(failures));
> +				fail_compile = mode == 2 || mode == 4;
> +				fail_match = mode == 3 || mode == 4;
> +				library =
> +					dlopen(argv[1], RTLD_NOW | RTLD_LOCAL);
> +				if (!library) {
> +					fprintf(stderr, "%s\n", dlerror());
> +					abort();
> +				}
> +				if (mode) {
> +					for (unsigned repeat = 0; repeat < 3;
> +					     repeat++) {
> +						pthread_t thread;
> +						assert(pthread_create(
> +							       &thread, NULL,
> +							       worker,
> +							       NULL) == 0);
> +						assert(pthread_join(thread,
> +								    NULL) == 0);
> +					}
> +					assert(failures[0] ==
> +					       (mode == 2 || mode == 4));
> +					assert(failures[1] ==
> +					       (mode == 3 || mode == 4));
> +					assert(allocated[0] ==
> +					       (failures[0] ? 3U : 1U));
> +					assert(allocated[1] == !failures[1]);
> +					assert(allocated[0] - freed[0] ==
> +					       !failures[0]);
> +					assert(allocated[1] - freed[1] ==
> +					       !failures[1]);
> +				} else {
> +					assert(!allocated[0] && !allocated[1]);
> +				}
> +				/* Join first so all TLS destructors finish before unload. */
> +				assert(dlclose(library) == 0);
> +				assert(!dlopen(argv[1],
> +					       RTLD_NOW | RTLD_NOLOAD));
> +				assert(allocated[0] == freed[0] &&
> +				       allocated[1] == freed[1]);
> +				cases++;
> +			}
> +		}
> +	}
> +	assert(unlink(path) == 0);
> +	printf("regex-context-lifetime: %u unload scenarios passed\n", cases);
> +	return 0;
> +}
> -- 
> 2.56.0

