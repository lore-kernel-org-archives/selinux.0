Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6S1pwqn008931
	for <selinux@tycho.nsa.gov>; Thu, 27 Jul 2006 21:51:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6S1ptaY000951
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 01:51:56 GMT
From: "David O'Brien" <daobrien@redhat.com>
To: Forrest Taylor <ftaylor@redhat.com>, Harald Hoyer <harald@redhat.com>,
        James Morris <jmorris@redhat.com>, Karsten Wade <kwade@redhat.com>,
        Nalin Dahyabhai <nalin@redhat.com>,
        "NSA_SELinux List" <selinux@tycho.nsa.gov>,
        Stephen John Smoogen <smooge@gmail.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Thomas Woerner <twoerner@redhat.com>, Tomas Mraz <tmraz@redhat.com>,
        Ulrich Drepper <drepper@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: RHEL5 Security Guide draft TOC for review/comment
Date: Fri, 28 Jul 2006 11:51:45 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y2WyEGPMO7eySDZ"
Message-Id: <200607281151.46191.daobrien@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_y2WyEGPMO7eySDZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Firstly, apologies if you receive this twice. I'm casting a wide net...

I've attached the draft TOC of the Red Hat Enterprise Linux 5 Security Guide 
for all to review and comment on. (Despite appearances it's not supposed to 
be a valid xml file; I wrote it that way for my own convenience.) As 
mentioned in the Scope Statement (attached), this is the integration of the 
RHEL4 Security Guide and the SELinux Guide. Our focus for this release is on 
accuracy and use cases, at the expense of low-level details.

Please feel free to make any suggestions about structure, topics, etc., how we 
could use/enhance this info from other areas (Training?) or vice versa.

I have a few names down for reviewers, authors/editors, etc., (see comments in 
file) but am looking for more. If there is an area where you feel you could 
contribute, please put your hand up.  All contributors will be acknowledged 
and included in the colophon, and earn our undying gratitude.  :-)

cheers
-- 
David O'Brien
Red Hat Asia Pacific Pty Ltd

Tel:  +61-7-3514-8189
Fax: +61-7-3514-8199

email: daobrien@redhat.com
web: http://apac.redhat.com/
IRC: daobrien #docs #selinux #devel #doc-i18n

--Boundary-00=_y2WyEGPMO7eySDZ
Content-Type: text/plain;
  charset="us-ascii";
  name="RHEL5SecurityGuideScopeStatement"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="RHEL5SecurityGuideScopeStatement"

RHEL5 Security Guide
Scope Statement

The RHEL5 Security Guide integrates two previously separate guides: The Red Hat Enterprise Linux 4 Security Guide and the Red Hat Enterprise Linux 4 SELinux Guide. These guides are being integrated and updated to provide a single source of information for all security-related topics for Red Hat Enterprise Linux.
 
The RHEL5 Security Guide provides a general introduction to security, and from the perspective of Red Hat Linux in particular. It provides conceptual information in the areas of security assessment, common exploits, and intrusion and incident response. It also provides conceptual and specific configuration information for hardening Workstation, Server, VPN, firewall and other implementations using SELinux. A Troubleshooting section provides information on common problems and how to resolve them.
 
The RHEL5 Security Guide assumes a basic knowledge of IT security, and consequently provides only minimal coverage of common security practices such as controlling physical access, sound account-keeping policies and procedures, auditing, etc. Neither does it cover the intricacies of SELinux in detail, such as writing policies for certain 3rd party applications. Where appropriate, reference is made to external resources for this and related information.

 
 
--Boundary-00=_y2WyEGPMO7eySDZ
Content-Type: text/xml;
  charset="us-ascii";
  name="RHEL5SecurityGuideTOC.xml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="RHEL5SecurityGuideTOC.xml"

<part>
Security And Authentication
<chapter>Security Overview
<!-- Reviewed by David O'Brien daobrien@redhat.com -->
	<section>Introduction
		What is Computer Security?
			How did Computer Security Come about?
		Security Controls
		Conclusion
	</section>
	
	<section>
	Vulnerability Assessment
		Thinking Like the Enemy
		Defining Assessment and Testing
		Evaluating the Tools
	</section>
	
	<section>
	Attackers and Vulnerabilities
		A Quick History of Hackers
		Threats to Network Security
		Threats to Server Security
		Threats to Workstation and Home PC Security
	</section>
	
	<section>
	Common Exploits and Attacks
	</section>
	
	<section>	
	Security Updates
		Updating Packages
	</section>

</chapter>
<chapter>Securing Your Network
	<section>Workstation Security
<!-- David O'Brien doing initial review -->
	REVIEW
		 Evaluating Workstation Security
		 BIOS and Boot Loader Security
		 Password Security
		 Administrative Controls
<!-- 		waiting for David Sainty review? -->
		 Available Network Services
		 Personal Firewalls
		 Security Enhanced Communication Tools
	</section>
	
	<section>
	Server Security
