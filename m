Message-ID: <52177D45.60402@tycho.nsa.gov>
Date: Fri, 23 Aug 2013 11:18:29 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: Common Intermediate Language (CIL) Update
References: <51F6A808.5080204@tycho.nsa.gov> <1377189006.38963.YahooMailNeo@web87904.mail.ir2.yahoo.com> <521668CA.7040305@tycho.nsa.gov> <1377270346.9016.YahooMailNeo@web87904.mail.ir2.yahoo.com>
In-Reply-To: <1377270346.9016.YahooMailNeo@web87904.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/2013 11:05 AM, Richard Haines wrote:
> Thanks for the bad news, anyway I've been trying the classmap / classmapping and not sure if this is a bug or
> another change. The sample I've been using is (I just modified the test policy):
>
>      (classmap files_rw (read write))
>
>      (classmapping files_rw read
>          (file (open read getattr)))
>
>      (classmapping files_rw write
>          (file (execute_no_trans entrypoint execmod open audit_access))
>          (file (open write setattr)))
>
> However the results vary between your version and the Tresys version as follows:
>
> secil from git clone http://oss.tresys.com/git/cil.git cil
> allow policy.console_t policy.t_1 : policy.file { write setattr execute_no_trans entrypoint execmod open audit_access } ;
> allow policy.console_t policy.t_2 : policy.file { read getattr open } ;
>
> secil from git clone https://jwcarter@bitbucket.org/jwcarter/secilc.git
> allow policy.console_t policy.t_1 : policy.file { execute_no_trans entrypoint execmod open audit_access } ;
> allow policy.console_t policy.t_2 : policy.file { read getattr open } ;
>
>
> I think the Tresys version is correct (well I hope so)
>

The Tresys version is correct. This is a bug. I will take a look at it.

Thanks for the report.

Jim


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
