Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OG2itH005137
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 12:02:44 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so1595979eek.1
        for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 09:02:42 -0700 (PDT)
Message-ID: <1382630560.3041.150.camel@d30>
Subject: Re: Allow audit2allow to return constraint information from policy
From: Dominick Grift <dominick.grift@gmail.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Date: Thu, 24 Oct 2013 18:02:40 +0200
In-Reply-To: <5269207C.4090809@redhat.com>
References: <5269207C.4090809@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2013-10-24 at 09:28 -0400, Daniel J Walsh wrote:
> At the end of last year I was complaining about audit2allow and the SELinux
> tools chain not being able to give better information about what constraint is
> being violated, so a admin or policy writer could have a clue on how to fix
> the problem.
> 
> A fairly common problem is domains trying to change the role or user component
> of the label.  Or in the MCS and MLS world, what attribute do I need to add to
> my policy to allow the AVC.
> 
> Richard Haines wrote some nice patches to add the constraint information to
> the kernel and to change user space to reveal this information.
> 
> Sadly we thought these discussions had happened on the list, but I guess we
> had taken it private.  Here is the userspace patch to reveal this information.
> 
> The kernel team will be posting the kernel patch hopefully soon.  We believe
> that even though the kernel does not need the additional information about the
> constraint, the limited space required to carry this information makes sense.
> 


Can we though make that information opt-in

I think it annoying that when i run audit2allow my screen gets filled
with all kinds of information i am not interested in

I could find a option to get rid of the noise


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
