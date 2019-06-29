Return-Path: <SRS0=45Fk=U4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DFC5B577
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A3E216FD
	for <selinux@archiver.kernel.org>; Sat, 29 Jun 2019 19:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="OS15oMD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfF2TpH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:45:07 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:41035
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbfF2TpH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 29 Jun 2019 15:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1561837505; bh=qKZKtWakMQGolr/1894EwLg4nzPjYLAHD4wA/usCoNk=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=OS15oMD2aJXVQuPqgNjKCAyvqK14xscqNr2V16Fd6Te6A1wXLVqCYeLhoY6DQPpjNxP1ynWIpKBE2BuT0qppOlXAniKEgak/Vk9N1pea+oG+8HMAjkCepAtSpYSz+Pdl8KPEGSzDaPJjLdoobaIYYrrBVwTKuQGw6DgrTsVNBEDhdtG5h0sEv7csVzUo5/V0v55KXMJSIaDA1xWfxJs2aQZFlhNkvUfCqduYW0KNbJTIn+aOmZBesyX7LUH1le3OyL+iXA3m0fhPUrYw4rct5p6WRNkoUArAJzQhadny85Nb8Ebbk+De87xgYeMSqjQ/lRsI3tNmM+AeFCv//o4FJQ==
X-YMail-OSG: .7oY1NoVM1lHeIe70cIa9KIpt4QbVQw4clSXQx4xFA6gBjJvj1rYHutIC9X0gk3
 asXi5QAgMG.drml1xjQTheutmoCcV7_R27SCY3otdn9vatzZFEEZJSzOOtxbBXMS2WN1443mm62R
 ybzaRNCNYfNw6N2lj5MMFA9Hp3pEjAH6RBR_QMY6ysN4Hrgt6vgTpsKS6c1gubwKVLbEdRfriJnC
 IzN45Mf8PyPQUUb7kERlJ6ORYNevfPtTA8iCOAc5uK0xxm.n770igV_4OKA4Y9O6FYFApkMSYaYf
 dJKO2De3yAoJ7Pq.37UX_tt2R8FR1asjjGFTRVq.VmyqgXSIpe_i0MoFQ17h9CYzyOKfX6wB7xyS
 Yp1XUhsolaJ_pZs.SLjFY.N9HSoNRbfhJAZDMh3nvYiygCClMhrVDUFse0JO7zFf05BLnvf19.aa
 lnDy8SbcOpkbBEXAsB.6B_9h0sYr3ptpmQcCuXJD.eT_ZVdfxu1W_suyoJK4A_BbgqNfNC726WcN
 20VrQjPukmOs1O_5xa5s6leiJXQC7Kz78f6Sh1WYYmE.JlZJy8AvYrPLgBt0MUCWu.lYF.gbHHf3
 kEYiMN6M4Rqb89LOuNst9B7V7YggwwBxI2SGYf_YP4_87lSiyYRFQ71_EeEPnSybcaXSWzNdWA2S
 _6yM8LdE4_jichotuT670bMaffxjNgN235vRIsqDTVMDC4EiVWtHC6jdEtO.SZkzTMXoySUnzqwp
 aHa7WbETW6OrHzjaOZ0TkFCYPOG_cc.HgKN39VG13p8.d3C_7fj00Go.19mTFVxrBGhqFSrk1gpw
 y9paWHy_TqqMrGrm9cG9E1iB4EWrfKnxilVUK7QSBncck5HIlKYa9giPCK6bGzmcpGbM4_GHKMde
 TdsdaNBtFpnHgzUZqZzE7chOfvGf1zkQv.mdZFsV9LhWZryfvchU9YON0zh_tg5NQgCCYmLMaUdC
 8i0iSguPe5R8._VddVIkA6vifs6YEpeT4nuLqLQIo1eUkyBSpExtUkFUacKJnp4qJN2hmoM.YJYm
 Vf7rbN2oFx.VdKJ05Ct8R1TmhNkl8tCCgurNUb1Zii1LHBQSFUeEVc47vXpb9lWmWv5Um3edI3Lo
 _lxse63x5eUXeXsxHdXo4mZaduR.FPDDOkK_7kJIJ6rMX.qlr6qeeHq9OUPJi5hW2Bi9sDjuuVoV
 slCmd4UoFZT.tEPlutC4NHCyih9dLaqnrkhzMEb.UikNLztqSkg0K5DiwLT6JmvoXYCeselBX8I5
 jOnE6hP66h8y4.wfmnXY1zs7OxD1V
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Jun 2019 19:45:05 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp430.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7f3d1a5d27e2f9d7c433ea07cf04760b;
          Sat, 29 Jun 2019 19:45:03 +0000 (UTC)
Subject: Re: Fwd: [PATCH v4 15/23] LSM: Specify which LSM to display
To:     Stephen Smalley <stephen.smalley@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, keescook@chromium.org,
        John Johansen <john.johansen@canonical.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        Paul Moore <paul@paul-moore.com>
References: <20190626192234.11725-1-casey@schaufler-ca.com>
 <20190626192234.11725-16-casey@schaufler-ca.com>
 <89561452-86f9-fd9a-1390-0cd4bde1fd62@tycho.nsa.gov>
 <7944672e-a590-44a3-743a-48c1785a5464@schaufler-ca.com>
 <CAB9W1A1nwE7WBZqTe-GV8xNb83_B2ybV7cco++nfMjtDz9NJrg@mail.gmail.com>
 <CAB9W1A29fCn=cH_Mx-g-P6M-5t+832ayhMmjy3PFZ-BOL3BuDQ@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <fecdeb90-ccd5-9f23-525f-456ab325dd35@schaufler-ca.com>
