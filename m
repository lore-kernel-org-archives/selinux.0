Subject: Re: user guide drafts: Maintaining SELinux Labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>,
        Glenn Faden <Glenn.Faden@sun.com>, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48ED4FBC.4020303@redhat.com>
References: <737og9$5vh3i@dmzms99902.na.baesystems.com>
	 <48ED4FBC.4020303@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 08:55:19 -0400
Message-Id: <1223643319.25569.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2008-10-09 at 10:26 +1000, Murray McAllister wrote:
> Clarkson, Mike R (US SSA) wrote:
> > 
> >> -----Original Message-----
> >> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov]
> > On
> >> Behalf Of Glenn Faden
> >> Sent: Wednesday, October 08, 2008 8:46 AM
> >> To: Daniel J Walsh
> >> Cc: Murray McAllister; SE Linux
> >> Subject: Re: user guide drafts: Maintaining SELinux Labels
> >>
> >> Daniel J Walsh wrote:
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> Murray McAllister wrote:
> >>>
> >>>> Hi,
> >>>>
> >>>> The following are the first few drafts of the "Maintaining SELinux
> >>>> Labels" sections. Any comments and corrections are appreciated.
> >>>>
> >>>> Cheers.
> >>>>
> >>>> Copying Files and Directories
> >>>>
> >>>> When files and directories are copied, they inherit the SELinux
> > context
> >>>> of the parent directory they are copied to. This helps ensure files
> > and
> >>>> directories are labeled with the correct SELinux context after
> > being
> >>>> moved. The following example demonstrates copying a file from a
> > user's
> >>>> home directory to /var/www/html/, which is used by the Apache HTTP
> >>>> Server. Since the file is copied, it inherits the correct SELinux
> >> context:
> >> Is this true when using MLS policy? Assuming the policy allows a
> > subject
> >> to create a file in a directory, shouldn't the newly created file's
> >> SELinux context have the same sensitivity as the subject who wrote it?
> > 
> >> Or is the new file's type copied from the directory and the
> > sensitivity
> >> copied from the subject?
> > 
> > You are correct, the type is copied from the directory and the level is
> > copied from the subject. It might also be worth mentioning that the type
> > is copied from the directory as default behavior, which can be
> > overridden with type_transition statements.
> > 
> >> --Glenn
> I've changed the first paragraph. How about:
> 
> When files and directories are copied, they inherit the SELinux context 
> of the parent directory they are copied to[1].

Not exactly, no.  The security context of a new file is computed from a
combination of the security context of the creating process and the
security context of the parent directory, and may further be adjusted by
policy rules.  The user identity and level are inherited from the
creating process.  The role is always object_r presently.  The type is
inherited from the parent directory unless there is a type transition
rule in the policy for the (creating process domain, parent directory
type, file object class) triple.  For example, when a process creates a
file in /tmp, there is usually a type transition rule defined such that
each domain gets its own private temporary file type.

>  This helps ensure files 
> and directories are labeled with the correct SELinux context after being 
> copied. Also, when a file is copied over an existing file, the existing 
> file's context is maintained.

Unless the user specified options to cp to preserve the context of the
original on the copy.

>  On systems running the MLS policy, when 
> files are copied, they inherit the type from the parent directory they 
> are being copied to, and the level from the process that copied them.
> 
> Is the last sentence, is "the level from the process that copied them" 
> correct? Should it be "from the process or user that..."?
> 
> [1] By default, the type is copied from the parent directory. This 
> behavior can be overridden by using type_transition statements in custom 
> SELinux policies.
> 
> I've included an example at the end of the section to show copying a 
> file over an existing one.
> 
> Thanks for your feedback.
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
