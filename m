Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C3449B0C
	for <selinux@vger.kernel.org>; Fri,  4 Sep 2026 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516016; cv=none; b=OOvLIOSfSxO5tv9qdY2m+r6BThcBnFigDKTzNlfOGxQnoxRihadu/bO3RZYnZ6TPlQJd18FVSEuV+cxJDNJOvBd32+x/eG4DMPhy9XnRakiOw8bYuoJv0GPRUntLdbt7itaIh266owuSC3AwombgKu1YVKbwLVdJ7tFzTQP9aQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516016; c=relaxed/simple;
	bh=9/WOEyxFyRr7dLqt71b/czRGeOr/XhZbkbxZni8GFhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XGDzyHWZnrlJ3T/mWFx89hZv8RK6RO9qVEUUf3aPWucB9o4Le75U/LT8yQbGEJCA4FmfteAwk7xHRHsBI+AwlXaAb3iloyVlAXWTLToGRl1eTlaelj7znWRiuXyDVuvySjnLjIGPZdytYjdW4wgm47bhQdEhLph47ufyaNOy6PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDgqcr83; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDgqcr83"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788516013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tlKqIYOzJp2lPSk0ixOdhjEAbZXAk2sFKmONWaOCo+g=;
	b=dDgqcr83ZfmC5qhKq3jCYA+4VazAmLj3AB070Hj4usx70t8u5Vo5C1//Q7H0T7G0ireCNO
	F4bjmxQVDAoq+NaMkmBdPElyRQFn3D36SKdnFVltFBk32z5W6MXu541MghZWF1L76FatbH
	tGtELgwo6I0lbSPfAA36T65Kk21PJJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-6NGXKDaBMg-y_Y_3vPvIdw-1; Fri,
 04 Sep 2026 06:00:11 -0400
X-MC-Unique: 6NGXKDaBMg-y_Y_3vPvIdw-1
X-Mimecast-MFC-AGG-ID: 6NGXKDaBMg-y_Y_3vPvIdw_1788516010
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E06D6195FE10;
	Fri,  4 Sep 2026 10:00:09 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 730E81955F00;
	Fri,  4 Sep 2026 10:00:09 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, =?utf-8?Q?Thi=C3=A9baud?= Weksteen
 <tweek@google.com>, Ondrej
 =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>
Subject: Re: [PATCH v3] Add support for UTF-8 in file context labels
In-Reply-To: <CAEjxPJ7isYB2FekKMubJrDgdCuaRc27w6Rwfo9==BPe0GY4iyQ@mail.gmail.com>
References: <20260903151347.1513631-2-lautrbach@redhat.com>
 <CAEjxPJ7isYB2FekKMubJrDgdCuaRc27w6Rwfo9==BPe0GY4iyQ@mail.gmail.com>
