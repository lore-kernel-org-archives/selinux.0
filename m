From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Michael Reilly <michaelr@cisco.com>
Subject: Re: Yet another question - newrole and xterm's
Date: Sat, 18 Oct 2003 14:48:58 +1000
Cc: SELinux@tycho.nsa.gov
References: <20031015191716.5478c74b.michaelr@cisco.com> <200310171339.33673.russell@coker.com.au> <20031017210210.0c4e7894.michaelr@cisco.com>
In-Reply-To: <20031017210210.0c4e7894.michaelr@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310181448.58230.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 18 Oct 2003 14:02, Michael Reilly wrote:
> Thank you Russell - once again your help was invaluable.
>
> su on my system requires pam_wheel.so so when newrole was installed newrole
> also required pam_wheel.  No problem on a normal terminal.
>
> Instead I commented out pam_wheel.so so any user may run newrole.  Sounds
> like the way to go anyway.

I agree.  SE Linux determines who gets to change role/domain and how they can 
do it.  pam_wheel is a clumsy attempt to do similar things and provides no 
benefit.

However a module similar to pam_wheel which checks the SE Linux context and 
does not permit changing UID unless the role is right could be a handy thing 
to make password guessing more difficult.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
