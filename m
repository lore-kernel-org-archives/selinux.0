Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBKHAwcX021055
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 12:10:59 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBKHBXEG019516
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 17:11:34 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id kBKHBXqU018780
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 12:11:33 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id kBKHBXuX008851
	for <selinux@tycho.nsa.gov>; Wed, 20 Dec 2006 12:11:33 -0500
Message-ID: <45896ECC.6010605@redhat.com>
Date: Wed, 20 Dec 2006 12:11:40 -0500
From: Karl MacMillan <kmacmill@redhat.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: [ANN] Madison policy generation tools
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The first public release of the Madison SELinux policy generation tools 
can be found at http://et.redhat.com/madison/. Madison is a new project 
to create command line and GUI policy generation tools that:

   * Create more readable and secure policy by leveraging the reference
     policy development environment.
   * Provide administrators with guidance and information to help them
     make good security decisions.

This release focuses on the creation of a foundation library (in 
python). It only includes a single tool - audit2policy - that is a drop 
in replacement for audit2allow with better reference policy interface 
call generation (using the undocumented -R audit2allow flag).

Contributions are very welcome. I'm looking for help with:

   * Testing (particularly interface call generation and module
     generation)
   * Documenation
   * Unit test creation
   * Code / tool development

See the website for more details on contributing.

To the authors of other policy generation tools: I would like to avoid 
duplication of effort where possible. The current release focuses on 
areas that other tools have not explored thoroughly. Moving forward I 
would to discuss how we can best work together.

Please send any feedback to the selinux development list.

Thanks - Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
