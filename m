Subject: Re: SELinux metadata protection
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "schaufler-ca.com - Casey Schaufler" <casey@schaufler-ca.com>
Cc: linux-security-module@wirex.com, selinux@tycho.nsa.gov
In-Reply-To: <200601021906.k02J6HmB009362@luminouswebdesign.com>
References: <200601021906.k02J6HmB009362@luminouswebdesign.com>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 10:46:50 -0500
Message-Id: <1136303210.27632.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-01-02 at 14:06 -0500, schaufler-ca.com - Casey Schaufler
wrote:
> Casey takes a deep breath...
> 
> The filename is not an attribute of the file.
> The pathname components are data contained
> in directory entries. The association of path name
> to inode number is one way. There is no association
> of path name from file. Really. This is the thing
> that make audit hard.
> 
> Yes, I know "It's obvious". It's just not true.

The world is ending because I agree with Casey on this one...
The filename is not an attribute of the file, and we do not want this
type of filtering on directory reads.  Use the permissions on the
directory itself to control who can see the names it contains.  It is
the data container for the filenames.

Use polyinstantiation aka Multi-Level Directories aka moldy directories
for shared directories like /tmp.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
