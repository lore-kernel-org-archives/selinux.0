Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4GFZdZU012531
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 11:35:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40mJPq5mCyz25sSX
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 15:34:07 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40mJPq1854z25sSG
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 15:34:07 +0000 (UTC)
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>
Cc: Stephen Smalley <stephen.smalley@gmail.com>,
 selinux <selinux@tycho.nsa.gov>
References: <991a548d-1cdc-5e15-89d9-a36a557429d2@schaufler-ca.com>
 <CAB9W1A1=mRMn_HuUu-Qsxy8goWMW1C3U5eCOTWV1JSj2+9F2BA@mail.gmail.com>
 <ae956be3-3fef-3b87-53b3-75779d3f5286@schaufler-ca.com>
 <d44677e9-65dc-969a-4162-97c447740d2c@tycho.nsa.gov>
 <2e193c01-1a89-7984-f4e1-c37959bcd4b2@schaufler-ca.com>
 <CAHC9VhQgG0dBEP-0JP65nW2V_UbZ5Z=ZymmAsmuYDUzcPtDmxQ@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <9baf02da-0c18-14a8-4c00-f1c983f9b89a@schaufler-ca.com>
Date: Wed, 16 May 2018 08:34:02 -0700
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQgG0dBEP-0JP65nW2V_UbZ5Z=ZymmAsmuYDUzcPtDmxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: Anyone using the SELinux test suite on Fedora 28?
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/15/2018 2:08 PM, Paul Moore wrote:
> On Tue, May 15, 2018 at 10:50 AM, Casey Schaufler
> <casey@schaufler-ca.com> wrote:
>> On 5/15/2018 5:28 AM, Stephen Smalley wrote:
>>> On 05/14/2018 08:10 PM, Casey Schaufler wrote:
>>>> On 5/14/2018 4:48 PM, Stephen Smalley wrote:
>>>>> It's been running fine for me. Maybe you just need to clean your tree and do a fresh make test.
>>>> Did that first thing.
>>>>
>>>> Digging down, I find that the "make -C policy load" is failing.
>>>>
>>>> make[1]: Leaving directory '/home/cschaufler/SELinux/selinux-testsuite/policy/test_policy'
>>>> # General policy load
>>>> <snip>
>>>> I bet the reason it's doing this is obvious. Just not to me.
>>> Add or uncomment expand-check = 0 in /etc/selinux/semanage.conf.
>>> That's noted in the README but used to be the default in Fedora (changed in 28).
>> Yup, that did the trick. Thank you.
>>
>> I suggest that you move the note about expand-check up from "Running the Tests"
>> into "Userland and Base Policy". With the Fedora 28 change it's much more likely
>> to be an issue.
> Let's just add a check to the Makefile before we attempt to load the
> policy.  People are more likely to notice a meaningful error message
> than they are instructions in the docs.  Check the patch I just sent
> to the list.

I think that will do just fine. Thank you.
