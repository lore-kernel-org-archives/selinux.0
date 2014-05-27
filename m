Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4RDUYXY009884
 for <selinux@tycho.nsa.gov>; Tue, 27 May 2014 09:30:34 -0400
Message-ID: <538493D3.6010305@tresys.com>
Date: Tue, 27 May 2014 09:32:03 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, <selinux@tycho.nsa.gov>, Refpolicy Mail List
 <refpolicy@oss1.tresys.com>
Subject: Re: user_t more restrictive than sshd_t (e.g.)?
References: <537EE13B.7090603@gmail.com> <538441F4.3010104@gmail.com>
In-Reply-To: <538441F4.3010104@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/27/2014 03:42 AM, dE wrote:
> On 05/23/14 11:18, dE wrote:
>> As we know, the user_r does not allow many processes to have high privilege types (system_t for e.g. which's tailored for a single program named X), if such a process is executed, it'll have a type of user_t.
>>
>> However system_t specifies restrictions on the program exactly as per X's specifications -- it wont allow the program to do anything outside what's it supposed to do.
>>
>> But that's not the same for user_t -- this type is generic and there are many things that user_t allows which system_t does not.
>>
>> This may form a security vector; a vulnerable program which should run as system_t but is not run cause user_r does not allow that type, this allows the program to do many things which it's not designed to do; so basically this bypasses SELinux restrictions as put on by system_t.
>>
>> So, is there any way to prevent this form happening -- or can we specify in the policy what type to run the program as when it's run by a user with role user_r or any other user which is not allowed system_t?
>>
>> As an e.g. we may see systemctl.
> 
> Is this concern real?

Moving thread to refpolicy mail list.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
