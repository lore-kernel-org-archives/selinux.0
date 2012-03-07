Message-ID: <1331129563.3040.2.camel@localhost>
Subject: Re: [PATCH] SELinux: allow default source/target selectors for
 user/role/range
From: Eric Paris <eparis@redhat.com>
To: qingtao.cao@windriver.com
Cc: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Date: Wed, 07 Mar 2012 09:12:43 -0500
In-Reply-To: <4F56CB36.7000700@windriver.com>
References: <1331080128-26425-1-git-send-email-eparis@redhat.com>
	 <4F56CB36.7000700@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-03-07 at 10:43 +0800, Harry Ciao wrote:
> 
> On 03/07/2012 08:28 AM, Eric Paris wrote:
> > When new objects are created we have great and flexible rules to
> > determine the type of the new object.
> 
> Shouldn't we introduce a default_type for class_datum as well? So far 
> the process and various socket classes will inherit the creating 
> process's domain, that is, DEFAULT_SOURCE as in your example, whilst for 
> any other classes the type of the newly created object will follow the 
> containing directory, that is, DEFAULT_TARGET.
> 
> Above logic has been hard-coded in security_compute_sid, which is a 
> matter of policy and should be moved from security server to refpolicy.

Agreed, but we cannot remove the old defaults.  They still need to be
available in case someone loads an old policy.  We could create a new
policy capability which when enabled would require policy to define all
of the defaults, but I don't think it's worth it, since any definition
in policy with this new rule type will overwrite the defaults in the
security server.

A mistake I made was only showing examples of this with files.  The new
rule syntax is:

default_user { file process } source;
default_range { socket } target low-high;

So the tclass of the created object is part of the decision.

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
