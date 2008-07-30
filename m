Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6UIA1Zn000671
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2008 14:10:01 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m6UI9ov4005713
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2008 18:10:01 GMT
Subject: ANN: CDS Framework version 3.0
From: Dave Sugar <dsugar@tresys.com>
Reply-To: cdsframework@tresys.com
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Cc: cdsframework@tresys.com
Content-Type: text/plain
Date: Wed, 30 Jul 2008 14:08:39 -0400
Message-Id: <1217441319.3863.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Version 3.0 of the CDS Framework Toolkit from Tresys Technology is now
available for download from the Tresys Open Source website at
http://oss.tresys.com  

The CDS Framework Toolkit is an Eclipse plug-in that allows engineers to
leverage the power of SELinux when designing and implementing cross
domain solutions without requiring that they have in depth knowledge of
the complex details of underlying SELinux security policies.  In
particular the CDS Framework Toolkit provides the following benefits to
CDS developers on SELinux systems:     

* An integrated development environment for creating security policy
* Graphical editing of information flow for developing security policy
* SELinux policy generation
* Integration with SLIDE and Reference Policy (also available on
http://oss.tresys.com)


Version 3.0 highlights:
* Support for Multi-Level Security (MLS), as well as the previously
supported type enforcement and Role-Based Access Control (RBAC)
mechanisms  
* Support for labeled networking to allow for inter-system interactions 
* Enhanced usability by providing better end user customization of
generated SELinux policy and an increase in the granularity of what can
be specified within the Framework  
* Addition of form editors to edit linkage files
* Display of custom additions (linkage and dictionary files) in the
framework navigator 
* Display of backflow information with ability to customize in
dictionary
* Ability to hide enters and entrypoints
* Enhancements to the new resource wizard
* Bug fixes including problems with nested control resources, accesses
to base domains, dictionary problems 

Dave Sugar
Tresys Technology, LLC

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
