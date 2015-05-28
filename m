MIME-Version: 1.0
In-Reply-To: <55676C25.5040609@tycho.nsa.gov>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
 <20150528190926.GG26667@tamriel.snowman.net>
 <55676C25.5040609@tycho.nsa.gov>
Date: Thu, 28 May 2015 14:40:33 -0500
Message-ID: <CAFPpqQEFQ+RQsbztDUM=2rfb=oy5=J9aAt0mfBFsrte_TfH9iw@mail.gmail.com>
Subject: Re: postgresql policy
From: Ted Toth <txtoth@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In fact I'm using a variant of selinux_check_access in my
sepostgres_check_row_perm function that I called
selinux_check_access_noaudit since the select policy may naturally
fail perm checks on rows that are above the callers level and I don't
want generate audit storms.

On Thu, May 28, 2015 at 2:27 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 05/28/2015 03:09 PM, Stephen Frost wrote:
>> Stephen,
>>
>> * Stephen Smalley (sds@tycho.nsa.gov) wrote:
>>> On 05/28/2015 12:52 PM, Ted Toth wrote:
>>>> The ref policy contains a number of sepgsql_ types that are specific
>>>> to the sepgsql postgresql module. The sepgsql module was written to
>>>> support a postgresql security patch that was never accepted by the
>>>> upstream. Now postgresql has gone in a different direction security
>>>> wise adding row level security (RLS). I've been working on developing
>>>> RLS policy to label rows on insert and update and to check access
>>>> perms on select. I've tried using the sepgsql module in the RLS policy
>>>> but have come to the conclusion that because it was not designed for
>>>> this purpose it is not usable. So I'd like to suggest that these types
>>>> be moved out of the postgresql policy possibly into their own module
>>>> although I personally think they have little if any use.
>>>
>>> Should probably post a rfc patch to refpolicy list.
>>>
>>> On a different note, does this RLS implementation have any SELinux
>>> integration or is it just the typical "let's implement our own custom
>>> policy engine in the database manager and not link it in any way to the
>>> OS security model" approach?  Pity if it is the latter.
>>
>> As the one who committed RLS to PostgreSQL, I'm hopeful that what we
>> have is actually able to provide both.  There is a system inside of
>> PostgreSQL for creating policies, which was a requirement of the PG
>> community as we fully expect it to be used in non-SELinux environments,
>> but there are also hooks available where a module (such as the sepgsql
>> contrib module that's included with PG) could add its own restrictive
>> and/or permissive policies.
>
> Thanks, glad to hear that there are at least hooks available.
>
>> I'm certainly interested in the type changes being discussed here and
>> would love to work with someone from the SELinux community on improving
>> the sepgsql contrib module (or, perhaps, adding a different and simpler
>> module which is closer to a shim around SELinux than the existing
>> sepgsql module).
>
> Yes, the latter might be the best path.  It could use the newer
> selinux_check_access() interface in libselinux for checking whether a
> given permission is granted and avoid having to replicate or directly
> use the lower level interfaces.
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
