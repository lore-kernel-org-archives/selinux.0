From: David Howells <dhowells@redhat.com>
In-Reply-To: <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil> 
References: <1149186390.2511.2.camel@moss-tarheels.epoch.ncsc.mil> 
To: Michael LeMay <mdlemay@epoch.ncsc.mil>
Cc: jmorris@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        dhowells@redhat.com
Subject: Re: [PATCH] selinux: Kernel access key retention support for SELinux 
Date: Fri, 02 Jun 2006 10:21:45 +0100
Message-ID: <12509.1149240105@warthog.cambridge.redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Michael LeMay <mdlemay@epoch.ncsc.mil> wrote:

> Introduce SELinux hooks to support the access key retention subsystem
> within the kernel.  Incorporate new flask headers from a modified
> version of the SELinux reference policy, with support for the new
> security class representing retained keys.  Extend the "key_alloc"
> security hook with a task parameter representing the intended
> ownership context for the key being allocated.  Attach security
> information to root's default keyrings within the SELinux
> initialization routine.

The code looks okay, but I've a couple of comments on the documentation:

> +future.  Currently, all of the basic permissions explained above are provided
> +in SELinux as well, and are simply checked after all discretionary permission
> +checks have been performed.

Aren't the standard checks done first, then the security module checks?

> +The user and user session keyrings that are created when the user logs in are
> +currently labeled with the context of the login manager, but will soon be labeled
> +with the user's initial context.

What do you mean by "soon"?  Do you mean that we don't do this at the moment,
but will do some time in the future, or do you mean that the keyrings start
off labelled one way, but get relabelled later on in the login process?

I think I'd also split the second paragraph a bit.

Can you also wrap the text at 80 characters please?  I won't mention that
"labeled" should be "labelled":-)

How about this:

---
The security class "key" has been added to SELinux so that mandatory access
controls can be applied to keys created within various contexts.  This support
is preliminary, and is likely to change quite significantly in the near future.
Currently, all of the basic permissions explained above are provided in SELinux
as well, and are always checked before any discretionary permission checks are
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

Remember, if you're using emacs, do: "ESC 7 9 C-x f" to set the fill column,
then "M-q" on each paragraph to fill it appropriately.

David

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
