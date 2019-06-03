Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B512C04AB5
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4418B26741
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 22:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="cDBWcpgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfFCWFw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 18:05:52 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:29772 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfFCWFw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 18:05:52 -0400
X-EEMSG-check-017: 416786946|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 03 Jun 2019 20:43:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1559594593; x=1591130593;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=QmTWwuwr4Y+7bKyVQ5RA/Wy5TmJ8creUXk1HzCi+B9o=;
  b=cDBWcpggeeSjObVHQ9KH+bCFAHGKAksx1nzELrQQvAvrdnhU+EiE7fz6
   IafAf4x1p488NCDx68312HF42r/C68QZbewiALlZHmfxKD89i829BCX0L
   r1DN87X9pf6KDQ3kdjpUG6izYSyjxq8XrYGTjvB1002yFJl+YPJt1ejEa
   KlYJlNsnTTMFmR1K5KFnSym3Go3OWuzohaft+v0/som9HyP9KfriDqGTY
   DAqlg12KWuRasmJECwEu/0Rnapbl2u8D8uXaul3xHUGTZ4iGF6OSL8rrq
   LTmZjQBnRFlt/QqaWSXFVB9R0iKsoD2aCaZMg/R83uhaAn+Zof/bCLZq8
   g==;
X-IronPort-AV: E=Sophos;i="5.60,548,1549929600"; 
   d="scan'208";a="28499749"
IronPort-PHdr: =?us-ascii?q?9a23=3AhrHvuxXcEepRLdqBjIrv20KXI+LV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSAvqdThVPEFb/W9+hDw7KP9fy5ACpZusnK6SxTOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjMusUMnIdvJKQ8xh?=
 =?us-ascii?q?TUrnZHf+ld2H9lK0+Ukxvg/Mm74YRt8z5Xu/Iv9s5AVbv1cqElRrFGDzooLn?=
 =?us-ascii?q?446tTzuRbMUQWA6H0cUn4LkhVTGAjK8Av6XpbqvSTksOd2xTSXMtf3TbAwXj?=
 =?us-ascii?q?Si8rtrRRr1gyoJKzI17GfagdFrgalFvByuuQBww4/MYIGUKvV+eL/dfcgHTm?=
 =?us-ascii?q?ZFR8pdSjBNDp+5Y4YJAeUBJ+JYpJTjqVUIoxW1GA2gCPrxxjJMg3P727Ax3e?=
 =?us-ascii?q?Y8HgHcxAEuAswAsHrUotv2OqkdX++6w6vUwjvMdP5WxTTw5ZLUfhw9r/yBX7?=
 =?us-ascii?q?R9etfRx0k1EAPFi02dp5H5PzyLzuQNs3aU7+x9Xuyyjm4osQVxojyxycYsl4?=
 =?us-ascii?q?LEgZkVxU3f9Shi3IY0JcG3SE58YdK+FptQrDuVO5F5QsMlXWFloSA3waAIt5?=
 =?us-ascii?q?68eSgF0pUnxxjHZvyEbYeI+BTjW/iVITtig3JlYr2/ihCv+kaj0u3xTtS43V?=
 =?us-ascii?q?lFoyZfktTAq2oB2wLc58SZUPdx40Gs0iuV2Q/J8OFLO0U0mLLeK54m37E/iI?=
 =?us-ascii?q?IesV/GHi/qgEX2i7KWdlk89uio9evnZrLmq4eAN4BukAH+M7kumtelDeQkMg?=
 =?us-ascii?q?kBQ2ib+eOm2L3l4UL5W6lFguczkqnYtJDWPcUbpqinDA9Jyosv9hmyAji83N?=
 =?us-ascii?q?kYgHULNkxJdR2Zg4TzJl3COPX4Au2+g1Sonjdr3ffGPrj5D5XWM3fDi6zsfa?=
 =?us-ascii?q?p96kFAyAozyspT55RPCr4bOv7zVUjxtMLAAh8jLwO02/rnCMl61o4GQ2KPA7?=
 =?us-ascii?q?OWMKPIvl+S++0gO/WDa5cVuDnnKvgl4eDhjWQilFAGYamp3J0XaGymEfR8JU?=
 =?us-ascii?q?WWf2bsjs0dHmcNuwo0VPbqh0GaUT5Pe3ayWLox5iolB4KiDIfDQJ2tgbOa0S?=
 =?us-ascii?q?elEZ1ZeHpGBkqPEXj2bYWEXekDaCaILs9miDwEWqCrS5U92hG2qA/6171nI/?=
 =?us-ascii?q?LP9S0ZsZLj0MJ56PHJmREo8jx7FNqS03uRT2FvhW4ISDo207p+oUx50FuMza?=
 =?us-ascii?q?94g/kLXeBUsslIWQczL5KU7+V7Dd3pElbbf9yJQUyqdd6RATgwSN8q69USYk?=
 =?us-ascii?q?BhFs+kgwyF1C2vVftdjLGPBZop4orC0HXrYcVw0XDL0O8mlVZiCvROMWmnj6?=
 =?us-ascii?q?s3zQ/ZCpTViA3NnaeuceIXmjTK/mqZ0XGms0RRUQo2WqLACyMxfEzT+O/l61?=
 =?us-ascii?q?vCQrnmMrEuNg9M2IbWMadRQsH4hlVBAvH4MZLRZHznyDT4PgqB2r7ZNNmiQG?=
 =?us-ascii?q?4axiiITRFewg0=3D?=
