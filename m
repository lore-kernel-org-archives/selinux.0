Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7I0eenj000759
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 20:40:40 -0400
Received: from sca-es-mail-1.sun.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7I0fju3008585
	for <selinux@tycho.nsa.gov>; Tue, 18 Aug 2009 00:41:45 GMT
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-1.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n7I0ebNh028391
	for <selinux@tycho.nsa.gov>; Mon, 17 Aug 2009 17:40:37 -0700 (PDT)
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII; format=flowed
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 id <0KOJ00400R2HZI00@fe-sfbay-10.sun.com> for selinux@tycho.nsa.gov; Mon,
 17 Aug 2009 17:40:37 -0700 (PDT)
Date: Mon, 17 Aug 2009 17:40:24 -0700
From: Glenn Faden <Glenn.Faden@sun.com>
Subject: Re: Not quite MLS.
In-reply-to: <1250545104.3588.149.camel@rxm-581b.stl.gtri.gatech.edu>
To: rob myers <rob.myers@gtri.gatech.edu>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-id: <4A89F878.1040604@sun.com>
References: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu>
 <1250509252.3629.84.camel@moss-pluto.epoch.ncsc.mil>
 <1250545104.3588.149.camel@rxm-581b.stl.gtri.gatech.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

rob myers wrote:
>
> I believe the difference between SELinux with MLS policy and what I am
> trying to build is that I want higher sensitivity levels to dominate
> lower sensitivity levels only on a per category basis.
>
> For example, it is my understanding that under MLS UserB must have
> sensitivity level 3 access to category 3 because UserB has access to
> sensitivity level 3 access to other categories.  Another possibility
> under MLS would be to remove UserB's access to category 3 for all
> sensitivities.  Neither of these is what I want the system to do.
>   
For MLS systems based on the Mitre/DIA label encodings format it is 
possible to exclude specific categories on a per sensitivity label basis 
from the User Accreditation Range. For an example, see:

    http://docs.sun.com/app/docs/doc/819-0874/sec6-2?a=view

In your example, you could define specify the valid categories for each 
of the four classifications (levels).

    UserA's access matrix:

    category, sl0, sl1, sl2, sl3
           0, yes, yes, no , no 
           1, yes, yes, no , no 
           2, yes, yes, yes, no 
           3, yes, yes, yes, yes 


    UserB's access matrix:

    category, sl0, sl1, sl2, sl3
           0, yes, yes, yes, yes
           1, yes, yes, yes, yes
           2, yes, yes, yes, yes
           3, yes, yes, yes, no 


you could specify

    classification= s10; all compartment combinations valid;
    classification= s11; all compartment combinations valid;
    classification= s12; all compartment combinations valid except:
    c0
    c1
    classification= s13; only valid compartment combinations:
    c3


So it is possible to specify a User Accreditation Range conforming to 
either the UserA or UserB matrix. However, the format only provides for 
a single User Accreditiation Range that would apply to all users. In MLS 
systems I'm familiar with, there is no facility to exclude categories 
from the kernel dominance checks.

--Glenn

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
