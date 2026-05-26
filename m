Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D393A7F4D
	for <selinux@vger.kernel.org>; Tue, 26 May 2026 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838974; cv=none; b=jWKIdqTlqNNpdeaFl8eo4PFyxibXUqDGnm7oH5FcE1EOtp7CINhS6j0WKiFFXB4K6n5HWchhqOLeia9d9CUdPRlEY2M5mi5dFAla9kixjB426jdxhslFVTyctEU5IKlH1N2Fay8oG1gnwfjiydMGjTRU89dU7wVo8SzlzGIhDyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838974; c=relaxed/simple;
	bh=8IfJhhc4hdUyXTPLH1Mg7LrvXqDe/XgQqcHBOzR6Zq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ErbCLHkG8cw1FxHZ/i6p3FKVcly+xztioxxkM8pCWz2rtKsLy11WIzMuLbe+/U9dsoYFU2J8XEatl7pmiyBoeyJHp9AojfSxxglPJPuj1NAC5jVDGRGSgDAJD5T6K4wnYmBUFWOmJq7ajDtSICVyNAsAkxpGYlnuInG05OZiUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X0S0Rbf7; arc=none smtp.client-ip=66.163.189.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X0S0Rbf7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779838971; bh=1CDLTs0tZP7QrHGHAUN+uSFZxV9A2b5F458OJqVcWM4=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=X0S0Rbf7iws/ASuO3SXUHYUmeq4/BFFaPaRJRcVK7uDXp9n71KjL1Qkd9lJWxg0mcBFNSb6aDCGqL5zFxsT0zk9hOS7i3eVLuiybpsL+19ZvdjIB31e96eP60EiPrCB6hBNwBEdRpRpdr1br6I0fQwLwgzbVJUw2VpNotmq5VSkagKvq8Im1lnAxohKKjIM3RIzoyax8gI8V04TeuxbUDRpjxk/asKcz7szwWVVqns2RFXOiRyNXxW0WMhJEs4JqYLalZGb52Mm1sHFXPkWz7YqgJULEvPAIFUHO0TL6SZv/ODk9Nyig7u97l5lTWGLwgq9ICKw6DcbWaG8/O4A8iQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1779838971; bh=kleFoFDyzmh12e4jJAxAKCORffGpTpikl97yE5a7dDQ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=YRW2S1t0HpoXxdMqLgaXnQDw49KId4DxG2nYsBgBDOi9z/z0giYLBGX/RRI9yvxoFd09exWf4Vtl2awGK5Sji4QRVmMtdbpe2xYO+vnUTspvzulszKKErteSbZeDV5rUi8IxADUDAUeyEsoNiznhd7GLh2wk0aRRwLZpjPd0Z7qM6iSTYu155xFpfCC6Fub45E6IwqFuVvob1WWA+Yk8yWysmFK0Wa3zT7hUeG09iZr+qmrcgPmDCkzvef6SsdKAnpPorhfGEWguuZoTBGonvSDaMJvnPGqxNiqnoakhMs7pjSd2+r2Zs2UCobkAYKyXxnXmYBitF49h87pZ7ecm/g==
