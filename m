Return-Path: <SRS0=oTsg=XW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E6C388F3
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9042A20872
	for <selinux@archiver.kernel.org>; Fri, 27 Sep 2019 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="U5iAP0rW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfI0Nvd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:51:33 -0400
Received: from USFB19PA35.eemsg.mail.mil ([214.24.26.198]:24896 "EHLO
        USFB19PA35.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfI0Nvd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Sep 2019 09:51:33 -0400
X-EEMSG-check-017: 12640696|USFB19PA35_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="12640696"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by USFB19PA35.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Sep 2019 13:51:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569592291; x=1601128291;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=mNlfIjCutaSskVf8VxyMBEjVtnCYOhIj/t+WS2eckns=;
  b=U5iAP0rWjonM7YJV2on9xJWo3upaQj5qHUD7rtX3X6HcvqJoDaTYsrTV
   VLGFXQIvaSaq1ChCh8ni8Rb1/Lx0quRRoMjKXG0if/sWaCzaQbbfIcs77
   oTFFP8yz9sIGTmmrCtWgcwjKcAy+FdTrsNipDUzlzpska7WuMUd25h73I
   4ZxO7nnv//OVnQLNvPpJThmEiXHAuswWeag8a8kgzNQ4f+7A2G5qNwR3q
   inQ0/3MTnwZoyGgBwL5q1ONRAqqErh53Srb/IfyVq1mTAbPFmLkHEsZlp
   W1geoH1NIyRR8bqW55bmgdCE/p1iXBaFPXcB03oX7WITpHLNit440z1xB
   A==;
X-IronPort-AV: E=Sophos;i="5.64,555,1559520000"; 
   d="scan'208";a="28397885"
IronPort-PHdr: =?us-ascii?q?9a23=3AXA2hWRd2sLZQnEj3rDQPpWZVlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcS6Yh7h7PlgxGXEQZ/co6odzbaP6Oa7Bydev96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6twvcu8gZjYZjK6s61w?=
 =?us-ascii?q?fErGZPd+lK321jOEidnwz75se+/Z5j9zpftvc8/MNeUqv0Yro1Q6VAADspL2?=
 =?us-ascii?q?466svrtQLeTQSU/XsTTn8WkhtTDAfb6hzxQ4r8vTH7tup53ymaINH2QLUpUj?=
 =?us-ascii?q?ms86tnVBnlgzoJOD4j9GHcl9J+gqRVrhm8oxBz2pDYbYCQOPd4Y6jTf84VRX?=
 =?us-ascii?q?BZU8hMSSJBDIOyYYgBAeUPMulXrZXyqVQVoBuiBwShHv/jxiNGi3L026Axzu?=
 =?us-ascii?q?QvERvB3AwlB98ArWjUo8vtNKcST++1yrTDwyjGb/xM3Tf97JbHcxA8qvyLRr?=
 =?us-ascii?q?J/bNHRxFIzFwLFklqQqYvlMymT1uQWqWeX9eVgVeWxi2M+rQx6vzahxsApio?=
 =?us-ascii?q?bTh4IVzEjJ9T5kwIkoIt23VlR7YcW+HJtLsCGWL5B2Qt4/TGFvoio7xKYGtJ?=
 =?us-ascii?q?imdyYJ0JQq3wPTZvOIfoSS4h/vSfydLSl3iX57Yr6zmhC/+lW6xOLmTMm7yl?=
 =?us-ascii?q?NKozJAktnLq38CyQTe6tOCSvth5keh3iuP1xzL5uFEP080ka3bJoY9wrEqjJ?=
 =?us-ascii?q?oTsFnDHjTslEXqjK6ZakUk+u+y5+ThfrrmvYOTO5VxigH/NqQigs2/AeImPQ?=
 =?us-ascii?q?gSR2WX5Oux2bL58UD5XblGlOM6n6bHvJzAOMgXvqu5DBVU0oYn5Ra/FTCm0N?=
 =?us-ascii?q?EAkHkcMV1FYwmKj5TpOl7SIPD4Cu2zg1K3kDhx3fzGMbrhAovVInjZjLjhZa?=
 =?us-ascii?q?p961JbyAcr1tBQ+ZZUCrAHIPLuVU78r8LYDhAnPAyu2ernC8ty1pkYWW2RBq?=
 =?us-ascii?q?+VKqTSsUWH5rFnH+7Zf4IRuTDgO9A76PP0y3w0g1kQee+ux5RERmq/G6FdP0?=
 =?us-ascii?q?iBYXfqyuwEGGMOsxt2GPfmk3WeQDVTYDC0RKt66TYlXtH1RbzfT5yg1eTSlB?=
 =?us-ascii?q?ywGYdbMyUcVF0=3D?=
X-IPAS-Result: =?us-ascii?q?A2ClAQCDE45d/wHyM5BmHAEBAQQBAQwEAQGBVgQBAQsBg?=
 =?us-ascii?q?XMqbVIBMiqEIo5tTQEBAQEBAQaBNol1igmFOoFnCQEBAQEBAQEBASsJAQIBA?=
 =?us-ascii?q?YRAAoM3IzcGDgIMAQEBBAEBAQEBBQMBAWyFLQyCOimCaQEFIwQRUQsYAgImA?=
 =?us-ascii?q?gJXEwgBAYJfPwGBdhQPrhN/M4VNgzOBSIEMKAGMDRh4gQeBESeCaz6CSBkEG?=
 =?us-ascii?q?IEwZII+glgElgqXDYIsgi6EV44ABhuDKZYLLZYLkxcigVgrCAIYCCEPgycJR?=
 =?us-ascii?q?xAUjDGBWoIkJQMwgQYBAY4+AQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 27 Sep 2019 13:51:26 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8RDpQiB012200
        for <selinux@vger.kernel.org>; Fri, 27 Sep 2019 09:51:26 -0400
Subject: Re: question about selinux_restore_tty() in sudo's selinux.c
To:     selinux@vger.kernel.org
References: <20190927075507.GA20555@seamus.lan>
 <0fb7bf1f-f13b-3bec-7b91-53460dfbe265@tycho.nsa.gov>
 <20190927130805.GA22281@seamus.lan>
 <1aefe0bf-ab82-3b41-7f49-5a540ab8f7f9@tycho.nsa.gov>
 <20190927134908.GB22281@seamus.lan>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <caf2c1c0-682b-1ff6-aee9-cc91dd6ad8a6@tycho.nsa.gov>
Date:   Fri, 27 Sep 2019 09:51:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927134908.GB22281@seamus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 9/27/19 9:49 AM, Dominick Grift wrote:
> On Fri, Sep 27, 2019 at 09:33:06AM -0400, Stephen Smalley wrote:
>> On 9/27/19 9:08 AM, Dominick Grift wrote:
>>> On Fri, Sep 27, 2019 at 08:59:26AM -0400, Stephen Smalley wrote:
>>>> On 9/27/19 3:55 AM, Dominick Grift wrote:
>>>>> sudo does not reset the role of my tty properly [1], and i was wondering if anyone is able to determine what is causing this [2]
>>>>>
>>>>> [1] https://bugzilla.sudo.ws/show_bug.cgi?id=898
>>>>> [2] https://www.sudo.ws/repos/sudo/file/tip/src/selinux.c
>>>>
>>>> Are you sure sudo is calling selinux_restore_tty()?
>>>>
>>>>
>>>
>>> running sudo with:
>>>
>>> Debug sudo /var/log/sudo_debug all@debug
>>> Debug sudoers.so /var/log/sudo_debug all@debug
>>>
>>> Yields:
>>>
>>> grep selinux /var/log/sudo_debug
>>> Sep 27 15:06:29 sudo[3417] <- sudo_new_key_val_v1 @ ../../../lib/util/key_val.c:61 := selinux_role=sysadm.role
>>> Sep 27 15:06:29 sudo[3417]     7: selinux_role=sysadm.role
>>> Sep 27 15:06:29 sudo[3447] -> selinux_setup @ ../../src/selinux.c:349
>>> Sep 27 15:06:29 sudo[3447] -> get_exec_context @ ../../src/selinux.c:274
>>> Sep 27 15:06:29 sudo[3447] <- get_exec_context @ ../../src/selinux.c:328 := 0x564eed3621b0
>>> Sep 27 15:06:29 sudo[3447] -> relabel_tty @ ../../src/selinux.c:160
>>> Sep 27 15:06:29 sudo[3447] <- relabel_tty @ ../../src/selinux.c:253 := 0
>>> Sep 27 15:06:29 sudo[3447] -> audit_role_change @ ../../src/selinux.c:76
>>> Sep 27 15:06:29 sudo[3447] <- audit_role_change @ ../../src/selinux.c:98 := 6
>>> Sep 27 15:06:29 sudo[3447] <- selinux_setup @ ../../src/selinux.c:395 := 0
>>> Sep 27 15:06:29 sudo[3447] -> selinux_execve @ ../../src/selinux.c:405
>>> Sep 27 15:06:29 sudo[3417] -> selinux_restore_tty @ ../../src/selinux.c:114
>>> Sep 27 15:06:29 sudo[3417] <- selinux_restore_tty @ ../../src/selinux.c:142 := 0
>>
>> Ok, so you entered and exited selinux_restore_tty() without error. No
>> warning messages of any kind in any of the sudo logs? Not sure where
>> sudo_warn() and sudo_warnx() messages go.
> 
> No warnings or any other clues. I guess it must be this then:
> 
>      if (se_state.ttyfd == -1 || se_state.new_tty_context == NULL)
> 	goto skip_relabel;

That should only occur if there was no tty or security_compute_relabel() 
didn't provide a new context to set in the first place. Not if it 
actually relabeled the tty earlier.

Does newrole work correctly with your policy?

> 
>>
>> selinux_restore_tty() does a goto skip_relabel in multiple cases:
>> - if there was no tty (ttyfd == -1),
>> - if we didn't set a new tty context (new_tty_context),
>> - if the context on the tty was changed from the value set by sudo
>> (strcmp...) e.g. some other process changed it in the interim, but this
>> should have logged a warning,
>>


