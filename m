Return-Path: <SRS0=jgNJ=PX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEBCC43387
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 13:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DE420657
	for <selinux@archiver.kernel.org>; Tue, 15 Jan 2019 13:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="krrOEfq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfAON0L (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:26:11 -0500
Received: from uphb19pa10.eemsg.mail.mil ([214.24.26.84]:47008 "EHLO
        USFB19PA13.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727618AbfAON0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Jan 2019 08:26:10 -0500
X-EEMSG-check-017: 225802754|USFB19PA13_EEMSG_MP9.csd.disa.mil
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA13.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 15 Jan 2019 13:26:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1547558766; x=1579094766;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nhDyV2itowsfMO6dOL9AmsE6uQrIMBipNuIjHncUtGs=;
  b=krrOEfq7DWTZITf7EunVv7MOm6DyFtaPME6cZoMyiL/bYZrjT1DLtn3k
   cZ2dIY+LC9IiyVJ+lqEOQ7nUcxGlJV61Sju8R+GHjJPCW7pLGDK6tqgo/
   iMacpVYC2tnawfEujDh7XfEf672sjm4C2rkIV0UJESaCgfboOoj0i9RTS
   maL+XfhRwTXnwGy+NMyVi9vYp9Iszxv+YDmiRKYt/luLe3Xie2jgdA+fT
   KENDJaaDlJUQfyzsmmhRe7BLVV1lU5EY55Tm69czvrD9PnESYDgJDcaZm
   53acPkNvlx7Hr0ziu8wreVD/07Ot57tJRPV4z3SYRRIRIRQCA2hQP9jy1
   g==;
X-IronPort-AV: E=Sophos;i="5.56,481,1539648000"; 
   d="scan'208";a="19520715"
IronPort-PHdr: =?us-ascii?q?9a23=3AG99YzhBbTXgvS8eCRXroUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPTzrsbcNUDSrc9gkEXOFd2Cra4c26yO6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglUhzexe69+IAmrpgjNq8cahpdvJLwswR?=
 =?us-ascii?q?XTuHtIfOpWxWJsJV2Nmhv3+9m98p1+/SlOovwt78FPX7n0cKQ+VrxYES8pM3?=
 =?us-ascii?q?sp683xtBnMVhWA630BWWgLiBVIAgzF7BbnXpfttybxq+Rw1DWGMcDwULs5Qi?=
 =?us-ascii?q?qp4bt1RxD0iScHLz85/3/Risxsl6JQvRatqwViz4LIfI2ZMfxzca3HfdMeWG?=
 =?us-ascii?q?FPQMBfWSJcCY+4docDEvYNMeNeooLgpVUBsAG+CBGxCu3xxD9Ghnz406M03O?=
 =?us-ascii?q?suEw7JwAMuEskSsHnWttj5KLseXO63waTO0D7Nb+lW2TD46IXQbx4hve+DXa?=
 =?us-ascii?q?pwccXPz0kkCh7LjlCKpozhOzOayOQMuHWc4up7SO2vkHUqqx1xozezxscsjZ?=
 =?us-ascii?q?PFhoQOyl/e7yl5z4E1JcOhRUN9fNWqHpxQtySAOIt3RMMvW25ouCcmyr0GpJ?=
 =?us-ascii?q?60ZzIGx4ggxx7abfGMbouG4gr7WeqMLjp1i2hpdbKiixqo70StxfPwWtOp3F?=
 =?us-ascii?q?tMsyFLiMPDtmoX2BzW8sWHT/x98Vq/1juXzADT7/1EIVgzlarGN54t2r4wmY?=
 =?us-ascii?q?QXsUTEBiL2hF/5jLWXdkU54eik8fjnY7X6qZ+cMI94kAf+Pbg1msOjG+g4Nw?=
 =?us-ascii?q?kOX2yD9eS90r3s41H5Ta1XgvA5naTVqpDXKdkBqqKnDAJZzJwv5wunAzejyt?=
 =?us-ascii?q?sYnH0HLFxfeBKAiojkI0rOL+3jDfqkn1StkCtkx/DBPrH7BJXNNWLMnK3ufb?=
 =?us-ascii?q?Z69U5Q0BAzwsxH55JIFrEBJ+r+Wlf1tNPCEx85Lxa0zP39B9hmzIMRR3+AAq?=
 =?us-ascii?q?+DP6POq1OH+uUvI+yUbo8PpDn9M+Ql5+LpjXIhgl8SY62p3ZoRaHClEfVrOF?=
 =?us-ascii?q?uZYXXyjdcbC2sKvRQxTPbsiFKcVT5ffXGyX7gz5mJzNIXzNYrfXMiJiaGdxi?=
 =?us-ascii?q?2yFZ0eMnhCA02QC33hX5+JV/cFdGSZJco3wRIeUr30cJMszRGjskfBzrNjKu?=
 =?us-ascii?q?fFsnkDuYnLyMl+5+qVkwo7szNzEZLOgCm2U2hokzZQFHcN16dlrBk4kw7b3A?=
 =?us-ascii?q?=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AXAABn3j1c/wHyM5BkGwEBAQEDAQEBBwMBAQGBUwQBA?=
 =?us-ascii?q?QELAYFaKWZPMyeEAZQMUgaBECWJL45NgXswCAGDPztGAoJBIjYHDQEDAQEBA?=
 =?us-ascii?q?QEBAgFsHAyCOikBgmcBBSMVQRALDgoCAiYCAlcGDQYCAQGCXz8BgXQND6xXg?=
 =?us-ascii?q?S+ELgGBE4RygQuLNBd4gQeBEScMgl+DHgKEaoJXAolSBoYjSThUkDUJhyCKZ?=
 =?us-ascii?q?wYYgjGPT48JjTQELYFWKwgCGAghDzuCbAmGAIVlhQwhAzCBBQEBiiIBAQ?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 15 Jan 2019 13:26:05 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto.infosec.tycho.ncsc.mil [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x0FDQ3Oh012797;
        Tue, 15 Jan 2019 08:26:04 -0500
Subject: Re: [PATCH v2] setsebool: support use of -P on SELinux-disabled hosts
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, jwcart2@tycho.nsa.gov
References: <20190110162624.29309-1-sds@tycho.nsa.gov>
 <pjda7k3fpbg.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <e3bd22ec-4d3b-99a8-2910-e4b5db8333dc@tycho.nsa.gov>
Date:   Tue, 15 Jan 2019 08:28:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <pjda7k3fpbg.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 1/14/19 6:31 AM, Petr Lautrbach wrote:
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> As reported in #123, setsebool immediately exits with an error if
>> SELinux is disabled, preventing its use for setting boolean persistent
>> values.  In contrast, semanage boolean -m works on SELinux-disabled
>> hosts.  Change setsebool so that it can be used with the -P option
>> (persistent changes) even if SELinux is disabled.  In the SELinux-disabled
>> case, skip setting of active boolean values, but set the persistent value
>> in the policy store.  Policy reload is automatically disabled by libsemanage
>> when SELinux is disabled, so we only need to call semanage_set_reload()
>> if -N was used.
>>
> 
> So right now, `setsebool -N` and `semanage boolean -N` have the same effect that
> `load_policy` is not run, but the value of the boolean is changed when
> SELinux is enabled so it affects the system. Would it make sense to use
> -N to just change values in the store and do not change the value in the
> running kernel? E.g.
> 
> --- a/policycoreutils/setsebool/setsebool.c
> +++ b/policycoreutils/setsebool/setsebool.c
> @@ -187,11 +187,14 @@ static int semanage_set_boolean_list(size_t boolcnt,
>                                                    boolean) < 0)
>                          goto err;
>   
> -               if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
> -                       fprintf(stderr, "Failed to change boolean %s: %m\n",
> -                               boollist[j].name);
> -                       goto err;
> -               }
> +               if (no_reload)
> +                       semanage_set_reload(handle, 0);
> +               else
> +                       if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
> +                               fprintf(stderr, "Failed to change boolean %s: %m\n",
> +                                                               boollist[j].name);
> +                               goto err;
> +                       }
> 
> 
> A similar patch would need to be applied to seobject.py as well in this case.

