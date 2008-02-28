Subject: Re: [PATCH -v2] SELinux: create new open permission
From: Eric Paris <eparis@redhat.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1204224606.32061.218.camel@gorn>
References: <1204221520.3206.86.camel@localhost.localdomain>
	 <1204224606.32061.218.camel@gorn>
Content-Type: text/plain
Date: Thu, 28 Feb 2008 14:00:33 -0500
Message-Id: <1204225233.3206.120.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 2008-02-28 at 13:50 -0500, Christopher J. PeBenito wrote:
> On Thu, 2008-02-28 at 12:58 -0500, Eric Paris wrote:
> > Adds a new open permission inside SELinux when 'opening' a file.  The
> > idea is that opening a file and reading/writing to that file are not the
> > same thing.  Its different if a program had its stdout redirected
> > to /tmp/output than if the program tried to directly open /tmp/output.
> > This should allow policy writers to more liberally give read/write
> > permissions across the policy while still blocking many design and
> > programing flaws SELinux is so good at catching today.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > 
> 
> What does open on a dir mean?  Isn't that the same as the read perm?

Admittedly there is very little distinction and I don't know the
usefulness, but it is possible for a process to pass an open fd to a
directory so I saw little reason to exclude it.  lnk and socket files
were excluded because they could not be 'opened.'  Obvious for a socket,
but lnk files are magically changed in the kernel to an open on the real
file before the security check, so you couldn't ever pass an open lnk
file.

> #============= httpd_t =============
> allow httpd_t user_tmp_t:dir { read open };
> #============= ntpd_t ==============
> allow ntpd_t user_tmp_t:dir read;

-Eric

> > allow httpd_t user_tmp_t:dir { read open };
> [...]
> > + * Convert a file mask to an access vector and include the correct open
> > + * open permission.
> > + */
> > +static inline u32 open_file_mask_to_av(int mode, int mask)
> > +{
> > +	u32 av = file_mask_to_av(mode, mask);
> > +
> > +	if (selinux_policycap_openperm) {
> > +		/*
> > +		 * lnk files and socks do not really have an 'open'
> > +		 */
> > +		if (S_ISREG(mode))
> > +			av |= FILE__OPEN;
> > +		else if (S_ISCHR(mode))
> > +			av |= CHR_FILE__OPEN;
> > +		else if (S_ISBLK(mode))
> > +			av |= BLK_FILE__OPEN;
> > +		else if (S_ISFIFO(mode))
> > +			av |= FIFO_FILE__OPEN;
> > +		else if (S_ISDIR(mode))
> > +			av |= DIR__OPEN;
> > +		else
> > +			printk(KERN_ERR "SELinux: WARNING: inside open_file_to_av "
> > +				"with unknown mode:%x\n", mode);
> > +	}
> > +	return av;
> > +}
> > +
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
