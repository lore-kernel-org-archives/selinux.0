Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4DFD4gA003402
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 11:13:05 -0400 (EDT)
Received: from web31605.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j4DFA17F021724
	for <selinux@tycho.nsa.gov>; Fri, 13 May 2005 15:10:01 GMT
Message-ID: <20050513151013.18860.qmail@web31605.mail.mud.yahoo.com>
Date: Fri, 13 May 2005 08:10:13 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Busted by constraints.
To: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2005-05-12 at 13:37 -0700, Casey Schaufler
> wrote:

> Everything we need to reproduce the denial is
> included in the audit
> message (i.e. the relevant security contexts and
> object information)
> except for the policy itself.

Yup.

> So all you need is
> the audit log and the
> policy that was in effect at the time, and you can
> reproduce the
> computation.

So where is the policy-in-effect stored?
Certainly you're not going to suggest using
the policy source file that happens to be there
at the time of analysis. That policy file
(actually, that set of policy files soon)
may bear little resemblence to the policy
that was in force at the time the event
occured. Even if you're talking about the
policy file at the time of collection
there is real risk that the content of the
policy file does not match what the kernel
is enforcing.

> I'll make a simple patch to libsepol
> and a trivial utility
> that does this.

Enjoy. It's pretty pointless.


Casey Schaufler
casey@schaufler-ca.com


		
Discover Yahoo! 
Stay in touch with email, IM, photo sharing and more. Check it out! 
http://discover.yahoo.com/stayintouch.html

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
