Message-ID: <4A03C033.6030307@tycho.nsa.gov>
Date: Fri, 08 May 2009 01:16:35 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Casey Schaufler <casey@schaufler-ca.com>
CC: "Serge E. Hallyn" <serue@us.ibm.com>, Eric Paris <eparis@redhat.com>,
        selinux@tycho.nsa.gov, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, viro@ZenIV.linux.org.uk,
        sds@tycho.nsa.gov
Subject: Re: SELinux and access(2), we want to know.
References: <1241723924.2791.107.camel@localhost.localdomain> <20090507195729.GA21104@us.ibm.com> <4A03AC41.1040505@schaufler-ca.com>
In-Reply-To: <4A03AC41.1040505@schaufler-ca.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Casey Schaufler wrote:
> Serge E. Hallyn wrote:
>   
>> Quoting Eric Paris (eparis@redhat.com):
>>   
>>     
>>> 3) I've also heard it hinted that we could do this with audit by just
>>> having audit drop the denials that include the access(2) syscall and the
>>> scontext and tcontext for the slew of things the SELinux policy writers
>>> know we are not interested in.  And while it seems good, now we have
>>>     
>>>       
>> What is the difference whether an attacker does access(2) to check for
>> /etc/shadow rights, or does a failed open()?
>>   
>>     
>
> I have been studiously ignoring the discussions on the SELinux list because
> in the end it really doesn't matter, as Serge (appears to) point out here.
> The access() system call was a major thorn in the side of the POSIX security
> working group because its behavior is not really very rational. By design
> it does not take into account read-only file systems, ACLs, MAC labels,
> TOMOYO policy, or anything other than the mode bits. A successful return
> from access() gives you no assurance whatever that if you actually try the
> operation it will succeed. My recollection is that every version of
> "trusted unix" written treats the system call the same way it would a
> call to lstat(), because that's really all it is doing.
>   

Serge, and the status quo, says access() == open(), not access() == lstat().

Eric's proposed change would be necessary to support access() ==
lstat(), even as an option.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