That makes sense to me logically (in fact, I don't really understand why 
setsebool w/o -P would ever trigger a reload), but I guess the concern 
is whether any existing users rely on the current behavior, e.g. the 
%post scriptlet in container-selinux that led to this issue.

> 
> 
> 
>> Fixes: https://github.com/SELinuxProject/selinux/issues/123
>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>> ---
>> v2 changes setsebool to only call semanage_set_reload() if -N was specified;
>> otherwise we can use the libsemanage defaults just as we do in semodule
>> and semanage.
>>   policycoreutils/setsebool/setsebool.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/policycoreutils/setsebool/setsebool.c b/policycoreutils/setsebool/setsebool.c
>> index 53d3566c..a5157efc 100644
>> --- a/policycoreutils/setsebool/setsebool.c
>> +++ b/policycoreutils/setsebool/setsebool.c
>> @@ -18,7 +18,7 @@
>>   #include <errno.h>
>>   
>>   int permanent = 0;
>> -int reload = 1;
>> +int no_reload = 0;
>>   int verbose = 0;
>>   
>>   int setbool(char **list, size_t start, size_t end);
>> @@ -38,11 +38,6 @@ int main(int argc, char **argv)
>>   	if (argc < 2)
>>   		usage();
>>   
>> -	if (is_selinux_enabled() <= 0) {
>> -		fputs("setsebool:  SELinux is disabled.\n", stderr);
>> -		return 1;
>> -	}
>> -
>>   	while (1) {
>>   		clflag = getopt(argc, argv, "PNV");
>>   		if (clflag == -1)
>> @@ -53,7 +48,7 @@ int main(int argc, char **argv)
>>   			permanent = 1;
>>   			break;
>>   		case 'N':
>> -			reload = 0;
>> +			no_reload = 1;
>>   			break;
>>   		case 'V':
>>   			verbose = 1;
>> @@ -130,6 +125,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>   	semanage_bool_key_t *bool_key = NULL;
>>   	int managed;
>>   	int result;
>> +	int enabled = is_selinux_enabled();
>>   
>>   	handle = semanage_handle_create();
>>   	if (handle == NULL) {
>> @@ -191,7 +187,7 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>   						  boolean) < 0)
>>   			goto err;
>>   
>> -		if (semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>> +		if (enabled && semanage_bool_set_active(handle, bool_key, boolean) < 0) {
>>   			fprintf(stderr, "Failed to change boolean %s: %m\n",
>>   				boollist[j].name);
>>   			goto err;
>> @@ -202,7 +198,8 @@ static int semanage_set_boolean_list(size_t boolcnt,
>>   		boolean = NULL;
>>   	}
>>   
>> -	semanage_set_reload(handle, reload);
>> +	if (no_reload)
>> +		semanage_set_reload(handle, 0);
>>   	if (semanage_commit(handle) < 0)
>>   		goto err;

