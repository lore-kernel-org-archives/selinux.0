Message-ID: <43B97E72.3070306@tresys.com>
Date: Mon, 02 Jan 2006 14:26:42 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] File Contexts APIs (part 1)
References: <43B086A1.2030007@cornell.edu>
In-Reply-To: <43B086A1.2030007@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> Hi, this patch implemens an API for working with file_contexts.local.
> 
> A file context record is represented as a (regexp, type, context) triple.
> A key is (regexp, type), and matches only if regexp and type match exactly.
> type is block, char, pipe, regular file, all files, etc..
> 
> This key scheme might be too simple, but (as in ports), it seems like more
> complex operations with the key should be pushed into the client.
> 
> The parser is compatible with the current file_contexts format.
> It also allows multi-line records, like all other semanage parsers.
> 
> Note:
>        Unlike ports and interfaces, semanage_fcontext_get_con() can and 
> will
>        return NULL on file specifications without a context (<<none>>).
>        Interfaces and ports do not support <<none>>.
> 
> Note2:
>        Like in ports, I am concerned here about the order of 
> iterate()/list()
>        traversal - I will likely have to reverse it in the dbase code, 
> because it
>        seems backwards.
Matchpathcon already re-sorts contexts (based on exact/inexact matches 
now, and stem specificity once we get some issues resolved). That said, 
the sorts we do are stable, which means if 2 keys have the exact same 
specificity they'll stay in order. This would be an issue with your 
reversal. Just out of curiosity, why not prepend entries to the linked 
list so that they are always in the order of the file (likewise for 
every other record type). It seems strange that the list could 
potentially get reversed on every write (reads in reverse and writes in 
order?)
> 
> Caveats:
>        - there's currently no support for working with the overall
>        file_contexts file, this is just the .local file
> 
>        - validation is missing - needs additional sepol functionality, just
>        like seuser validation
> 
>        - .local file is not installed yet, it stays in the sandbox - 
> needs code to merge
>        .local into the other file_contexts file somehow (or 
> alternatively, the file_contexts.local path
>        should be exposed by libselinux)
> 
we already have a little infrastructure for dealing with file_contexts 
files in libsemanage, however matchpathcon is currently looking for a 
.local file in POLICYTYPE/contexts/files/file_contexts.local so you 
should probably install it there.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
