Date: Wed, 15 Oct 2003 18:52:23 -0700
From: Michael Reilly <michaelr@cisco.com>
To: russell@coker.com.au
Cc: <SELinux@tycho.nsa.gov>
Subject: Re: Anyone run mozilla in enforce mode?
Message-Id: <20031015185223.3f8d19b6.michaelr@cisco.com>
In-Reply-To: <200310151016.43827.russell@coker.com.au>
References: <20031014121148.4155015d.michaelr@cisco.com>
	<200310151016.43827.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I played with things a bit and mozilla now works.  The one thing I recall
doing is relabeling the javaplugin shared library.  I installed mine in
/usr/local/2re1.4.1.gcc3 and it was not labeled as a shlib_t.

Why no avc denied I do not know (I verified here were no dontaudit lines in
policy.conf before compiling and load it).

I made a couple of unrelated changes.  I am reviewing my notes to see if
something could have fixed mozilla.

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