<!-- David O'Brien doing initial review -->
	REVIEW
		 Securing Services With TCP Wrappers and xinetd
		 Securing Portmap
		 Securing NIS
		 Securing NFS
		 Securing the Apache HTTP Server
		 Securing FTP
		 Securing Sendmail
		 Verifying Which Ports Are Listening
	</section>
	
	<section>
	Pluggable Authentication Modules (PAM)
	REVIEW
	<!-- Some updates available but would like a volunteer. May get tmraz@redhat.com or nalin@redhat.com more involved? -->
	</section>
	
	<section>
	TCP Wrappers and xinetd
	REVIEW
<!-- Trying to get twoerner@redhat.com to volunteer  :-) -->
	</section>
	
	<section>
	Kerberos
<!-- 	Being reviewed by Nalin Dahyabhai <nalin@redhat.com>  -->
	</section>
	
	<section>
	Virtual Private Networks
<!-- Lining up Bill Nottingham <notting@redhat.com> and Harald Hoyer <harald@redhat.com> for review -->
	REVIEW
		 VPNs and Red Hat Enterprise Linux
		 IPsec
		 IPsec Installation
		 IPsec Host-to-Host Configuration
		 IPsec Network-to-Network configuration
	</section>
	
	<section>	
	Firewalls
<!-- Looking for reviewer -->
	REVIEW
		 Netfilter and iptables
		 Using iptables
		 Common iptables Filtering
		 FORWARD and NAT Rules
		 Viruses and Spoofed IP Addresses
		 iptables and Connection Tracking
		 ip6tables
		 Additional Resources
	</section>
	
	<section>	
	iptables
	<!-- Looking for reviewer -->
	REVIEW
<!-- Should we leave this here or move up to "Firewalls"? -->
	</section>
</chapter>

<chapter>SELinux Overview
<!-- Looking for technical reviewers for all of the following -->
<!-- In the absence of resources to effectively review the SELinux chapters, topics can be dropped for RHEL5 and picked up later. This applies especially to low-level, detailed information. Refer to the Scope Statement for further guidelines. -->
	
	<section>
	SELinux Architectural Overview
<!-- 	VERY QUICK REVIEW -->
		 Flask Security Architecture and SELinux
		 SELinux, an Implementation of Flask
	</section>
	
	<section>	
	SELinux Policy Overview
<!-- 	VERY QUICK REVIEW -->
		 What Is Policy?
		 Where is the Policy?
		 Policy Role in Boot
<!-- 	CAREFULLY REVIEW THE FOLLOWING -->
		 File System Security Contexts
		 Object Classes and Permissions
		 TE Rules - Attributes
		 TE Rules - Types
		 TE Rules - Access Vectors
		 Policy Macros
		 SELinux Users and Roles
		 TE Rules - Constraints
		 Special Interfaces and File Systems
	</section>
	
	<section>	
	Targeted Policy Overview
		 What is the Targeted Policy?
		 Files and Directories of the Targeted Policy
<!-- 	CAREFULLY REVIEW THE FOLLOWING -->
		 Understanding the File Contexts Files
		 Common Macros in the Targeted Policy
		 Understanding the Roles and Users in the Targeted Policy
	</section>
	
	<section>
	Multi-Level Security Overview
		WRITE FROM BLOGS
	<!-- David O'Brien daobrien@redhat.com to write draft. Looking for reviewer -->
	</section>
	
	<section>	
	Multi-Category Security Overview
		WRITE FROM BLOGS
	<!-- David O'Brien daobrien@redhat.com to write draft. Looking for reviewer -->
	</section>
		
</chapter>
<chapter>Working with SELinux
	<section>
	Controlling and Maintaining SELinux
<!-- 	CAREFULLY REVIEW THE FOLLOWING -->
		 End User Control of SELinux
		 Administrator Control of SELinux
		 Analyst Control of SELinux
		 Policy Writer Control of SELinux
	</section>
	
	<section>	
	Tools for Manipulating and Analyzing SELinux
<!-- 	CAREFULLY REVIEW THE FOLLOWING -->
		 Information Gathering Tools
		 Using seaudit for Audit Log Analysis
	</section>
	
	<section>	
	Compiling SELinux Policy
<!-- 	CAREFULLY REVIEW THE FOLLOWING -->
		 Policy Compile Procedure
		 What Happens During Policy Build
	</section>
	
	<section>
	Customizing and Writing Policy
<!-- 	CAREFULLY REVIEW THE FOLLOWING -->
		 General Policy Troubleshooting Guidelines
		 Minor Customizations of the Existing Policy
		 Writing New Policy for a Daemon
		 Deploying Customized Binary Policy
	</section>
	
</chapter>
<chapter>Appendixes

	<section>
	SELinux Use Cases
	CAREFULLY REVIEW THE FOLLOWING
		Example Policy Reference - dhcpd
	</section>
	
	<section>
	Comparing MCS and ACL
		WRITE FROM BLOGS
	<!-- David O'Brien daobrien@redhat.com to write draft. Looking for reviewer -->
	</section>
		
</chapter>

<chapter>References


	UPDATE

</chapter>
</part>

--Boundary-00=_y2WyEGPMO7eySDZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
