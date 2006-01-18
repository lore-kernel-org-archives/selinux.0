Message-ID: <43CE94BB.1080302@redhat.com>
Date: Wed, 18 Jan 2006 14:19:23 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu>	 <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>	 <43CE8AB3.1070103@cornell.edu> <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil> <43CE91FC.7040205@redhat.com> <43CE93E6.8080401@cornell.edu>
In-Reply-To: <43CE93E6.8080401@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>>
>> cut and paste errors in error messages in seobject.py
> Those were not cut and paste errors, they were intentional. The 
> message corresponds to the semanage/tool function being used. The 
> libsemanage function is always modify_local, so that would make all 
> such error messages say "failed to modify" for all objects.
>
>
When a user tries to add and he gets a failed to modify error, he will 
suspect a problem.  The writers of the code can figure out that they 
both call the same function.

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
