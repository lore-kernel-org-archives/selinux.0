Return-Path: <SRS0=zFQt=PM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB3C43387
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 15:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36B021871
	for <selinux@archiver.kernel.org>; Fri,  4 Jan 2019 15:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfADP5e (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 4 Jan 2019 10:57:34 -0500
Received: from ithil.bigon.be ([163.172.57.153]:40084 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfADP5e (ORCPT <rfc822;selinux@vger.kernel.org>);
        Fri, 4 Jan 2019 10:57:34 -0500
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 4EEAC20F22;
        Fri,  4 Jan 2019 16:57:32 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id hCReicbpmLI9; Fri,  4 Jan 2019 16:57:32 +0100 (CET)
Received: from [10.40.0.63] (mail2.vdab.be [193.53.238.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Fri,  4 Jan 2019 16:57:32 +0100 (CET)
Subject: Re: [PATCH] libsemanage: Always set errno to 0 before calling
 getpwent()
To:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
References: <20190102134639.30515-1-bigon@debian.org>
 <e2da0c12-9e7d-089f-d45a-fba523e6e04f@debian.org>
 <91136ae0462be76415705cb8a014d2a49e59aa85.camel@tycho.nsa.gov>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <3a568434-6d6a-172c-6337-d43ddfb910e1@debian.org>
Date:   Fri, 4 Jan 2019 16:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <91136ae0462be76415705cb8a014d2a49e59aa85.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Le 4/01/19 à 16:11, Stephen Smalley a écrit :
> On Wed, 2019-01-02 at 15:30 +0100, Laurent Bigonville wrote:
>> Le 2/01/19 à 14:46, Laurent Bigonville a écrit :
>>> From: Laurent Bigonville <bigon@bigon.be>
>>>
>>> The manpage explicitly states that:
>>>
>>>     The  getpwent()  function  returns a pointer to a passwd
>>> structure, or
>>>     NULL if there are no more entries or an error occurred.  If an
>>> error
>>>     occurs, errno is set appropriately.  If one wants to check errno
>>> after
>>>     the call, it should be set to zero before the call.
>>>
>>> Without this, genhomedircon can wrongly return the following:
>>>     libsemanage.get_home_dirs: Error while fetching
>>> users.  Returning list so far.
>>>
>>> https://github.com/SELinuxProject/selinux/issues/121
>>>
>>> Signed-off-by: Laurent Bigonville <bigon@bigon.be>
>>> ---
>>>    libsemanage/src/genhomedircon.c | 13 ++++++++++---
>>>    1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/libsemanage/src/genhomedircon.c
>>> b/libsemanage/src/genhomedircon.c
>>> index 3e61b510..591941fb 100644
>>> --- a/libsemanage/src/genhomedircon.c
>>> +++ b/libsemanage/src/genhomedircon.c
>>> @@ -361,7 +361,11 @@ static semanage_list_t
>>> *get_home_dirs(genhomedircon_settings_t * s)
>>>    
>>>    	errno = 0;
>>>    	setpwent();
>>> -	while ((pwbuf = getpwent()) != NULL) {
>>> +	while (1) {
>>> +		errno = 0;
>>> +		pwbuf = getpwent();
>>> +		if (pwbuf == NULL)
>>> +			break;
>>>    		if (pwbuf->pw_uid < minuid || pwbuf->pw_uid > maxuid)
>>>    			continue;
>>>    		if (!semanage_list_find(shells, pwbuf->pw_shell))
>>> @@ -403,7 +407,6 @@ static semanage_list_t
>>> *get_home_dirs(genhomedircon_settings_t * s)
>>>    		}
>>>    		free(path);
>>>    		path = NULL;
>>> -		errno = 0;
>> Actually I'm wondering if this shouldn't stay there
> Why?

According to strdup() manpage, it can also change errno, isn't there a 
risk that errno is changed to an non-zero value and then causing the 
warning below to be printed?


>
>>>    	}
>>>    
>>>    	if (errno) {
>>> @@ -1101,7 +1104,11 @@ static int
>>> get_group_users(genhomedircon_settings_t * s,
>>>    	}
>>>    
>>>    	setpwent();
>>> -	while ((pw = getpwent()) != NULL) {
>>> +	while (1) {
>>> +		errno = 0;
>>> +		pw = getpwent();
>>> +		if (pw == NULL)
>>> +			break;
>>>    		// skip users who also have this group as their
>>>    		// primary group
>>>    		if (lfind(pw->pw_name, group->gr_mem, &nmembers,
