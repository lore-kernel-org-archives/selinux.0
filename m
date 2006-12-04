MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC] Ability to allow unknown class and permissions
Date: Mon, 4 Dec 2006 15:28:34 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C82D7@exchange.columbia.tresys.com>
In-Reply-To: <45748451.1080005@mentalrootkit.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Karl MacMillan" <kmacmillan@mentalrootkit.com>
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>,
        "Eric Paris" <eparis@parisplace.org>, <selinux@tycho.nsa.gov>,
        "James Morris" <jmorris@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> 
> Joshua Brindle wrote:
> >> From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com]
> 
> <snip>
> 
> >>> It doesn't give the interface I don't think, but it does let us 
> >>> redefine user object classes without worrying about the
> >> kernel rejecting it.
> >> Not certain I understand this comment either.
> >>
> > 
> > Perhaps I misunderstood your points, I didn't see how they 
> applied to 
> > this exactly either. How is adding an option to the policy 
> config to 
> > ignore unknown permissions resulting in an interface to help with 
> > dynamic object classes?
> 
> My understanding of the current suggestion is:
> 
> 1) A policy flag indicating that unknown object classes and 
> permissions should be ignored.
> 2) load_policy / libsemanage changed to optionally generate 
> avtab entries for unknown object classes or permissions based on 1.
> 
> In order to accomplish 2, load_policy / libsemanage will have 
> to be able to compare the object classes and permissions that 
> the kernel currently knows about to the ones referenced in 
> the policy. Hence a kernel interface exporting information 
> about the object classes and permissions of which the kernel is aware.
> 

Why do you need #2 if you have #1? Or Why would you need #1 if you have
#2? I thought the config flag was for the kernel..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
