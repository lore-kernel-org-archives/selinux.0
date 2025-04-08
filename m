Received: from sonic307-15.consmr.mail.ne1.yahoo.com (sonic307-15.consmr.mail.ne1.yahoo.com [66.163.190.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31E22ACE3
	for <selinux@vger.kernel.org>; Tue,  8 Apr 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131516; cv=none; b=gLDL7KhUiBt9CmOnFwNxR3SXXVRJ3Ftdh4XgElWRMuWVwpH5yFeuEgPVliU9LoYBnRCKkM7Xi5YBAJ/p03GJyqL7+pn2bPLHr7iMZMZE85QfW+FFiBrDh0SsqA9VJwvRhYmvIzVAp2W8ofbTzWvF0n2OG/rJ1I0MdMB4YARApBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131516; c=relaxed/simple;
	bh=e3En4V92v80XJLKjWfPt/hAlZ4Q6SPESKtwDek/YWm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSJAazYujERIrjoeTkhIAiJti4TqL4MHTV3skSpaAxFai/fRvP4/45i4rPkvVFCulcMXfzO72ututBWWUIL5BijchHUHQROwrDUUZ3GeH4h5T0PByU4As94+uCpQCx/PCoVRirhu5zgUwC5kBdN2/suZKhIlsGL04Fq0DUA+Obw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=TDG/w3Uw; arc=none smtp.client-ip=66.163.190.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="TDG/w3Uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744131513; bh=e3En4V92v80XJLKjWfPt/hAlZ4Q6SPESKtwDek/YWm8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=TDG/w3UwUkzCeUjjCeIHyfAIlfXI85LA6M2Z6c36HPhDCEwjUT2fpkBoE7aJLFzMYURVN0SPnAAUV7TrEC3nNfsvyogVcObimp/E3vPCD25/WxdgUW9n6KrWHMrPNt4moVt6iMJkRcwu4YPt0xscLaF38/W4DBbtJlTLZIBRqhcyoDE729O3wKzc5sw10LC2ybbCpsQAMN8PcOkpPUeAeyMh0H8LidqXy/4g8ASJ65yI0M49A504p1OqLQMgDhR5mtyLhdYhGjdSs+qrmQ4/7ju8EyoWb3qRMvCzYWZ4wptm5MuLRMKIC7Mco/zQ8SLNXCTtB2IzvWt/zouMNF/KTg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744131513; bh=dw/8qBSlogJK/fWyvLijp36dL3j3qdtoe0N5zrxfj59=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hT6MInJWG4KT5QhTYBlsg8W06ApRbFPXpdA9pVqWbgCp/Kq1l+EbXsJ7qa5LEzI7KXuVmaHyDaEjKmvjQlpBqq0gfN2bsMHeQ7kzb+ROprpsNdbs604rq7gr6XTSK17f7Y/URHq5p3M3R8FKAtdKCvEfe1o21QJtnOC5Zgiyrv7QoVAtogpCXN/rPCT8RjpyhtJP/bGc1sRwzLdlQcxiy4qege/jI+/OQOKUEwrKnZSIcJ3jnYqTx3vk0kMlgThRrnNKIZ0zOGnL7MbvrupkeIo/Dt8Nzn5jGLIL0UOXYdpPyHd4KsyRVg5K1/xncKwzIikm4QLEoN7SkO4v4Bd6RQ==
X-YMail-OSG: ixmY0nEVM1kgvi8x1IuO13414Urb6wsNy8bLgywNWmYUHZUoz_muP3LWtR9bRu4
 NwgJ8Wfqm9.xTjpFXHXcoRs02JoGKuUT9tyZSawB8zc64cXDSeAHvpyQNdU4Vd3bfTIy7yPjtbR_
 TFkeLlqtBY5emk5mDcJom3ClGj7hJGN846MdmrE3v.Q_oTMZ7CU51B1mcXChASJ9SitlCY7OszjC
 MZFh395IRGOhAwZ8zAmmSOhh6KifA1qbU3faww27U7_9qeBDKTv4GQ_v8.Ry94SgT9nD1VlvT0mc
 nc.hyb51SxwVAyqgwn2z1AacPQd4O02n.QBTpJ0Qmz.B6jyzgQYFL9J0V.Zgqns0sG0WlB33avY9
 vq6mwM14mUvnITZ6TKZhnnG263UT3tOJT_Np6tSVkKfO7fXp_HsnRmPDpvv7LlUxXXxUDw4b_ZCp
 nUl9gQKXf0CammYmBbDdbfKsSQK.7_PGZDbNcAa06QwrpbFs8FCIBnYdwjf3ksJiaC46XRZX70ME
 Qlwe2.GIPz.uiEaJf5g2ImXU7bzlVwAFK_nE2dR4SvcTBUdeH4MUfhJe5UXKADip7oOshj49s5Hn
 4x7LF.fkveqWzsnWPAKN2fWOvu4do0FaAGCXx4ezye3n4YWRgqWNhpkVHlkqKuYuHvUKoTLGp4qR
 CbZ5VUNI0aLpm2mHh8CWRdBddOEr1yDaURIdWqTOB12LHNJZRO89TzMK4AOIDU6.UJ4jPQWCsZb.
 86aTNSc17U_cDX_t0jzoDDHpCNlGjQfN8rLOAW3m3wAZ7PwFTi.3X.7WaagWE487T.G45yOM1sPK
 XsEBfvNTP5CN149oiGNka6RH72pq8_ZnRhzhvwAsNLTLsAtSHj1Ih9vdtNbVomPxEVA4Zx86vk6x
 7DGhbUpFdXuqVENlqoL.LUBmNdC6xKqb5rSi3yLO9NRhJYpZV7P2BB_A1T0_0rOLsT7egrtvzTcK
 p2Ga5f4b48aEK.1NaAw2C_l2IKPb1WA864c65Em_OrbW1UNEGl6tDBsBBUJxapd5InXn5axhYNLH
 crkPImYfUBwckFaFc2eJxIvwCPveoE8f_XYIpmrkeWfAhE0aYwZbNy6vcl98BmG3YTBHNVMUJHES
 wY.T6amt8MnG5PnhtlZQnc49jg69eor6VVjyQNx2DHlC8Wky_K6DyIMk14D5CjTWcJBQO6_A9MiA
 rdJ3kyi4E1qYKlfAsNb9R46lazbTtD0HmvXh_eZYF3gcFeCtH3TwpHJdKSgT9NJ.HpbK1KtsoD2W
 CIyLBMuj3vfTeqMjBuWkBIAui_5daXVfJgbxcNrylvmkNKwn13lV35QA5UT9u75xz2kI3g68gNF2
 YiZAuLCDvKs1tkAgmIwCcNwjrFowuAA_eCukFN1ZP7cQjszIApzg6SzLenIT4hN_FZYT_WWdY6uR
 BlYdpqiD3uDq6aLMMweHLmDptSlISYY4ijkLQ1YPG0qF54ID2vVKARPHAqaAihkmpDsFDgfFeA1p
 dSYM_XsGxxKUJl1DtKr53k5Vl7d9_pWKKwY54Fug3xG8rfvcMGiSdEgZvZ2nF40x0ygiLTZDhE7I
 j2rlzB8ZGjbzb84b6rkrT.gbc0lG380jhzBK.gw2vJB6_I2txzNpXr5G25dUsZmiC1dcfYUTs8aQ
 0c66Dav7ftijW0U87V1ojl3ER3N2iwfjDrOkptfZ3NcwuLCKfXdaD980FY57ijdW6wPf8onfFhID
 j0Q5E0GrKHfXCQA9xjDAQdASioXYGLEx.qtBfdcb4YCGi5w040_Kr.e1SSqaBmvALQl4w.RSjYof
 tBW78hZz1ZkipepeivDzyqpROtOngK6_06XFGEFm2U1O1gDLIgc5E_9G7O.84a4sGhaZ7gr2._Fm
 f6cDhnZetbowiYcAe3gWyOTQTrY1WryDI4ljFhwoa11BtKwu2fXpGQ0A6DdohUvtZhAEwp2qC.Ty
 rgdHOTS1ZK0Acnlba1MUCOw_VuONtxfe7dJpBqJbXw2Byd7XiIWXUf0kpMTsBes_kDQvR6X1VxVI
 YhnuPcxYigHcQ0QqKBSp4MNkNtDFGVINnio6uHr2gvUN4i3a58L9Ixi9lTWe.Smhx_peoanb7HEl
 1zp_EncgPtReNkJDxS1UioAZHV8FKfw8bxkAhNMiThvv702jmM5Y1bSWviSq.o9pq.YMmdhufmet
 NJC0t_CSwEW5Yq2k79tgugHUoBAc69SYHCJbm6sKiT.Fxq6MWYzxdFTj4XGTAoo0kTskxacuwXYi
 Mxs0Lbu5R9iEpjdiZ4dD.0JYTA0OmIM.3zwDfmk0Sv4yO5Jb5ilDRdeVaxGZCkKk1lJqJKoJM
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 11940aed-117c-4b6c-871a-02bc0bae110a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 8 Apr 2025 16:58:33 +0000
Received: by hermes--production-gq1-6f8bfcd964-fl6ms (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b13ff0137a9481d56fe33a5f709f2762;
          Tue, 08 Apr 2025 16:28:07 +0000 (UTC)
Message-ID: <2a13a228-01fb-442f-924a-702342618b2e@schaufler-ca.com>
Date: Tue, 8 Apr 2025 09:28:05 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 2/4] net: Retire DCCP.
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Paul Moore <paul@paul-moore.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, selinux@vger.kernel.org,
 linux-security-module@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250407231823.95927-1-kuniyu@amazon.com>
 <20250407231823.95927-3-kuniyu@amazon.com>
 <CAHC9VhQCS-TfSL4cMfBu2GszHS8DVE05Z6FH-zPXV=EiH4ZHdg@mail.gmail.com>
 <cd8c8f91-336d-4dd2-b997-4f7581202e64@googlemail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <cd8c8f91-336d-4dd2-b997-4f7581202e64@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.23590 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 4/7/2025 10:22 PM, Christian Göttsche wrote:
> Apr 8, 2025 03:35:15 Paul Moore <paul@paul-moore.com>:
>
>> On Mon, Apr 7, 2025 at 7:19 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>> DCCP was orphaned in 2021 by commit 054c4610bd05 ("MAINTAINERS: dccp:
>>> move Gerrit Renker to CREDITS"), which noted that the last maintainer
>>> had been inactive for five years.
>>>
>>> In recent years, it has become a playground for syzbot, and most changes
>>> to DCCP have been odd bug fixes triggered by syzbot.  Apart from that,
>>> the only changes have been driven by treewide or networking API updates
>>> or adjustments related to TCP.
>>>
>>> Thus, in 2023, we announced we would remove DCCP in 2025 via commit
>>> b144fcaf46d4 ("dccp: Print deprecation notice.").
>>>
>>> Since then, only one individual has contacted the netdev mailing list. [0]
>>>
>>> There is ongoing research for Multipath DCCP.  The repository is hosted
>>> on GitHub [1], and development is not taking place through the upstream
>>> community.  While the repository is published under the GPLv2 license,
>>> the scheduling part remains proprietary, with a LICENSE file [2] stating:
>>>
>>>   "This is not Open Source software."
>>>
>>> The researcher mentioned a plan to address the licensing issue, upstream
>>> the patches, and step up as a maintainer, but there has been no further
>>> communication since then.
>>>
>>> Maintaining DCCP for a decade without any real users has become a burden.
>>>
>>> Therefore, it's time to remove it.
>>>
>>> Removing DCCP will also provide significant benefits to TCP.  It allows
>>> us to freely reorganize the layout of struct inet_connection_sock, which
>>> is currently shared with DCCP, and optimize it to reduce the number of
>>> cachelines accessed in the TCP fast path.
>>>
>>> Note that we leave uAPI headers alone for userspace programs.
>>>
>>> Link: https://lore.kernel.org/netdev/20230710182253.81446-1-kuniyu@amazon.com/T/#u #[0]
>>> Link: https://github.com/telekom/mp-dccp #[1]
>>> Link: https://github.com/telekom/mp-dccp/blob/mpdccp_v03_k5.10/net/dccp/non_gpl_scheduler/LICENSE #[2]
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Adding the LSM and SELinux lists for obvious reasons, as well as Casey
>> directly since he maintains Smack and I don't see him on the To/CC
>> line.

It's annoying that I found out about this indirectly. No biscuit.

Nonetheless, for the Smack bits:

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

