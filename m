Date: Wed, 27 Feb 2008 01:04:19 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH][RFC] Unify printk messgaes
In-Reply-To: <1204033728.2846.35.camel@localhost.localdomain>
Message-ID: <Xine.LNX.4.64.0802270103580.1962@us.intercode.com.au>
References: <Xine.LNX.4.64.0802262049370.10387@us.intercode.com.au>
 <1204033728.2846.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Feb 2008, Eric Paris wrote:

> 
> On Tue, 2008-02-26 at 20:53 +1100, James Morris wrote:
> > I noticed that we had a mix of "SELinux:" and "security:" prefixes in our 
> > kernel boot messages, so I've unified these to "SELinux:" with the patch 
> > below to reduce user confusion.  (It doesn't try and fix every printk, 
> > just the ones with "security:").
> > 
> > Also simplified the avtab hash message, from:
> > 
> >   SELinux:8192 avtab hash slots allocated. Num of rules:163922
> > 
> > to
> > 
> >   SELinux: 8192 avtab hash slots, 163922 rules.
> > 
> > 
> > Comments?
> 
> If you are going to do this can you add a KERN_* prefix to everything
> that doesn't have one?  Or do we really prefer things to get
> default_message_loglevel ??

The patch has already been pushed out, added this to the todo list.

--
James Morris <jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
