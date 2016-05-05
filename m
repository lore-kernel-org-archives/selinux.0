Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u45DpgNJ006743
 for <selinux@tycho.nsa.gov>; Thu, 5 May 2016 09:51:42 -0400
Subject: Re: Licence of the new setools icons
To: Laurent Bigonville <bigon@debian.org>, <selinux@tycho.nsa.gov>
References: <ed0f0b63-8fc6-a136-b5c9-950f1abca19b@debian.org>
 <0f85ca94-14ab-5637-de0b-3e61380de26e@tresys.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <bbfcf26d-82fa-3f17-d8b1-c2e29387dbfb@tresys.com>
Date: Thu, 5 May 2016 09:51:15 -0400
MIME-Version: 1.0
In-Reply-To: <0f85ca94-14ab-5637-de0b-3e61380de26e@tresys.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/5/2016 8:46 AM, Christopher J. PeBenito wrote:
> On 5/5/2016 7:46 AM, Laurent Bigonville wrote:
>> Hello,
>>
>> setools(4) includes a new set of icons. The COPYING file included in the
>> same directory states:
>>
[...]
>> This doesn't seems free (as in freedom) as the license doesn't give
>> right to modify the icons.
>>
>> This will make it difficult to include setools in some distro (Debian,
>> Fedora,...).
>>
>> Couldn't the icons already present in the Qt icons theme be used
>> instead? Most of them should have equivalent.
> 
> If the licensing is a problem, then I can look into replacing the icons
> with the Qt icons (patches welcome).

Replacing with standard icons ended up being straightforward and will be
in 4.0.1.

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
