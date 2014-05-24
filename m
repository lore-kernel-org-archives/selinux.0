Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4O3fwPC010835
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2014 23:41:58 -0400
Received: by mail-pa0-f54.google.com with SMTP id bj1so4946508pad.13
 for <selinux@tycho.nsa.gov>; Fri, 23 May 2014 20:41:59 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.88.118])
 by mx.google.com with ESMTPSA id qw8sm6991442pbb.27.2014.05.23.20.41.57
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 23 May 2014 20:41:58 -0700 (PDT)
Message-ID: <53801468.5080208@gmail.com>
Date: Sat, 24 May 2014 09:09:20 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Significance of SELinux user and roles on objects.
References: <537AE191.7070403@gmail.com> <537B5BD3.4090507@tresys.com>
 <537D9F47.7020704@gmail.com> <1400743958.10370.0.camel@x220.localdomain>
 <537F5039.5070806@tycho.nsa.gov> <537F6D02.2010801@gmail.com>
 <537F6F7A.7090805@tycho.nsa.gov>
In-Reply-To: <537F6F7A.7090805@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/23/14 21:25, Stephen Smalley wrote:
> On 05/23/2014 11:45 AM, dE wrote:
>> On 05/23/14 19:12, Stephen Smalley wrote:
>>> On 05/22/2014 03:32 AM, Dominick Grift wrote:
>>>> On Thu, 2014-05-22 at 12:25 +0530, dE wrote:
>>>>> On 05/20/14 19:12, Christopher J. PeBenito wrote:
>>>>>> The kernel will create files with object_r regardless
>>>>> Is this defined in the policy or is hard coded in the kernel?
>>>> Hard coded into the kernel
>>> Unless the policy specifies to default from source or target for the
>>> file class...
>>>
>>>
>> So you can define the default object in the policy file as per the
>> object class.
> See:
> http://selinuxproject.org/page/DefaultRules
>

Ok. So this's comparatively a new feature. Thanks for sharing.
