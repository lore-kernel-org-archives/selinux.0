Message-ID: <442D5A3F.9090409@cornell.edu>
Date: Fri, 31 Mar 2006 11:35:11 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We need a	way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com> <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>
> At present, you can force the nvidia entry to win by adding it as a
> local fcontext via semanage or file_contexts.local.  But if we add the
> sort to libsemanage, we'll lose the ability to give precedence to local
> fcontexts added by semanage unless we exclude the local ones from the
> sort, right?
>   
Hmm, I think we actually don't have this capability as of right now - my 
fault, as I didn't get around to addressing this issue, which would 
consist of either not merging the .local file into the other one (as we 
do now), or moving the sort algorithm into libsemanage, where it would 
sort the local things separately from the module things.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
