MIME-Version: 1.0
In-Reply-To: <200909300919.35275.paul.moore@hp.com>
References: <20090908055806.GA24297@myhost.felk.cvut.cz> <200909291654.07458.paul.moore@hp.com>
	<f73f7ab80909292051m7f591868lbd86e5e948cdcd8a@mail.gmail.com>
	<200909300919.35275.paul.moore@hp.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 30 Sep 2009 09:49:51 -0400
Message-ID: <f73f7ab80909300649n785436b6nb15dc62d13713b2@mail.gmail.com>
Subject: Re: MCS and default labels
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, russell@coker.com.au,
        Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>,
        selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 30, 2009 at 09:19, Paul Moore <paul.moore@hp.com> wrote:
> On Tuesday 29 September 2009 11:51:42 pm Kyle Moffett wrote:
>>  (C)  Processes which are *not* s4 may communicate over the network
>> only when protected by IPsec, and only if the IPsec connection is
>> specifically negotiated using certificates/keys based on the level of
>> the data being protected.
>
> I think the tricky part here is the "... certificates/keys based on the level
> of the data ..." statement.  Is is sufficient to have one certificate per
> host/node as long as you have one SA per label?

Unfortunately not.  Imagine that the device is some kind of network
appliance, router, etc.  You would not want to reconfigure your
storage server or router every time you add a new node.  Beyond that,
different data levels probably have different protection requirements.
 For instance, say you have a physical network that is safe to
transport "personal data" unprotected, but not  "trade secrets" (IE:
the network itself is s0:c1):

  * When you send data between "s0" processes across the network, you
would want to save CPU and enable better network debugging by just
using AH (the data doesn't need protection against exposure, just
against contamination).

  * When you send data between "trade secrets" (s0:c2) processes
across the network, that *does* need protection, and so you would use
ESP.

For a lot of government classified-data systems, there's a lot more
levels than that, and some levels require different key-lengths or
algorithms.  I'm afraid that for the purposes I am interested in, a
separate root-CA per MLS level is really the only practical
configuration.

Given that, I guess the question is, how hard would it be to modify
racoon and/or the kernel to give me the behavior I want?

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
