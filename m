Message-ID: <555230E7.6030604@tycho.nsa.gov>
Date: Tue, 12 May 2015 12:57:11 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Andrew Holway <andrew.holway@otternetworks.de>, selinux@tycho.nsa.gov
Subject: Re: SELinux talk
References: <CAEcA1_vvm7TEkrULWOxbC=BtuCyn+Tm0DMXLE3ScZe24Lktpjw@mail.gmail.com>
In-Reply-To: <CAEcA1_vvm7TEkrULWOxbC=BtuCyn+Tm0DMXLE3ScZe24Lktpjw@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/12/2015 10:42 AM, Andrew Holway wrote:
> Hello,
> 
> I'm giving a talk on SELinux at a little conference here in Berlin in a
> couple of days. I was going to do the following items.
> 
> IEEE 1003.1e/2c - A withdrawn draft standard.
> Linux ACLS - Hacked together from IEEE 1003.1e/2c
> SELinux -> An opensource solution for the US military.
> DAC 1997 -> 2015 - The elephant in the room.
> 
> I was wondering if anyone could provide me with specific bulletpoint
> examples of the problems inherent with the current ACL system and how
> SELinux can mitigate these problems.

This has been repeatedly described in our published papers and
presentations as well as many external SELinux resources.  In short form:

DAC:
- Decisions based only on user identity/ownership.
- No protection against malicious or flawed applications (every
application you run has access to everything to which you have access,
and is free to propagate that access to others).
- Subject to the whims, carelessness, or maliciousness of every user.
- Typically only two major categories of users:  superuser or completely
unprivileged, leading to overprivilege for many processes or weak
permissions to work around.

MAC, and in particular SELinux:
- Decisions based on all security-relevant attributes, taking into
account not only user identity but also active role, the trustworthiness
and function of the program that is executing (encoded in the domain),
the clearance of the user, etc.
- Ability to confine malicious and flawed applications, including even
ones that run as root.
- Policy defined by administrator/organization, enforced over all users
and their programs.
- Support for fine-grained least privilege, ability to tailor to match
the specific trustworthiness and function of each component.


> Can anyone tell me about the relationship between IEEE 1003.1e/2c and
> SELinux? 

Largely none.  That withdrawn draft standard embodied the traditional
view of Mandatory Access Control and Privileges embodied in the legacy
trusted operating systems of the past, which is quite different from the
flexible Mandatory Access Control architecture and Type Enforcement
model embodied in SELinux.  That flexible MAC architecture and TE model
were in fact designed to address the shortcomings of such systems.
Again, see our published papers and presentations and external SELinux
resources, e.g.:
https://www.nsa.gov/research/selinux/background.shtml
https://www.nsa.gov/research/selinux/docs.shtml
http://freecomputerbooks.com/The-SELinux-Notebook-The-Foundations.html
http://seandroid.bitbucket.org/PapersandPresentations.html

Particularly with respect to comparisons with POSIX.1e, you may be
interested in:
http://www.securecomputing.com/pdf/secureos.pdf (not about SELinux per
se, but compares Type Enforcement, which is the core SELinux security
model, to POSIX.1e capability model)

> Any other interesting nuggets to keep a technical but non security
> focussed audience interested?
