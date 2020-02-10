Return-Path: <SRS0=Rep/=36=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB2C35254
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 19:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806F920842
	for <selinux@archiver.kernel.org>; Mon, 10 Feb 2020 19:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F41JYXLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBJTKb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:10:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726831AbgBJTKa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Feb 2020 14:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581361830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TESQzFtippnPQdv3pNvrJQ1KgPUfe8GJwYqcHNwkflM=;
        b=F41JYXLgfuEmDIKkyLs44VQslbLE7VXjud2xpU6/d1nLJpj8ETEiKfX78RC7Vkyvjf/x6X
        NL/u6XVT+54HozXcwwwMsAnhbHbfj4ze4EdQ+3wWe98I+ax2eFL0TL5Cun0eTIyq1sLsP/
        QvZaT4NxYR2CxBRbP0rrA1/HWMx2kbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-w1X8IQ7YMwagsW38OrFMOA-1; Mon, 10 Feb 2020 14:10:25 -0500
X-MC-Unique: w1X8IQ7YMwagsW38OrFMOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87149DBA6;
        Mon, 10 Feb 2020 19:10:24 +0000 (UTC)
Received: from localhost (ovpn-204-56.brq.redhat.com [10.40.204.56])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 122E710013A7;
        Mon, 10 Feb 2020 19:10:23 +0000 (UTC)
References: <20200210182302.352398-1-plautrba@redhat.com>
 <5e88f99a-555c-9467-4cb4-6949b7cfdc98@tycho.nsa.gov>
User-agent: mu4e 1.2.0; emacs 27.0.60
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH v4] libselinux: Eliminate use of security_compute_user()
In-reply-to: <5e88f99a-555c-9467-4cb4-6949b7cfdc98@tycho.nsa.gov>
Date:   Mon, 10 Feb 2020 20:10:22 +0100
Message-ID: <pjdr1z28di9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Stephen Smalley <sds@tycho.nsa.gov> writes:

> On 2/10/20 1:23 PM, Petr Lautrbach wrote:
>> get_ordered_context_list() code used to ask the kernel to compute the complete
>> set of reachable contexts using /sys/fs/selinux/user aka
>> security_compute_user(). This set can be so huge so that it doesn't fit into a
>> kernel page and security_compute_user() fails. Even if it doesn't fail,
>> get_ordered_context_list() throws away the vast majority of the returned
>> contexts because they don't match anything in
>> /etc/selinux/targeted/contexts/default_contexts or
>> /etc/selinux/targeted/contexts/users/
>> get_ordered_context_list() is rewritten to compute set of contexts based on
>> /etc/selinux/targeted/contexts/users/ and
>> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
>> contexts, using security_check_context(), from this set.
>> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>
>> diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
>> index 689e46589f30..fb53fd436650 100644
>> --- a/libselinux/src/get_context_list.c
>> +++ b/libselinux/src/get_context_list.c
>> @@ -243,23 +222,84 @@ static int get_context_order(FILE * fp,
>>   		if (*end)
>>   			*end++ = 0;
>>   -		/* Check for a match in the reachable list. */
>> -		rc = find_partialcon(reachable, nreach, start);
>> -		if (rc < 0) {
>> -			/* No match, skip it. */
>> +		/* Check whether a new context is valid */
>> +		if (SIZE_MAX - user_len < strlen(start) + 2) {
>> +			fprintf(stderr, "%s: one of partial contexts is too big\n", __FUNCTION__);
>> +			errno = EINVAL;
>> +			rc = -1;
>> +			goto out;
>> +		}
>> +		usercon_len = user_len + strlen(start) + 2;
>> +		usercon_str = malloc(usercon_len);
>> +		if (!usercon_str) {
>> +			rc = -1;
>> +			goto out;
>> +		}
>> +
>> +		/* set range from fromcon in the new usercon */
>> +		snprintf(usercon_str, usercon_len, "%s:%s", user, start);
>> +		usercon = context_new(usercon_str);
>> +		if (!usercon) {
>> +			if (errno != EINVAL) {
>> +				free(usercon_str);
>> +				rc = -1;
>> +				goto out;
>> +			}
>> +			fprintf(stderr,
>> +				"%s: can't create a context from %s, skipping\n",
>> +				__FUNCTION__, usercon_str);
>> +			free(usercon_str);
>>   			start = end;
>>   			continue;
>
> Feel free to make this a fatal error too; I can't see a valid scenario for it.
> The only cases where context_new() can fail are a syntactically invalid context
> or out of memory.

My idea was that if there's a wrong entry, it would be better to skip it
and try to parse and use the rest.

>>   		}
>
> I think we could lift the free(usercon_str); to here or even immediately after
> the context_new() if we stopped including it in the error message above.  Then
> we don't have to repeat it below multiple times.

I'd like to preserve this string in the error message as it can help users with
investigation problem when there's a wrong syntax or typo.


>> +		if (context_range_set(usercon, fromlevel) != 0) {
>> +			free(usercon_str);
>> +			context_free(usercon);
>> +			rc = -1;
>> +			goto out;
>> +		}
>> +		free(usercon_str);
>> +		usercon_str = context_str(usercon);
>> +		if (!usercon_str) {
>> +			context_free(usercon);
>> +			rc = -1;
>> +			goto out;
>> +		}
>>   -		/* If a match is found and the entry is not already ordered
>> -		   (e.g. due to prior match in prior config file), then set
>> -		   the ordering for it. */
>> -		i = rc;
>> -		if (ordering[i] == nreach)
>> -			ordering[i] = (*nordered)++;
>> +		/* check whether usercon is already in reachable */
>> +		if (is_in_reachable(*reachable, usercon_str)) {
>> +			start = end;
>
> Still need a context_free(usercon); here in order to avoid leaking its memory.
>

I'm sorry I missed it. It will be fixed in the next patch version (hopefully)

>> +			continue;
>
> [...]


-- 
()  ascii ribbon campaign - against html e-mail 
/\  www.asciiribbon.org   - against proprietary attachments

