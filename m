Subject: Re: user guide drafts: Archiving Files with tar/star
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Murray McAllister <mmcallis@redhat.com>
Cc: russell@coker.com.au, Daniel J Walsh <dwalsh@redhat.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48EEB91C.4080205@redhat.com>
References: <48EDAE09.8070903@redhat.com> <48EDEFB9.9090702@redhat.com>
	 <48EE9415.6050902@redhat.com> <200810101251.30094.russell@coker.com.au>
	 <48EEB91C.4080205@redhat.com>
Content-Type: text/plain
Date: Fri, 10 Oct 2008 08:57:39 -0400
Message-Id: <1223643459.25569.27.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2008-10-10 at 12:08 +1000, Murray McAllister wrote:
> Russell Coker wrote:
> > On Friday 10 October 2008 10:30, Murray McAllister <mmcallis@redhat.com> 
> > wrote:
> >>> tar xvf file.tgz | restorecon -f -
> >>>
> >>> Would reset the file context on disk after the extraction.
> >> Does this only apply to the tar file itself, not the files in it? On
> >> rawhide the extracted files (that have extended attributes) inherit the
> >> type of the directory they are being extracted in.
> > 
> > The "v" option of tar causes it to list on stdout all the files it extracts.
> > 
> > The -f- option of restorecon makes it take a list of files to relabel on 
> > stdin.  So it relabels all files extracted from the tar file.
> > 
> > The inheriting of file contexts from a directory (in the absence of policy 
> > rules specifying otherwise) has AFAIK always been the design of SE Linux.
> 
> When would "tar | restorecon -f -" be used if files inherit contexts 
> from parent directories (if policy has not be changed)? Sorry, I am a 
> bit slow :)

restorecon consults the file_contexts configuration, which maps pathname
regular expressions to the appropriate security context to assign to a
file when it is installed.  tar xf foo.tar by itself will merely apply
the usual runtime creation logic for file labeling, i.e. compute the
context of the new files from the combination of the creating process
context (user, level) and the parent directory (type) or type_transition
rule.  tar xvf foo.tar | restorecon -f - should reset the file contexts
to the original install-time file contexts defined by the file contexts
configuration.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
