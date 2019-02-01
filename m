Return-Path: <SRS0=EhYF=QI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A91EC282D8
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 12:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014DC21872
	for <selinux@archiver.kernel.org>; Fri,  1 Feb 2019 12:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbfBAMpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:45:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbfBAMpK (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 1 Feb 2019 07:45:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 212DA4CE9A;
        Fri,  1 Feb 2019 12:45:10 +0000 (UTC)
Received: from workstation (unknown [10.43.12.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65EAF5D787;
        Fri,  1 Feb 2019 12:45:08 +0000 (UTC)
References: <20190131132226.19030-1-plautrba@redhat.com> <20190131132226.19030-3-plautrba@redhat.com> <CAJfZ7=kMpqdfbQ4NfHT_5FbY-63N0O2L1xUMBi2MHMnRB=0Y+Q@mail.gmail.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 3/3] libsemanage: Fix USE_AFTER_FREE defects reported by coverity scan
In-reply-to: <CAJfZ7=kMpqdfbQ4NfHT_5FbY-63N0O2L1xUMBi2MHMnRB=0Y+Q@mail.gmail.com>
Date:   Fri, 01 Feb 2019 13:45:07 +0100
Message-ID: <pjdva23smng.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 01 Feb 2019 12:45:10 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Nicolas Iooss <nicolas.iooss@m4x.org> writes:

> On Thu, Jan 31, 2019 at 2:22 PM Petr Lautrbach 
> <plautrba@redhat.com> wrote:
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  libsemanage/src/direct_api.c | 21 ++++++++-------------
>>  1 file changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/libsemanage/src/direct_api.c 
>> b/libsemanage/src/direct_api.c
>> index c58961be..8e4d116d 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -1028,7 +1028,7 @@ static int 
>> semanage_direct_write_langext(semanage_handle_t *sh,
>>
>>         fp = NULL;
>>
>> -       ret = 0;
>> +       return 0;
>>
>>  cleanup:
>>         if (fp != NULL) fclose(fp);
>> @@ -2177,7 +2177,6 @@ cleanup:
>>         semanage_module_info_destroy(sh, modinfo);
>>         free(modinfo);
>>
>> -       if (fp != NULL) fclose(fp);
>>         return status;
>>  }
>>
>> @@ -2342,16 +2341,6 @@ static int 
>> semanage_direct_get_module_info(semanage_handle_t *sh,
>>         free(tmp);
>>         tmp = NULL;
>>
>> -       if (fclose(fp) != 0) {
>> -               ERR(sh,
>> -                   "Unable to close %s module lang ext file.",
>> -                   (*modinfo)->name);
>> -               status = -1;
>> -               goto cleanup;
>> -       }
>> -
>> -       fp = NULL;
>> -
>>         /* lookup enabled/disabled status */
>>         ret = semanage_module_get_path(sh,
>>                                        *modinfo,
>> @@ -2395,7 +2384,13 @@ cleanup:
>>                 free(modinfos);
>>         }
>>
>> -       if (fp != NULL) fclose(fp);
>> +       if (fp != NULL && fclose(fp) != 0) {
>> +               ERR(sh,
>> +                   "Unable to close %s module lang ext file.",
>> +                   (*modinfo)->name);
>> +               status = -1;
>> +       }
>> +
>>         return status;
>>  }
>>
>> --
>> 2.20.1
>
> After reading this patch, I am wondering what the USE_AFTER_FREE
> defects were about. Were there real use-after-fclose bugs that 
> are
> fixed by this patch? Or is this patch more about silencing 
> Coverity's
> false positives due to difficulties in parsing constructions 
> such as
> "fclose(fp);fp = NULL; if(f != NULL)fclose(fp);"? It would be 
> useful
> if the patch description contains answers to these questions.


Diff between scans before and after shows that it fixes at least 
the two
following defects:

Error: USE_AFTER_FREE (CWE-672):
libsemanage-2.8/src/direct_api.c:2142: freed_arg: "fclose" frees 
"fp".
libsemanage-2.8/src/direct_api.c:2180: use_closed_file: Calling 
"fclose" uses file handle "fp" after closing it.
# 2178|   	free(modinfo);
# 2179|   
# 2180|-> 	if (fp != NULL) fclose(fp);
# 2181|   	return status;
# 2182|   }

Error: USE_AFTER_FREE (CWE-672):
libsemanage-2.8/src/direct_api.c:2345: freed_arg: "fclose" frees 
"fp".
libsemanage-2.8/src/direct_api.c:2398: use_closed_file: Calling 
"fclose" uses file handle "fp" after closing it.
# 2396|   	}
# 2397|   
# 2398|-> 	if (fp != NULL) fclose(fp);
# 2399|   	return status;
# 2400|   }


But it was supposed to fix more defects and reading it again it 
would be
better to assign NULL to fp on line 2349 instead of moving the 
whole
code block to cleanup.

I'll resend new set of patches with better commit messages.

Thanks!

> Otherwise the content of the patch looks good to me.
>
> Nicolas

