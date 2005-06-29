Message-ID: <42C302F9.4080901@us.ibm.com>
Date: Wed, 29 Jun 2005 16:22:17 -0400
From: Janak Desai <janak@us.ibm.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Stephen Smalley <sds@tycho.nsa.gov>, janak@us.ibm.com,
   Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>
Subject: Re: file contexts and modularity
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>	 <1120073041.20484.70.camel@celtics.boston.redhat.com>	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil> <1120075381.20484.75.camel@celtics.boston.redhat.com>
In-Reply-To: <1120075381.20484.75.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>>So at that point you no longer need to keep home directory contexts in
>>file_contexts at all, and you just exclude home directories from
>>relabeling.
> 
> 
> How is the context of the bind-mounted home dir configured?
> 
> and subdirectories? pre-created?
> what determines their context?
> 
> I am trying to understand where the labeling 
> information is stored, if you want to get rid of the 
> file_contexts.homedirs file.
> 
> 
> 

Subdirectory context is obtained from the policy
using security_compute_member() call. So the pam module will
get the security context of the member, create the
directory and bind mount it to the polyinstantiated directory.
As Stephen mentioned, the member directory is no longer a
subdirectory of polyinstantiated directory. A configuration
file is checked to determine where to create member directories
for a perticular polyinstantiated directory.

-Janak

> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 
> 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
