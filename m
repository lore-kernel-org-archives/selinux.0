Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7HEIs0a004294
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 10:18:54 -0400
Received: from oproxy6-pub.bluehost.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p7HEIrjW017308
	for <selinux@tycho.nsa.gov>; Wed, 17 Aug 2011 14:18:53 GMT
Received: from localhost ([127.0.0.1] helo=box559.bluehost.com)
	by box559.bluehost.com with esmtpa (Exim 4.76)
	(envelope-from <rarob@travelinglightfarm.net>)
	id 1QtgxI-0007qX-8C
	for selinux@tycho.nsa.gov; Wed, 17 Aug 2011 08:18:52 -0600
Message-ID: <5d23aa2d56b118186ba6a735c220f728.squirrel@box559.bluehost.com>
Date: Wed, 17 Aug 2011 10:18:52 -0400
Subject: RHEL5, selinux-policy-2.4.6.30-el5, and pidof AVC issue
From: rarob@travelinglightfarm.net
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been banging my head against this since yesterday.  I have a confined
root process that is trying to run the /sbin/pidof and getting an AVC
denials (raw AVC messages lower down).  The output from 'audit2allow -a
-l' suggests adding the following:

allow myDomain_t crond_t:process ptrace;
allow myDomain_t cupsd_t:process ptrace;
allow myDomain_t setrans_t:process ptrace;
allow myDomain_t src_t:dir { getattr search };
allow myDomain_t udev_t:process ptrace;
allow myDomain_t unconfined_t:process ptrace;
allow myDomain_t xdm_t:process ptrace;

I've explicitly verified that these are present, both by adding them to my
policy and using sesearch to show that they are in fact present. 
Audit2why indicates the problem may be a constraint, but if so I'm having
a hard time understanding how to track down what attribute I need to add
to satisfy the constraint.  I have pulled the source for the policy down
and have tried diving through it.  I did load the enableaudit.pp to see if
that gave me any additional info, and I did not see any, so I've reloaded
base.pp.

At this point upgrading to a more recent policy is not an option.  Our
customer base isn't always able to upgrade.

Below I've focused on the AVCs related to cupsd_t just for brevity.  Any
help would be greatly appreciated.


Output from setroubleshoot below:
Summary
    SELinux is preventing /sbin/killall5 (myDomain_t) "ptrace" to
    <Unknown> (cupsd_t).

Detailed Description
    SELinux denied access requested by /sbin/killall5. It is not expected
that
    this access is required by /sbin/killall5 and this access may signal an
    intrusion attempt. It is also possible that the specific version or
    configuration of the application is causing it to require additional
access.

Allowing Access
    You can generate a local policy module to allow this access - see
    http://fedora.redhat.com/docs/selinux-faq-fc5/#id2961385 Or you can
disable
    SELinux protection altogether. Disabling SELinux protection is not
    recommended. Please file a
http://bugzilla.redhat.com/bugzilla/enter_bug.cgi
    against this package.

Additional Information

Source Context                user_u:system_r:myDomain_t
Target Context                system_u:system_r:cupsd_t:SystemLow-SystemHigh
Target Objects                None [ process ]
Affected RPM Packages         SysVinit-2.86-14 [application]
Policy RPM                    selinux-policy-2.4.6-30.el5
Selinux Enabled               True
Policy Type                   targeted
MLS Enabled                   True
Enforcing Mode                Permissive
Plugin Name                   plugins.catchall
Host Name                     rh50-32-selinux
Platform                      Linux rh50-32-selinux 2.6.18-8.el5 #1 SMP
Fri Jan
                              26 14:15:21 EST 2007 i686 i686
Alert Count                   12
Line Numbers

Raw Audit Messages

avc: denied { ptrace } for comm="pidof" egid=0 euid=0 exe="/sbin/killall5"
exit=15 fsgid=0 fsuid=0 gid=0 items=0 pid=21880
scontext=user_u:system_r:myDomain_t:s0 sgid=0
subj=user_u:system_r:myDomain_t:s0 suid=0 tclass=process
tcontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023 tty=pts0 uid=0


audit2allow -a -l |grep myDomain_t :
allow myDomain_t cupsd_t:process ptrace;

sesearch -A  -s myDomain_t -t cupsd_t
Found 1 av rules:
   allow myDomain_t cupsd_t : process ptrace ;

audit2why (filtered for the cupsd_t denial):
type=AVC msg=audit(1313588704.514:732): avc:  denied  { ptrace } for 
pid=23237 comm="pidof" scontext=user_u:system_r:securityblanket_cfg_t:s0
tcontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023 tclass=process
        Was caused by:
                Constraint violation.
                Check policy/constraints.
                Typically, you just need to add a type attribute to the
domain to satisfy the constraint.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
