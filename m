Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m4LDulK8016674
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 09:56:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m4LDuk3O029694
	for <selinux@tycho.nsa.gov>; Wed, 21 May 2008 13:56:46 GMT
Message-ID: <48342A34.4060907@redhat.com>
Date: Wed, 21 May 2008 09:57:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Rob Visser <visser.rob@gmail.com>
CC: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SELINUX admin with LDAP
References: <869100480805210301s6ddfa47bl5b6b1e603a68acdd@mail.gmail.com>
In-Reply-To: <869100480805210301s6ddfa47bl5b6b1e603a68acdd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Rob Visser wrote:
> Hello,
> 
> Is it possible to administer SELINUX users and RBAC stuff in LDAP? With RH
> directory server?
> It would be nice, since all the other stuff can be administered in LDAP.
> 
> Rob Visser
> 
We are working toward this goal.

seusers is now used with libselinux which I believe is a mistake.

I want to move the selection of the SELinux user and MLS Role into the
login programs pam_selinux and sshd.

RedHat is looking into integration with FreeIPA.  The biggest problem we
have now is how to select the correct seuser for a a machine.

The following is a potential format for a seusers distributed file

# Format
# loginname;machine;service;selinuxuser;level
# +name == group name
system_u;*;*;system_u;s0-s0:c0.c1023
root;redsox.boston.redhat.com;*;unconfined_u;s0-s0:c0.c1023
dwalsh;people.redhat.com;*;xguest_u;s0
dwalsh;people.fedoraproject.com;*;xguest_u;s0
dwalsh;redline.boston.redhat.com;*;user_u;s0
dwalsh;redsox.boston.redhat.com;*;unconfined_u;s0-s0:c0.c1023
dwalsh;redsox.boston.redhat.com;ssh;guest_u;s0-s0:c0.c1023
+engineering;redsox;ssh;staff_u;s0-s0:c0.c1023
+engineering;*;ssh;staff_u;s0-s0:c0.c1023
+engineering;*;*;staff_u;s0-s0:c0.c1023
*;*;xdm;xguest_u;s0
*;*;*;guest_u;s0

We have come up with a couple of formats for the "best match", but this
has to be easily understood by an administrator.

Anyways this conversation should take place on the selinux
<selinux@tycho.nsa.gov> developer list
> 
> 
> ------------------------------------------------------------------------
> 
> --
> fedora-selinux-list mailing list
> fedora-selinux-list@redhat.com
> https://www.redhat.com/mailman/listinfo/fedora-selinux-list


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
