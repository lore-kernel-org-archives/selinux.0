Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4D29roq027600
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 22:09:53 -0400
Message-ID: <5552B26C.9000101@schaufler-ca.com>
Date: Tue, 12 May 2015 19:09:48 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>,
 Andrew Holway <andrew.holway@otternetworks.de>, selinux@tycho.nsa.gov
Subject: Re: SELinux talk
References: <CAEcA1_vvm7TEkrULWOxbC=BtuCyn+Tm0DMXLE3ScZe24Lktpjw@mail.gmail.com>
 <555230E7.6030604@tycho.nsa.gov>
In-Reply-To: <555230E7.6030604@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 5/12/2015 9:57 AM, Stephen Smalley wrote:
> On 05/12/2015 10:42 AM, Andrew Holway wrote:
>> Hello,
>>
>> I'm giving a talk on SELinux at a little conference here in Berlin in a
>> couple of days. I was going to do the following items.
>>
>> IEEE 1003.1e/2c - A withdrawn draft standard.

As Stephen says below, SELinux is more of a pendulum swing away from
than a derivative of that work and the TCSEC that inspired it.

>> Linux ACLS - Hacked together from IEEE 1003.1e/2c

Not a hack. Really. A port of the ACLs from Irix,
with the nasty parts replaced. Yes, based on 1003.1e/2c,
but all the UNIX systems did that, too.

>> SELinux -> An opensource solution for the US military.
>> DAC 1997 -> 2015 - The elephant in the room.

Oh! Please, expound. 


>>
>> I was wondering if anyone could provide me with specific bulletpoint
>> examples of the problems inherent with the current ACL system and how
>> SELinux can mitigate these problems.
> This has been repeatedly described in our published papers and
> presentations as well as many external SELinux resources.  In short form:
>
> DAC:
> - Decisions based only on user identity/ownership.
> - No protection against malicious or flawed applications (every
> application you run has access to everything to which you have access,
> and is free to propagate that access to others).
> - Subject to the whims, carelessness, or maliciousness of every user.
> - Typically only two major categories of users:  superuser or completely
> unprivileged, leading to overprivilege for many processes or weak
> permissions to work around.
>
> MAC, and in particular SELinux:
> - Decisions based on all security-relevant attributes, taking into
> account not only user identity but also active role, the trustworthiness
> and function of the program that is executing (encoded in the domain),
> the clearance of the user, etc.
> - Ability to confine malicious and flawed applications, including even
> ones that run as root.
> - Policy defined by administrator/organization, enforced over all users
> and their programs.
> - Support for fine-grained least privilege, ability to tailor to match
> the specific trustworthiness and function of each component.
>
>
>> Can anyone tell me about the relationship between IEEE 1003.1e/2c and
>> SELinux? 
> Largely none.  That withdrawn draft standard embodied the traditional
> view of Mandatory Access Control and Privileges embodied in the legacy
> trusted operating systems of the past, which is quite different from the
> flexible Mandatory Access Control architecture and Type Enforcement
> model embodied in SELinux.  That flexible MAC architecture and TE model
> were in fact designed to address the shortcomings of such systems.

The MAC component of P1003.1e/2c was sufficient to supply the Bell & LaPadula
model required by the Orange Book (the "traditional" model) but was also
carefully designed to allow for alternative models. One of the members of the
working group wanted to do Biba integrity. A timestamp model was also held up
as a something that had to be supportable. POSIX limits itself to interfaces,
so you can't really read much into what's going on underneath. You could support
the MAC interfaces on Linux (in support of SELinux or Smack) if you were so
inclined.

Capabilities are another story.

> Again, see our published papers and presentations and external SELinux
> resources, e.g.:
> https://www.nsa.gov/research/selinux/background.shtml
> https://www.nsa.gov/research/selinux/docs.shtml
> http://freecomputerbooks.com/The-SELinux-Notebook-The-Foundations.html
> http://seandroid.bitbucket.org/PapersandPresentations.html
>
> Particularly with respect to comparisons with POSIX.1e, you may be
> interested in:
> http://www.securecomputing.com/pdf/secureos.pdf (not about SELinux per
> se, but compares Type Enforcement, which is the core SELinux security
> model, to POSIX.1e capability model)
>
>> Any other interesting nuggets to keep a technical but non security
>> focussed audience interested?
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>
