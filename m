Return-Path: <SRS0=73iw=2C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97785C43603
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5255921655
	for <selinux@archiver.kernel.org>; Thu, 12 Dec 2019 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Tw+be5Eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfLLQvM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:51:12 -0500
Received: from sonic313-14.consmr.mail.ne1.yahoo.com ([66.163.185.37]:41512
        "EHLO sonic313-14.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729970AbfLLQvL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Dec 2019 11:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576169468; bh=MqweZKKpjjc1wMNczf+9aMV7BUtTUqC6sp90EBZrh88=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Tw+be5EoxRt3ughvIILEyAEiLpraxRvqeWXkrhVRVjlGkwXaxnZF8ty+ZguvAkEuB+yy7LSXImXuE/ZETHyWjdu0ZDa+UcsZWjy5uYocUujIyo2pq6gk58WNwiJLrZr4WTc2oJ0W3RcOjr502pLG382oVk/aRKYFMnpndVizMJ2GD1cKsONtk3Qe7VypnQ2bwhmkGcY/YMR3zSiYSVJ3s/UMLgU2xSH76jn61LeoINp7rrwYyCZY0E+8AIOPl9gmghqUjX2efvtK2SJtNqQgiOhpLWuPK6y/NNv+1VGLpKKhdgTwEEJ3SEOHEB4fbA+VP3zfoQ5X3QErJpvifma5kA==
X-YMail-OSG: Qv7i13oVM1nKbEgWyEsuDwdFMEX.4lCWI6.MYy2r3fZCUIAQzeoRuC_q2Nn9XVh
 u4yQwOxAwj_1rxB_Jg7yCmVRf4AihM0FeYFlaSz0CZMcwb2_ItWO8TfcmZ.oJtTt1PtPaPyUvPKB
 gMvNdJQFX.mjizMz3B3iVFG85uCNJEU0rWLL.k135ldnz02FEtYNS9Nly_XY.VEszeJv8vjOI0MU
 hcLl2tyj.0HR56XgDPpaFUX5MMipGCnCcRsZOoiVGveWCJ68Ccx2UvwHG3uUQ3FhcFyuJ5u4dnSu
 4rCioqGH6c5EM3l7EgHCRnvt_BQxi0WlYr._haFH3qb7ukIwtYIMq_.ANajMozQYIZ_xEuynjgHY
 thfUjwXCFJlYJ5e9E1e1thvztRRZHA5yQctSPq4uwybUO4whqYicTSjMHzXNmS2YmU1xTtvNmSJO
 6y7PA0lnaATqLDhnyhAqNX4qmP1bMe.uNX4kTQ4TemSxPmN24tw0uL5baJ1a97rGYaVV2Bv2MSRw
 v.5DlBOrrRJIPYdLV66mM.6a.R2DRe4AdxWb.TC711a9IKBdQDTQVoywVc7tBbVYv3MEcK2ksWiQ
 Ylr5W4X181rQIqLxT4pn.m.sSxMoamX4qaj0lh1QU9TJ_d_jcU.toxQdpLC5LbjWqS4_nta5EFyH
 6avgVSgREKwETPeX3PUZx28dNI1GAy6.J26i1I4e6yoU9fXkys9TOVECnzRME1GQqTBdbVBHiZaG
 BjQnpaZis36D2S.bs.lSoOrhdTjwvlqmrMhcNXpNdCtd5tNQR0AkUTIc0Y8sn.CujBqfzemqFeYi
 QMDQYhFFNp8NW6oTM5h4xDQAzOIu7P8a6oIZejclMwrbhR_ry7Te.R5PX91d20wjSOTaHrgm2E.e
 edQYIe4M7Z.aRCYKIzOIYeJjdHdCP5RBfwV9Yrdx0WtUqZckEBJ0a47rNVaY.np.ELFDv_SBP.Bj
 FkT8hHeOPeg_ZBlkl1.QlYMSqc.wQkxLiV9I0x73FsenlC7MPSvapCQExfoRQe0g87aWK2tX0h2O
 n4Xwf1tM0sIZ5ZfdlAbfbYdtffGMMD.EqkTpFK7Zewxo56YFC9Nv1Qv86nHu1PZ8XTnP8wKp7vbP
 LPjCHvsr1HCRpS3OB9V_wk59PHfqfG_DcT.DDtT3lAVu30RCL5mtwURycTUfdmYF6dp0B032srnP
 KT.qVmvGRKu1o9G9Qx1lRLRSEQ2CTy3a0U8pGdOArLHpfwbNdQedByHovjMHsg5KFt_5Jk8BW7kv
 TiearoKzgVOgmVMSaB6lNWWTHpebQGIt9drXDIuBTgGjabjE8Agoo77LZhyIvNGchkGHHZ2L8OJs
 hbbouEC1A_RVM86lZInMYHD.8OaAYkE8HPl.wNtX40AgoElf_gdlSsWP39G5iJdHCOXfJ.OWcGSe
 hjiiBgfuzeHCeWnaSkssIwaKBpc6jSxfBurBzJVysLYql3tte
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Thu, 12 Dec 2019 16:51:08 +0000
Received: by smtp421.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7460d3dc33bd6ed5b347b625bf178da1;
          Thu, 12 Dec 2019 16:51:04 +0000 (UTC)
Subject: Re: [PATCH] LSM: allow an LSM to disable all hooks at once
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191211140833.939845-1-omosnace@redhat.com>
 <677be2d4-8247-3c2b-ac13-def725cffaeb@tycho.nsa.gov>
 <201912110840.62A4E64BA@keescook>
 <356c555a-d4ab-84fb-0165-f7672bc1ee63@schaufler-ca.com>
 <2fdb09e7-6668-cb1b-8a2d-1550278ae803@tycho.nsa.gov>
 <CAFqZXNtjELoG_5GK5c4XpH8Be3NfsKMZdZvrJKPpnTLPKKgZ9A@mail.gmail.com>
 <1f613260-d315-6925-d069-e92b872b8610@tycho.nsa.gov>
 <CAFqZXNsZvTfeL_ST7FSxbgM28E3RzKrF1f4JqYUhVY7++01NMw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ff4f8616-6b55-04a2-eef6-d33141432efc@schaufler-ca.com>
Date:   Thu, 12 Dec 2019 08:51:03 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsZvTfeL_ST7FSxbgM28E3RzKrF1f4JqYUhVY7++01NMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/12/2019 8:03 AM, Ondrej Mosnacek wrote:
> On Thu, Dec 12, 2019 at 2:14 PM Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
>> On 12/12/19 6:49 AM, Ondrej Mosnacek wrote:
>>> On Wed, Dec 11, 2019 at 8:12 PM Stephen Smalley <sds@tycho.nsa.gov> w=
rote:
>>>> On 12/11/19 1:35 PM, Casey Schaufler wrote:
>>>>> On 12/11/2019 8:42 AM, Kees Cook wrote:
>>>>>> On Wed, Dec 11, 2019 at 09:29:10AM -0500, Stephen Smalley wrote:
>>>>>>> On 12/11/19 9:08 AM, Ondrej Mosnacek wrote:
>>>>>>>> Instead of deleting the hooks from each list one-by-one (which c=
reates
>>>>>>>> some bad race conditions), allow an LSM to provide a reference t=
o its
>>>>>>>> "enabled" variable and check this variable before calling the ho=
ok.
>>>>>>>>
>>>>>>>> As a nice side effect, this allows marking the hooks (and other =
stuff)
>>>>>>>> __ro_after_init unconditionally. Since SECURITY_WRITABLE_HOOKS n=
o longer
>>>>>>>> makes sense, remove it and instead use SECURITY_SELINUX_DISABLE =
directly
>>>>>>>> for turning on the runtime disable functionality, to emphasize t=
hat this
>>>>>>>> is only used by SELinux and is meant to be removed in the future=
=2E
>>>>>>> Is this fundamentally different/better than adding if (!selinux_e=
nabled)
>>>>>>> return 0; to the beginning of every SELinux hook function?  And a=
s I noted
>>>>>>> to Casey in the earlier thread, that provides an additional easy =
target to
>>>>>>> kernel exploit writers for neutering SELinux with a single kernel=
 write
>>>>>>> vulnerability. OTOH, they already have selinux_state.enforcing an=
d friends,
>>>>>>> and this new one would only be if SECURITY_SELINUX_DISABLE=3Dy.
>>>>>> Yeah, I agree here -- we specifically do not want there to be a tr=
ivial
>>>>>> way to disable LSMs at runtime. CONFIG_SECURITY_SELINUX_DISABLE sh=
ould
>>>>>> be considered deprecated IMO, and we don't want to widen its featu=
res.
>>>>> In /etc/selinux/config SELINUX=3Ddisabled is documented as "No SELi=
nux
>>>>> policy is loaded". How about if instead of blocking policy load and=

>>>>> removing the hooks it just blocked policy load? It may be appropria=
te
>>>>> to tweak the code a bit to perform better in the no-policy loaded
>>>>> case, but my understanding is that the system should work. That wou=
ld
>>>>> address backward compatibility concerns and allow removal of
>>>>> security_delete_hooks(). I don't think this would have the same
>>>>> exposure of resetting selinux_enabled.
>>>> I think that comment stems from before runtime disable was first
>>>> implemented in the kernel, when the only option was to leave SELinux=

>>>> enabled with no policy loaded.  Fedora didn't consider that (or
>>>> selinux=3D0) to be acceptable alternatives, which is why we have run=
time
>>>> disable today.
>>> Do you happen to remember the reasons why it wasn't acceptable? We ar=
e
>>> ready to start pushing for disabling SECURITY_SELINUX_DISABLE in
>>> Fedora, but we're not sure why it is so crucial. Knowing what we need=

