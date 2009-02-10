Subject: Re: [PATCH 3/3] SELinux: better printk when file with invalid
 label found
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1234276211.3724.20.camel@localhost.localdomain>
References: <20090209213714.9537.8322.stgit@paris.rdu.redhat.com>
	 <20090209213724.9537.35275.stgit@paris.rdu.redhat.com>
	 <1234275283.4642.29.camel@localhost.localdomain>
	 <1234276211.3724.20.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 10 Feb 2009 09:59:17 -0500
Message-Id: <1234277957.4642.48.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-02-10 at 09:30 -0500, Eric Paris wrote:
> On Tue, 2009-02-10 at 09:14 -0500, Stephen Smalley wrote:
> > On Mon, 2009-02-09 at 16:37 -0500, Eric Paris wrote:
> > > Currently when an inode is read into the kernel with an invalid label
> > > string (can often happen with removable media) we output a string like:
> > > 
> > > SELinux: inode_doinit_with_dentry:  context_to_sid([SOME INVALID LABEL])
> > > returned -22 dor dev=[blah] ino=[blah]
> > > 
> > > Which is all but incomprehensible to all but a couple of us.  Instead, on
> > > EINVAL only, I plan to output a much more user friendly string and I plan to
> > > ratelimit the printk since many of these could be generated very rapidly.
> > > 
> > > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> > You could likely further drop the function name in all cases, and maybe
> > even the error code (is there no strerror() equivalent in the kernel?).
> 
> I'd say that anyone getting the other message needs to report it to a
> developer and I kinda like return codes, function names, and everything
> else that normal users consider cryptic.  It really shouldn't be popping
> out, so I hoped to leave it as is.
> 
> If you really want me to simply that one as well, do you have a text
> suggestion?  If not, I'll leave this patch as is.

Shrug.  That's fine.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
