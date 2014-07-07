Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s67E0cF4025087
 for <selinux@tycho.nsa.gov>; Mon, 7 Jul 2014 10:00:38 -0400
Message-ID: <53BAA801.8070308@tresys.com>
Date: Mon, 7 Jul 2014 10:00:33 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>, <selinux@tycho.nsa.gov>
Subject: Re: secilc: is anyone able to confirm that type_change ...
References: <1404563967.9852.42.camel@x220.localdomain>
 <1404652323.9852.49.camel@x220.localdomain>
In-Reply-To: <1404652323.9852.49.camel@x220.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/06/2014 09:12 AM, Dominick Grift wrote:
> On Sat, 2014-07-05 at 14:39 +0200, Dominick Grift wrote:
>> ... rules are no longer honored using policy compiled with any of the
>> recent secilc revisions?
>>
>> My login programs no longer relabel my login tts/pts, even though my
>> policy has, what i believe are, proper type_change rules.
>>
>>
> 
> the compute_relabel command from libselinux-utils does the right thing.
> Still for some reason the login programs do not relabelto the type. (the
> identity is relabeled)
> 
> How can this be? sesearch shows the type_change rules, compute_relabel
> shows the expected result, yet some how all login program's i have tried
> consistently ignore the type (but not the identity)
> 
> I have been running SSHD in debug mode in hopes to get some more
> information but as far as SSHD is concerned all is fine. It almost seems
> it is just not aware of the type (needless to say the type is there and
> usable)
> 

I can't reproduce the problem with my test policies. The typechange
statements look like they are correctly inserted into the binary and I
am seeing the expected type changes at runtime.

Is this with your monogam policy?
