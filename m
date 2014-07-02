Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s62G7Wm4026993
 for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2014 12:07:33 -0400
References: <1404306318.6656.YahooMailNeo@web120703.mail.ne1.yahoo.com>
 <53B40C9D.90607@tycho.nsa.gov>
Message-ID: <1404317250.56434.YahooMailNeo@web120705.mail.ne1.yahoo.com>
Date: Wed, 2 Jul 2014 09:07:30 -0700
From: Andy Ruch <adruch2002@yahoo.com>
Subject: Re: semanage commit forces CPU to 100%
To: James Carter <jwcart2@tycho.nsa.gov>, SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <53B40C9D.90607@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Reply-To: Andy Ruch <adruch2002@yahoo.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>










> On Wednesday, July 2, 2014 7:42 AM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> > On 07/02/2014 09:05 AM, Andy Ruch wrote:
> 
>>  Hello,
>> 
>>  I'm experiencing a pretty serious issue when making changes with 
> semanage. I'm running RHEL 6.5 with a custom SELinux policy. The semanage 
> process will lockup and use 100% of the CPU. The only way to stop it is to hard 
> reset the system. When I reset the system, the SELinux policy will sometimes 
> become corrupt, forcing me to re-install the policy. This issue will occur 
> roughly one third of the time I run semanage. I have seen this happen when 
> performing several different actions, including doing an SELinux policy RPM 
> update. For testing, however, I repeatedly run:
>> 
>>  semanage user -a -R sysadm_r -R staff_r -r s0-s0:c0.c1023 myuser_u
>> 
>> 
>>  I was able to trace it through the python code to where commit() is being 
> called, but I haven't dug into the C code yet. Has anyone seen anything like 
> this before? It could be a problem with my policy, but why doesn't it happen 
> every time? Any thoughts on where to look in the C code?
>> 
>> 
> 
> How long is the semanage process at 100% before you do a hard reset? Some 
> operations do take a while.
> 
> Can you reproduce the issue without your custom policy?
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>



When the command works, it will take a few seconds. When it fails, I've waited up to 10 minutes and it still never returns.

Unfortunately, my system is pretty customized so I can't run the targeted policy on there. When I do a straight RHEL install, I can't get it to fail (in the limited testing that I did). That's why I suspect it's my policy, but I'm not sure why it would only fail some of the time.
