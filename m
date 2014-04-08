Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s385rb6w024814
 for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2014 01:53:37 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so537611pbb.33
 for <selinux@tycho.nsa.gov>; Mon, 07 Apr 2014 22:53:37 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.82.248])
 by mx.google.com with ESMTPSA id vd8sm5012569pac.12.2014.04.07.22.53.35
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 07 Apr 2014 22:53:36 -0700 (PDT)
Message-ID: <53438E4D.4040702@gmail.com>
Date: Tue, 08 Apr 2014 11:21:09 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What do you mean by a 'domain'.
References: <53426EC3.6020109@gmail.com> <5342920B.3030308@tycho.nsa.gov>
In-Reply-To: <5342920B.3030308@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/07/14 17:24, Stephen Smalley wrote:
> On 04/07/2014 05:24 AM, dE wrote:
>> Hi!
>>
>> Sorry for the trival question; but on reading various SELinux resources,
>> it appears everyone talks about some 'domain' but no one defines what is
>> it.
>>
>> So I wanna what what is a domain in SELinux.
> See:
> http://www.nsa.gov/research/_files/selinux/papers/policy2/x86.shtml
>

So domain is a SELinux identifier of a process and it's not necessary to 
for each process to have a unique SELinux domain.

I didn't know NSA hosted docs also. Thanks! I'll refer to them instead.