X-IPAS-Result: =?us-ascii?q?A2AUAAAqhfVc/wHyM5BmGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYFmKmpRMyiEFIgciz0CBoEQJYlQjw2BewkBAQEBAQEBAQEtBwECAQGEQ?=
 =?us-ascii?q?AKDEiM0CQ4BAwEBAQQBAQEBAwEBbBwMgjopAYJmAQEBAQIBIw8BBVELGAICJ?=
 =?us-ascii?q?gICVwYBDAYCAQGCXz8BgWoDCQUPD6hcgTGEMgGBFIMmgUAGgQwoAYtZF3iBB?=
 =?us-ascii?q?4ERJwyCMS4+ghqCKoMKglgEkx6VWwmCD4IYhCeMbQYbgiKKc4lZjQCHC5EKO?=
 =?us-ascii?q?IFYKwgCGAghDzuCbBOCBRqIYYVbIwMwAQEBAYECAQGQPAEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 03 Jun 2019 20:43:12 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x53KhA8q031874;
        Mon, 3 Jun 2019 16:43:10 -0400
Subject: Re: [PATCH] selinux: Fix strncpy in libselinux and libsepol
To:     Richard Haines <richard_c_haines@btinternet.com>,
        selinux@vger.kernel.org, William Roberts <bill.c.roberts@gmail.com>
References: <20190531151609.16873-1-richard_c_haines@btinternet.com>
 <d122ef80-dc99-511e-6132-44a4072e4b37@tycho.nsa.gov>
 <d794f7e08a3728706fa3b865b3bae2cfd74afc45.camel@btinternet.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f9b3c3bb-2285-f549-5a99-6182750d1862@tycho.nsa.gov>
Date:   Mon, 3 Jun 2019 16:43:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d794f7e08a3728706fa3b865b3bae2cfd74afc45.camel@btinternet.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/2/19 9:35 AM, Richard Haines wrote:
> On Fri, 2019-05-31 at 15:35 -0400, Stephen Smalley wrote:
>> On 5/31/19 11:16 AM, Richard Haines wrote:
>>> When building with gcc9, get build errors such as:
>>>
>>> genbools.c:24:2: error: ‘strncpy’ output may be truncated copying
>>> 8191
>>> bytes from a string of length 8191 [-Werror=stringop-truncation]
>>>      24 |  strncpy(dest, ptr, size);
>>>         |  ^~~~~~~~~~~~~~~~~~~~~~~~
>>
>> It would be nice if we could just remove all of this code, modulo
>> ABI/API concerns (maybe we could reduce the public interfaces to
>> no-ops?).  It is all legacy code I think, predating kernel 2.6.22
>> (kernel automatically preserves boolean values across policy reload)
>> and
>> the use of libsemanage (managed policy, persistent boolean changes
>> directly applied to the kernel policy file).  Probably not used by
>> anything later than RHEL 4, which should be dead and gone by now I
>> hope.
> 
> Any comments on this list:
> 
> libsepol/src/genusers.c
> 	delete file + cleanup
> 
> libsepol/src/genbools.c
> 	delete file + cleanup
> 
> libselinux/src/load_policy.c
> Remove areas that use:
> 	genbools_array
> 	genusers
> 	genbools
> 	setlocaldefs
> 	preservebools
> 
> libselinux/src/booleans.c
> no-op:
> 	security_load_booleans()
> 
> modify as no need for "int permanent":
> 	security_set_boolean_list()

Yes, we'd keep the argument to preserve API/ABI but drop the code 
handling permanent == 1.  The callers were already updated to use 
libsemanage instead for saving persistent booleans.

> 
> libselinux/src/selinux_config.c
> Remove:
> 	SETLOCALDEFS
> 
> Clean up any leftovers (man pages etc.)

FWIW, see 
https://lore.kernel.org/selinux/1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil/

It never landed upstream since policyrep never merged to master.
Picked up again here:
https://lore.kernel.org/selinux/1201203958.21288.120.camel@moss-spartans.epoch.ncsc.mil/

But RHEL4 was still a concern, so we fell back to just this patch:
https://lore.kernel.org/selinux/1202311592.27371.150.camel@moss-spartans.epoch.ncsc.mil/

I'm hoping we can remove it all now finally.

