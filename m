Message-ID: <442D7CFC.8060704@cornell.edu>
Date: Fri, 31 Mar 2006 14:03:24 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: sds@tycho.nsa.gov
CC: Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: The sort algorithm is broken by the second rule,  We need	a	way
 to pin these rules to the top.
References: <442D41CA.8070702@redhat.com>  <442D436A.1010805@tresys.com>	 <1143817846.24555.329.camel@moss-spartans.epoch.ncsc.mil>	 <442D5A3F.9090409@cornell.edu> <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1143831151.17469.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>   Sorting is presently only
> happening in the policy build process via the
> refpolicy/support/fc_sort.c helper program, so it is only applied to the
> file_context file provided by the policy itself, not to any local
> entries (whether created via semanage or not).
>   
My mistake, I thought sorting was moved into matchpathcon at some point...
In that case the patch I sent shouldn't be necessary.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
