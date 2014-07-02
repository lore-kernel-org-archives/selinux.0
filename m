Message-ID: <53B40C9D.90607@tycho.nsa.gov>
Date: Wed, 02 Jul 2014 09:43:57 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Andy Ruch <adruch2002@yahoo.com>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: semanage commit forces CPU to 100%
References: <1404306318.6656.YahooMailNeo@web120703.mail.ne1.yahoo.com>
In-Reply-To: <1404306318.6656.YahooMailNeo@web120703.mail.ne1.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/02/2014 09:05 AM, Andy Ruch wrote:
> Hello,
>
> I'm experiencing a pretty serious issue when making changes with semanage. I'm running RHEL 6.5 with a custom SELinux policy. The semanage process will lockup and use 100% of the CPU. The only way to stop it is to hard reset the system. When I reset the system, the SELinux policy will sometimes become corrupt, forcing me to re-install the policy. This issue will occur roughly one third of the time I run semanage. I have seen this happen when performing several different actions, including doing an SELinux policy RPM update. For testing, however, I repeatedly run:
>
> semanage user -a -R sysadm_r -R staff_r -r s0-s0:c0.c1023 myuser_u
>
>
> I was able to trace it through the python code to where commit() is being called, but I haven't dug into the C code yet. Has anyone seen anything like this before? It could be a problem with my policy, but why doesn't it happen every time? Any thoughts on where to look in the C code?
>
>

How long is the semanage process at 100% before you do a hard reset? Some 
operations do take a while.

Can you reproduce the issue without your custom policy?

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
