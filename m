Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sBJGfiA6020295
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 11:41:44 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBJGffqN017031
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 11:41:41 -0500
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (vpn-225-80.phx2.redhat.com [10.3.225.80])
 by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 sBJGfeoO030588
 for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2014 11:41:40 -0500
Message-ID: <54945543.7090706@redhat.com>
Date: Fri, 19 Dec 2014 11:41:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Some of our customers are looking to turn on SELinux but they also
 want to use CSP from Symantec
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Currently Symantec requires SELinux be disabled, claiming there is
conflicts in the kernel modules.

http://www.symantec.com/connect/forums/does-scsp-agent-support-selinux

As the customer wants to take advantage of certain  SELinux features
like sVirt for VMs and Docker Containers, this conflict is coming to a head.

Is anyone familiar with whether or not this is a real conflict or just
something assumed by Symantec?

The customer like Symantec's ability to do intrusion detection and
remote logging and configuration of CSB. 

Bottom line the customer wants both.
