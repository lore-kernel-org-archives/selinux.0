Subject: Re: Question for the experts -- DIRTY COW and SELinux
To: Judd Meinders <judd.meinders@rockwellcollins.com>
References: <1477088418.3651.15.camel@chicago.vc>
 <576dac61-bebb-cdd2-f69d-ce369a79cede@tycho.nsa.gov>
 <CAGReGbQBMVbNRVp9s0s6iJEBDP0pDVgOS+ys--5EJzVS34M6RA@mail.gmail.com>
Cc: Robert Lee <robert.lee@chicago.vc>, SELinux <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1a2c8dc5-5d39-5cc6-4928-5f7dd111ef44@tycho.nsa.gov>
Date: Mon, 24 Oct 2016 11:03:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAGReGbQBMVbNRVp9s0s6iJEBDP0pDVgOS+ys--5EJzVS34M6RA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/24/2016 10:42 AM, Judd Meinders wrote:
> On Mon, Oct 24, 2016 at 9:35 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>> On 10/21/2016 06:20 PM, Robert Lee wrote:
>>> Given the unpleasant nature of CVE-2016-5195, would an SELinux confined
>>> application that exploited the Dirty COW vulnerability be capable also
>>> of escaping domain enforcement?
>>>
>>> Hopefully my question is not ambiguous.
>>>
>>> Thanks in advance.
>>
>> Sorry, SELinux can't help with CVE-2016-5195.
> 
> Couldn't SELinux help reduce the attack surface.  From the small
> amount of testing I have conducted, it looks like the attacker is
> required to be able to read the file or object they are trying to
> manipulate.  If MAC denies read, the attack doesn't work right?
> 
> Please let me know if I'm mistaken.

For files, yes (but plenty of files that must be normally readable can
be written via it).  Doesn't help at all for vDSO-based root.
SELinux ptrace checks are also not useful here because introspection is
always allowed by the kernel (whether or not that is a good idea is open
to debate).
