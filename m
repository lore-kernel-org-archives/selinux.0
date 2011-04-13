From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
Subject: Re: SELinux mixed/virtualisation policy
Date: Wed, 13 Apr 2011 23:34:15 +1000
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
        SELinux@tycho.nsa.gov
References: <4DA1E50F.4060506@linux.vnet.ibm.com> <1302697169.16451.12.camel@moss-pluto> <4DA59F38.7090101@linux.vnet.ibm.com>
In-Reply-To: <4DA59F38.7090101@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201104132334.15438.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 13 Apr 2011, Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com> 
wrote:
> > Now something that has been suggested in the past would be adding
> > another level/range component to the security context for use by a
> > Biba-like integrity model.  That might be interesting, but would
> > obviously require quite a few changes on both the kernel and userland
> > side.  It would also require resolving the unfortunate ambiguity in the
> > current security context format.
> 
> Please, correct if I am wrong, but from what I understand adding another
> level and range component will just add another level of hierarchy for
> multiple set of sensitivities and categories (i.e.
> s0-s15:s0-s15:c0.c1023 or even s0-s15:c0.c1023:s0-s15:c0.c1023). So the
> virtualised sensitivities should be below or above the standard
> sensitivities in this new level and range component?

For at least 10 years there has been a general plan to use the role field in 
the on-disk labels.  Now we are just starting work on it.  Using the role 
field has clear benefits but it's taken this long because there are plenty of 
other things to work on and work-arounds for the need for it.

That said, I think that there are many potential benefits for adding more 
fields to the sensitivity label.  One thing that I think would be useful would 
be to have a field that can be used as a default-creation level for files.  
Setting the create context works well enough for a process but isn't inherited 
by child processes.

It would be interesting to setup a Biba/BLP policy as a test too, if nothing 
else that would be a good demonstration for people who think that the current 
MLS is too confusing.  :-#

I'm sure we could find other uses if it was implemented.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
