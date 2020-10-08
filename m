Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDCC43457
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 22:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9162722248
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 22:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XH2Mkouk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJHWuc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 18:50:32 -0400
Received: from sonic317-39.consmr.mail.ne1.yahoo.com ([66.163.184.50]:39338
        "EHLO sonic317-39.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730582AbgJHWuc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 18:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602197431; bh=59E1z/m1+n2p/5+pV518l1x2nvKoHVzcc+clWGrcxtI=; h=To:Cc:References:From:Subject:Date:In-Reply-To:From:Subject; b=XH2MkoukztFAbrCm/rBTYyEg+9GJdLZDqdQyQPNgJXAd5FYbwlFPxzURc89o4GvZFQD5X7x5EeXovv1KzNwo0kOt/F7C4C1JIP1O+Do/81uygeMgxqfGkG7F78bAsYDJG42R82UQBR9l77zG1C7bk8Nq6xOQHnA9QoYTO/9U2Os0UsceKcxUeftN1lBrXzRx7bqu8EEERO2+mTjTvTElpDecUO5q52DZb6s58azb3S1Yzw57usT54D9I1vVWr9ooX71+jU2WPd6GXkQh/4sg2nvzVX04pf5Vx2yjnvO4mlIVSgZgWbCQiDnEsKTukmECoxX01dfBggcNx876PY6EaA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602197431; bh=LSQZ+ZW0rfG4Cig0Ax/of/OjHTQJ8OHynS891+/JKqs=; h=To:From:Subject:Date; b=AFfCdeoKKJXVhhMEsuaAsdB4w/rMIBVCIinOJxv0w/Te54l+tZ7By0JttPYpzOaHT2alV01BQkGcn7WEDO25xoHfPvRSlpnlgdqWUHAiOJTMf9+zq2OCGXsnfQXglRapNeQrokCUS3cxzDoJtqAEv21MSflKcNwkgixm3CAAfT8/PHYjGh37UCnoKtCNehOGnzYdPs9jA6g+EdoVJCoUA242EbKm03sjsPwcGrRZENeXqEh6dqDRAxoY6Q0TGt+HF8vDByVmjMQTtAj9cgKq3mUQqgkljDtUxZSuGisZTUNJIFalUJPIvaUiDT+uACjfsFmYIREtsClIo4svHfrybQ==
X-YMail-OSG: iljJLckVM1la98UH_sYjCwmBybFP3UGSFCDV85NfY2xuj8xcsSa9Sbgt2eqy8Po
 c3Wnb23iNmgJzgRgDw3dd5cQ45dVs6dvJnxTpmmwFOlQqDOXH49SCqQlrbw1iXvDLp0fLLqvu1vj
 nxfMt6JDKXei.gQ7E9.xXAGthqMWVJUKAl7Ho1rlmwCpqDyz_BU9ZPeFPL82LhO3tnbCPlgZ8Es0
 Qdwc5moMz2p6XUYth4InK69LPnLJs8S06y2prdyGkOvmeZI268ImOs952UUYXTSwA2q6iLye2eX6
 I25PnqIGEg8s2oQsx2wfeujfZFHHf4zPffOiqzFToZQhFFLrO0GULUC_e78KTiyzgco9AOxjolb7
 MjGInV6ZCynVBSKGg_RLRUJ..vgj2COMeqV4mOE6qUhiWelCb0VrRubj01tvQ0SEQTuzq3pfbV04
 Iivbs.oJlBCGLkgj6zwaYFS.in0h_dAbjOjdcBrWezUq_j6ufLlX3GDcN8PFyEm7RD96W83P6w50
 c5K7NzQhSVeQrTOzHtsjh_a0T.NqgJ6g58e791Ldw.0LqKuVXDo5y1PhKdHFChdh6oHGVx7CDm5H
 iFsq9hURbNGddmn3moBbEfIPKm0hWeXbX8oFrvn4SXVImp66jNOnqw20IhlVlPraDDM90EHUQXp9
 9fB3TNIYJvUpWbHMRSue8zRjUMe749nXDVVzFss5SbDSFQvUWi5_vk9cMLwEcFobz5Hfn_1SRzEl
 k3tguARilbrfudRy2qLC8lN15IjHsRtpFI6OapJ_KF0QPIqLM5Eb4pHdNmjB3eBq4GbVInTDojgi
 Y2.rq0nH8jnqXHX472aPEc8YNZRVzXqv33XlJvMOhfsQmFp63AxxnNWlsKPF9bvdoAV.Y2VO14N8
 a6uGUz.wBLqtbCUg4HITtjHajmYUCDLtev.KtR25cbH93Kz55NyYKr0ndGLGl4fmF5ZAw8cAA75v
 .IcwAWo.0EOsdOdMlCdTHL1KVXlLPVAaxdnNpesd6eq2FGjhCuraYik1HgeYoU1t.JCV0R9FvSo9
 _cabmzedrEkVo4h_TyTgBjJhbAGk2iI8puRe4z6pn_EN5PowhiGou_SJBujIZej4uQsTxAz2flXy
 WgL9gSPvZfd106ekvoMnZLpY1lIkmXwSrO9dXAoM4UiqKLaT.X2ryQ9Wm8y4QX68_W.2B8NSfh9f
 c_YfRBpIgEyMqkdHECTUjxV_zFv3jENT4q7M8FkbYzPG98PlvCzyLRDs9X7VN5.R5vU6yL2iEp7B
 Slpd1aHXJKzXFCfs50vtKhm5lFhtvQvh2jTsOK0Ahmn6stFTHaeA8BWvsBL3CYSZhqwiQIa8y3Eo
 F_N9RIp0jRxwLMJKr6asTzfOdq_rUe6Gmi8vaZH6mLi_6ATzX5vetH.iHDi2HQAkRn7BbuO5qS7n
 rK34Sr_bcD1AEZAPHHZs0Tug7vEv_LnCXDWaj4XzVVQexihR7OokDYFx6pI8tvbBcsBClY2egrg_
 H2GG3991CQtIpGkMU5ZGANQnX7tOlld8pO4mpuvvg8ptTqDPXADDrPXFmmDh26L_GEV6bJForPsf
 Bjw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Oct 2020 22:50:31 +0000
Received: by smtp424.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 36b2ad728fdb2258ea5bdbcb48ccbc41;
          Thu, 08 Oct 2020 22:50:25 +0000 (UTC)
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
 <CAN-5tyE2ri+SWTQZfZQoV=U__UdMRgB5MR5ma0yQM4Yy03oEZw@mail.gmail.com>
 <d0dfede2-0e8d-25ae-0f20-58da4f4bc08b@schaufler-ca.com>
 <CAN-5tyGA34529m5GNEE7xt1ys2vbUuQHn=N12kmtYzhTi-Rcyg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: selinux: how to query if selinux is enabled
Message-ID: <f2cb46e2-d702-2b99-1602-53253be2fc7c@schaufler-ca.com>
Date:   Thu, 8 Oct 2020 15:50:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyGA34529m5GNEE7xt1ys2vbUuQHn=N12kmtYzhTi-Rcyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16795 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/2020 1:56 PM, Olga Kornievskaia wrote:
> On Thu, Oct 8, 2020 at 2:44 PM Casey Schaufler <casey@schaufler-ca.com>=
 wrote:
>> On 10/8/2020 8:15 AM, Olga Kornievskaia wrote:
>>> On Thu, Oct 8, 2020 at 10:08 AM Ondrej Mosnacek <omosnace@redhat.com>=
 wrote:
>>>> On Thu, Oct 8, 2020 at 3:50 PM Olga Kornievskaia <aglo@umich.edu> wr=
ote:
>>>>> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wro=
te:
>>>>>> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> =
wrote:
>>>>>>> Hi folks,
>>>>>>>
>>>>>>> From some linux kernel module, is it possible to query and find o=
ut
>>>>>>> whether or not selinux is currently enabled or not?
>>>>>>>
>>>>>>> Thank you.
>>>>>> [NOTE: CC'ing the SELinux list as it's probably a bit more relevan=
t
>>>>>> that the LSM list]
>>>>>>
>>>>>> In general most parts of the kernel shouldn't need to worry about =
what
>>>>>> LSMs are active and/or enabled; the simply interact with the LSM(s=
)
>>>>>> via the interfaces defined in include/linux/security.h (there are =
some
>>>>>> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate=
 a
>>>>>> bit more on what you are trying to accomplish?
>>>>> Hi Paul,
>>>>>
>>>>> Thank you for the response. What I'm trying to accomplish is the
>>>>> following. Within a file system (NFS), typically any queries for
>>>>> security labels are triggered by the SElinux (or I guess an LSM in
>>>>> general) (thru the xattr_handler hooks). However, when the VFS is
>>>>> calling to get directory entries NFS will always get the labels
>>>>> (baring server not supporting it). However this is useless and affe=
cts
>>>>> performance (ie., this makes servers do extra work  and adds to the=

>>>>> network traffic) when selinux is disabled. It would be useful if NF=
S
>>>>> can check if there is anything that requires those labels, if SElin=
ux
>>>>> is enabled or disabled.
>>>> Isn't this already accomplished by the security_ismaclabel() checks
>>>> that NFS is already doing?
>>> No it is not (for the readdir). Yes security_ismaclabel() is used
>>> during the calls triggers thru the xattr_handle when a security_label=

>>> is queried on a specific file system object (inode).
>>>
>>> This is done thru the xattr_handler interface which supplies things
>>> like a "key" (which I'm not exactly sure that is but LSM(selinux)
>>> uses). The only thing that we have in VFS readdir call is a
>>> dentry(inode). (inode)->i_security isn't NULL (I already checked as I=

>>> was hoping that would be null when selinux is disabled). So I need
>>> something else to check to see if selinux/LSM is active.
>> The NFS labeling is supposed to work for any security module, not
>> just SELinux. security_ismaclabel() should be the interface you need
>> to use. Checking inode->i_security would NOT give you a definitive
>> answer, as a security module may very well have an inode attribute
>> that is not related to Mandatory Access Control (MAC).
> Can you suggest what should be passed into security_ismaclabel()?
> Typically this is driven by a call into the kernel module that
> registered an xattr_handler and LSM passes into it an attribute name
> to use to lookup (basically what is passed into the xatrr_handler for
> key/name is passed to security_ismaclabel()). VFS readdir doesn't have
> anything like that.

I'm not convinced that the question makes sense. Are you trying to
avoid in the VFS layer a call in the NFS layer to fetch an attribute
the NFS layer isn't supporting? Is that reasonable? I could see changing
the NFS implementation to be more careful about the calls it is making,
but not the VFS layer. Or am I (once again) missing the point?


