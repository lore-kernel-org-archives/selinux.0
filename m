Date: Sun, 12 Oct 2003 13:52:51 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Joshua Brindle <JBrindle@snu.edu>
Cc: SELinux@tycho.nsa.gov
Subject: Re: selinux from user POV
Message-ID: <20031012035251.GA24474@snoopy.apana.org.au>
References: <sf880644.030@atlas.snu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <sf880644.030@atlas.snu.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(note: my connection has been down, and mail is only just starting
to come it; I don't know if anyone else has replied yet, but I will
bite anyway).

On Sat, Oct 11, 2003 at 01:29:07PM -0500, Joshua Brindle wrote:
> 1.An admin could cron relabeling to the /home partition, this is hackish
> and doesn't seem like a good solution to me..
> 
> 2. Could give users access to a limited setfiles script with a limited 
> read-only file_contexts file that they can use on their own directories,
> they'd also have to be given permission to label ssh types.. (ick)
> it would also require additional user knowledge.. users aren't prone
> to learn _anything_
> 
> --- nsa guys really won't like these---
> 
> 3. Trap file creation in glibc and use a limited file_contexts that
> glibc can read and setfscreatecon just before opening it for 
> creation. This suffers from being in the context of whatever 
> called for the file creation so many domains would possibly have
> to be given relabel permissions. 

This would not work without spawning a seperate process to do
the relabeling.

> 4. (This one may be over complicated but seems like the most
> transparent solution). Load the file_contexts file into the kernel, 
> NOT for enforcement of labels for files that already exist but
> only for creation of new files. hook around open file, if it's being
> created assign it's label, the file_contexts loaded into the kernel
> could be limited to avoid any possible security hazards, this would
> eliminate the need to assign relabeling permissions to user contexts
> and application contexts that may need to create files in the user
> home dirs.. (mail daemons, etc). 

This would mean moving policy type decisions into the kernel.
IMHO we should be removing as much as possible from the kernel,
not adding to it.

Maybe, I guess the kernel could invoke a user level process when a
directory is created (hmmm... Sounds a bit like the Dazuko kernel patch
or possibly fam could be used), but I am not sure I like this approach.

My preference is a user level solution.

First off, why is this an issue in this first place?

Answer: because users home directories have already been created
without adding the these directories or setting the SE-Linux types.

Suggestion(1): would it be better if adduser and/or useradd was modified
to allow hooks to do this automatically?

Obviously this isn't going to work for existing users.

Suggestion(2). Use script/program, as in (1) that any user can run that
will automatically setup all(?) their directories to use defaults?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
