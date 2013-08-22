Message-ID: <521668CA.7040305@tycho.nsa.gov>
Date: Thu, 22 Aug 2013 15:38:50 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Common Intermediate Language (CIL) Update
References: <51F6A808.5080204@tycho.nsa.gov> <1377189006.38963.YahooMailNeo@web87904.mail.ir2.yahoo.com>
In-Reply-To: <1377189006.38963.YahooMailNeo@web87904.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/22/2013 12:30 PM, Richard Haines wrote:
> Thanks for the updated CIL that has many useful fixes, however I notice that you removed the "permissionset" statement. Is this to be dropped altogether or just in your version (I've got lots in my test policy so thought I would ask before I change them all).
>

Yes, it is. Permissions can no longer be referred to apart from their class. Not 
only was the permissionset statement removed, but permissions can no longer be 
passed as an argument to a call.

Either classpermissionset or classmapping statements can be used to replace 
them. I am sorry to say that this is a little bit more work up front, but I 
think it makes sense for the overall policy.


> Richard
>
>
>
> ________________________________
>   From: James Carter <jwcart2@tycho.nsa.gov>
> To: SELinux List <selinux@tycho.nsa.gov>
> Cc: Steve Lawrence <slawrence@tresys.com>
> Sent: Monday, 29 July 2013, 18:36
> Subject: Common Intermediate Language (CIL) Update
>
>
> The CIL compiler, secilc, is now able to create MLS, MCS, and non-MLS binary policies from a slightly modified version of Refpolicy that has been converted to CIL.
>
> Anyone interested in trying CIL out can do the following:
>
> 1) Clone the CIL compiler and cilpolicy
> git clone https://jwcarter@bitbucket.org/jwcarter/secilc.git
> git clone https://jwcarter@bitbucket.org/jwcarter/cilpolicy.git
>
> 2) Build secilc
> cd secilc
> make
> cd ..
>
> 3) Build cilpolicy
> ./secilc/secilc `cat cilpolicy/LISTING`
>
>
> To build an MLS policy:
>
> Edit "cilpolicy/mls_declarations" and change "(tunable enable_mls false)" to "(tunable enable_mls true)"
>
> Build the MLS policy: ./secilc/secilc -M `cat cilpolicy/LISTING`
>
> MCS is similar.
>
>
> Anyone interested in trying to create their own CIL policy from Refpolicy can clone the Flask Policy Parser (fpp) from bitbucket and follow the instructions in the README. To clone fpp:
> git clone https://jwcarter@bitbucket.org/jwcarter/fpp.git
>
> -- James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
