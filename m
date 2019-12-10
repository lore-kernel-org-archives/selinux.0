Return-Path: <SRS0=5m9B=2A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B7C43603
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ADF2077B
	for <selinux@archiver.kernel.org>; Tue, 10 Dec 2019 19:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="jhSpf07O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLJT5x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:57:53 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:37964
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726362AbfLJT5x (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Dec 2019 14:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1576007871; bh=mxmxrJqpi6L6adJYyNrsXw+e1ZgjXx8wP+mGs8Pj8RM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=jhSpf07OA4cY9JSky654fJSHreQUrKUA0cI+rPvtTs/uPGamy36xRlY/4skYzrMQadWlg7xvA8SCMwUMcFI7K5B34WVfmIVOmswnjd43yu6tWqMgTOioCGRe22mozLGAiMVh8+2ESwIx5WQEgMjvxJxz9UnUXSPRFPG9ZgxRb4WCuSvHEg+IdeCEebmWC1GBDCXZHfpaR2rKGwuTYAbvQoxPH8H7cZv3YijkX/qOhN0quRjPYyhvRM5397vPKIy4tgfTor3WEmH+rFP1amJZuXB2N4nvegU30J+03LQNvYqtLjsWCTWf1ap7XSWJnaYQrs9+SQcw8aSElZyQJRts5Q==
X-YMail-OSG: DRV_BDUVM1mE_4pkuyP8y2_xUsGUGEeQM3tofsqMbTuSuf9MME1ebCCRLcV6KlJ
 an4skSVevvHLxQ4UDKAw5LwHp1s78bolsFLiNMbiEmxzL_A3vK8LdP7CPLIfukLnREvggjtvT4dQ
 HAJG2bDlXmSpTRBDH1_pgJt6dQTjOraxriwn8tevZ58fCRysST4TLSWToYSRkWkWa.9dTfgeLha0
 s1ekg.C0CfyCp.QLhO6amBf5sDzT7zdBWTzTVbDm7hGo6bew_pbuX9a6_b9_twsk3AtcgoklA92T
 w36unxmvlm_TveS2OjjPKbxBxiLeMW6pBI1xkndFOOGnsR7Is3ILkuz8y8Fnfz5zULYrl2dVjFBS
 2GMTY7RFvawyubwvp_FmmaXK9YguZGSMfDyfzI12SA0vMsAYuAeRpGD_ztG1iYsMlfEyPPnUBYtN
 eDkHnCdPYpAvsNOf.f.MyHf1EH0kq1Q20bUd61DWAE9s9Fbza9LimTBqHCPrQwdbwMG2.sS6jvsO
 RPUqhF1Jnq4wF_fiSzJYdesVfZ7wUQ6B9csXu2Gk9KP0.YxssMx_ieTQvYYDysrbLDk598qlcmIv
 8wZrN5n1JdnYdnnMc.UuWweNlz2VBQXNjf_xGtQ3bfPGDgleU0aVof3RRTZXmV15F6Gzj7MJl2.Z
 uWDRIiKJnNzNHb.tBca2Y7n7H1ev8UqdpYGEtWJvaYJSQt7k18NucJVbKymFZbKHW8ikLRvzYQzr
 7NK4FR6Ptlaz_ZvIkfkWhYGvXimh4b3zWzNEMfQ7W.xAk0G0aDQq9VFmxw0lJHhZAIC0ahoB4B5O
 HTNfIYANHjZgfjsL6dhUomw__5tvIaL5IkJmMMkbuFCU2_T4QMcD73YmmbZ4TV7pXBBXhUm_Ck4b
 y.iWIHkoAAJkH98Ecu6yx6TqY6.d3vPf5YAnwvDIhGHCQbdu2URVNRENIguMFzs2PTUer3r1J2Yd
 Ugj69MeQ8bjBY0ueC4XtIomMn2xDdkW3p1ExFaParI1AjifEEyNucf9IJneKF0plpNkB9Ygk3Rju
 k.UJBFqHC_mi77IFFJqurL_M44mV3ps7XmqK5mg0dpEhZ42fg9dEKIVOylzYjDs9tq.obctuW35e
 ofs7EMSXiByTBopYJDrEIUuejNEfOurk2gxGXiZqayY1mm7.HpaeTlSGDbtjkGf5WNL6gf4j8ZfD
 OPXW3on0pppF6xtxTY0LogPaeGiRUvXRC3oYvewooIC3GePFtFk_aDkRJ2ZCLTgrlN1zWqsIIQVW
 _4y0UgB_ACGpia1RFkzmGZs1A7DKOXPPhbq6dWcbFIWxYx_Sugs0ydn77v7wx8ByUtiWHiBfMpUg
 foGDF_nb7AC9ySqHsHa3vjNVwdgwQPBQ7KC1cYRTcWA0pdMIOXdgD5JL626NaJcq5XAXhMlxwRpM
 gIyyECMnnv5bcwSrxEK9toMIL8i3DYQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 10 Dec 2019 19:57:51 +0000
Received: by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID da03eb79ccc50cc025ef77f1c6a55f5f;
          Tue, 10 Dec 2019 19:57:47 +0000 (UTC)
Subject: Re: [PATCH] selinux: reorder hooks to make runtime disable less
 broken
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191209075756.123157-1-omosnace@redhat.com>
 <23671223-f841-564c-6ae8-0401bce0fa20@tycho.nsa.gov>
 <CAFqZXNvMHEvv0tP7ybFEsH1-CvE5GGC9fEP=yXqEnQmjxgdDjA@mail.gmail.com>
 <CAHC9VhRe=xdz9eD9q8mO8=3QDVfsRpn7OUyXDj7o4C-cYfFHMQ@mail.gmail.com>
 <e1d9b641-8de6-9a0a-e6a2-d58c178a184b@schaufler-ca.com>
 <9669d08f-6411-f381-2f2a-59ab1d3fe337@tycho.nsa.gov>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <658a7738-9582-0b16-3803-649e89fbc250@schaufler-ca.com>
Date:   Tue, 10 Dec 2019 11:57:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9669d08f-6411-f381-2f2a-59ab1d3fe337@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/10/2019 11:50 AM, Stephen Smalley wrote:
> On 12/10/19 2:43 PM, Casey Schaufler wrote:
>> On 12/10/2019 11:29 AM, Paul Moore wrote:
>>> On Tue, Dec 10, 2019 at 6:19 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>>>> On Mon, Dec 9, 2019 at 2:21 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>>> On 12/9/19 2:57 AM, Ondrej Mosnacek wrote:
>>>>>> Commit b1d9e6b0646d ("LSM: Switch to lists of hooks") switched the LSM
>>>>>> infrastructure to use per-hook lists, which meant that removing the
>>>>>> hooks for a given module was no longer atomic. Even though the commit
>>>>>> clearly documents that modules implementing runtime revmoval of hooks
>>>>>> (only SELinux attempts this madness) need to take special precautions to
>>>>>> avoid race conditions, SELinux has never addressed this.
>>>>>>
>>>>>> By inserting an artificial delay between the loop iterations of
>>>>>> security_delete_hooks() (I used 100 ms), booting to a state where
>>>>>> SELinux is enabled, but policy is not yet loaded, and running these
>>>>>> commands:
>>>>>>
>>>>>>       while true; do ping -c 1 <some IP>; done &
>>>>>>       echo -n 1 >/sys/fs/selinux/disable
>>>>>>       kill %1
>>>>>>       wait
>>>>>>
>>>>>> ...I was able to trigger NULL pointer dereferences in various places. I
>>>>>> also have a report of someone getting panics on a stock RHEL-8 kernel
>>>>>> after setting SELINUX=disabled in /etc/selinux/config and rebooting
>>>>>> (without adding "selinux=0" to kernel command-line).
>>>>>>
>>>>>> Reordering the SELinux hooks such that those that allocate structures
>>>>>> are removed last seems to prevent these panics. It is very much possible
>>>>>> that this doesn't make the runtime disable completely race-free, but at
>>>>>> least it makes the operation much less fragile.
>>>>>>
>>>>>> An alternative (and safer) solution would be to add NULL checks to each
>>>>>> hook, but doing this just to support the runtime disable hack doesn't
>>>>>> seem to be worth the effort...
>>>>> Personally, I would prefer to just get rid of runtime disable
>>>>> altogether; it also precludes making the hooks read-only after
>>>>> initialization.  IMHO, selinux=0 is the proper way to disable SELinux if
>>>>> necessary.  I believe there is an open bugzilla on Fedora related to
>>>>> this issue, since runtime disable was originally introduced for Fedora.
>>>> I, too, would like to see it gone, but removing it immediately would
>>>> likely cause issues for existing users (see [1]) ...
>>>>
>>>> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1430944#c2
>>> For the record, and for those who didn't click on the RHBZ link above,
>>> I'm a big fan of getting rid of SELinux's runtime disable but concede
>>> that it must be done in such a way to as not horribly break userspace.
>>
>> Is there some reason that changing the "disable SELinux" option
>> has to remove the hooks? Why can't it set selinux_enabled to 0
>> and be done with it?
>
> selinux_enabled is only used during initialization to deal with selinux=0 across the different components of SELinux.  It isn't checked by the hooks themselves.  And if we were to add a if (!selinux_enabled) return 0 to the start of every hook, then that's just another easy target for kernel exploits to leverage.

That's what I expected, but I wanted to see it explicitly stated. Thanks.

