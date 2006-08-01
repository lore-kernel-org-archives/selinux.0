Subject: Re: Context mounts and unsupported context strings
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Cory Olmo <colmo@TrustedCS.com>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>, Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov
In-Reply-To: <20060725142513.9ee1efc3.colmo@TrustedCS.com>
References: <20060725142513.9ee1efc3.colmo@TrustedCS.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 10:07:15 -0400
Message-Id: <1154441235.3582.107.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-07-25 at 14:25 -0500, Cory Olmo wrote:
> I recently ran into a problem with mounting file systems for particular
> context strings.  At this point we are still in the analysis phase so any
> information or ideas would be appreciated.
> 
> The problem:
> 
> Attempt to mount a cdrom with the context option of
> context=system_u:object_r:iso9660_t:s1:c0,c2,c4
> 
> The context will get interpreted as only
> system_u:object_r:iso9660_t:s1:c0.  The reason is that the field separator
> for the option field is ',', which is the same as that for categories. As a
> result the rest of the context ends up being interpreted as additional
> mount options that get passed on to the file system.
> 
> We've considered translation, escape characters, and quoting the entire
> context string.  So far the most feasible appear to be either escaping or
> quoting the entire context string.

Hi,

Any progress on this?  I assume it requires a patch for both mount and
the kernel.  In the kernel, try_context_mount() and
selinux_sb_copy_data() would need to understand the escaping or quoting.
mount and nfsmount also perform parsing of the options and handling of
the context options (context translation, converting to the nfs mount
binary structure in the nfs case).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
