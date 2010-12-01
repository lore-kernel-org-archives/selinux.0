MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: What can selinux do that "audit" by itself cant do ?
Date: Wed, 1 Dec 2010 13:06:52 -0500
Message-ID: <D06FE0A2807BC145B0D38744789D4F5D09EA0021@de01exm68.ds.mot.com>
In-Reply-To: <201012010844.36650.sgrubb@redhat.com>
References: <Pine.LNX.4.44.0710262329300.30215-100000@citation2.av8.net> <1193840770.3983.86.camel@moss-spartans.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D09E9FCDD@de01exm68.ds.mot.com> <201012010844.36650.sgrubb@redhat.com>
From: "Hasan Rezaul-CHR010" <CHR010@motorola.com>
To: "Steve Grubb" <sgrubb@redhat.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thank You soo much Steve for your answers  :-)

R.H.
 

-----Original Message-----
From: Steve Grubb [mailto:sgrubb@redhat.com] 
Sent: Wednesday, December 01, 2010 7:45 AM
To: Hasan Rezaul-CHR010
Cc: Stephen Smalley; selinux@tycho.nsa.gov
Subject: Re: What can selinux do that "audit" by itself cant do ?

Hello,

On Tuesday, November 30, 2010 07:17:30 pm Hasan Rezaul-CHR010 wrote:
> Lets say I am using SELinux in my Linux product to monitor the 
> filesystem and generate avc deny events in audit.log, whenever my 
> strict selinux policy is violated... And I am running in Permissive 
> mode (so NOT actively preventing anything, just reporting...).
> 
> Is there any reason why I cant simply write a bunch of rules in 
> audit.rules  to accomplish the same objective ?

I think that you want to use the right tool for the right job. The audit
system is designed to monitor system activity. SE Linux is a MAC
subsystem. There are requirements that MAC events are auditable, which
seems to be what you have been using in place of just the audit system.

 It should be known that if you turn SE Linux off, you won't get the
same events in the audit logs. This is because SE Linux can have policy
written that does not like some interactions that are "legal" from a DAC
perspective. The only way to know if you are missing anything important
is to run with SE Linux disabled and see if the audit rules captures
everything you expect.


> Possibly a dumb question, so apologize in advance, but other than 
> Policy Enforcement and Prevention in the 'Enforcing' mode (which I 
> cant use in my product for various reasons), what else is SELinux 
> buying me, that I cant get by using just audit ?

SE Linux has helped debug many software problems like leaked file
descriptors or shared memory that is executable. The audit system won't
be able to catch those since it was never designed to concern itself
with information flow control. It was designed to monitor resource
access. Nearly the same, but different. For example, the audit system
would assume that if a child process inheritted and used a descriptor
from a parent process, then it must be OK. SE Linux because it worries
about information flow control would be more suspicious and report a
process attempting to access a resource that it was not known to
previously have.

 
> I am sure there must be significant benefits of SELinux, but can 
> someone help me understand some of the benefits.

Audit should be used for auditing, SE Linux should be used for access
control. They are orthogonal.


> And also perhaps some of the SELinux functionalities are desirable,
but
> cannot be accomplished by just audit. Can you tell me what those may
be?
> If there is an article or URL that provides more depth, please feel
free
> to share that as well.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
