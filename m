MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Ability to allow unknown class and permissions
Date: Mon, 4 Dec 2006 15:11:27 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C82D0@exchange.columbia.tresys.com>
In-Reply-To: <45747FCE.4080206@mentalrootkit.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: "Eric Paris" <eparis@parisplace.org>, <selinux@tycho.nsa.gov>,
        "James Morris" <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> > 
> > I'd prefer to avoid a selinuxfs tunable altogether, as it 
> means that 
> > we can't actually tell what setting was in effect for a 
> given (kernel,
> > policy) pair without other external data (e.g. audit record upon 
> > setting), and it means that we cannot prepad the avtab 
> access vectors 
> > at policy load time (avoiding any overhead in 
> security_compute_av at 
> > permission check time).
> > 
> 
> For this to work libsemanage / libsepol needs to know about 
> any new kernel object classes. Since the whole goal here is 
> to not force an upgrade of the selinux packages that means 
> that the kernel needs to export that info, correct?
> 

Refpolicy is going to begin generating 2 sets of headers soon, one for
the kernel (with only kernel classes) and one for libselinux with
everything. Additionally its planned for the security servers to be able
to export the info to OM's, but that info will come from the policy, not
the headers.

> This is something that we have wanted for a while anyway as 
> it is required to allow modules to declare object classes, 
> userspace object managers to avoid hard coded object class / 
> perm numbers, etc. I believe that Chad had posted some 
> thoughts about how to do this a while ago.
> 
> I think this is the correct solution and it has the side 
> benefit of resulting in an interface that we wanted anyway.
> 

It doesn't give the interface I don't think, but it does let us redefine
user object classes without worrying about the kernel rejecting it.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
