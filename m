Date: Thu, 5 Jan 2006 08:56:36 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>,
   linux-security-module@wirex.com, selinux@tycho.nsa.gov
Subject: Re: SELinux metadata protection
Message-ID: <20060105145636.GB23146@sergelap.austin.ibm.com>
References: <200601021906.k02J6HmB009362@luminouswebdesign.com> <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Mon, 2006-01-02 at 14:06 -0500, schaufler-ca.com - Casey Schaufler
> wrote:
> > Casey takes a deep breath...
> > 
> > The filename is not an attribute of the file.
> > The pathname components are data contained
> > in directory entries. The association of path name
> > to inode number is one way. There is no association
> > of path name from file. Really. This is the thing
> > that make audit hard.
> > 
> > Yes, I know "It's obvious". It's just not true.
> 
> The world is ending because I agree with Casey on this one...
> The filename is not an attribute of the file, and we do not want this
> type of filtering on directory reads.  Use the permissions on the
> directory itself to control who can see the names it contains.  It is
> the data container for the filenames.
> 
> Use polyinstantiation aka Multi-Level Directories aka moldy directories
> for shared directories like /tmp.

Looking at the second "application note" for 5.3.4.1 of PP_MLOSPP_MR
(from http://niap.nist.gov/cc-scheme/pp/PP_MLOSPP-MR_V1.22.html), it
says:

"The MAC policy covers all subjects and all objects.  The list of
objects must include object attributes that are themselves objects
(such as filenames) because they can be manipulated by a user."

So it sounds like to meet this profile, we'd have to either have
separate controls on the filename, or extend a file's read/write
access rights to any dentry pointing to the inode.

Of course I'd resigned myself long ago to not being able to meet this
application note :)  Particularly due to the aforementioned hard-to-
handle information leak on touch(/var/somefilename).  So I'm not
arguing with the decision to abort this patch.

-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
