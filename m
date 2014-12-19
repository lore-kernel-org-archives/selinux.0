Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBJK2LRV001471
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 15:02:21 -0500
Message-ID: <54948452.4010000@schaufler-ca.com>
Date: Fri, 19 Dec 2014 12:02:26 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: eric gisse <jowr.pi@gmail.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Some of our customers are looking to turn on SELinux but they
 also want to use CSP from Symantec
References: <54945543.7090706@redhat.com>
 <CAHZ_Ajv=-P5baKoGNXgd-v9SAZhXkVmc2DpaBrVh2_ErSoQF_Q@mail.gmail.com>
In-Reply-To: <CAHZ_Ajv=-P5baKoGNXgd-v9SAZhXkVmc2DpaBrVh2_ErSoQF_Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/19/2014 11:44 AM, eric gisse wrote:
>> Why disabling SELinux is important? Because both SELinux and CSP are doing the same thing, except CSP does it better!
> I wonder how Symantec backs that claim up.

Emphatic assertion. It's a very popular form of argument in the security realm.

>
> On Fri, Dec 19, 2014 at 10:41 AM, Daniel J Walsh <dwalsh@redhat.com> wrote:
>> Currently Symantec requires SELinux be disabled, claiming there is
>> conflicts in the kernel modules.
>>
>> http://www.symantec.com/connect/forums/does-scsp-agent-support-selinux
>>
>> As the customer wants to take advantage of certain  SELinux features
>> like sVirt for VMs and Docker Containers, this conflict is coming to a head.
>>
>> Is anyone familiar with whether or not this is a real conflict or just
>> something assumed by Symantec?
>>
>> The customer like Symantec's ability to do intrusion detection and
>> remote logging and configuration of CSB.
>>
>> Bottom line the customer wants both.
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