X-YMail-OSG: aNzyOTUVM1kYiJoJwDaIZXRZpPu2fkfAXFjyvkNapXsbIlLkMIomXqHgqrinaO0
 Eru6sgYDbjYJhfRfealnCjwtdomHcxTov6fa6VHEuIQegx135KksteAGF0d0RnQ2wSYlQz4BS0MG
 4hUATndxTifIm4VTgUyc_ywJFhcIPF8bB4QWn6nQpM62WYLzLq3bo5gupHYK3AGhhTR_1qi76Kbe
 EvTGsxipApaAArytm_oxBcJ7RP5sd9yLjNZV8A4a_0v8_7hFpbNYvur7JBpG_hL2W5xJISFKm40M
 RPWRbUTAYIFq6FTw3IzvnoyJfxRAW1HEm4wub8RFXCmGnjIiHb0TnaRudqQy_dsyGOMFgJFowgAs
 eZEhWQ7YqZSzvdwIw9FYT4aurAog8dGeOm05eL92309eiouI1Rj1bYtpFxm1DYZ6SyhHCISlBq5v
 mVSvHW_xA.4hAGuExt3ywNv070Cv.6XD8.EowbAuR0EGS55BruwdEStmCASboXRkdZu0DtAGCnah
 S9zctke2K46DVHw4AcrTJapl0jrf2RMalOnZbB_2msH_f2Tcw7OJ3P2.ikMfsYgXaIRCkNon5ZYh
 hsnAnWdiLm7t6qo48Z4lTvXL3Yc2yF7oOwWlLmc0lpg6l6gX.0nUnd_61yDsVQKPg4lnEDM4_RxN
 9.CrXmFvmUKwAJI4ai7GdPBj26QltmsDaqHNWneiw_NyHzVGNp6vEBT7NTfAeQJ7u66h0L4gc0zm
 zuh2LEy2YLO3sp056sxnJ_YLxnrWbOKiwUn1ygl_DhzYrllZhOWydr.maq8ysDMecarD9_WPW9XM
 xTnLCn56MToEYLGzvoH32dbL9lRzkj1Odse64XI6jHT3BwUGiY56uuZ2FDXZ3rfoBHlh2uZ16uOi
 GsZ6TCBd6J1QaE5FaHaNNgrINP_eLnVXV6oRPlncteKAg.Uy1AZ5emqmSBSY90TW.fQVa9U8DxXM
 QLcwlvf4kyJdOKHA9tt_znliwhUr1Ct2n7bi1yIJBPYtnczUEDY7F764L6LkHgkWlk69.mb5zTZi
 .OW20Zy7SaBFgKqVTh7z2Dh4SPpZSXDTwnU_970X7ORgKcd58NMDHyG4Gzsqz7iRtXcLidYVkMlm
 95fpy2XrF.r1WoHRrixc3oa78zI9tSlDCPC6udX_FTpBxohPAuHzbu9SfSgEvDPcSQz5MBept_Z4
 kLJqiOGwWaAZrGXA4mJ3uG41pndpL_dEvAvhLY_Dg3vcwrh8BqXi2BOxhfcr00Gugk6MQXb2gcQ2
 GaqiR5hmLXlysVLU_gY.dpJ52KNHMQoty_CmjPkF752S7Xm58sXro12jz0U33r4iizbruYKchm8t
 SqB9ZmgB.cHrU9YAauSpNaVur_bCHpRiOX1UUCj_70p7iv3iCrb0MTahYZffb9l2SxvsVel0Gww7
 q0FVw9k0nZbBAD8FKtuGMP3li9x9iXy6zDKVisZlNHEpjIyr.14ol4eD.ZMXmbwWQNieA.yApLRo
 o0EWtBGVcXuBJLfnUhV0MKyrD_jS7_ELb0ltODvNl7XJ04CCoFma0HQy6okyUefb3g.dWmJDBE9n
 k.6COq0RTAY3My_5cDtm39YiSRi7Ne.RJCAQDfSJYq_MHC50pOtTBR_Fr6MEFxxi0lC3xDkU_iEP
 RWVenF89.B9zrP4mrNLOUz5ig2cVyhqiLXBjzCJGQtYTtnCNpW3UAt59lWaDzgAugXXerJ8roYuq
 2eE.UdJyVvqIBS8sC8u8LKl9zFd20dDa.MzwEFW97dZbaiZTPAfOFNTQuWkLfZbRJqi_t_Gl7WpV
 _lMYie.517CMQapaulY1gsO86zyrk8OQMgR8bhj1Hv8EbAgCV5739rrPyenCqFuGH9P7HQoCZRK6
 7xS6ZYHNH_6Zo8sR1SL4JUIhd_jAjdwJaoRTZxHFplpt7XRGml591ij8ghOq18Oo2SJBmEK2GPuC
 m3F6GCmPTCLha4i1l90XCNEx31AfZE3BsACn5OBf8lx6c3cnidq1cEGGYC3LIt1gTOoRhWJTuclX
 QsvUZ_Q7hZjrPJnUlt1OWn8.DRHQYMKAqDeiB3L4JVD4zFopcIEsICSzq7GciSbFvQEPDmiqDzuo
 oSzDsNzkHIZa63kRQuz.oErHahbulniwuh3xtQ7iqGuMdy2okO1yZ9sGCTtHHHavba1f3RCVnDLw
 WVRXWPLrsbtVx5D1Ik_OVki13jBTsur30F5IHHULdCA7yXAPSYfopuuYy7kPGqXyqe.z1THCeCJT
 rgdDqW8MkVHYRTKa9FI18qgYo3dHZw46MY_PqkmFswWpnAWUgIuIAQgdE4yndWQgckQ7fSDwm9lY
 -
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: d8f94fa7-f81f-455b-9259-7af97949666d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 May 2026 23:42:51 +0000
Received: by hermes--production-gq1-7bb7df5c46-2m55j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 055310fc59bad35d27ec552ff320b8e5;
          Tue, 26 May 2026 23:42:45 +0000 (UTC)
