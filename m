Message-ID: <546A5C6F.6030805@redhat.com>
Date: Mon, 17 Nov 2014 15:37:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
 "Paddie O'Brien" <paddieobrien@gmail.com>, Selinux@tycho.nsa.gov
Subject: Re: Question on unconfined_t
References: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
 <546A1634.1070900@tycho.nsa.gov>
In-Reply-To: <546A1634.1070900@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On 11/17/2014 10:37 AM, Stephen Smalley wrote:
> On 11/17/2014 09:44 AM, Paddie O'Brien wrote:
>> Hi,
>>
>> As a learning exercise I created a simple policy to sandbox a simple
>> program in its own domain.
>>
>> I had to add rules to the policy to allow the program to be executed
>> from unconfined_t. Is this normal? My understanding was that a process
>> in unconfined_t was subject only to DAC so why did I have to add this
>> rule? What does unconfined_t actually mean?
> SELinux has no intrinsic concept of unconfined_t; unconfined_t is just a
> type that is allowed to do most things by policy.
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
>
You probably did not define the type as a file_type(mytype_t)

unconfined_t is only allowed to execute file types, if you just define a
type and put it on a file, SELinux does not know if it is a port_type or
a process type (domain)
So it is not allowed.
