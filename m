Date: Tue, 20 Nov 2007 08:44:22 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: "Matthew N. Dodd" <Matthew.Dodd@sparta.com>
cc: "David P. Quigley" <dpquigl@tycho.nsa.gov>,
        Labeled NFS <labeled-nfs@linux-nfs.org>, selinux@tycho.nsa.gov
Subject: Re: [Labeled-nfs] [PATCH 08/13] NFS: Introduce lifecycle managment
 for label attribute.
In-Reply-To: <4741C77D.9080209@sparta.com>
Message-ID: <Xine.LNX.4.64.0711200835040.29957@us.intercode.com.au>
References: <1195243404.20981.3.camel@moss-terrapins.epoch.ncsc.mil>
 <1195243824.20981.19.camel@moss-terrapins.epoch.ncsc.mil>
 <Xine.LNX.4.64.0711192226180.20955@us.intercode.com.au> <4741C77D.9080209@sparta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Nov 2007, Matthew N. Dodd wrote:

> > 
> > You need to check the return of kmalloc().
> 
> If kmalloc() returns NULL then any label data returned by the GETATTR
> operation will not be used.  Labeling would be performed by the policy in the
> 'd_instantiate' function.

I suspect this would lead to inconsistent behavior & confuse folk.  
Perhaps try and return an error (which seems typical in much of the 
surrounding code) as a first option.

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