>>> to address before disabling/removing it would help a lot.
>> IIRC, they considered the selinux=3D0 kernel boot parameter to be
>> inadequate because of the difficulty in changing kernel boot parameter=
s
>> on certain platforms (IBM?).  The no-policy-loaded alternative still
>> left a lot of SELinux processing in place, so users would still end up=

>> paying memory and runtime overheads for no benefit if we only skipped
>> policy load.
> Thanks, I was worried that there was also something more tricky than
> this. We could make adding-removing the kernel parameter easier on
> Fedora by creating and maintaining a tool that would be able to do it
> reliably across the supported arches. That shouldn't be too hard,
> hopefully.
>
>>>> selinux_state.initialized reflects whether a policy has
>>>> been loaded.  With a few exceptions in certain hook functions, it is=

>>>> only checked by the security server service functions
>>>> (security/selinux/ss/services.c) prior to accessing the policydb.  S=
o
>>>> there is a lot of SELinux processing that would still occur in that
>>>> situation unless we added if (!selinux_state.initialized) return 0;
>>>> checks to all the hook functions, which would create the same exposu=
re
>>>> and would further break the SELinux-enabled case (we need to perform=

>>>> some SELinux processing pre-policy-load to allocate blobs and track =
what
>>>> tasks and objects require delayed security initialization when polic=
y
>>>> load finally occurs).
>>> I think what Casey was suggesting is to add another flag that would
>>> switch from "no policy loaded, but we expect it to be loaded
>>> eventually" to "no policy loaded and we don't expect/allow it to be
>>> loaded any more", which is essentially equivalent to checking
>>> selinux_enabled in each hook, which you had already brought up.
>> Yep.  if (!selinux_enabled) return 0; or if (selinux_state.disabled)
>> return 0; under #ifdef CONFIG_SECURITY_SELINUX_DISABLE in every hook
>> might be the best option until it can be removed altogether; avoids
>> impacting the LSM framework or any other security module, preserves th=
e
>> existing functionality, fairly low overhead on the SELinux-disabled ca=
se.
> OK, so I'll put together another patch that removes all the
> security_delete_hooks() stuff and adds the checks.

I endorse this approach enthusiastically.

>
>> NB selinux_enabled was originally just for selinux=3D0 handling and th=
us
>> remains global (not per selinux-namespace).  selinux_state.disabled is=

>> only for runtime disable via selinuxfs, which could be applied per
>> selinux-namespace if/when selinux namespaces are ever completed and
>> merged. Aside from clearing selinux_enabled in selinux_disable() and
>> logging selinux_enabled in sel_write_enforce() - which seems pointless=

>> by the way, there are no other uses of selinux_enabled outside of __in=
it
>> code AFAICS.  I think at one time selinux_enabled was exported for use=

>> by other kernel code related to SECMARK or elsewhere but that was
>> eliminated/generalized for other security modules.  So it seems like w=
e
>> could always make selinux_enabled itself ro_after_init, stop clearing =
it
>> in selinux_disable() since nothing will be testing it, and just use
>> selinux_state.disabled in the hooks (and possibly in the
>> sel_write_enforce audit log).
> Yes, that sounds reasonable.
>

