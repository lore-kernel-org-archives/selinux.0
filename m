Subject: Re: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Janak Desai <janak@us.ibm.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <42C302F9.4080901@us.ibm.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
	 <42C302F9.4080901@us.ibm.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:43:59 -0400
Message-Id: <1120077839.20484.104.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Subdirectory context is obtained from the policy
> using security_compute_member() call. 

int security_compute_member(security_context_t scon,
                            security_context_t tcon,
                            security_class_t tclass,
                            security_context_t *newcon)

So, it seems to me that
this is insufficient basis to determine proper newcon - 
file_type_auto_trans doesn't work for the same reason.

(scon, tcon, tclass) -> newcon 

is a 1:many map, and not 1:1.

So...how will pre-creation work if the file_contexts.homedirs
file is erased (the only many:1 map available, 
which becomes 1:1 given evaluation order).


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
