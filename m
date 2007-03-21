Subject: Re: Kernel Panics, when start with amendments in SELInux Source
	Code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070321175402.60015.qmail@web86912.mail.ukl.yahoo.com>
References: <20070321175402.60015.qmail@web86912.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Wed, 21 Mar 2007 14:38:16 -0400
Message-Id: <1174502296.22565.426.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-03-21 at 17:54 +0000, JanuGerman wrote:
> I have made a change to the security server of the
> SELinux to see the files, that it accesses and print
> their names. But when the kernel re-boots after
> compilation, it panics and says that "some thing is
> accessing directly the hardware" and keep on saying
> this, until, i disable the selinux at boot time.
> 
> The code is as follows added to the
> security_compute_av
> 
> const unsigned char *filepathp;
> 	char filepathbuf[512];	
> 	unsigned long count;
> 	filepathp = (const unsigned char *)
> 	    d_path(testfile->f_dentry, testfile->f_vfsmnt,
> filepathbuf, 512);

What makes you think there is any file at all on every permission check?
Many permission checks are on non-file objects altogether.

> 	if (filepathp < 0) {

if (IS_ERR(filepathp)) {

> 		filepathp = testfile->f_dentry->d_name.name;
> 		count = testfile->f_dentry->d_name.len + 1;
> 		if (count > 512)
> 			count = 512;

What is count used for?

> 	} else {
> 		count = strlen(filepathp);
> 	}
> 	printk("Hi, this is the name of the file being
> accessed %s \n",filepathp);
> 	return 0;
> 
> 
> The testfile object is set within the
> fs/nami.c:file_permission() into to a global variable,
> which is then accessed by the services.c via
> linux/fs.h.

That's nice, except that:
a) file_permission() in fs/namei.c doesn't get called at all for
non-file checks,
b) file_permisison() in fs/namei.c doesn't even get called at all for
many file checks.
c) you need to provide locking on that global variable.

> The intention is to get the file information
> associated with particular inodes. If some body can
> help me in sorting out this, i will be very thankful.

SELinux avc auditing or the syscall auditing will happily provide you
with such information.  No need to add printk's to SELinux for it.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
