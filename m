Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6R8CirT000247
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 04:12:44 -0400 (EDT)
Received: from imf17aec.mail.bellsouth.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6R8CEmJ026418
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 08:12:15 GMT
Message-ID: <41060E79.1080102@bellsouth.net>
Date: Tue, 27 Jul 2004 04:12:41 -0400
From: Jim McCullough <jwmccull@bellsouth.net>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Wolfgang Pfeiffer <roto@gmx.net>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Selinux possible on Debian-Linux/ppc?
References: <1090769556.7265.32.camel@debby> <200407261340.04981.russell@coker.com.au>
In-Reply-To: <200407261340.04981.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm not sure on ppc.  I never had to install linux on one personally.  
Give me two more weeks and I will tell you how it goes with SGI Octane's 
though.  I scavenged two at work for mini-servers for the group I am 
with.  Before they went out the door to the dump.  One of which is going 
to requires some extensive perl work to incorperate NetDisco project.  
Default Debian Sarge build breaks the root discovery with CDP SNMP and 
creation of network topology maps.  The other box is for nagios with 
selinux kernel base and policies because of the dual roll with the 
IT-Security group for network security scans, and with Network-Ops for 
monitoring network devices and servers.
I will let you know how the build goes when I get it completed.  BTW, 
the CVS archive on the web site seems to be holding stable at work on a 
P3 500 I setup on 2.6.7 last thurs.  Still going and still screaming, 
throughput and performance much better than the 2.6.7-686 build from the 
binary tree.

Jim McCullough

Russell Coker wrote:

>On Mon, 26 Jul 2004 01:32, Wolfgang Pfeiffer <roto@gmx.net> wrote:
>  
>
>>But I'm not quite sure whether SElinux will run on that machine, and on
>>Debian-ppc ...
>>    
>>
>
>It is expected to work, I think that the Gentoo people have been getting PPC 
>machines to run SE Linux.
>
>  
>
>>But a quick search for SElinux packages for my system gives this:
>>
>>      * checkpolicy - SELinux policy compiler
>>      * libselinux1 - SELinux shared libraries
>>      * libselinux1-dev - SELinux development headers
>>      * policycoreutils - SELinux core policy utilities
>>      * selinux-doc - documentation for Security-Enhanced Linux
>>      * selinux-policy-default - Policy config files and management for
>>        NSA Security Enhanced Linux
>>      * selinux-utils - SELinux utility programs
>>    
>>
>
>You will need to compile ssh, dpkg, cron, sysvinit, logrotate, and pam with 
>the SE Linux patches from my web site to get it going.  I only have i386 
>architecture hardware, and a lot of my stuff hasn't been accepted into Debian 
>yet.
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
