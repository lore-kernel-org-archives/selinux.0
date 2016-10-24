MIME-Version: 1.0
In-Reply-To: <1a2c8dc5-5d39-5cc6-4928-5f7dd111ef44@tycho.nsa.gov>
References: <1477088418.3651.15.camel@chicago.vc>
 <576dac61-bebb-cdd2-f69d-ce369a79cede@tycho.nsa.gov>
 <CAGReGbQBMVbNRVp9s0s6iJEBDP0pDVgOS+ys--5EJzVS34M6RA@mail.gmail.com>
 <1a2c8dc5-5d39-5cc6-4928-5f7dd111ef44@tycho.nsa.gov>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 24 Oct 2016 09:17:28 -0700
Message-ID: <CAFftDdoJ-Z8eYLQHWZbNDcneJ2zcGUCiFr2jgg9bvfMv5rnxCQ@mail.gmail.com>
Subject: Re: Question for the experts -- DIRTY COW and SELinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Judd Meinders <judd.meinders@rockwellcollins.com>,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Oct 24, 2016 at 8:03 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/24/2016 10:42 AM, Judd Meinders wrote:
>> On Mon, Oct 24, 2016 at 9:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> On 10/21/2016 06:20 PM, Robert Lee wrote:
>>>> Given the unpleasant nature of CVE-2016-5195, would an SELinux confined
>>>> application that exploited the Dirty COW vulnerability be capable also
>>>> of escaping domain enforcement?
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

In theory, yes, as Stephen points out, but many things are needed to be readable
or things break.

Assuming something like preventing read of all setuid root binaries or policy
preventing any type of transition on exec of a setuid binary, you may be
able to limit some of the damage, if getting a root execution was what
you wanted to stop.

But considering that this will allow one to bypass write protection on any
file, means, you likely don't need just a "root shell". Consider modifying
shared libraries, passwd files, etc.

Iv'e only looked at it briefly, and I thought this write-up was good, for those
intested in more:
http://www.theregister.co.uk/2016/10/21/linux_privilege_escalation_hole/


Doesn't help at all for vDSO-based root.
> SELinux ptrace checks are also not useful here because introspection is
> always allowed by the kernel (whether or not that is a good idea is open
> to debate).
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