Date:   Sat, 29 Jun 2019 12:45:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAB9W1A29fCn=cH_Mx-g-P6M-5t+832ayhMmjy3PFZ-BOL3BuDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 6/28/2019 6:01 PM, Stephen Smalley wrote:
> On Fri, Jun 28, 2019 at 12:15 PM Casey Schaufler <casey@schaufler-ca.co=
m> wrote:
>> On 6/28/2019 7:45 AM, Stephen Smalley wrote:
>>> On 6/26/19 3:22 PM, Casey Schaufler wrote:
>>>> Create a new entry "display" in /proc/.../attr for controlling
>>>> which LSM security information is displayed for a process.
>>>> The name of an active LSM that supplies hooks for human readable
>>>> data may be written to "display" to set the value. The name of
>>>> the LSM currently in use can be read from "display".
>>>> At this point there can only be one LSM capable of display
>>>> active.
>>> IIUC, presently, at the end of the entire series,
>>>
>>> 1) Any process can change its display attribute to any enabled securi=
ty module, and no security module can veto that change.
>> That is correct. If a security module could hoard the display it
>> could prevent user space from functioning in a multiple module
>> environment.
>>
>>> 2) The display attribute is inherited across fork and exec, even exec=
s that change credentials, and again no security module has control over =
the inheritance of this attribute.
>> Also correct. Scripts don't work otherwise.
> It's a security hole waiting to happen. Unprivileged caller sets its
> display value to Smack on a mostly SELinux system that happens to
> enable Smack too, then exec's a credential-changing SELinux-aware
> program that uses one of the libselinux APIs to set one of the
> /proc/self/attr attributes to a different SELinux context. Due to the
> change in display, the SELinux-aware program instead ends up setting
> one of the Smack attributes and therefore the desired SELinux context
> is never applied to the process or file or socket or whatever.

The credential-changing SELinux-aware program is getting
invoked by an unprivileged, Smack aware program? Would anyone
expect that to be a good idea? I'll admit it could happen,
but setting the Smack label of your SELinux-aware program
(which will need CAP_MAC_ADMIN, BTW) to "system_u:system_r:wheehee_t"
is unlikely to result in anything other than your SELinux-aware
program getting very frustrated. In the other direction, a
Smack-aware program that trys to set its SELinux context to "^"
is going to fail by SELinux policy. While I am willing to accept
that it is possible that there is a way to exploit this, it
would require convoluted SELinux and Smack policies. Anyone
who has reason to use a combination of Smack and SELinux on
a real system is already signing up for more configuration
headaches than I would wish on anyone.
=C2=A0
I have strongly advocated addition of /proc/.../attr/
subdirectories for all LSMs, and that all user space migrate
to using them. /proc/.../attr/selinux/current would not be
affected by the display setting. We know, and have known for
years that so long as "current" is shared there will be this
sort of problem.


>
>>> 3) Setting the display attribute affects more than just the contexts =
read or written by the process itself:
>>> - Contexts reported in audit logs,
>>> - Contexts passed across binder (generated in sender context, deliver=
ed to receiver),
>>> - Contexts passed to NFS servers for new files,
>>> - Contexts returned by NFS servers for existing files,
>>> - Netlink-related contexts (?possibly generated in sender context rat=
her than receiver context?),
>>> - This list may not be complete.
>> Any of which can be changed should a more rational behavior be propose=
d.
>> One possibility is to use lsm=3D'value',lsm=3D'value' encoding for int=
ernal
>> communications, but there's been considerable resistance to anything
>> like that.
> These are also security holes waiting to happen.  Processes can use it
> to hide their SELinux contexts from the audit logs, forge different
> SELinux contexts on binder IPC, forge file contexts to which they have
> no SELinux permissions on new files, ... All they need is stacking to
> be enabled and one other module that helpfully lets them set attribute
> values that look like SELinux contexts, and then they can set those
> and switch their display at the right time.

What would you propose as a more rational behavior?
Seriously, I could use some help here.


>>> 4) A security_secid_to_secctx() in one process' context (e.g. sender)=
 or with one display value followed later by a security_secctx_to_secid()=
 call in a different process' context (e.g. receiver) or with a different=
 display value may ask a different security module to perform the reverse=
 translation of the context than the forward translation.
>> Do you have an example of where this might happen?
>> Contexts are rarely used within the kernel. The usual
>> behavior is to generate them, send them out to user space,
>> and delete them. They get cached in some networking code,
>> but not in cases where more than one (existing) security
>> module will ever use them. Binder may be an exception, but
>> only SELinux (currently) supports binder.
> Haven't looked but I don't like the asymmetry of the interface.
> Doesn't matter that only SELinux supports binder if  you ever want any
> other security module other than SELinux enabled at the same time as
> SELinux.

Binder needs another look then.

>> Is that correct?  If so, it seems problematic.
>> Balancing backward compatibility with new behavior is hard!
>> What would you suggest for audit logs? Should we put all LSM
>> data in every record? Is NFS a concern for anyone not using
>> SELinux?
> Yes to all on audit if stacking is going to be real.  And yes, I think
> other security modules will care about NFS if they are serious.

I would love to get feedback from the audit maintainers about
how they would like the multiple LSM data formatted.

NFS is ... challenging. It was supposed to work with Smack
when it went in, but to the best of my understanding never
actually demonstrated.

>> There is no user space that uses display, and it's going
>> to take some time to work out all the kinks before we even
>> think about teaching systemd about it.
> That doesn't make it acceptable to introduce a mechanism that weakens
> security now.

Agreed in principle, not necessarily in detail.


