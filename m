Date: Fri, 05 Oct 2001 09:36:51 -0700
From: Paul Krumviede <pwk@acm.org>
To: Stephen Smalley <sds@tislabs.com>,
        "Justin R. Smith" <jsmith@mcs.drexel.edu>
cc: SELinux@tycho.nsa.gov
Subject: Re: Some questions
Message-ID: <43000731.1002274611@localhost>
In-Reply-To: <Pine.GSO.4.33.0110050943410.29582-100000@raven>
References: <Pine.GSO.4.33.0110050943410.29582-100000@raven>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

trimmed to ssh only...

--On Friday, 05 October, 2001 09:57 -0400 Stephen Smalley <sds@tislabs.com> 
wrote:

>
> On 5 Oct 2001, Justin R. Smith wrote:
>
>> 3. SSH no longer recognizes my authorized keys --- I must always enter a
>> password to use it. I've regenerated the keys several times (putting the
>> appropriate public keys in 'authorized_keys') without success. I know
>> the sshd on my system was replaced by another. Does it function
>> differently?
>
> The utils Makefile only installs the modified sshd, not the rest of the
> package, since we only modified sshd.  So if you were using a different
> version of OpenSSH, you might have a compatibility problem.  The openssh
> package provided with SELinux is the default one provided with RedHat 7.1
> with the SELinux modifications.  If you are using a newer version of
> OpenSSH, then I would suggest porting the SELinux patch forward to the
> newer version (and please feed the resulting patch back to us).  If you
> are using an older version of OpenSSH, then I would suggest doing a 'make
> install' in the openssh-2.5.2p2-5 directory and then doing a 'make
> relabel' in the utils directory.

i've had to force use of the version 2 protocol to make this work, either
via the command line option to ssh or by changing the sshd_config file
to only use protocol version 2. doing what is suggested above was not
sufficient for me - i was trying to make this work separately some time
ago (and i think i've had to do this on a base redhat 7.0 system, if i
recall the circumstances correctly). i don't know if it matters or not,
but this was when i had a DSA key present; i haven't tried it with
only RSA keys.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
