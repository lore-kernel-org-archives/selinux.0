Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7NM2sw0020163
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 18:02:54 -0400
Received: by mail-oi0-f65.google.com with SMTP id b22so3798139oii.3
 for <selinux@tycho.nsa.gov>; Tue, 23 Aug 2016 15:02:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <082767a3-acab-4d46-6195-06e35251d53e@tycho.nsa.gov>
References: <1471709886.22998.1.camel@trentalancia.net>
 <CAHC9VhRouoqqrq_Vn1A3wh7kwvodUK-j7xR3=uwep7t0Ktdh3w@mail.gmail.com>
 <89E5C3EA-9794-4496-A195-1C997A5BBF44@trentalancia.net>
 <CAGH-KguvJZVLAUYQP_iFk2KG7DDFe9kGADWK_dkbGPHuStjpcQ@mail.gmail.com>
 <43BE5B4F-9AE4-4EDB-825A-F1C15042B385@trentalancia.net>
 <CAHC9VhQOTQNsNT7T53qE5g1pK8BN270ZAFyUJ0xAnzsbPg57YA@mail.gmail.com>
 <1471799849.2544.2.camel@trentalancia.net>
 <1471870947.2354.1.camel@trentalancia.net>
 <1471899875.19333.3.camel@trentalancia.net>
 <1471961693.30659.7.camel@trentalancia.net>
 <082767a3-acab-4d46-6195-06e35251d53e@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 23 Aug 2016 18:02:51 -0400
Message-ID: <CAHC9VhRp80bRirP=p8gqzdf_37ZeuKGxfUVqZqS5p0_X_z71Ug@mail.gmail.com>
Subject: Re: [PATCH v5] Classify AF_ALG sockets
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Guido Trentalancia <guido@trentalancia.net>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Aug 23, 2016 at 10:42 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 08/23/2016 10:14 AM, Guido Trentalancia wrote:
>> Modify the SELinux kernel code so that it is able to classify sockets with
>> the new AF_ALG namespace (used for the user-space interface to the kernel
>> Crypto API).
>>
>> A companion patch has been created for the Reference Policy and it will be
>> posted to its mailing list, once this patch is merged.
>
> 1. Could we reclaim the redhat1 policy capability (originally reserved
> for the ptrace_child capability that was later discarded and is not used
> anywhere), or would that pose any compatibility problems (I don't think
> so, but not entirely sure)?

Yes, we *should* be able to reuse the capability, but some closer
inspection/testing would likely need to be done.  There was a thread
about this somewhere a few months ago ...

> 2. Could we generalize this to support separate classes for every
> address family implemented by Linux rather than doing them piecemeal?

I agree.  I think Guido mentioned this might take some more time, but
that is fine with me, I don't believe there is any hard deadline for
this work.

-- 
paul moore
www.paul-moore.com
