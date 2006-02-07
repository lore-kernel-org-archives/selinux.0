Message-ID: <43E90FEB.6010503@tresys.com>
Date: Tue, 07 Feb 2006 16:23:55 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   SELinux <SELinux@tycho.nsa.gov>
Subject: Re: [PATCH] Add seuser and user_extra to package format
References: <43E7D03D.4090909@tresys.com>  <43E80E52.6090503@cornell.edu> <1139322866.2872.44.camel@moss-spartans.epoch.ncsc.mil> <43E8DE4F.1040203@tresys.com> <43E8FD98.20202@cornell.edu>
In-Reply-To: <43E8FD98.20202@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>>
>> IMO we should leave the semanageswig.i as the language neutral 
>> interface file (and not remove the _by_idx functions) and make 
>> language specific files include it. Then all the common parts are in 
>> semanageswig.i and python specific ones are in another file. That way 
>> we are free to use better features for python without eliminating the 
>> possibility of building the wrappers for another language and it 
>> shouldn't make maintenance any harder.
> Have you tried to see if the current typemaps work on any other language?
> I don't think the t_output_helper function you're using is defined in 
> any other language except for python.
> 

Ok, it looks like you are right, I just tried it on perl and 
t_output_helper was undefined. So aside from the #includes and the 
*_by_idx pretty much everything in the current .i file is python specific.

It looks like this library is sufficiently complex that there will need 
to be a .i file for each language supported, unfortunately.

We can still use the semanageswig.i to pull in all the headers that we 
are wrapping and put language specific things in their own .i file.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
