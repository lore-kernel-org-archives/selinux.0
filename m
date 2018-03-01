From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Vit Mojzis <vmojzis@redhat.com>, selinux <selinux@tycho.nsa.gov>
References: <1498485334.13301.9.camel@tycho.nsa.gov>
 <20180228101510.21023-1-vmojzis@redhat.com>
 <20180228101510.21023-3-vmojzis@redhat.com>
 <CAFftDdq6FSzXqYnEGuXMSo0LXuiHY36yLaipVwyh-Cisgu3Lpw@mail.gmail.com>
 <CAFftDdrLJwF3eeWiYTdaxT=fJL89=pFN=_rZHYEPsh-nZCXanQ@mail.gmail.com>
 <c28bb7c3-fed8-7e33-ed1b-265dbeec97d9@tycho.nsa.gov>
 <CAFftDdq7R7VVX7_deBXQTxqj+JkX25S_v5wxQ+A+Q8EvU=2V+A@mail.gmail.com>
 <CAFftDdpspqtE5cTAkcrJrHc1t5chSAp+MqAw1AvCZRrCTY5onw@mail.gmail.com>
 <75313331-a071-0806-bcc7-f27625f69149@tycho.nsa.gov>
 <CAFftDdohOaMi7Usjd4+=4DxJDP+SOdV9LOQSNOUg9QKiA8xXQQ@mail.gmail.com>
 <6859db2e-60b3-20af-1a5d-546b612ffd93@tycho.nsa.gov>
 <06b07cb5-d37e-0bc2-91ad-3f00faad45af@tycho.nsa.gov>
Message-ID: <9c2d8c9d-5875-0f9e-6a28-cd3e4d9f8d7f@tycho.nsa.gov>
Date: Thu, 1 Mar 2018 09:46:05 -0500
MIME-Version: 1.0
In-Reply-To: <06b07cb5-d37e-0bc2-91ad-3f00faad45af@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 3/3] libsemanage: replace access() checks to make setuid
 programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/01/2018 09:40 AM, Stephen Smalley wrote:
> On 02/28/2018 03:53 PM, Stephen Smalley wrote:
>> On 02/28/2018 02:44 PM, William Roberts wrote:
>>> On Wed, Feb 28, 2018 at 11:39 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> On 02/28/2018 02:26 PM, William Roberts wrote:
>>>>> So peeking through the code base, I see:
>>>>>
>>>>> int semanage_direct_is_managed(semanage_handle_t * sh)
>>>>> {
>>>>> if (semanage_check_init(sh, sh->conf->store_root_path))
>>>>> goto err;
>>>>>
>>>>> if (semanage_access_check(sh) < 0)
>>>>> return 0;
>>>>>
>>>>> return 1;
>>>>>
>>>>>       err:
>>>>> ERR(sh, "could not check whether policy is managed");
>>>>> return STATUS_ERR;
>>>>> }
>>>>>
>>>>> Which semanage_access_check eventually gets down to a raw access check.
>>>>>
>>>>> Which is only ever used in test_fcontext
>>>>>
>>>>> semanage_access_check is also the only consumer of semanage_direct_access_check
>>>>>
>>>>> which is the semanage_store_access_check is only consumed by the
>>>>> former and test case and
>>>>> the same could be said for semanage_store_access_check
>>>>>
>>>>> I think this is a good time to roll in patch 4 and drop everything
>>>>> relying on semanage_store_access_check.
>>>>>
>>>>> Thoughts?
>>>>
>>>> semanage_access_check() is part of the shared library ABI. Can't be
>>>> removed.  Used by seobject.py via the python bindings.  At most, we can
>>>> kill all internal users but the ABI has to remain.
>>>
>>> Ahh yes, duh.
>>>
>>> Outside of just killing off internal users of it, should we modify it
>>> to not use access?
>>> So it at least works under setuid?
>>
>> I don't think it is worthwhile, and it isn't clear how one would test
>> the directory writability case.  Plus semanage_access_check() is only
>> advisory and the caller is free to ignore the result or not call it in
>> the first place.  It is really only intended to allow a program to save
>> itself some work if it isn't going to be able to access the policy store
>> at all, not as a security feature.  Also, as I've said before, I
>> wouldn't warrant libsemanage to be safe if called from a setuid program;
>> no one has ever audited it for such to my knowledge.
> 
> By the way, please test that these patches do not end up yielding silent
> failures or confusing error messages when users run semanage or semodule
> commands with insufficient permissions, e.g. semanage login -l or
> semodule -l as non-root.  That's what semanage_access_check() was for,
> to check up front and provide a useful error message before doing any
> other work.

And for comparison, this is what we get today before these patches:
$ semanage login -l
ValueError: SELinux policy is not managed or store cannot be accessed.

$ semodule -l
libsemanage.semanage_create_store: Could not access module store at
/var/lib/selinux/targeted, or it is not a directory. (Permission denied).
libsemanage.semanage_direct_connect: could not establish direct
connection (Permission denied).
semodule:  Could not connect to policy handler

The messages don't have to be the same, but we need to make sure we have
some useful diagnostic that points to the underlying problem.
