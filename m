Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Janak Desai <jdesai@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:03:01 -0400
Message-Id: <1120075381.20484.75.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> So at that point you no longer need to keep home directory contexts in
> file_contexts at all, and you just exclude home directories from
> relabeling.

How is the context of the bind-mounted home dir configured?

and subdirectories? pre-created?
what determines their context?

I am trying to understand where the labeling 
information is stored, if you want to get rid of the 
file_contexts.homedirs file.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
