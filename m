Message-ID: <46D837BA.9000707@argus-systems.com>
Date: Fri, 31 Aug 2007 10:46:02 -0500
From: "Mikel L. Matthews" <mikel@argus-systems.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: David Howells <dhowells@redhat.com>, viro@ftp.linux.org.uk,
        selinux@tycho.nsa.gov,
        LSM List <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: SELinux security and passed file descriptors
References: <1188487195.26572.351.camel@moss-spartans.epoch.ncsc.mil>	 <10698.1188486734@redhat.com>  <8927.1188570735@redhat.com> <1188572504.26572.459.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1188572504.26572.459.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-08-31 at 15:32 +0100, David Howells wrote:
>> Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>
>>> That's how mandatory access control is supposed to work; otherwise, a
>>> flaw in A can leak the descriptor to B at will in violation of security
>>> policy.
>> Yeah, but by making it impossible to have the flaw, you've also made it
>> impossible for A to validly pass to B a file descriptor B wouldn't otherwise
>> be able to access directly, but should be able to access on behalf of A.
> 
> Let me say it again:  that's how mandatory access control is supposed to
> work.  A program (or user) isn't supposed to be able to delegate access
> under a mandatory policy.

How about looking at it this way, I am work for company A and therefore 
I can see all of their engineering documents. You work for company B and 
are not supposed to see any of our engineering documents. Company A's 
policy states that I can't disclose company private information to any 
one who is not cleared for it. So by giving you access to this 
information (either by telling you (e.g., passing a file descriptor) or 
handing you a document) I am in violation of company policy. MAC is 
there to enforce the company policy so I won't give you the information 
you are not supposed to have.

> 
>> To put it another way, how does A now legitimately pass on to B the grant of
>> rights A had on that specific file descriptor?
> 
> That would be discretionary, and therefore vulnerable to flawed and
> malicious code.  That's the point.

Or B is a privileged (trusted) process that can raise/change the correct 
privilege/capability/context to access the information/descriptor.


-- 
Thanks,
Mike
----
Mikel L. Matthews
Chief Technology Officer
Innovative Security Systems, Inc. (dba Argus Systems Group)
1809 Woodfield Dr.
Savoy IL 61874
+1-217-355-6308
www.argus-systems.com

"Any intelligent fool can make things bigger, more complex, and more
violent.  It takes a touch of genius - and a lot of courage - to move
in the opposite direction."
				Albert Einstein

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