Date: Fri, 04 Sep 2026 12:00:08 +0200
Message-ID: <87o6ed1glz.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Thu, Sep 3, 2026 at 12:00=E2=80=AFPM Petr Lautrbach <lautrbach@redhat.=
com> wrote:
>>
>> - libselinux to be able to read UTF-8 spec entries
>> - libselinux to compile regexes with UTF strings
>> - initialize locales in setfiles, sefcontext_compile, semodule
>> - semanage_exec_prog to execute external programs with LC_CTYPE set to
>> the current environment
>> - disable UTF-8 support build time using DISABLE_UTF=3Dy environment
>> variable
>>
>> Fixes:
>>     # cat unicode.cil
>>     (filecon "/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=BD(/.*)?" any (system_u ob=
ject_r user_home_t ((s0) (s0))))
>>
>>     # semodule -i unicode.cil
>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_=
contexts:  line 2145 error due to: Non-ASCII characters found
>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_=
contexts:  line 2145 error due to: Non-ASCII characters found
>>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invali=
d argument
>>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles return=
ed error code 1.
>>     semodule:  Failed!
>>
>>     # semanage fcontext --add -t user_home_t "/opt/=C5=BElu=C5=A5ou=C4=
=8Dk=C3=BD(/.*)?"
>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_=
contexts.local:  line 4 error due to: Non-ASCII characters found
>>     /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_=
contexts.local:  line 4 error due to: Non-ASCII characters found
>>     /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invali=
d argument
>>     libsemanage.semanage_validate_and_compile_fcontexts: setfiles return=
ed error code 1.
>>     OSError: Error
>>
>> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
>> ---
>
>> diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
>> index d6b5bf0252ba..f632a87275d4 100644
>> --- a/libselinux/src/regex.c
>> +++ b/libselinux/src/regex.c
>> @@ -96,7 +96,12 @@ int regex_prepare_data(struct regex_data **regex, cha=
r const *pattern_string,
>>                 return -1;
>>
>>         (*regex)->regex =3D pcre2_compile((PCRE2_SPTR)pattern_string,
>> -                                       PCRE2_ZERO_TERMINATED, PCRE2_DOT=
ALL,
>> +                                       PCRE2_ZERO_TERMINATED,
>> +#ifdef NO_UTF
>> +                                       PCRE2_DOTALL,
>> +#else
>> +                                       PCRE2_DOTALL | PCRE2_UTF,
>> +#endif
>
> This causes pcre2_match() to validate the subject as UTF-8 on every
> call, which in addition to incurring
> overhead on every file
>

Would you prefer NO_UTF to be default so only distributions which
enabled this would be affected?


> would also cause regex_match() to return REGEX_ERROR and
> label_file.c:lookup_check_node() to fail the whole lookup with errno
> ENOENT. Thus, restorecon on a file
> whose name isn't UTF-8 will error out instead of falling back to
> matching /.* and labeling accordingly.
> If you add PCRE2_MATCH_INVALD_UTF to the flags, then pcre2_match()
> will instead treat invalid bytes
> as "cannot match anything" but can still match literals and character
> classes and will return REGEX_NO_MATCH
> instead of REGEX_ERROR.

I was not able to get it working correctly using filename with invalid
utf8 symbol even with PCRE2_MATCH_INVALID_UTF.

PCRE2_DOTALL without PCRE2_UTF matches anything on byte level for
'.'. The problematic are wildcards. e.g. '/opt/=C5=BElu=C5=A5ou=C4=8Dk=C3=
=BD+'

I'm working in a patch which without PCRE2_UTF but which would allow to
use '(*UTF)' sequence directly in file spec:

# semanage fcontext -a -t etc_t '/opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE+'
# matchpathcon /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE
/opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE        system_u:object_r:usr=
_t:s0

vs

# semanage fcontext -a -t etc_t '(*UTF)/opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE+'
# matchpathcon /opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE
/opt/=C5=BElu=C5=A5ou=C4=8Dk=C5=BE=C5=BE=C5=BE        system_u:object_r:etc=
_t:s0


>> diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/se=
fcontext_compile.c
>> index e504b5084c8d..04c86053b2c8 100644
>> --- a/libselinux/utils/sefcontext_compile.c
>> +++ b/libselinux/utils/sefcontext_compile.c
>> @@ -1,6 +1,7 @@
>>  #include <endian.h>
>>  #include <errno.h>
>>  #include <getopt.h>
>> +#include <locale.h>
>>  #include <stdint.h>
>>  #include <stdio.h>
>>  #include <string.h>
>> @@ -564,6 +565,10 @@ int main(int argc, char *argv[])
>>         struct spec_node *root =3D NULL;
>>         struct sidtab stab =3D {};
>>
>> +       /* Initialize locale for UTF-8 support */
>> +       setlocale(LC_ALL, "");
>> +
>> +
>
> This shouldn't be necessary with the dropping of mbrtowc() and using
> utf8_char_len(); what still needs locale to be set? Ditto for the other
> setlocale() changes.

