Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NKTNgA000876
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:29:23 -0400 (EDT)
Subject: Re: [PATCH] selinux_sb_copy_data requires a whole page?
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <Xine.LNX.4.44.0506231548050.14587-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0506231548050.14587-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 16:22:34 -0400
Message-Id: <1119558154.10817.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This would still (maybe) leave sec info in the buffer after the null
whereas previously it would have been nulled out.  Do we care?

Eric

On Thu, 2005-06-23 at 15:50 -0400, James Morris wrote:
> On Thu, 23 Jun 2005, Eric Paris wrote:
> 
> > Is there a good reason I'm missing why we should require a whole page?
> > Maybe somebody else (or an old version of lustre) is going to hit on
> > this.  Comments?
> 
> Actually, a strcpy() should work ok here, as the last byte of the options 
> page will always be null terminated (e.g. in do_mount()).
> 
> 
> > --- linux-2.6.9/security/selinux/hooks.c.cor	2005-06-23 16:53:05.000000000 -0400
> > +++ linux-2.6.9/security/selinux/hooks.c	2005-06-23 16:54:01.000000000 -0400
> > @@ -1980,7 +1980,7 @@ static int selinux_sb_copy_data(struct f
> >  		}
> >  	} while (*in_end++);
> >  
> > -	copy_page(in_save, nosec_save);
> > +	memcpy(in_save, nosec_save, strlen(nosec_save));
> >  	free_page((unsigned long)nosec_save);
> >  out:
> >  	return rc;
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.
> > 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
