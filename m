Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k211QEN0003757
	for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2006 20:26:14 -0500
Received: from xproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k211Ojpu014988
	for <selinux@tycho.nsa.gov>; Wed, 1 Mar 2006 01:24:45 GMT
Received: by xproxy.gmail.com with SMTP id t14so10938wxc
        for <selinux@tycho.nsa.gov>; Tue, 28 Feb 2006 17:26:13 -0800 (PST)
Message-ID: <4ef5fec60602281726j2895cdcfwdc10696c1c081560@mail.gmail.com>
Date: Tue, 28 Feb 2006 17:26:13 -0800
From: coderman <coderman@gmail.com>
To: selinux@tycho.nsa.gov
Subject: virtual SELinux appliances, automated test suites
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

there have been some interesting discussions in the past here and
elsewhere related to combining virtual machines and SELinux enabled
operating system instances. (open source NetTop where virtual
instances also apply SELinux policy internally?) [1] [2] [3]

i'd like to know if anyone is aware of additional resources related to
this approach.  i am using  this method coupled with user centric two
factor authentication (right now token + pass phrase) to provide a
secure environment for various task/service oriented OS instances
(virtual appliances as VMware calls them when virtualized.[4] 
currently these are dedicated instances launched from boot loader and
the virtualization piece is where my focus now resides)

the terra project looks promising but i cannot find any code or
implementation details aside from that presented in the paper. [5]

the various User Mode Linux images which support SELinux policy are
relevant though i would prefer a stronger xen/vmware isolation between
virtual instances. [6] [7]

the secure virtual file system uses xen to manage fs communication
used by virtual machines although it too lacks detail.  if
code/implementation for this could be obtained and SELinux aware
instances executed under xen this might fit the bill nicely. [8]

the way in which we are using virtual appliances requires the OS
images be pre-populated with all necessary keys, configuration, and
application data.  this places an emphasis on testing to ensure
mastered os instances / appliances function as desired standalone or
within a network.  information related to automated regression
testing, learning modes for SELinux policy definition/refinement, and
other relevant resources would be greatly appreciated.  there is
little information on these methods currently available that i was
able to find applied to SELinux although similar projects exist for
other targets. [9] [10]

best regards,


[1.] " Paranoid Penguin - The Future of Linux Security"
  http://www.linuxjournal.com/node/8296/print

[2.] "xen 2.0 - adding selinux permissions"
  http://www.nsa.gov/selinux/list-archive/0411/9642.cfm

[3.] "Re: XP as a base for NetTop"
  http://www.nsa.gov/selinux/list-archive/0405/7222.cfm

[4.] "Community Virtual Appliances"
  http://www.vmware.com/vmtn/appliances/community.html

[5.] "Terra: A Virtual Machine-Based Platform for Trusted Computing"
  http://footstool.stanford.edu/~jchow/papers/sosp03/terra.pdf

[6.] "The ADIOS Project - Automated Download and Installation of
Operating Systems"
  http://dc.qut.edu.au/adios/news.html

[7.] "Annotated HOWTO for creating an SELinux enabled UML system"
  http://www.golden-gryphon.com/software/security/selinux-uml.xhtml

[8.] "SVFS: Secure Virtual File System"
  http://www.eecs.umich.edu/~zhaoxin/svfs_intro.htm

[9.] "Systrace - Interactive Policy Generation for System Calls"
  http://www.citi.umich.edu/u/provos/systrace/

[10.] "Using Test Suites to Validate the Linux Kernel"
  http://linuxquality.sunsite.dk/articles/testsuites/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
