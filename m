Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340B1C433F5
	for <selinux@archiver.kernel.org>; Wed,  1 Dec 2021 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbhLAPkK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:40:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234031AbhLAPkJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 1 Dec 2021 10:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638373008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LHtT/evk7iy6Swcl5dGfL3akfQhh8yVRYaMD8xDIhPc=;
        b=R7Q47LHifxbf41tMRrfYtyHMmyUEnWLKCgxzCDB3HyGIf0w83y33SfxNtX4wE/zcY/Zo3E
        Ee/TrBePl4/UE7WGPh2L0ipHh4QVf89mvgxhopPc91FkYVel4+sWXIbbLj7rj0T3yMI9TK
        eiXRZxL4aREsA/uMHNqXc6DabLkzDYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-s8r-mKowM-SShvU1ERhWWA-1; Wed, 01 Dec 2021 10:36:45 -0500
X-MC-Unique: s8r-mKowM-SShvU1ERhWWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EBA410247A9;
        Wed,  1 Dec 2021 15:36:41 +0000 (UTC)
Received: from localhost (unknown [10.40.193.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8686219729;
        Wed,  1 Dec 2021 15:36:40 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?utf-8?Q?G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mcstrans: port to new PCRE2 from end-of-life PCRE
In-Reply-To: <20211130110425.13595-1-cgzones@googlemail.com>
References: <20211123183249.6133-1-cgzones@googlemail.com>
 <20211130110425.13595-1-cgzones@googlemail.com>
Date:   Wed, 01 Dec 2021 16:36:39 +0100
Message-ID: <87sfvc1gmw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Christian G=C3=B6ttsche <cgzones@googlemail.com> writes:

> Quoting pcre.org:
>
>     There are two major versions of the PCRE library. The current
>     version, PCRE2, released in 2015, is now at version 10.39.
>
>     The older, but still widely deployed PCRE library, originally
>     released in 1997, is at version 8.45. This version of PCRE is now at
>     end of life, and is no longer being actively maintained. Version
>     8.45 is expected to be the final release of the older PCRE library,
>     and new projects should use PCRE2 instead.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

There's few minor whitespace issues, see inline.

Other than that

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
> v2:
>    - do not use pcre2_substring_get_bynumber(), fixes NATO mcstrans
>      tests (spotted by Petr Lautrbach)
> ---
>  mcstrans/Makefile       |   6 ++
>  mcstrans/src/Makefile   |   4 +-
>  mcstrans/src/mcstrans.c | 131 ++++++++++++++++++++++++++++------------
>  mcstrans/utils/Makefile |   6 +-
>  4 files changed, 104 insertions(+), 43 deletions(-)
>
> diff --git a/mcstrans/Makefile b/mcstrans/Makefile
> index c993a9f5..b20279ab 100644
> --- a/mcstrans/Makefile
> +++ b/mcstrans/Makefile
> @@ -1,3 +1,9 @@
> +PKG_CONFIG ?=3D pkg-config
> +PCRE_MODULE :=3D libpcre2-8
> +PCRE_CFLAGS :=3D $(shell $(PKG_CONFIG) --cflags $(PCRE_MODULE)) -DPCRE2_=
CODE_UNIT_WIDTH=3D8
> +PCRE_LDLIBS :=3D $(shell $(PKG_CONFIG) --libs $(PCRE_MODULE))
> +export PCRE_MODULE PCRE_CFLAGS PCRE_LDLIBS
> +
>  all:=20
>  	$(MAKE) -C src=20
>  	$(MAKE) -C utils
> diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
> index 76ef0557..ef518625 100644
> --- a/mcstrans/src/Makefile
> +++ b/mcstrans/src/Makefile
> @@ -20,10 +20,10 @@ CFLAGS ?=3D -Wall -W -Wundef -Wmissing-noreturn -Wmis=
sing-format-attribute
>  all: $(PROG)
>=20=20
>  $(PROG): $(PROG_OBJS) $(LIBSEPOLA)
> -	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LDLIBS_LIBSEPOL=
A)
> +	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap $(PCRE_LDLIBS) $(LDLIBS_=
LIBSEPOLA)
>=20=20
>  %.o:  %.c=20
> -	$(CC) $(CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -fPIE -c -o $@ $<
> +	$(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -=
fPIE -c -o $@ $<
>=20=20
>  install: all
>  	test -d $(DESTDIR)$(SBINDIR) || install -m 755 -d $(DESTDIR)$(SBINDIR)
> diff --git a/mcstrans/src/mcstrans.c b/mcstrans/src/mcstrans.c
> index 09577ea0..6e4bfd3b 100644
> --- a/mcstrans/src/mcstrans.c
> +++ b/mcstrans/src/mcstrans.c
> @@ -26,7 +26,7 @@
>  #include <selinux/context.h>
>  #include <syslog.h>
>  #include <errno.h>
> -#include <pcre.h>
> +#include <pcre2.h>
>  #include <ctype.h>
>  #include <time.h>
>  #include <sys/time.h>
> @@ -36,7 +36,6 @@
>  #include "mcstrans.h"
>=20=20
>  #define N_BUCKETS 1453
> -#define OVECCOUNT (512*3)
>=20=20
>  #define log_error(fmt, ...) fprintf(stderr, fmt, __VA_ARGS__)
>=20=20
> @@ -82,9 +81,9 @@ typedef struct word_group {
>  	affix_t *suffixes;
>  	word_t *words;
>=20=20
> -	pcre *prefix_regexp;
> -	pcre *word_regexp;
> -	pcre *suffix_regexp;
> +	pcre2_code *prefix_regexp;
> +	pcre2_code *word_regexp;
> +	pcre2_code *suffix_regexp;
>=20=20
>  	ebitmap_t def;
>=20=20
> @@ -109,7 +108,7 @@ typedef struct domain {
>  	base_classification_t *base_classifications;
>  	word_group_t *groups;
>=20=20
> -	pcre *base_classification_regexp;
> +	pcre2_code *base_classification_regexp;
>  	struct domain *next;
>  } domain_t;
>=20=20
> @@ -317,9 +316,9 @@ destroy_group(word_group_t **list, word_group_t *grou=
p) {
>  	free(group->name);
>  	free(group->sword);
>  	free(group->join);
> -	pcre_free(group->prefix_regexp);
> -	pcre_free(group->word_regexp);
> -	pcre_free(group->suffix_regexp);
> +	pcre2_code_free(group->prefix_regexp);
> +	pcre2_code_free(group->word_regexp);
> +	pcre2_code_free(group->suffix_regexp);
>  	ebitmap_destroy(&group->def);
>  	free(group);
>  }
> @@ -392,7 +391,7 @@ destroy_domain(domain_t *domain) {
>  		free(domain->base_classifications);
>  		domain->base_classifications =3D next;
>  	}
> -	pcre_free(domain->base_classification_regexp);
> +	pcre2_code_free(domain->base_classification_regexp);
>  	while (domain->groups)
>  		destroy_group(&domain->groups, domain->groups);
>  	free(domain->name);
> @@ -963,14 +962,16 @@ word_size(const void *p1, const void *p2) {
>  }
>=20=20
>  static void
> -build_regexp(pcre **r, char *buffer) {
> -	const char *error;
> -	int error_offset;
> +build_regexp(pcre2_code **r, char *buffer) {
> +	int error;
> +	PCRE2_SIZE error_offset;
>  	if (*r)
> -		pcre_free(*r);
> -	*r =3D pcre_compile(buffer, PCRE_CASELESS, &error, &error_offset, NULL);
> -	if (error) {
> -		log_error("pcre=3D%s, error=3D%s\n", buffer, error ? error: "none");
> +		pcre2_code_free(*r);
> +	*r =3D pcre2_compile((PCRE2_SPTR8) buffer, PCRE2_ZERO_TERMINATED, PCRE2=
_CASELESS, &error, &error_offset, NULL);
> +	if (!*r) {
> +		PCRE2_UCHAR errbuf[256];
> +  		pcre2_get_error_message(error, errbuf, sizeof(errbuf));

  SELinuxProject/selinux/master/.git/worktrees/patchwork/rebase-apply/patch=
:127: space before tab in indent.
                  pcre2_get_error_message(error, errbuf, sizeof(errbuf));


> +		log_error("pcre compilation of '%s' failed at offset %zu: %s\n", buffe=
r, error_offset, errbuf);
>  	}
>  	buffer[0] =3D '\0';
>  }
> @@ -1088,12 +1089,12 @@ compute_raw_from_trans(const char *level, domain_=
t *domain) {
>  #endif
>=20=20
>  	int rc =3D 0;
> -	int ovector[OVECCOUNT];
> +	pcre2_match_data *match_data =3D NULL;
>  	word_group_t *g =3D NULL;
>  	char *work =3D NULL;
>  	char *r =3D NULL;
> -	const char * match =3D NULL;
> -	int work_len;
> +	char *match =3D NULL;
> +	size_t work_len;
>  	mls_level_t *mraw =3D NULL;
>  	ebitmap_t set, clear, tmp;
>=20=20
> @@ -1114,11 +1115,20 @@ compute_raw_from_trans(const char *level, domain_=
t *domain) {
>  	if (!domain->base_classification_regexp)
>  		goto err;
>  	log_debug(" compute_raw_from_trans work =3D %s\n", work);
> -	rc =3D pcre_exec(domain->base_classification_regexp, 0, work, work_len,=
 0, PCRE_ANCHORED, ovector, OVECCOUNT);
> +	match_data =3D pcre2_match_data_create_from_pattern(domain->base_classi=
fication_regexp, NULL);
> +	if (!match_data) {
> +		log_error("allocation error %s", strerror(errno));
> +		goto err;
> +	}
> +	rc =3D pcre2_match(domain->base_classification_regexp, (PCRE2_SPTR8)wor=
k, work_len, 0, PCRE2_ANCHORED, match_data, NULL);
>  	if (rc > 0) {
> -		match =3D NULL;
> -		pcre_get_substring(work, ovector, rc, 0, &match);
> -		log_debug(" compute_raw_from_trans match =3D %s len =3D %u\n", match, =
strlen(match));
> +		const PCRE2_SIZE *ovector =3D pcre2_get_ovector_pointer(match_data);
> +		match =3D strndup(work + ovector[0], ovector[1] - ovector[0]);
> +		if (!match) {
> +			log_error("allocation error %s", strerror(errno));
> +			goto err;
> +		}
> +		log_debug(" compute_raw_from_trans match =3D %s len =3D %zu\n", match,=
 strlen(match));
>  		base_classification_t *bc;
>  		for (bc =3D domain->base_classifications; bc; bc =3D bc->next) {
>  			if (!strcmp(bc->trans, match)) {
> @@ -1138,12 +1148,23 @@ compute_raw_from_trans(const char *level, domain_=
t *domain) {
>  		char *p=3Dwork + ovector[0] + ovector[1];
>  		while (*p && (strchr(" 	", *p) !=3D NULL))
>  			*p++ =3D '#';
> -		pcre_free((char *)match);
> +
> +		free(match);
>  		match =3D NULL;
>  	} else {
> -		log_debug(" compute_raw_from_trans no base classification matched %s\n=
", level);
> +		switch (rc) {
> +		case PCRE2_ERROR_NOMATCH:
> +			log_debug(" compute_raw_from_trans no base classification matched %s\=
n", level);
> +			break;
> +		default:
> +			log_error("compute_raw_from_trans: base matching error for input '%s'=
: %d\n", level, rc);
> +			break;
> +		}=09=09
>  	}
>

  SELinuxProject/selinux/master/.git/worktrees/patchwork/rebase-apply/patch=
:190: trailing whitespace.



>=20=20
> +	pcre2_match_data_free(match_data);
> +	match_data =3D NULL;
> +
>  	if (mraw =3D=3D NULL) {
>  		goto err;
>  	}
> @@ -1154,23 +1175,43 @@ compute_raw_from_trans(const char *level, domain_=
t *domain) {
>  		change =3D 0;
>  		for (g =3D domain->groups; g && !change && !complete; g =3D g->next) {
>  			int prefix =3D 0, suffix =3D 0;
> -			int prefix_offset =3D 0, prefix_len =3D 0;
> -			int suffix_offset =3D 0, suffix_len =3D 0;
> +			PCRE2_SIZE prefix_offset =3D 0, prefix_len =3D 0;
> +			PCRE2_SIZE suffix_offset =3D 0, suffix_len =3D 0;
>  			if (g->prefix_regexp) {
> -				rc =3D pcre_exec(g->prefix_regexp, 0, work, work_len, 0, 0, ovector,=
 OVECCOUNT);
> +				match_data =3D pcre2_match_data_create_from_pattern(g->prefix_regexp=
, NULL);
> +				if (!match_data) {
> +					log_error("allocation error %s", strerror(errno));
> +					goto err;
> +				}
> +				rc =3D pcre2_match(g->prefix_regexp, (PCRE2_SPTR8)work, work_len, 0,=
 0, match_data, NULL);
>  				if (rc > 0) {
> +					const PCRE2_SIZE *ovector =3D pcre2_get_ovector_pointer(match_data);
>  					prefix =3D 1;
>  					prefix_offset =3D ovector[0];
>  					prefix_len =3D ovector[1] - ovector[0];
> +				} else if (rc !=3D PCRE2_ERROR_NOMATCH) {
> +					log_error("compute_raw_from_trans: prefix matching error for input =
'%s': %d\n", level, rc);
>  				}
> +				pcre2_match_data_free(match_data);
> +				match_data =3D NULL;
>  			}
>  			if (g->suffix_regexp) {
> -				rc =3D pcre_exec(g->suffix_regexp, 0, work, work_len, 0, 0, ovector,=
 OVECCOUNT);
> +				match_data =3D pcre2_match_data_create_from_pattern(g->suffix_regexp=
, NULL);
> +				if (!match_data) {
> +					log_error("allocation error %s", strerror(errno));
> +					goto err;
> +				}
> +				rc =3D pcre2_match(g->suffix_regexp, (PCRE2_SPTR8)work, work_len, 0,=
 0, match_data, NULL);
>  				if (rc > 0) {
> +					const PCRE2_SIZE *ovector =3D pcre2_get_ovector_pointer(match_data);
>  					suffix =3D 1;
>  					suffix_offset =3D ovector[0];
>  					suffix_len =3D ovector[1] - ovector[0];
> +				} else if (rc !=3D PCRE2_ERROR_NOMATCH) {
> +					log_error("compute_raw_from_trans: suffix matching error for input =
'%s': %d\n", level, rc);
>  				}
> +				pcre2_match_data_free(match_data);
> +				match_data =3D NULL;
>  			}
>=20=20
>  /* anchors prefix ^, suffix $ */
> @@ -1179,14 +1220,23 @@ compute_raw_from_trans(const char *level, domain_=
t *domain) {
>  			     (g->suffixes && suffix)) &&
>  			     g->word_regexp) {
>  				char *s =3D work + prefix_offset + prefix_len;
> -				int l =3D (suffix_len ? suffix_offset : work_len) - prefix_len - pre=
fix_offset;
> -				rc =3D pcre_exec(g->word_regexp, 0, s, l, 0, 0, ovector, OVECCOUNT);
> +				PCRE2_SIZE len =3D (suffix_len ? suffix_offset : work_len) - prefix_=
len - prefix_offset;
> +				match_data =3D pcre2_match_data_create_from_pattern(g->word_regexp, =
NULL);
> +				if (!match_data) {
> +					log_error("allocation error %s", strerror(errno));
> +					goto err;
> +				}
> +				rc =3D pcre2_match(g->word_regexp, (PCRE2_SPTR8)s, len, 0, 0, match_=
data, NULL);
>  				if (rc > 0) {
> -					match =3D NULL;
> -					pcre_get_substring(s, ovector, rc, 0, &match);
> -					trim((char *)match, g->whitespace);
> +					const PCRE2_SIZE *ovector =3D pcre2_get_ovector_pointer(match_data);
> +					match =3D strndup(s + ovector[0], ovector[1] - ovector[0]);
> +					if (!match) {
> +						log_error("allocation error %s", strerror(errno));
> +						goto err;
> +					}
> +					trim(match, g->whitespace);
>  					if (*match) {
> -						char *p =3D triml((char *)match, g->whitespace);
> +						char *p =3D triml(match, g->whitespace);
>  						while (p && *p) {
>  							int plen =3D strlen(p);
>  							unsigned int i;
> @@ -1223,9 +1273,13 @@ compute_raw_from_trans(const char *level, domain_t=
 *domain) {
>  						memset(work + suffix_offset, '#', suffix_len);
>  						memset(s + ovector[0], '#', ovector[1] - ovector[0]);
>  					}
> -					pcre_free((void *)match);
> +					free(match);
>  					match =3D NULL;
> +				} else if (rc !=3D PCRE2_ERROR_NOMATCH) {
> +					log_error("compute_raw_from_trans: word matching error for input '%=
s' for substring '%s': %d\n", level, s, rc);
>  				}
> +				pcre2_match_data_free(match_data);
> +				match_data =3D NULL;
>  			}
>  /* YYY */
>  			complete=3D1;
> @@ -1264,10 +1318,11 @@ err:
>  	mls_level_destroy(mraw);
>  	free(mraw);
>  	free(work);
> -	pcre_free((void *)match);
> +	free(match);
>  	ebitmap_destroy(&tmp);
>  	ebitmap_destroy(&set);
>  	ebitmap_destroy(&clear);
> +	pcre2_match_data_free(match_data);
>  	return NULL;
>  }
>=20=20
> diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
> index 9dfe7723..a48f4e72 100644
> --- a/mcstrans/utils/Makefile
> +++ b/mcstrans/utils/Makefile
> @@ -14,13 +14,13 @@ endif
>  all: $(TARGETS)
>=20=20
>  transcon: transcon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOLA)
> -	$(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
> +	$(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSEPOLA)
>=20=20
>  untranscon: untranscon.o ../src/mcstrans.o ../src/mls_level.o $(LIBSEPOL=
A)
> -	$(CC) $(LDFLAGS) -o $@ $^ -lpcre -lselinux $(LDLIBS_LIBSEPOLA)
> +	$(CC) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -lselinux $(LDLIBS_LIBSEPOLA)
>=20=20
>  %.o:  %.c=20
> -	$(CC) $(CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
> +	$(CC) $(CFLAGS) $(PCRE_CFLAGS) -D_GNU_SOURCE -I../src -fPIE -c -o $@ $<
>=20=20
>  install: all
>  	-mkdir -p $(DESTDIR)$(SBINDIR)
> --=20
> 2.34.1

