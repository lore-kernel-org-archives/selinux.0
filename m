Message-ID: <442FB65C.10201@cornell.edu>
Date: Sun, 02 Apr 2006 07:32:44 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We need a	way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com> <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil> <442D5A3F.9090409@cornell.edu> <442D663F.8010200@cornell.edu>
In-Reply-To: <442D663F.8010200@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
>
>> Hmm, I think we actually don't have this capability as of right now - 
>> my fault, as I didn't get around to addressing this issue, which 
>> would consist of either not merging the .local file into the other 
>> one (as we do now), or moving the sort algorithm into libsemanage, 
>> where it would sort the local things separately from the module things. 
> ...maybe this will help.
>
I assume this patch won't be used...but in case anyone decides to merge 
it, it's buggy - it needs to treat lack of file_contexts.local in the 
sandbox as non-fatal and fallthrough on install, just like it was done 
for the seusers file - simple 1-line change.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
