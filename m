Message-ID: <43469CF1.80408@tresys.com>
Date: Fri, 07 Oct 2005 12:06:09 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, SELinux-dev@tresys.com,
   dwalsh@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [ SEMANAGE ] [ SEPOL ] More database work
References: <43454A61.8010907@cornell.edu> <1128626875.15836.168.camel@moss-spartans.epoch.ncsc.mil> <1128695426.1450.26.camel@moss-spartans.epoch.ncsc.mil> <434699D7.9040307@cornell.edu>
In-Reply-To: <434699D7.9040307@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> 
>> Ok, I've made a first cut at the changes to libsepol and updated it and
>> checkpolicy to build again, and am starting to work through libsemanage.
>> As an example of what to expect, the diff below to database_direct.[ch]
>> was needed to get it to compile again.
>>   
> 
> Ok...
> 
> On second thought that code was likely wrong to begin with, since Tresys 
> put their modules in a special package container, and mark everything 
> with a special magic, and use special functions to read everything.... 
> I'll get it fixed later... not testing the direct case yet.

It isn't just a special package container. The actual policy format for 
modules is different because it retains more information than the binary 
format. The 'package' format is the module with the file contexts 
prepended to it. The module format and the file contexts are needed to 
properly link and expand a policy.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
