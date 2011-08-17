Subject: Re: RHEL5, selinux-policy-2.4.6.30-el5, and pidof AVC issue
From: Stephen Smalley <sds@tycho.nsa.gov>
To: rarob@travelinglightfarm.net
Cc: selinux@tycho.nsa.gov
In-Reply-To: <5d23aa2d56b118186ba6a735c220f728.squirrel@box559.bluehost.com>
References: <5d23aa2d56b118186ba6a735c220f728.squirrel@box559.bluehost.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Aug 2011 10:45:34 -0400
Message-ID: <1313592334.28571.18.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-08-17 at 10:18 -0400, rarob@travelinglightfarm.net wrote:
> I've been banging my head against this since yesterday.  I have a confined
> root process that is trying to run the /sbin/pidof and getting an AVC
> denials (raw AVC messages lower down).  The output from 'audit2allow -a
> -l' suggests adding the following:
> 
> allow myDomain_t crond_t:process ptrace;
> allow myDomain_t cupsd_t:process ptrace;
> allow myDomain_t setrans_t:process ptrace;
> allow myDomain_t src_t:dir { getattr search };
> allow myDomain_t udev_t:process ptrace;
> allow myDomain_t unconfined_t:process ptrace;
> allow myDomain_t xdm_t:process ptrace;
> 
> I've explicitly verified that these are present, both by adding them to my
> policy and using sesearch to show that they are in fact present. 
> Audit2why indicates the problem may be a constraint, but if so I'm having
> a hard time understanding how to track down what attribute I need to add
> to satisfy the constraint.

What exactly do you want myDomain_t to be able to do, and to what target
processes?  I doubt you want to allow this for all of these domains.
Which target processes do you want myDomain_t to be able to look up /
kill?

The relevant constraint here would be in policy/mcs, as your process is
running with a MCS level of s0 aka SystemLow but the target is running
s0-s0:c0.c1023 aka SystemHigh.  Type attribute is mcsptraceall,
refpolicy interface is mcs_ptrace_all().  Alternatively you could run
your process fully ranged to SystemHigh and avoid the need to add this
attribute.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
