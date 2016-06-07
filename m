Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u57FK4AM018819
 for <selinux@tycho.nsa.gov>; Tue, 7 Jun 2016 11:20:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 07 Jun 2016 11:19:59 -0400
From: John Chludzinski <john.chludzinski@vivaldi.net>
To: Michael Napolitano <mnapolitano@tresys.com>
Cc: Brandon Whalen <brandon@quarksecurity.com>, selinux@tycho.nsa.gov,
 clip@oss.tresys.com
Subject: RE: [Clip] Problem building CLIP ISO
In-Reply-To: <1B1248A9FF092147A781D1BFB389C4FAC5B20C@Exchange10.columbia.tresys.com>
References: <17ff81b08dae0262ca3caa4ee4c4e516@mail.vivaldi.net>
 <9A09501E-CDD5-42FB-BE54-16ED300427E5@quarksecurity.com>
 <0511adc58271fee860d444145cc050d3@mail.vivaldi.net>
 <0aa6135de6910c69df10ed55debb3622@mail.vivaldi.net>
 <1B1248A9FF092147A781D1BFB389C4FAC5B20C@Exchange10.columbia.tresys.com>
Message-ID: <7c06486c50b8f263f16ee6cb5dd9de3f@mail.vivaldi.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Tried below a second time and got:


$ subscription-manager register --username <username> --password 
<password> --auto-attach

Registering to: subscription.rhsm.redhat.com:443/subscription
The system has been registered with ID: 
2021b3d2-3f9b-4a5e-89e2-7c30298a2ccb

No products installed.


Ran:

$ ./bootstrap.sh

... and got past the previous problem.

Now working on new problem:

Failed loading plugin: spacewalk
RHEL optional channel is disabled...enabling
Error: rhel-7-server-optional-rpms is not a valid repository ID. Use 
--list option to see valid repositories.

---John


On 2016-06-07 09:51, Michael Napolitano wrote:
> The bootstrap is attempting to subscribe your machine to the RedHat
> network. The username and password that you are entering need to be
> valid RedHat network credentials.
> 
> -Mike
> 
> -----Original Message-----
> From: clip-bounces@oss.tresys.com [mailto:clip-bounces@oss.tresys.com]
> On Behalf Of John Chludzinski
> Sent: Tuesday, June 07, 2016 9:40 AM
> To: Brandon Whalen
> Cc: selinux@tycho.nsa.gov; clip@oss.tresys.com
> Subject: Re: [Clip] Problem building CLIP ISO
> 
> BTW, $ subscription-manager status
> 
> ... returns:
> 
> +-------------------------------------------+
>     System Status Details
> +-------------------------------------------+
> Overall Status: Unknown
> 
> Therefore the grep fails.
> 
> -----------------------------------------
> 
> Therefore it executes:
> 
> $ subscription-manager --auto-attach register
> 
> ... which results in:
> 
> <username> cannot register with any organizations.
> 
> 
> ---John
> 
> 
> 
> 
> 
> On 2016-06-07 09:33, John Chludzinski wrote:
>> I get to line 141 in bootstrap.sh:
>> 
>> /usr/bin/sudo /usr/bin/subscription-manager status | grep -q "Current"
>> || /usr/bin/sudo /usr/bin/subscription-manager --auto-attach register
>> 
>> 
>> 
>> On 2016-06-06 18:17, Brandon Whalen wrote:
>>>> On Jun 6, 2016, at 5:45 PM, John Chludzinski
>>>> <john.chludzinski@vivaldi.net> wrote:
>>>> 
>>>> I ran:
>>>> 
>>>> $ git clone -b CLIP_RHEL_7.0_Final
>>>> https://github.com/TresysTechnology/clip.git
>>>> 
>>>> As root, I ran:
>>>> 
>>>> $ ./bootstrap.sh
>>>> 
>>>> and got ...
>>>> 
>>>> <username> cannot register with any organizations.
>>>> 
>>>> So I tried:
>>>> 
>>>> $ subscription-manager register --username <username> --password
>>>> <passwor> --auto-attach
>>>> 
>>>> and got ...
>>>> 
>>>> <username> cannot register with any organizations.
>>>> 
>>>> 
>>>> What’s
>>>> the solution?
>>>> 
>>> 
>>> I’ve added the clip mailing list to this thread John. Please use the
>>> CLIP mailing list and not the SELinux one for these types of
>>> questions in the future. The two groups work together but people
>>> don’t always watch both.
>>> 
>>> Did you look at the boostrap.sh script to see what it is doing?
>>> 
>>>> 
>>>> ---John
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>> 
>> _______________________________________________
>> Clip mailing list
>> Clip@oss.tresys.com
>> http://oss.tresys.com/mailman/listinfo/clip
> 
> _______________________________________________
> Clip mailing list
> Clip@oss.tresys.com
> http://oss.tresys.com/mailman/listinfo/clip
