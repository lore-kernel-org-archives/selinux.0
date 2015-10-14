Subject: Re: does load_policy default to loading the lowest polvers available?
To: Stephen Smalley <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
References: <561E5EF4.9080606@tycho.nsa.gov> <20151014141101.GB5222@x250>
 <561E63E0.1080609@tycho.nsa.gov> <20151014142952.GC5222@x250>
 <561E7840.50903@tycho.nsa.gov> <20151014154828.GA2909@x250>
 <561E7D47.7090306@tycho.nsa.gov> <20151014164145.GA11363@x250>
 <561E8872.3090404@tycho.nsa.gov> <20151014173416.GA15883@x250>
 <20151014173839.GB15883@x250> <561E937A.9080909@tycho.nsa.gov>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-ID: <561EBB6A.1080907@tresys.com>
Date: Wed, 14 Oct 2015 16:30:34 -0400
MIME-Version: 1.0
In-Reply-To: <561E937A.9080909@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2015 1:40 PM, Stephen Smalley wrote:
> On 10/14/2015 01:38 PM, Dominick Grift wrote:
>> On Wed, Oct 14, 2015 at 07:34:16PM +0200, Dominick Grift wrote:
>>
>>> Setools(4) doesnt work with my policy (it can't deal with cil namespaces
>>> seemingly, and returns non-sense)

Dominick, would you mind sending me your policy off-list so I can debug
this?

>> Besides. did you know that setools (4) does not use
>> /sys/fs/selinux/policy? It uses /etc/selinux/SELINUXTYPE/policy/policy.X
>> instead. This sounded to me like a bad idea. Mainly because you don't
>> know if the /etc/selinux/SELINUXTYPE/policy/policy.X is the policy that
>> is currently actually loaded into the system.
> 
> It should use selinux_current_policy_path() to find the policy.

It does use it, but as a fallback. I've since changed the code to try
the selinux_current_policy_path() first.


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com
