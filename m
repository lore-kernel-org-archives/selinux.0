Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6N6gb0d027103
 for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2014 02:42:37 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so1041916pdj.7
 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2014 23:42:41 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.83.48])
 by mx.google.com with ESMTPSA id y2sm5272448pas.45.2014.07.22.23.42.39
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Tue, 22 Jul 2014 23:42:40 -0700 (PDT)
Message-ID: <53CF595C.7060209@gmail.com>
Date: Wed, 23 Jul 2014 12:12:36 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: What's a policy capability?
References: <53CA2650.2050608@gmail.com> <53CD0CCB.5080300@tycho.nsa.gov>
 <53CDF09D.4050304@gmail.com> <53CE589C.4030408@tresys.com>
In-Reply-To: <53CE589C.4030408@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/22/14 17:57, Christopher J. PeBenito wrote:
> On 7/22/2014 1:03 AM, dE wrote:
>> On 07/21/14 18:21, Stephen Smalley wrote:
>>> On 07/19/2014 04:03 AM, dE wrote:
>>>> I came cross this term and couldn't find much reference to it.
>>> A mechanism for telling the kernel that your policy supports some new
>>> feature/capability and therefore it is safe for the kernel to enable the
>>> corresponding check/logic.  Used as a way of supporting new
>>> checks/features in a backward-compatible manner:  old policies will not
>>> have defined the policy capability for the new feature and therefore
>>> will not enable the new check/logic by default, while new policies can
>>> opt into or out of the new check/logic at their discretion.
>>>
>> Ok, thanks for clarifying.
>>
>> But just curious -- these new checks may not be not be backwards
>> compatible? I mean if the kernel has enabled a policy feature, but the
>> loaded policy does not have any such capability, then can it cause any
>> problems?
> Yes.  One example is the open permission on file classes.  When that was
> added in the kernel, if you didn't have a policy that had open
> permissions in it, then your system wouldn't work at all; no domain
> would be allowed to open any file.  To fix that, we added the open_perms
> capability, so you could specify that your policy was updated for the
> open permission.
>
>> Also the policy has a version, using that it's capabilities can be known
>> to the kernel and it may enable disable the features based on that. So
>> in this case, why is policy capability required?
> That versions the policy database structure itself, not which object
> classes or permissions are included.  For example, when default_*
> statements were added, the policy structure had to be changed, so the
> policy version was incremented.
>

I've noticed, that there're only 2 policy capabilities in Fedora 19.


That must means this polcap feature is relatively new.
