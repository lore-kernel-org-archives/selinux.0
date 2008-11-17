Subject: Re: Handling labeling on filesystems that don't support SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Sean E. Millichamp" <sean@bruenor.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        Fedora Selinux Mailing List <fedora-selinux-list@redhat.com>,
        Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>
In-Reply-To: <1226938609.3282.34.camel@sewt>
References: <1225998785.3313.5.camel@sewt>  <49218381.4050509@redhat.com>
	 <1226935605.25156.51.camel@moss-spartans.epoch.ncsc.mil>
	 <1226938609.3282.34.camel@sewt>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 11:34:24 -0500
Message-Id: <1226939664.25156.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-11-17 at 11:16 -0500, Sean E. Millichamp wrote:
> Hmm... I believe that checking for an error at assignment time is not
> going to be a workable solution for Puppet.
> 
> The problem is that Puppet prepares what it needs to do in a transaction
> before doing it.  Take the situation where /usr/local is NFS mounted:
> 
> # ls -Z /usr/local/bin/foo
> -rwxr-xr-x  root root system_u:object_r:nfs_t:s0       /usr/local/bin/foo
> # matchpathcon /usr/local/bin/foo
> /usr/local/bin/foo	system_u:object_r:bin_t:s0
> 
> Then you run puppet with a manifest that includes management
> of /usr/local/bin/foo.

Can you explain what it means for puppet to manage a NFS-mounted
filesystem?  I'd tend to think that file management would happen on the
server, not on a client.  And puppet could easily run into problems with
e.g. setting ownership/mode information on a NFS-mounted filesystem due
to squashroot, uid/gid remapping, etc.

>   The first thing Puppet does is determine default
> values.  For SELinux this means a call to matchpathcon.  Then Puppet
> determines the current values with lgetfilecon.  It notices that the
> default value for the type should be bin_t, but the current is nfs_t so
> it adds changing the type to its list of things to do.  As it is
> building this list it reports on the things it intends to do.
> 
> Once it determines all of the actions that it needs to take only then
> does it perform the setfilecon call to update the context.  Even if we
> catch and silently ignore the error here the logging for the steps it
> intends to take will occur on every single Puppet run, filling the logs
> with what amounts to garbage and making email reports of changes
> essentially useless (as you would get an email on every run telling you
> of the changes it was going to make).
> 
> Performing a setfilecon call to the same context that exists during the
> first phase to determine if a value can be set would be the only way I
> could see to handle this, but it violates Puppet's promise of not
> touching anything during a noop run and will update the ctime of the
> file.
> 
> In the case of filesystems which behave like vfat Puppet would set the
> label the first time following the mount and until it is remounted
> wouldn't generate any additional messages.  Filesystems which behave
> like NFS are the real problem case though and NFS is far more likely to
> be mounted at a spot where matchpathcon returns a default then (for
> example) vfat is.
> 
> I'm not a fan of hardcoding a whitelist of supported filesystems for the
> very reasons Dan mentioned but it sounds like there isn't a good option
> for Puppet at the moment (and since I couldn't find any better options,
> this is what is going into the next Puppet release).

Ok - that's essentially what Dan does in his /sbin/fixfiles script as
well.

>   No chance of
> seeing a "supports_setfilecon" type call?

Possibly an interface could be added to selinuxfs and wrapped with a
libselinux function of that nature.

Or possibly we could export that via a new mount option that shows up
in /proc/mounts since we now support exporting information about context
mounts there?  There are already mount options for user_xattr and acl
for example, but not explicitly for security contexts.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
