Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9EHemP9017006
 for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2015 13:40:48 -0400
Subject: Re: does load_policy default to loading the lowest polvers available?
To: selinux@tycho.nsa.gov
References: <561E5EF4.9080606@tycho.nsa.gov> <20151014141101.GB5222@x250>
 <561E63E0.1080609@tycho.nsa.gov> <20151014142952.GC5222@x250>
 <561E7840.50903@tycho.nsa.gov> <20151014154828.GA2909@x250>
 <561E7D47.7090306@tycho.nsa.gov> <20151014164145.GA11363@x250>
 <561E8872.3090404@tycho.nsa.gov> <20151014173416.GA15883@x250>
 <20151014173839.GB15883@x250>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <561E937A.9080909@tycho.nsa.gov>
Date: Wed, 14 Oct 2015 13:40:10 -0400
MIME-Version: 1.0
In-Reply-To: <20151014173839.GB15883@x250>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2015 01:38 PM, Dominick Grift wrote:
> On Wed, Oct 14, 2015 at 07:34:16PM +0200, Dominick Grift wrote:
>
>> Setools(4) doesnt work with my policy (it can't deal with cil namespaces
>> seemingly, and returns non-sense)
>
>
> Besides. did you know that setools (4) does not use
> /sys/fs/selinux/policy? It uses /etc/selinux/SELINUXTYPE/policy/policy.X
> instead. This sounded to me like a bad idea. Mainly because you don't
> know if the /etc/selinux/SELINUXTYPE/policy/policy.X is the policy that
> is currently actually loaded into the system.

It should use selinux_current_policy_path() to find the policy.

In any event, did you try compute_av from libselinux on the system in 
question?