> 
> 
>>
>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>> ---
>>>    libselinux/src/booleans.c |  4 ++--
>>>    libsepol/src/genbools.c   | 20 +++++++++++---------
>>>    2 files changed, 13 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
>>> index ab1e0754..cdc03517 100644
>>> --- a/libselinux/src/booleans.c
>>> +++ b/libselinux/src/booleans.c
>>> @@ -539,7 +539,7 @@ int security_load_booleans(char *path)
>>>    
>>>    	__fsetlocking(boolf, FSETLOCKING_BYCALLER);
>>>    	while (getline(&inbuf, &len, boolf) > 0) {
>>> -		int ret = process_boolean(inbuf, name, sizeof(name),
>>> &val);
>>> +		int ret = process_boolean(inbuf, name, len, &val);
>>
>> This might fix the warning but is it correct? len is the size of the
>> buffer allocated by getline, which could be larger or smaller than
>> sizeof name and also could be larger than the number of bytes read.
>> process_boolean() seems to want the size of the name buffer as a
>> bound
>> for strncpy() in the strtrim() call. strtrim() also seems to be using
>> it
>> wrongly as a bound for the source aka name1, presuming they are the
>> same
>> size.
>>
> Sent a V2 patch that I hope fixes these.
> 
>>>    		if (ret == -1)
>>>    			errors++;
>>>    		if (ret == 1)
>>> @@ -557,7 +557,7 @@ int security_load_booleans(char *path)
>>>    		int ret;
>>>    		__fsetlocking(boolf, FSETLOCKING_BYCALLER);
>>>    		while (getline(&inbuf, &len, boolf) > 0) {
>>> -			ret = process_boolean(inbuf, name,
>>> sizeof(name), &val);
>>> +			ret = process_boolean(inbuf, name, len, &val);
>>
>> Ditto.
>>
>>>    			if (ret == -1)
>>>    				errors++;
>>>    			if (ret == 1)
>>> diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
>>> index d4a2df62..ad194ca6 100644
>>> --- a/libsepol/src/genbools.c
>>> +++ b/libsepol/src/genbools.c
>>> @@ -10,6 +10,8 @@
>>>    #include "private.h"
>>>    #include "dso.h"
>>>    
>>> +#define FGET_BUFSIZ 255
>>> +
>>>    /* -- Deprecated -- */
>>>    
>>>    static char *strtrim(char *dest, char *source, int size)
>>> @@ -32,7 +34,7 @@ static char *strtrim(char *dest, char *source,
>>> int size)
>>>    
>>>    static int process_boolean(char *buffer, char *name, int
>>> namesize, int *val)
>>>    {
>>> -	char name1[BUFSIZ];
>>> +	char name1[FGET_BUFSIZ];
>>>    	char *ptr = NULL;
>>>    	char *tok;
>>>    
>>> @@ -48,7 +50,7 @@ static int process_boolean(char *buffer, char
>>> *name, int namesize, int *val)
>>>    		ERR(NULL, "illegal boolean definition %s", buffer);
>>>    		return -1;
>>>    	}
>>> -	strncpy(name1, tok, BUFSIZ - 1);
>>> +	strncpy(name1, tok, FGET_BUFSIZ - 1);
>>>    	strtrim(name, name1, namesize - 1);
>>>    
>>>    	tok = strtok_r(NULL, "\0", &ptr);
>>> @@ -79,8 +81,8 @@ static int load_booleans(struct policydb
>>> *policydb, const char *path,
>>>    {
>>>    	FILE *boolf;
>>>    	char *buffer = NULL;
>>> -	char localbools[BUFSIZ];
>>> -	char name[BUFSIZ];
>>> +	char localbools[FGET_BUFSIZ];
>>> +	char name[FGET_BUFSIZ + 1];
>>
>> Similarly seems to be making faulty assumptions about using the same
>> buffer sizes throughout.
>>
>>>    	int val;
>>>    	int errors = 0, changes = 0;
>>>    	struct cond_bool_datum *datum;
>>> @@ -90,12 +92,12 @@ static int load_booleans(struct policydb
>>> *policydb, const char *path,
>>>    		goto localbool;
>>>    
>>>    #ifdef __APPLE__
>>> -        if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL)
>>> {
>>> -          ERR(NULL, "out of memory");
>>> -	  return -1;
>>> +	if ((buffer = (char *)malloc(FGET_BUFSIZ * sizeof(char))) ==
>>> NULL) {
>>> +		ERR(NULL, "out of memory");
>>> +		return -1;
>>>    	}
>>>    
>>> -        while(fgets(buffer, 255, boolf) != NULL) {
>>> +	while (fgets(buffer, FGET_BUFSIZ, boolf) != NULL) {
>>
>> I think this was just a hack to make it build on macOS for
>> Android.  But
>> there is no reason for this code to be used there.  I wouldn't
>> change
>> the other buffer sizes to match.
>>
>>>    #else
>>>    	size_t size = 0;
>>>    	while (getline(&buffer, &size, boolf) > 0) {
>>> @@ -124,7 +126,7 @@ static int load_booleans(struct policydb
>>> *policydb, const char *path,
>>>    
>>>    #ifdef __APPLE__
>>>    
>>> -	  while(fgets(buffer, 255, boolf) != NULL) {
>>> +	while (fgets(buffer, FGET_BUFSIZ, boolf) != NULL) {
>>>    #else
>>>    
>>>    	    while (getline(&buffer, &size, boolf) > 0) {
>>>
> 

