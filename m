Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C37C433FE
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09BFA207B0
	for <selinux@archiver.kernel.org>; Thu,  3 Dec 2020 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgLCR00 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Dec 2020 12:26:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:16866 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgLCR00 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 3 Dec 2020 12:26:26 -0500
IronPort-SDR: y7K15+QM+HErMjFxzfRgIr+4N2R7+Qb1zobUTHhhPgpsgyh346Dd8jgX0RSubi2eL5J9Ym0MOh
 0YEKKJrqnyVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170668972"
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="170668972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:24:44 -0800
IronPort-SDR: /NvaU8tRAqxTar36RDKg6SZ6ObfCkfF4BIkaH3U2hh7RG0615n0RM9ZJEta3Vv8hNjA5VO4qgj
 snI2MUXw5L7A==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="315821837"
Received: from hsualexa-mobl.amr.corp.intel.com ([10.254.71.111])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:24:44 -0800
Date:   Thu, 3 Dec 2020 09:24:43 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, mptcp@lists.01.org
Subject: Re: [MPTCP] Re: [RFC PATCH] selinux: handle MPTCP consistently with
 TCP
In-Reply-To: <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
Message-ID: <539f376-62c2-dbe7-fbfd-6dc7a53eafa@linux.intel.com>
References: <3336b397dda1d15ee9fb87107f9cc21a5d1fe510.1606904940.git.pabeni@redhat.com> <3a5f156da4569957b91bb5aa4d2a316b729a2c69.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2 Dec 2020, Paolo Abeni wrote:

> On Wed, 2020-12-02 at 11:31 +0100, Paolo Abeni wrote:
>> The MPTCP protocol uses a specific protocol value, even if
>> it's an extension to TCP. Additionally, MPTCP sockets
>> could 'fall-back' to TCP at run-time, depending on peer MPTCP
>> support and available resources.
>>
>> As a consequence of the specific protocol number, selinux
>> applies the raw_socket class to MPTCP sockets.
>>
>> Existing TCP application converted to MPTCP - or forced to
>> use MPTCP socket with user-space hacks - will need an
>> updated policy to run successfully.
>>
>> This change lets selinux attach the TCP socket class to
>> MPTCP sockets, too, so that no policy changes are needed in
>> the above scenario.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>>  security/selinux/hooks.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 6b1826fc3658..9a6b4bf1bc5b 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -1120,7 +1120,8 @@ static inline u16 inode_mode_to_security_class(umode_t mode)
>>
>>  static inline int default_protocol_stream(int protocol)
>>  {
>> -	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP);
>> +	return (protocol == IPPROTO_IP || protocol == IPPROTO_TCP ||
>> +		protocol == IPPROTO_MPTCP);
>>  }

This looks like a good default to me.

>>
>>  static inline int default_protocol_dgram(int protocol)
>> @@ -1152,7 +1153,7 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>>  				return SECCLASS_TCP_SOCKET;
>>  			else if (extsockclass && protocol == IPPROTO_SCTP)
>>  				return SECCLASS_SCTP_SOCKET;
>> -			else
>> +			elseextsockclass
>
> Whoops, my bad! I don't know how this chunk slipped-in. I'll fix it in
> the formal submission for inclusion, if there is agreement on this
> change.

Ok, looks fine to send after fixup.

I think there may be a small fix required to smack too, but that's an 
entirely different patch.

--
Mat Martineau
Intel
