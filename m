Subject: Re: Shell redirection and denials
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1191942284.23486.22.camel@dhcp-64-223.iad.redhat.com>
References: <1191870537.14569.23.camel@localhost.localdomain>
	 <1191940660.24970.94.camel@moss-spartans.epoch.ncsc.mil>
	 <1191942284.23486.22.camel@dhcp-64-223.iad.redhat.com>
Content-Type: text/plain
Date: Tue, 09 Oct 2007 13:17:45 -0400
Message-Id: <1191950265.13098.56.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-10-09 at 11:04 -0400, Karl MacMillan wrote:
> On Tue, 2007-10-09 at 10:37 -0400, Stephen Smalley wrote:
> > On Mon, 2007-10-08 at 15:08 -0400, Karl MacMillan wrote:
> > > One of Dan's constant sources of avcs is something like:
> > > 
> > > /usr/sbin/my_confined_app > some_file
> > > 
> > > Because the file is created by the shell, opened, and the FD handed to
> > > the application avcs can occur on read and write.
> > > 
> > > Getting rid of these via policy is next to impossible - the destination
> > > file type is usually governed by the directory and we don't actually
> > > want to allow that access directly to the confined application. I'd like
> > > to see if there is some other way to get rid of these denials.
> > > 
> > > I see two possible solutions:
[...]
> > > 2) Allow applications to confer access by passing the file descriptor
> > > (more like capabilities). This more closely matches how Unix actually
> > > works and, of course, is a huge source of vulnerabilities. Allowing this
> > > type of scheme just for shells might not be that bad.
[...]
> > (2) requires a kernel change, and requires care to avoid losing our
> > ability to control propagation of access rights in accordance with
> > policy (fundamental to MAC). I don't think you want the shell to be able
> > to arbitrarily pass any descriptor, but being able to distinguish in
> > policy between open (open_read, open_write) vs. transfer (transfer_read,
> > transfer_write) vs. use (read, write) could be useful so that you can
> > allow a process to inherit and use a descriptor without being able to
> > directly open the file.  DTOS had similar kinds of distinctions via
> > separate permissions on holding, using, and transferring port rights.
> > But policy would still need to allow use to all desired file types.
> > 
> > The hardest part there is just compatibility; it would have to leverage
> > the proposed policy.22 capability bitmap to enable the new checks.
> > 
> 
> Just what we need - more permissions! So, would 2 be useful beyond the
> shell? Chris / Dan, what do you think. Obviously if we can just make
> some changes to bash I'd rather do that.

I can't immediately think of any examples.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
