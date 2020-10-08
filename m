Return-Path: <SRS0=ZqYe=DP=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB973C433DF
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 18:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC9221FE
	for <selinux@archiver.kernel.org>; Thu,  8 Oct 2020 18:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="EDYSJYBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgJHSoB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:44:01 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:41482
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729207AbgJHSoB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 8 Oct 2020 14:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602182640; bh=NenSVKLj3daaoDKF8fJbsS3RJrzZ0jq5AAvnWsPLg1Y=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=EDYSJYBl5tZPhTxbgRjpU9L7XzJ9B/qkfMBZxOeLKn5yTa87cnKejHIEhI3uocOvFT0jEVFzTuKub4KZwQoLH+/VdMRg0TaYgewNz1rInIUvZjUi8AqqkQoL+a4/c3kogmz56J9zQCbveiChvGRv7TjTM60JvgcmyCZ851//VSyMY8c9HXM2juk4CIbmO9drX3pG7F/5a+MM7c2+LMH90wxOoldVUHSj9R7OyGQEhRvEiojtJYRs9BRmUm/DcnmN/tlc2wJvLwSc5p5n9V4xn15zEgHRhjg1mnXarkBV2PDpG3Fd4uXpOww5/5e6f0Tc2emcp9jINOPCyltUtb/k+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602182640; bh=d/1low3dnTSQekmO/dGD3iMMTBWKXFdteVEnN73tBF0=; h=Subject:To:From:Date; b=Ah9kD3N3piFGm9lJ8fZ5emqhQ5akXT684VVCnXISrH3QesdouKibNqJ/EIJR9Jxq22PnL44w7CVsBSgWFtev9mgf/uZ9xbIub4vOBbEo4nmYSlWMi/VGM9UVnPFf9y38YKqfXp29oB8maK3TU2n7CZIEV5XdQRwPIOwud/P0HlPmkMu5ZG9T9xKKWxnypWJTldMlv8vbGLXkQTt+ecnXm4eYtQ8FPDSdwSIPbOUiTMxV3QzwUn6kNtkjaWfW/b+UIk/tlSUQUWsPbG0+nBbdsVkeD/2342vzdwGLbz1rv4Prhj/cHm/S1fXGf8AY7ggk8XRSz2/fUiHxv4BsYn9/oA==
X-YMail-OSG: pmx_ykMVM1mlvXWj72mDkfj2Iw9F5csENQh_0oLnw1va2W9oaJtK_8358e_puFC
 Zojt5hJJamEVaZMocJb98ySiVz_w020pPUjxQUOOz_tP7npQfWnoGKZAWqX8EsoORszL_YRO6hPS
 9u92AGZr9WEbqmPC_xtNHQ3tocClKK6eLJJFxpT.xIJft0so.F6P_osEBqPr9RU.fHsJtfzDTve9
 k4O3H_.8ff_kN0oOFTFlK.yMTJXgodjrtMC5nXrb7zYlBtXEmJOjO7zHQtZ.qiA9hSJOuDaxM2Wq
 w.OH253Y2bHe2vyrCrD7WbsWjlTuRVDwNNcZ4yak0wCRcspmjIT8y.gR5Tlu7lk.L.dZncHNNwnD
 uNegbJVSTpMF8kymJ1Ios62aS8lRPLhzX3PZRwWgIKC8lSZMDEJL3dHwSvEpbCUpUCqKCLtP3Gcx
 EauNAbQ9GwCcyzPuSHeBfWwZvG1O34_EE5aHW1IeVBQa33o74DbZ5fUOl3jf4j15bipPHHU9kktW
 4Vl9RJ2oH53PfGuAxBiMZ0hvhPdnSEqN7SoLI_4M5GLChCOHci8sStAez7LiXaUUAiH2IxX1FOoB
 xmcTRTeJlRdO9HBdr8gZdqGV8vtukfegl8Mxgdpqjax.uDld5PVWoeLg.2yw2PrcZnhMsySb86Ru
 vkxkvvL8DyFeuU0_.amwZWXF.oYe3A4ER1PmhxYhODKIiXJXYII5SFNtSutZ823_ptmuwqkUeVAQ
 p_W70PhelWWzcO9gBDvwkKGEYf42Cpm4hSvB7FXkGtmJg7xJtxOhUvw8cPMHz0ilerDuj_JQN84E
 v52n3IIEQ7fwatWgduQVWgYZzcMusKWg4w0WituKjvslgXe10ldQbi2.DzGUrv6BQr3ujtzqruVQ
 aXjTYHARVFWMV1FQ3oCu1r0lJqOnYCqhwlRD.Ni8C1RqmCXRT.CFCZfmAaTLNWWWIICqu5NUroyq
 HINT.nW9kxPtQ.TzkO4VtOlx75V5m58LNlIN6OiMM1cVIOj6.jPqNX3Kj1Fch1dz2AqO3eRhaGUx
 RisvF6.WGCgCykxyYGSbWqkg9OgbTMEfixqr_Q9zaAHL.Mpe0QwvCJmMv372dJx5O.if3IXLxKOe
 zGYy2saS1_4znaoRUQH12cuyEmlwbl4ZrmN2SWowvPOewFMOtbcP4yaqEAlc89ntmP7zLycbIF_f
 Lw2Gv44g4kKKmHQwhnf6m04xSqAHkJwKKb1o3iikPV.pcG8UFq.Ned.ghuc35u5WFYAF3VdXF1D7
 MKx.8ai9AOfhSoXgYViKgDMhKQRgeDgmYXusx6pDVB6B4xZl4Q.S3Mnu7NJQQoIHEXt_bgtFoV7G
 Rm7Du1JEtPb3e4uN1jtcUG9KqMMY5xJsPGOgM50cqdiBiAIzjQKDbu38AVIymfwfNxje7SvLNerD
 Pvx52NiQ92ebdH55d2QRo_vQXbfd9OdGrzZPQ.p6eMcXLuBGkC.HalUKS3t3R2TiC.eTaZgdHiUW
 HJLwtcqvA5rDirwFq4FxMOpfcY36D8P8P_t016fOpyLn2gVrk5kBh7vMb3yaN_IrcWuo1wTg3ulh
 _R7rUyqP2eQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 8 Oct 2020 18:44:00 +0000
