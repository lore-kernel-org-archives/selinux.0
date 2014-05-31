Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4V5SNKv022075
 for <selinux@tycho.nsa.gov>; Sat, 31 May 2014 01:28:23 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx10so2422433pab.0
 for <selinux@tycho.nsa.gov>; Fri, 30 May 2014 22:28:24 -0700 (PDT)
Received: from [192.168.1.2] ([117.201.83.132])
 by mx.google.com with ESMTPSA id tl3sm28531766pac.41.2014.05.30.22.28.22
 for <selinux@tycho.nsa.gov>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 30 May 2014 22:28:23 -0700 (PDT)
Message-ID: <538967D5.4060001@gmail.com>
Date: Sat, 31 May 2014 10:55:41 +0530
From: dE <de.techno@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: [refpolicy] user_t more restrictive than sshd_t (e.g.)?
References: <537EE13B.7090603@gmail.com> <538441F4.3010104@gmail.com>
 <538493D3.6010305@tresys.com> <538494B3.2030700@tresys.com>
In-Reply-To: <538494B3.2030700@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/14 19:05, Christopher J. PeBenito wrote:
> On 05/27/2014 09:32 AM, Christopher J. PeBenito wrote:
>> On 05/27/2014 03:42 AM, dE wrote:
>>> On 05/23/14 11:18, dE wrote:
>>>> As we know, the user_r does not allow many processes to have high privilege types (system_t for e.g. which's tailored for a single program named X), if such a process is executed, it'll have a type of user_t.
>>>>
>>>> However system_t specifies restrictions on the program exactly as per X's specifications -- it wont allow the program to do anything outside what's it supposed to do.
>>>>
>>>> But that's not the same for user_t -- this type is generic and there are many things that user_t allows which system_t does not.
>>>>
>>>> This may form a security vector; a vulnerable program which should run as system_t but is not run cause user_r does not allow that type, this allows the program to do many things which it's not designed to do; so basically this bypasses SELinux restrictions as put on by system_t.
>>>>
>>>> So, is there any way to prevent this form happening -- or can we specify in the policy what type to run the program as when it's run by a user with role user_r or any other user which is not allowed system_t?
> If there is an exec() that causes a domain/role transition to an invalid context, the exec() will fail.  The program won't run.
>
>

Thanks for forwarding the response.

Unfortunately I've been going thorough more related confusion, so I'm 
sorting them out.
