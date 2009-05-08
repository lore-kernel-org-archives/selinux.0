Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n48ErxeM029352
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 10:53:59 -0400
Received: from smtp104.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n48Erx9S016296
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 14:53:59 GMT
Message-ID: <4A044771.5000004@schaufler-ca.com>
Date: Fri, 08 May 2009 07:53:37 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, "Serge E. Hallyn" <serue@us.ibm.com>,
        Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
        viro@ZenIV.linux.org.uk
Subject: Re: SELinux and access(2), we want to know.
References: <1241723924.2791.107.camel@localhost.localdomain>	 <20090507195729.GA21104@us.ibm.com>  <4A03AC41.1040505@schaufler-ca.com> <1241785627.6452.193.camel@localhost.localdomain> <4A0429A7.7060507@redhat.com>
In-Reply-To: <4A0429A7.7060507@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:
> On 05/08/2009 08:27 AM, Stephen Smalley wrote:
>> On Thu, 2009-05-07 at 20:51 -0700, Casey Schaufler wrote:
>>> Serge E. Hallyn wrote:
>>>> Quoting Eric Paris (eparis@redhat.com):
>>>>
>>>>> 3) I've also heard it hinted that we could do this with audit by just
>>>>> having audit drop the denials that include the access(2) syscall
>>>>> and the
>>>>> scontext and tcontext for the slew of things the SELinux policy
>>>>> writers
>>>>> know we are not interested in.  And while it seems good, now we have
>>>>>
>>>> What is the difference whether an attacker does access(2) to check for
>>>> /etc/shadow rights, or does a failed open()?
>>>>
>>> I have been studiously ignoring the discussions on the SELinux list
>>> because
>>> in the end it really doesn't matter, as Serge (appears to) point out
>>> here.
>>> The access() system call was a major thorn in the side of the POSIX
>>> security
>>> working group because its behavior is not really very rational. By
>>> design
>>> it does not take into account read-only file systems, ACLs, MAC labels,
>>> TOMOYO policy, or anything other than the mode bits. A successful
>>> return
>>> from access() gives you no assurance whatever that if you actually
>>> try the
>>> operation it will succeed. My recollection is that every version of
>>> "trusted unix" written treats the system call the same way it would a
>>> call to lstat(), because that's really all it is doing.
>>
>> Casey, please go read the access(2) / faccessat(2) code in Linux and
>> then come back to the discussion.  It does in fact take into account all
>> of those things presently (and notes in a comment that SuS v2 requires
>> that it report a read-only fs).

I stand humbly corrected. My years of experience have gotten
in the way of reality yet again.

>>
> Reality check.
>
> The biggest reason for this is Nautilus and other GUI tools that open
> a directory and look at all of the files in the directory checking
> their access.  So running as staff_t and using nautilus on the /etc
> directory or /bin/directory generates hundreds of AVC indicating that
> staff_t tried to read/write/execute every program it is not allowed to
> execute.
>
> Totally useless and gives the SELinux SUCKS crowd more ammunition.

Not to mention that a call to access() does not open the file. It
reports on the state of attributes of the file relative to the
attributes of a process. No access to the data is made available
via access() as is the case with open().

> If the MLS people want to treat ACCESS==OPEN then we are going to have
> a big boolean/tunable flag for their paranoia.  For everyone else. 
> Lets try to figure out when an application is actually doing something
> evil.

Treating access() the same as open() is wrong. Maybe that's what you
want in the SELinux policy, but it sure isn't consistent with the way
the file system works. Attribute accesses are different from data
accesses.

>
> Currently pam libraries and kerberos libraries run access checks that
> cause us to DONTAUDIT reads of /etc/shadow and WRITES of /etc/krb5.conf
> To pretty critical Security files.  So any app that uses kerberos
> (getpw) call and every app that uses PAM Authentication can try to
> read /etc/shadow and write /etc/krb5.conf without us knowing.
>
>
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
