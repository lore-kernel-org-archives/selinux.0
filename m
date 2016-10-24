From: Sean Hulbert <SHulbert@toolwire.com>
To: William Roberts <bill.c.roberts@gmail.com>, Stephen Smalley
 <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: RE: Question for the experts -- DIRTY COW and SELinux
Date: Mon, 24 Oct 2016 16:56:58 +0000
Message-ID: <EA758101A93318408A4B275BA3C215C4F5E88F3F@MBX023-W1-CA-2.exch023.domain.local>
References: <1477088418.3651.15.camel@chicago.vc>
 <576dac61-bebb-cdd2-f69d-ce369a79cede@tycho.nsa.gov>
 <CAGReGbQBMVbNRVp9s0s6iJEBDP0pDVgOS+ys--5EJzVS34M6RA@mail.gmail.com>
 <1a2c8dc5-5d39-5cc6-4928-5f7dd111ef44@tycho.nsa.gov>
 <CAFftDdoJ-Z8eYLQHWZbNDcneJ2zcGUCiFr2jgg9bvfMv5rnxCQ@mail.gmail.com>
In-Reply-To: <CAFftDdoJ-Z8eYLQHWZbNDcneJ2zcGUCiFr2jgg9bvfMv5rnxCQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

To help mitigate this old exploit. I would get Tripwire or file integrity monitor like AIDE - (Advanced Intrusion Detection Environment), enable Sudoer.  Then I would take it a bit further and jail user accounts and enable passphrase RSA certificate in order to run any executable.  

If a person has root access to the box to run the gcc compiler to install Dirty Cow, then you have bigger problems than this exploit.

Physical access is total access

Or you can just upgrade your kernel to a patched version.

Thank You
Sean Hulbert
 

If you have heard of a hacker by name, he/she has failed, fear the hacker you haven't heard of! 

CONFIDENTIALITY NOTICE: This communication with its contents may contain confidential and/or legally privileged information. It is solely for the use of the intended recipient(s). Unauthorized interception, review, use or disclosure is prohibited and may violate applicable laws including the Electronic Communications Privacy Act. If you are not the intended recipient, please contact the sender and destroy all copies of the communication.

igitur qui desiderat pacem, praeparet bellum!!!

Epitoma Rei Militaris
 

-----Original Message-----
From: Selinux [mailto:selinux-bounces@tycho.nsa.gov] On Behalf Of William Roberts
Sent: Monday, October 24, 2016 9:17 AM
To: Stephen Smalley
Cc: SELinux
Subject: Re: Question for the experts -- DIRTY COW and SELinux

On Mon, Oct 24, 2016 at 8:03 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/24/2016 10:42 AM, Judd Meinders wrote:
>> On Mon, Oct 24, 2016 at 9:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> On 10/21/2016 06:20 PM, Robert Lee wrote:
>>>> Given the unpleasant nature of CVE-2016-5195, would an SELinux 
>>>> confined application that exploited the Dirty COW vulnerability be 
>>>> capable also of escaping domain enforcement?
>>>>
>>>> Hopefully my question is not ambiguous.
>>>>
>>>> Thanks in advance.
>>>
>>> Sorry, SELinux can't help with CVE-2016-5195.
>>
>> Couldn't SELinux help reduce the attack surface.  From the small 
>> amount of testing I have conducted, it looks like the attacker is 
>> required to be able to read the file or object they are trying to 
>> manipulate.  If MAC denies read, the attack doesn't work right?
>>
>> Please let me know if I'm mistaken.
>
> For files, yes (but plenty of files that must be normally readable can 
> be written via it).

In theory, yes, as Stephen points out, but many things are needed to be readable or things break.

Assuming something like preventing read of all setuid root binaries or policy preventing any type of transition on exec of a setuid binary, you may be able to limit some of the damage, if getting a root execution was what you wanted to stop.

But considering that this will allow one to bypass write protection on any file, means, you likely don't need just a "root shell". Consider modifying shared libraries, passwd files, etc.

Iv'e only looked at it briefly, and I thought this write-up was good, for those intested in more:
http://www.theregister.co.uk/2016/10/21/linux_privilege_escalation_hole/


Doesn't help at all for vDSO-based root.
> SELinux ptrace checks are also not useful here because introspection 
> is always allowed by the kernel (whether or not that is a good idea is 
> open to debate).
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



--
Respectfully,

William C Roberts
_______________________________________________
Selinux mailing list
Selinux@tycho.nsa.gov
To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
