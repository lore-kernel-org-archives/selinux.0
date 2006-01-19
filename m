Message-ID: <43CFA1B5.20601@redhat.com>
Date: Thu, 19 Jan 2006 09:27:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest policycoreutils patch
References: <43CD54B9.4030307@redhat.com> <43CD9BDE.8010005@tresys.com>	 <43CDB89C.4030608@redhat.com> <43CDB8DF.9070100@tresys.com>	 <43CDBA95.8020308@redhat.com> <43CDBB35.6020209@tresys.com>	 <43CDE7ED.4020908@cornell.edu> <43CE6261.8030204@redhat.com>	 <43CE824E.6010904@cornell.edu>  <43CE8520.5050008@cornell.edu>	 <1137609022.8926.194.camel@moss-spartans.epoch.ncsc.mil>	 <43CE8AB3.1070103@cornell.edu>	 <1137610343.8926.202.camel@moss-spartans.epoch.ncsc.mil>	 <43CE91FC.7040205@redhat.com> <43CE93E6.8080401@cornell.edu>	 <43CE94BB.1080302@redhat.com> <1137614340.8926.233.camel@moss-spartans.epoch.ncsc.mil> <43CE9E81.3000706@cornell.edu>
In-Reply-To: <43CE9E81.3000706@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> Not sure I follow; the patch changes some occurrences of "Failed to add
>> port" to "Failed to modify port" in the add() method.
>>   
> ...which is wrong, imho, it should still say "Failed to add port".
> The second part of it is right, I think (I assume it's changing 
> modify(), hard to tell without the -p flag).
> There's a bug in modify that says "failed to add" currently.
>
> I agree with what Dan is saying, I just think the first place he's 
> changing is wrong.
>
Yes the first part of the patch is wrong.  The messsage under the add 
section should stay add.  I was changing the "add" to "modify" under the 
modify section and got carried away...
> There's another wrong message btw, see interfaces.modify().
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
