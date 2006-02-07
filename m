Message-ID: <43E8FD98.20202@cornell.edu>
Date: Tue, 07 Feb 2006 15:05:44 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Chad Hanson <chanson@TrustedCS.com>,
   Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add seuser and user_extra to package format
References: <43E7D03D.4090909@tresys.com>  <43E80E52.6090503@cornell.edu> <1139322866.2872.44.camel@moss-spartans.epoch.ncsc.mil> <43E8DE4F.1040203@tresys.com>
In-Reply-To: <43E8DE4F.1040203@tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> IMO we should leave the semanageswig.i as the language neutral 
> interface file (and not remove the _by_idx functions) and make 
> language specific files include it. Then all the common parts are in 
> semanageswig.i and python specific ones are in another file. That way 
> we are free to use better features for python without eliminating the 
> possibility of building the wrappers for another language and it 
> shouldn't make maintenance any harder.
Have you tried to see if the current typemaps work on any other language?
I don't think the t_output_helper function you're using is defined in 
any other language except for python.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
