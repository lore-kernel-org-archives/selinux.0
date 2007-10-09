Subject: Re: Shell redirection and denials
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1191870537.14569.23.camel@localhost.localdomain>
References: <1191870537.14569.23.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 10:37:40 -0400
Message-Id: <1191940660.24970.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-08 at 15:08 -0400, Karl MacMillan wrote:
> One of Dan's constant sources of avcs is something like:
> 
> /usr/sbin/my_confined_app > some_file
> 
> Because the file is created by the shell, opened, and the FD handed to
> the application avcs can occur on read and write.
> 
> Getting rid of these via policy is next to impossible - the destination
> file type is usually governed by the directory and we don't actually
> want to allow that access directly to the confined application. I'd like
> to see if there is some other way to get rid of these denials.
> 
> I see two possible solutions:
> 
> 1) Make the shell create and pass a descriptor to a pipe to the
> application - the shell itself would read / write to the file. This
> seems, to me, to more accurately reflect how we want to enforce the
> permissions.
> 
> 2) Allow applications to confer access by passing the file descriptor
> (more like capabilities). This more closely matches how Unix actually
> works and, of course, is a huge source of vulnerabilities. Allowing this
> type of scheme just for shells might not be that bad.
> 
> Has either of these been investigated? 1 seems pretty simple - is there
> something I'm missing here (perhaps the redirection should outlast the
> shell lifetime?).

I believe we've told people to do (1) manually in the past (not
automatically in the shell, but via the command line ala httpd -t |
cat), and making that happen transparently in the shell would be a
usability win.  But doing it always in the shell has implications for
performance and scalability; the shell then becomes a major bottleneck.
The shell could conceivably do a permission check to see whether the
indirection is required, but that means that user shells always need
permission to compute access decisions or that the shell would fall back
to always using the indirection if it lacks permission to check for
that.

(2) requires a kernel change, and requires care to avoid losing our
ability to control propagation of access rights in accordance with
policy (fundamental to MAC). I don't think you want the shell to be able
to arbitrarily pass any descriptor, but being able to distinguish in
policy between open (open_read, open_write) vs. transfer (transfer_read,
transfer_write) vs. use (read, write) could be useful so that you can
allow a process to inherit and use a descriptor without being able to
directly open the file.  DTOS had similar kinds of distinctions via
separate permissions on holding, using, and transferring port rights.
But policy would still need to allow use to all desired file types.

The hardest part there is just compatibility; it would have to leverage
the proposed policy.22 capability bitmap to enable the new checks.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
