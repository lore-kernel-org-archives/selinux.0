Message-ID: <43F86035.1010401@cornell.edu>
Date: Sun, 19 Feb 2006 07:10:29 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: Joshua Brindle <method@gentoo.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: semanage non MLS breakage
References: <1140150258.13377.15.camel@gorn.pebenito.net>	 <43F561F3.4080200@cornell.edu> <43F5DC70.3070103@gentoo.org>	 <43F5E618.4010001@cornell.edu> <43F5E74C.7050904@gentoo.org>	 <43F5E97B.8060102@cornell.edu> <43F5EB83.30402@gentoo.org>	 <43F5EE32.5080101@cornell.edu>  <43F64063.4040601@cornell.edu> <1140288277.18548.28.camel@gorn.pebenito.net> <43F77E2B.3050108@cornell.edu>
In-Reply-To: <43F77E2B.3050108@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> What I don't like about this is that libsemanage skips the MLS check 
> now, but still proceeds to write any MLS range found to disk. It 
> should invalidate an MLS range if it sees one. Will submit another 
> patch on top of the previous one...
Hmm, I don't know what to do about this...
There's several options:

1) Treat this as fatal error. This is by far the simplest solution - we 
already know when it happens, just make it fatal. Commit is aborted, and 
there's no problem. It seems a bit.... ugly, however, to abort a commit 
for which we clearly have all the data, and the user simply has extra 
data like MLS attached. Nevertheless, considering the options below, I 
think this is probably the best solution.

2) Ignore the problem, call it a feature. The user added MLS context 
into a non-MLS supporting policy - it's his/her fault. He or she can 
clean up the resulting mess. I don't like this approach though - the 
library should be proactive about preventing things that are incorrect, 
instead of creating a bigger problem.

3) Invalidate MLS at the beginning so it never proceeds in the library. 
This means:
       - adding a function to look in the policydb header, and determine 
whether it allows mls - I started to write this once before...
       - using this function in file parsers
       - performing partial validation on individual records through the 
dbase_* functions - I don't like this - I prefer full validation when we 
have information to do it - i.e. with all modules loaded, after the full 
policy has been constructed. This also requires knowing whether the 
policydb allows mls, without having a full policydb (while validation at 
the end doesn't require that).

4) Invalidate MLS where validation is currently done. The problem is that:
       - certain records are validated when they're copied from local 
dbase into sepol, where sepol treats this as non-fatal error, so it 
doesn't fail, informing the caller. No validation occurs directly on the 
local record (so MLS data remains, and can be written to disk)
        - In other cases, validation is done in an iterate() handler. 
Iterate handlers work on a const copy of the record, and the dbase. We'd 
have to change those requirements. This might actually be useful - but 
would require a bit more work in sepol to apply changes after iterate() 
was called with a temporary record.

5) Don't invalidate MLS, simply don't write it to disk. This looks kind 
of like a hack, and not a very good solution - the same problem might 
come up elsewhere. It requires:
     - passing an argument into the print() function that says MLS or no 
MLS.
     - informing database_file.c about that argument, which seems a bit 
wrong - complication created unnecessarily.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
