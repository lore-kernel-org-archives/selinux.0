From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>
Subject: Re: Security Officer and System Administrator Separation of Duties
Date: Sat, 4 Oct 2003 17:29:44 +1000
Cc: "Fleischman, Eric" <eric.w.fleischman@boeing.com>, SELinux@tycho.nsa.gov
References: <5B58696DB20B9140AD20E0685C573A6402992E48@xch-nw-09.nw.nos.boeing.com> <200310032132.33691.russell@coker.com.au> <20031003165350.C30369@lemuria.org>
In-Reply-To: <20031003165350.C30369@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310041729.44762.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 4 Oct 2003 00:53, Tom wrote:
> On Fri, Oct 03, 2003 at 09:32:33PM +1000, Russell Coker wrote:
> > I think that perhaps you misunderstood my message.  My point is that
> > anyone who can write to programs such as fsck and run them in their usual
> > context can trivially bypass any other security restrictions.
>
> I get you.
>
> Yes, it appears that a good configuration will need a third role for
> software updates and machine-level configurations.

If that is the case then we need to fix the policy to allow multiple 
admin_domain() entries.

Currently no-one has written any policy that has more than one admin_domain, 
so the chances of that working are quite small.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
