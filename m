From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: general security lib (was: 2.6.0-test3)
Date: Sat, 23 Aug 2003 15:06:01 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <1061468940.1665.16.camel@kusturica> <1061562771.28086.157.camel@moss-spartans.epoch.ncsc.mil> <3F465113.3010207@redhat.com>
In-Reply-To: <3F465113.3010207@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308231506.01495.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 23 Aug 2003 03:21, Daniel J Walsh wrote:
> Also how would you allow the user to select the context they will login
> as if there are more then one?  Unless we remove this capability and
> always force users to use newrole.

Firstly, this decision is not currently available in a regular ssh 
configuration or for cron.  So such a PAM module would easily allow the use 
of unmodified sshd and cron programs once support for the new PAM had been 
added.

As for login, I am under the impression that there is a possibility for a 
dialog between application and PAM module, so the PAM module could specify 
text to display and the application could return an answer to it.  But I 
haven't done any PAM coding yet so I'm not sure of this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
