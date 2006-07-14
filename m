Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6E6Vtvi024000
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 02:31:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6E6Vs2D028226
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 06:31:54 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k6E6VsHr029155
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 02:31:54 -0400
Received: from pobox.brisbane.redhat.com (pobox.brisbane.redhat.com [172.16.44.10])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k6E6Vl1i021704
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 02:31:48 -0400
From: "David O'Brien" <daobrien@redhat.com>
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com,
        rhselinux-project@redhat.com
Subject: RHEL5 Security Documentation Scope Statement
Date: Fri, 14 Jul 2006 16:31:42 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200607141631.42793.daobrien@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've prepared the following Scope Statement to help those involved in the 
project to update the RHEL5 Security Documentation. Please feel free to offer 
any suggestions, ask questions or get clarification. As we move forward there 
may be minor changes, but this should be pretty close.

Apologies for the cross-post and to those who receive multiple copies. Please 
forward this to interested parties who may not be on any of these lists.

----
The RHEL5 Security Guide integrates two previously separate guides: The Red 
Hat Enterprise Linux 4 Security Guide and the Red Hat Enterprise Linux 4 
SELinux Guide. These guides are being integrated and updated to provide a 
single source of information for all security-related topics for Red Hat 
Enterprise Linux.
 
The RHEL5 Security Guide provides a general introduction to security, and from 
the perspective of Red Hat Linux in particular. It provides conceptual 
information in the areas of security assessment, common exploits, and 
intrusion and incident response. It also provides conceptual and specific 
configuration information for hardening Workstation, Server, VPN, firewall 
and other implementations using SELinux. A Troubleshooting section provides 
information on common problems and how to resolve them.
 
The RHEL5 Security Guide assumes a basic knowledge of IT security, and 
consequently provides only minimal coverage of common security practices such 
as controlling physical access, sound account-keeping policies and 
procedures, auditing, etc. Neither does it cover the intricacies of SELinux 
in detail, such as writing policies for certain 3rd party applications. Where 
appropriate, reference is made to external resources for this and related 
information.

----
regards, 
David O'Brien
Red Hat Asia Pacific Pty Ltd

Tel:  +61-7-3514-8189
Fax: +61-7-3514-8199

email: daobrien@redhat.com
web: http://apac.redhat.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
