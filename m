Message-ID: <53C3EE48.6050704@tresys.com>
Date: Mon, 14 Jul 2014 10:50:48 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, Stephen Smalley
 <sds@tycho.nsa.gov>
Subject: Re: Showing port Labels
References: <53C37D83.9050705@davequigley.com>
 <1405329902.661.30.camel@x220.localdomain> <53C3D401.6030207@tycho.nsa.gov>
 <1405344305.661.33.camel@x220.localdomain>
In-Reply-To: <1405344305.661.33.camel@x220.localdomain>
Content-Type: text/plain; charset="us-ascii"
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 7/14/2014 9:25 AM, Dominick Grift wrote:
> On Mon, 2014-07-14 at 08:58 -0400, Stephen Smalley wrote:
> < snip >
> 
>>> It is probably not the answer you were looking for but i suppose I would
>>> use seinfo --portcon
>>
>> sepolicy network -p <portnumber>
>>
>>
> 
> Yes, but i prefer minimal/small (and preferably no interpreters):
> 
> # file /usr/bin/seinfo
> /usr/bin/seinfo: ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
> dynamically linked (uses shared libs), for GNU/Linux 2.6.32,
> BuildID[sha1]=04ae4e364753b502f227216e548e1ccbf0f33e14, stripped
> 
> # file /usr/bin/sepolicy
> /usr/bin/sepolicy: Python script, ASCII text executable, with very long
> lines

sepolicy is using libapol from setools, so its not really different than
seinfo, other than using a Python frontend.  Since SETools 4 is Python,
you'll eventually be running low on choices if you're trying to stick to
only C tools :)

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
