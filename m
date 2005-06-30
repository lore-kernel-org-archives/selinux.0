Subject: Re: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Janak Desai <janak@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120077839.20484.104.camel@celtics.boston.redhat.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
	 <42C302F9.4080901@us.ibm.com>
	 <1120077839.20484.104.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:53:25 -0400
Message-Id: <1120139605.32561.28.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 16:44 -0400, Ivan Gyurdiev wrote:
> > Subdirectory context is obtained from the policy
> > using security_compute_member() call. 
> 
> int security_compute_member(security_context_t scon,
>                             security_context_t tcon,
>                             security_class_t tclass,
>                             security_context_t *newcon)
> 
> So, it seems to me that
> this is insufficient basis to determine proper newcon - 
> file_type_auto_trans doesn't work for the same reason.
> 
> (scon, tcon, tclass) -> newcon 
> 
> is a 1:many map, and not 1:1.
> 
> So...how will pre-creation work if the file_contexts.homedirs
> file is erased (the only many:1 map available, 
> which becomes 1:1 given evaluation order).

To clarify, what I mean is... the file_context allows us to uniquely 
identify files, and label them appropriately. The (scon, tcon, tclass)
pair is not sufficient to uniquely identify the resultant type. 
There are many occasions where we need multiple types with the same
triple, which is why we have this hack script that Karl doesn't like
at all, which does pre-creation of subfolders. However, that 
script requires the file_contexts file to work, so I don't 
see how it can be removed, with or without polyinstantiation.

I can see the problem being fixed if you label files under /home
_and_ /tmp with a ROLE independent-type. This will also remove the
need to relabel after a change in primary role, which is currently
a major issue. However, I wasn't sure if that was being suggested? 
Is this what we're discussing here - removing role-dependent labeling,
since other roles' content will be hidden by polyinstantiation?




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
