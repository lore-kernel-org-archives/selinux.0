From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>, <SELinux@tycho.nsa.gov>
Subject: Re: Anyone run mozilla in enforce mode?
Date: Wed, 15 Oct 2003 10:16:43 +1000
References: <20031014121148.4155015d.michaelr@cisco.com>
In-Reply-To: <20031014121148.4155015d.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310151016.43827.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Oct 2003 05:11, Michael Reilly wrote:
> Now I have another problem - mozilla fails to start.  Nothing is logged
> even with the dontaudit's removed from the policy.  Mozilla does complain
> that it couldn't find one of its libraries (I do not recall which one and I
> left my notes at home).

It's been working well for me.

Please do the same things as you did for X, remove the dontaudits and see what 
gets logged.  Then please send me an email with the exact changes you made to 
the file_contexts (and anything else that needs changing).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