Received: by smtp414.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c5e8fdc1d0d40588cdf06cb095081493;
          Thu, 08 Oct 2020 18:43:58 +0000 (UTC)
Subject: Re: selinux: how to query if selinux is enabled
To:     Olga Kornievskaia <aglo@umich.edu>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
References: <CAN-5tyETQWVphrgqWjcPrtTzHHyz5DGrRz741yPYRS9Byyd=3Q@mail.gmail.com>
 <CAHC9VhRP2iJqLWiBg46zPKUqxzZoUOuaA6FPigxOw7qubophdw@mail.gmail.com>
 <CAN-5tyFq775PeOOzqskFexdbCgK3Gk_XB2Yy80SRYSc7Pdj=CA@mail.gmail.com>
 <CAFqZXNsG+B7OdmQimwNNVYCJM_Dc3jpNUFUpraoCEaicaoi+kQ@mail.gmail.com>
 <CAN-5tyE2ri+SWTQZfZQoV=U__UdMRgB5MR5ma0yQM4Yy03oEZw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d0dfede2-0e8d-25ae-0f20-58da4f4bc08b@schaufler-ca.com>
Date:   Thu, 8 Oct 2020 11:43:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAN-5tyE2ri+SWTQZfZQoV=U__UdMRgB5MR5ma0yQM4Yy03oEZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16795 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 10/8/2020 8:15 AM, Olga Kornievskaia wrote:
> On Thu, Oct 8, 2020 at 10:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>> On Thu, Oct 8, 2020 at 3:50 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>> On Wed, Oct 7, 2020 at 9:07 PM Paul Moore <paul@paul-moore.com> wrote:
>>>> On Wed, Oct 7, 2020 at 8:41 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>> Hi folks,
>>>>>
>>>>> From some linux kernel module, is it possible to query and find out
>>>>> whether or not selinux is currently enabled or not?
>>>>>
>>>>> Thank you.
>>>> [NOTE: CC'ing the SELinux list as it's probably a bit more relevant
>>>> that the LSM list]
>>>>
>>>> In general most parts of the kernel shouldn't need to worry about what
>>>> LSMs are active and/or enabled; the simply interact with the LSM(s)
>>>> via the interfaces defined in include/linux/security.h (there are some
>>>> helpful comments in include/linux/lsm_hooks.h).  Can you elaborate a
>>>> bit more on what you are trying to accomplish?
>>> Hi Paul,
>>>
>>> Thank you for the response. What I'm trying to accomplish is the
>>> following. Within a file system (NFS), typically any queries for
>>> security labels are triggered by the SElinux (or I guess an LSM in
>>> general) (thru the xattr_handler hooks). However, when the VFS is
>>> calling to get directory entries NFS will always get the labels
>>> (baring server not supporting it). However this is useless and affects
>>> performance (ie., this makes servers do extra work  and adds to the
>>> network traffic) when selinux is disabled. It would be useful if NFS
>>> can check if there is anything that requires those labels, if SElinux
>>> is enabled or disabled.
>> Isn't this already accomplished by the security_ismaclabel() checks
>> that NFS is already doing?
> No it is not (for the readdir). Yes security_ismaclabel() is used
> during the calls triggers thru the xattr_handle when a security_label
> is queried on a specific file system object (inode).
>
> This is done thru the xattr_handler interface which supplies things
> like a "key" (which I'm not exactly sure that is but LSM(selinux)
> uses). The only thing that we have in VFS readdir call is a
> dentry(inode). (inode)->i_security isn't NULL (I already checked as I
> was hoping that would be null when selinux is disabled). So I need
> something else to check to see if selinux/LSM is active.

The NFS labeling is supposed to work for any security module, not
just SELinux. security_ismaclabel() should be the interface you need
to use. Checking inode->i_security would NOT give you a definitive
answer, as a security module may very well have an inode attribute
that is not related to Mandatory Access Control (MAC).


