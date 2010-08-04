Subject: Re: [PATCH 2/4] SELinux: standardize return code handling in
 selinuxfs.c
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280951733.21957.215.camel@moss-pluto.epoch.ncsc.mil>
References: <20100803183116.31021.33444.stgit@paris.rdu.redhat.com>
	 <20100803183122.31021.54273.stgit@paris.rdu.redhat.com>
	 <1280951733.21957.215.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 16:03:20 -0400
Message-ID: <1280952200.23348.16.camel@dhcp231-200.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-08-04 at 15:55 -0400, Stephen Smalley wrote:
> On Tue, 2010-08-03 at 14:31 -0400, Eric Paris wrote:
> > selinuxfs.c has lots of different standards on how to handle return paths on
> > error.  For the most part transition to
> > 
> > 	rc=errno
> > 	if (failure)
> > 		goto out;
> > [...]
> > out:
> > 	cleanup()
> > 	return rc;
> > 
> > Instead of doing cleanup mid function, or having multiple returns or other
> > options.  This doesn't do that for every function, but most of the complex
> > functions which have cleanup routines on error.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> > ---
> > 
> >  security/selinux/selinuxfs.c |  652 ++++++++++++++++++++----------------------
> >  1 files changed, 317 insertions(+), 335 deletions(-)
> > 
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 402756c..3dcb841 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -177,7 +182,8 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
> >  	}
> >  	length = count;
> >  out:
> > -	free_page((unsigned long) page);
> > +	if (page)
> > +		free_page((unsigned long) page);
> >  	return length;
> 
> Isn't free_page(NULL) legal?

appears as though it is:

void free_pages(unsigned long addr, unsigned int order)
{
        if (addr != 0) {
                VM_BUG_ON(!virt_addr_valid((void *)addr));
                __free_pages(virt_to_page((void *)addr), order);
        }
}

Will resend.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
