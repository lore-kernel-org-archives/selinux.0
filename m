Date: Tue, 14 Oct 2003 17:27:45 -0700
From: Michael Reilly <michaelr@cisco.com>
To: russell@coker.com.au
Cc: <SELinux@tycho.nsa.gov>
Subject: Re: Anyone run mozilla in enforce mode?
Message-Id: <20031014172745.20156864.michaelr@cisco.com>
In-Reply-To: <200310151016.43827.russell@coker.com.au>
References: <20031014121148.4155015d.michaelr@cisco.com>
	<200310151016.43827.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As I mentioned, nothing is logged even with the dontaudit lines removed.

The only error message at all is one from mozilla itself saying it can't
find to a library.  I'll find out which one tonight.

michael
On Wed, 15 Oct 2003 10:16:43 +1000
Russell Coker <russell@coker.com.au> wrote:

> On Wed, 15 Oct 2003 05:11, Michael Reilly wrote:
> > Now I have another problem - mozilla fails to start.  Nothing is logged
> > even with the dontaudit's removed from the policy.  Mozilla does
> > complain that it couldn't find one of its libraries (I do not recall
> > which one and I left my notes at home).
> 
> It's been working well for me.
> 
> Please do the same things as you did for X, remove the dontaudits and see
> what gets logged.  Then please send me an email with the exact changes you
> made to the file_contexts (and anything else that needs changing).
> 
> -- 
> http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
> http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
> http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
> http://www.coker.com.au/~russell/  My home page


-- 
---- ---- ----
Michael Reilly    michaelr@cisco.com
    Cisco Systems, Santa Cruz, CA


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