Message-ID: <090a355d-3680-4113-a542-ff3b1c565f58@schaufler-ca.com>
Date: Tue, 26 May 2026 16:42:43 -0700
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: security_task_prctl: why -ENOSYS
To: William Roberts <bill.c.roberts@gmail.com>,
 LSM <linux-security-module@vger.kernel.org>,
 SElinux list <selinux@vger.kernel.org>
References: <CAFftDdrzV2xC7HBcgS8EPb-YewJyCK9uos4crXOCh5ONm6SxSg@mail.gmail.com>
 <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
Content-Language: en-US
Cc: Casey Schaufler <casey@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAFftDdqp8b5n21hdEP6w0-PK+CoG7mmQxgrnhpBLU7-1GZxniw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 5/26/2026 4:21 PM, William Roberts wrote:
> On Tue, May 26, 2026 at 5:39 PM William Roberts
> <bill.c.roberts@gmail.com> wrote:
>> Hello,
>>
>> I am trying to understand the motivation behind having
>> security_task_prctl only continue if the return value is -ENOSYS. This
>> seems to be very different from other LSM hooks I have investigated.
>> For example, in other hooks, the value from SE Linux avc_has_perms is
>> used directly. This essentially means that a 0 will cause the check to
>> pass, and anything < 0 usually an error.
>>
>> In commit:
>> ----
>> commit d84f4f992cbd76e8f39c488cf0c5d123843923b1 ("CRED: Inaugurate COW
>> credentials")
>>
>> (8) security_task_prctl() and cap_task_prctl().
>>
>>          security_task_prctl() has been modified to return -ENOSYS if it doesn't
>>          want to handle a function, or otherwise return the return
>> value directly
>>          rather than through an argument.
>>
>>          Additionally, cap_task_prctl() now prepares a new set of
>> credentials, even
>>          if it doesn't end up using it.
>> ----
>>
>> The check in kernel/sys.c is currently:
>>         error = security_task_prctl(option, arg2, arg3, arg4, arg5);
>>         if (error != -ENOSYS)
>>                 return error;
>>
>> Should this be something like, "error && error != -ENOSYS"?
>>
>> I ask because I am looking to leverage this hook in SE Linux, and it's
>> annoying to have to coerce all 0 returns to -ENOSYS.
> Of course after hours of banging my head and one email sent, it's more clear to
> me now WHY. This hook isn't meant for making yes or no decisions on an operation
> but rather to also handle special prctl flags for an LSM in question.
>
> I guess with the said, do we want this interface to be used for both
> a, let the lsm handle
> this prctl flag directed to me, as well as a yes/no security decision
> or do we want to split
> this out into two hooks?

The task_prctl hook is used in capability and yama. It is only used to
provide a place to process LSM specific prctl options. It is not used to
make security decisions outside of processing the LSM's options. If you
want to make security decisions on general prctl options you will need
a new hook.

>
>> Thanks,
>> Bill
