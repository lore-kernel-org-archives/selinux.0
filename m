Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2NHg6Ml032718
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 13:42:06 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2NHg4sr009239
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 17:42:05 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2NHg3dH013667
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 13:42:03 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2NHg2l0016509
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 13:42:02 -0400
Received: from [10.12.32.53] (redsox.boston.devel.redhat.com [10.12.32.53])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2NHg27w012474
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 13:42:02 -0400
Message-ID: <46041166.8010102@redhat.com>
Date: Fri, 23 Mar 2007 13:41:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Elimination of disable_trans boolean ramifications
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have removed the disable_trans booleans from Rawhide, and FC7 Test3.  
I wanted to remove these booleans because they cause as many problems as 
they solve.    If you turn off certain domains, it can change the 
labeling on the system and cause other confined domains to blow up.

If you syslog_disable_trans, the devlog_t context is wrong and any 
confined app that tries to syslog will no longer work.

The best thing to do when confronted with an AVC would be to figure out 
if this is expected behavior, if yes then report it as a bug to upstream 
or to the distribution and create a loadable policy module that handles 
the problem.

If there are so many problems or a user just does not want to deal with 
it I figured we could just load a policy that sets the domain as an 
unconfined_domain.

If you wanted to run samba as an unconfined domain  you would build a 
policy module

policy_module(mysamba, 1.0)

require {
        type smbd_t;
}

unconfined_domain(smbd_t)


Compile it

make -f /usr/share/selinux/devel/Makefile

And load it

semodule -i mysamba.pp

Only problem...

semodule -i mysamba.pp
libsepol.permission_copy_callback: Module mysamba depends on permission 
* in class capability, not satisfied
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!

But once we fix the interface this should work.

I think this is a better solution, we could even instrument 
system-config-selinux or audit2allow to  generate this policy module on 
the fly.  I think this is better than disable_trans or setting up a 
boolean for all confined domains to go to unconfined.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
