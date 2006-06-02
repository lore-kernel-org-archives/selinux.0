From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil> 
References: <1149253695.524.431.camel@moss-spartans.epoch.ncsc.mil>  <1149252277.7506.6.camel@moss-tarheels.epoch.ncsc.mil> <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil> <12509.1149240105@warthog.cambridge.redhat.com> <12388.1149253325@warthog.cambridge.redhat.com> 
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: David Howells <dhowells@redhat.com>,
        Michael LeMay <mdlemay@epoch.ncsc.mil>, jmorris@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 14:25:21 +0100
Message-ID: <12857.1149254721@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Stephen Smalley <sds@tycho.nsa.gov> wrote:

> > > > Currently, all of the basic permissions explained above are provided in
> > > > SELinux as well, and are always checked before any discretionary
> > > > permission checks are performed.
> > > 
> > > I think you meant to reverse the last sentence, but correct me if I'm
> > > wrong...
> > 
> > Yes.  Assuming I understand what you're saying, and that "discretionary
> > permissions checks" are what SE Linux does, then yes, key_task_permission()
> > does those last.  If not, then it needs rewording rather than reversing to
> > make it clearer.
> 
> Discretionary access control is what the basic Linux access control
> model is.  Mandatory access control is what SELinux provides.

Ah.  In that case a bit of rewording is required rather than reversal:

How about this:

---
The security class "key" has been added to SELinux so that mandatory access
controls can be applied to keys created within various contexts.  This support
is preliminary, and is likely to change quite significantly in the near future.
Currently, all of the basic permissions explained above are provided in SELinux
as well; SE Linux is simply invoked after all basic permission checks have been
performed.

Each key is labeled with the same context as the task to which it belongs.
Typically, this is the same task that was running when the key was created.
The default keyrings are handled differently, but in a way that is very
intuitive:

 (*) The user and user session keyrings that are created when the user logs in
     are currently labeled with the context of the login manager, but will soon
     be labeled with the user's initial context.

 (*) The keyrings associated with new threads are each labeled with the context
     of their associated thread, and both session and process keyrings are
     handled similarly.

Note, however, that the default keyrings associated with the root user are
labeled with the default kernel context, since they are created early in the
boot process, before root has a chance to log in.
---

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
