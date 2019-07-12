Return-Path: <SRS0=P1AD=VJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43947C742D6
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DD12054F
	for <selinux@archiver.kernel.org>; Fri, 12 Jul 2019 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="a9S258Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfGLSCp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:02:45 -0400
Received: from upbd19pa11.eemsg.mail.mil ([214.24.27.86]:16176 "EHLO
        upbd19pa11.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfGLSCp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 12 Jul 2019 14:02:45 -0400
X-EEMSG-check-017: 229383211|UPBD19PA11_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by upbd19pa11.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Jul 2019 18:02:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1562954541; x=1594490541;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=kNyF8/e9n0HaH7iNw5yqgELcNU7rsClNmPSLiqVugcY=;
  b=a9S258EuzlNcWrcnlUmoArjzwpjpCGKNEHn0J8kf6zrZO0g9cLYw1FxK
   K52L56b6URJTmRNYm0buKLmfGuST9X9ZXUnptzk+e5VkfrI/xSivsBQmX
   TYXUlA0r73OREuDrbtC2WFp9E50VlVKpc4WS1WEhBEAdqIo+Lsdd6Oagn
   S7XsZ6xBPWYy7QKom0NlFqM/w4rwlxb/xJ1Z8PQh4IOhyoctGsrNuw57f
   XLJj7nn3J/BL9p8qgJaZZaSqQT2dilc4vPbGDYDdYWabT27ZS4lrfxYnT
   YDvaqyggDdGJMFYf1WkD6s91sdOYEPQwGWNm+c3Ar0r7MJFvKfrBtHZxh
   w==;
X-IronPort-AV: E=Sophos;i="5.63,483,1557187200"; 
   d="scan'208";a="30098568"
IronPort-PHdr: =?us-ascii?q?9a23=3Aj4WAeBLUuKhZ92F09dmcpTZWNBhigK39O0sv0r?=
 =?us-ascii?q?FitYgXLvj9rarrMEGX3/hxlliBBdydt6sezbeO+Pm5ByQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+NhW7oRneusULnIdvK7s6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMteWTZBAoehZIURCeQPM/tTo43kq1YOqRayAA+hD/7txDBVnH/7xbA03f?=
 =?us-ascii?q?ovEQ/G3wIuEdwBv3vWo9rpO6kfSvy1wavSwDnfc/9b1zXw5Y7VeR4hu/GMWr?=
 =?us-ascii?q?dwfNLMx0kzCQzFllWQppLjPziIy+oNtnKU7+5kVe2xi28stgZ8oiOyycc3kY?=
 =?us-ascii?q?TJmoIUxUzE9SV+2oo1I8a4R1Rhbd6rF5tQqTiXOo1rSc0hW2FloDs2x7IJtJ?=
 =?us-ascii?q?KhfCUG1Y4rywDQZvCZaYSE/xTuX/uLLzhinnJqYre/ig638Uin1+LzSNG50E?=
 =?us-ascii?q?1PripZitnMsW0N1wDL5siHVPR9+kCh1C6T1w/J8OFEIF00lbHBJ549wr8/ip?=
 =?us-ascii?q?oTsUPZEi/whEr2l7OZel8h+uip7+TrerTmppmCOI9okgzyL6sjl8OlDek4Lw?=
 =?us-ascii?q?QCRXaX9Oui2LH54EH1WLBKgec3kqndvpDaP8MbpquhDg9Oz4kj8A2yDyum0d?=
 =?us-ascii?q?sEnXkHK0hJeBScj4fzIV3OL/f4Demnj1S2jDhr3+zGPqHmApjVLHjDlbDhfa?=
 =?us-ascii?q?xn605d0wo+1tZf6IhRCr4fIfL/QEjxtMbXDhUhKQy73/7nCMlh1oMZQW+PGr?=
 =?us-ascii?q?WWML7WsVKT/uIgOfSMZIsMtDb4LPgl4OTugmEjlVABeqmp2IMdaGqkEfR+P0?=
 =?us-ascii?q?WZfX3sj88aEWgUugo+TerqiECNUDNIeXayULwz5ishBIKlE4jDXIatj6KF3C?=
 =?us-ascii?q?uhGZ1WfG9GAEiWEXj0b4WER+sMaCWKL89lkzwEU6WhSoA42RG1qgD116dnLv?=
 =?us-ascii?q?DV+i0EtZPvzd115+rOmhEv8Tx7Ed+Q03+CT25qhGMEXTw2075loUx71FiD1b?=
 =?us-ascii?q?J0g/tCFdxc//lJSBs1NYbAz+xmDND/QgbBfsqVSFahWdipGzQxQcgtzNAUe0?=
 =?us-ascii?q?Z9GsmigQrH3yawBb8aiaCLDoQu8q3Ax3jxO9p9y3He2akikVYpXNBPOnGhhq?=
 =?us-ascii?q?549AjeHJLGk0WDl6atcKQc3TPN9GKZwWqJpkFYXxZ6Ub/ZUnAHekvWsdP561?=
 =?us-ascii?q?vZT7CwE7QnPRVOxNWCKqRQbt3piVVHRPH5NNvCZGKxnn+6BQyUybOUcIrqZ2?=
 =?us-ascii?q?Id0T3fCEgDkwAT+2yKNQo5BiehuW3eCiduGkzpY0737eZxsnW7TkgyzwGLc0?=
 =?us-ascii?q?Juzb619gQJivybTvMZxqgEtzs5qzVoAFa92MrbBMaaqAp6YqpdYcgw4Exb2m?=
 =?us-ascii?q?LZrQN9I5KgL6R8iV4Eagh4o1nh2w9rBYVHlMggtGkqwxZqKaKEzFNBcCuV3Z?=
 =?us-ascii?q?X3Or3NNmny+xava6vN117C0NaW4KAP6PE5q1X+uQGlDE0i829o09NNyXuT+o?=
 =?us-ascii?q?3KDBYOUZL2Sks38xl6p7fHYigy/o/bz2BsPrS1sj/ewN8pHvUqxQugf9hFLK?=
 =?us-ascii?q?OIDhP9E8ofB5vmFOt/uVGsYwlMGedI7q8vd5ekcvycwq+wFOBpmT+ny2Nd79?=
 =?us-ascii?q?Y5mmSN/Cp7TufTl7gfyveT3UPTUTfyll6n6OjriItEYncUBWP5xi/6Ut1/fK?=
 =?us-ascii?q?p3KL0XBH+uLsv//dB3g5rgSjYM71K4L08X08+uPxyJZhry2hMGhhdfmmCuhS?=
 =?us-ascii?q?btl288qDoutKfKmXWTkuk=3D?=
X-IPAS-Result: =?us-ascii?q?A2CcAADjyShd/wHyM5BlHAEBAQQBAQcEAQGBVgQBAQsBg?=
 =?us-ascii?q?WwqgW6ERJMwAQEBAQEBBoEJCCWJYIl9hxgJAQEBAQEBAQEBNAECAQGEQAKCV?=
 =?us-ascii?q?iM3Bg4BAwEBAQQBAQEBBAEBbIVIgjopAYJnAQUjBBE2CxALDgoCAiYCAlcGA?=
 =?us-ascii?q?QwIAQGCXz+BdxSsOn8zhUeDLYFHgQwoAYteF3iBB4E4DIJfPodOglgElHGVc?=
 =?us-ascii?q?QmCG4IfkWYGG5gHLY0HmVsigVgrCAIYCCEPO4JtgneOKSMDgTYBAY9iAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Jul 2019 18:02:19 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x6CI2HsL016590;
        Fri, 12 Jul 2019 14:02:17 -0400
Subject: Re: [RFC PATCH] security, capability: pass object information to
 security_capable
To:     James Morris <jmorris@namei.org>,
        Nicholas Franck <nhfran2@tycho.nsa.gov>
Cc:     paul@paul-moore.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, luto@amacapital.net,
        keescook@chromium.org, serge@hallyn.com,
        john.johansen@canonical.com, casey@schaufler-ca.com,
        mortonm@chromium.org,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
References: <20190712173404.14417-1-nhfran2@tycho.nsa.gov>
 <alpine.LRH.2.21.1907130347010.1509@namei.org>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <3605eb1a-fb1c-8933-b1e1-a60e54fb1e1c@tycho.nsa.gov>
Date:   Fri, 12 Jul 2019 14:02:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1907130347010.1509@namei.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 7/12/19 1:50 PM, James Morris wrote:
> On Fri, 12 Jul 2019, Nicholas Franck wrote:
> 
>> +	case LSM_AUDIT_DATA_CAP: {
>> +		const struct inode *inode;
>> +
>> +		if (a->u.cap_struct.cad) {
>> +			switch (a->u.cap_struct.cad->type) {
>> +			case CAP_AUX_DATA_INODE: {
>> +				inode = a->u.cap_struct.cad->u.inode;
>> +
>> +				audit_log_format(ab, " dev=");
>> +				audit_log_untrustedstring(ab,
>> +					inode->i_sb->s_id);
>> +				audit_log_format(ab, " ino=%lu",
>> +					inode->i_ino);
>> +				break;
>> +			}
>> +			}
>> +		}
>> +		audit_log_format(ab, " capability=%d ", a->u.cap_struct.cap);
>>   		break;
> 
> Will this break any existing userspace log parsers?

I'm hoping not given that we are only adding auxiliary fields and those 
are already defined for other AVC audit messages.  ausearch appeared to 
work fine.  Added the linux-audit mailing list to the cc line to get 
their view.
