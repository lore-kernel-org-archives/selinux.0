Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s06F5CCQ032197
 for <selinux@tycho.nsa.gov>; Mon, 6 Jan 2014 10:05:12 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so18087836pde.6
 for <selinux@tycho.nsa.gov>; Mon, 06 Jan 2014 07:05:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1401070200000.5247@tundra.namei.org>
References: <231455217.pFFWomdpV7@sifl>
 <alpine.LRH.2.02.1401070200000.5247@tundra.namei.org>
Date: Mon, 6 Jan 2014 10:05:10 -0500
Message-ID: <CAHC9VhRkPHVqcFmKZ31xBrdK3s4wTQ6Gsc4TWAFJEUQfS_Fvgg@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux patches for 3.14
From: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Jan 6, 2014 at 10:00 AM, James Morris <jmorris@namei.org> wrote:
> On Thu, 2 Jan 2014, Paul Moore wrote:
>
>> Hi James,
>>
>> With 3.13-rc6 out, it looks like it is time to pass along the SELinux pull
>> request for 3.14.  The tree below includes the patches listed here as well as
>> the 3.13-rcX fixes I've sent you previously (I've omitted the 3.13-rcX fixes
>> in the list below for the sake of clarity).  Of the five new patches here, all
>> but Richard's patch are fixes, and minor ones at that.
>>
>> On a sorta related note, over the past month or two, I've learned that my
>> simplistic approach to managing the SELinux tree is just a wee bit too
>> simplistic.  After the 3.14 merge window closes I'm going to move to a branch
>> based approach which should make things a bit easier for everyone (okay,
>> mostly me) when it comes to -next and -stable.
>>
>> Enjoy,
>> -Paul
>>
>> ---
>>
>> The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:
>>
>>   Linux 3.12 (2013-11-03 15:41:51 -0800)
>>
>> are available in the git repository at:
>>
>>   git://git.infradead.org/users/pcmoore/selinux master
>
> I resync'd my next branch for the TPM pull, and I've now pulled your
> request in, too.

Great, thanks.

-- 
paul moore
www.paul-moore.com
