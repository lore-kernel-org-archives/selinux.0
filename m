Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GCPLrT024082
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 08:25:21 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GCPKsh009547
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 12:25:21 GMT
Message-ID: <41498621.5090803@redhat.com>
Date: Thu, 16 Sep 2004 08:25:05 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Colin Walters <walters@redhat.com>
CC: ivg2@cornell.edu, selinux@tycho.nsa.gov
Subject: Re: SELinux policy discussion.
References: <4148A003.6080309@redhat.com>	 <1095295125.4231.127.camel@nexus.verbum.private>	 <1095302625.28466.56.camel@localhost.localdomain>	 <1095307503.4231.152.camel@nexus.verbum.private> <1095308130.4231.159.camel@nexus.verbum.private>
In-Reply-To: <1095308130.4231.159.camel@nexus.verbum.private>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Colin Walters wrote:

>On Thu, 2004-09-16 at 00:05 -0400, Colin Walters wrote:
>
>  
>
>>Do you have a particular daemon you feel should be in the strict policy?
>>    
>>
>
>I mean the targeted policy, obviously.
>
>  
>
If we added a tunable to allow users to read all sysadmfile files we 
would get somewhere between
strict policy and targeted.

bool user_read_adminfile false;

if (user_read_adminfiles) {
    r_dir_file($1_t, sysadmfile)
}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
