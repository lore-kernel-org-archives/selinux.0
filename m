Subject: Re: setsebool
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve Grubb <sgrubb@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1152793604.10075.197.camel@moss-spartans.epoch.ncsc.mil>
References: <44AD708E.10205@us.ibm.com> <44B5623C.8060600@us.ibm.com>
	 <44B6265C.3010005@redhat.com>  <200607130734.35344.sgrubb@redhat.com>
	 <1152792392.2561.4.camel@localhost.localdomain>
	 <1152793604.10075.197.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 08:41:56 -0400
Message-Id: <1152794516.2561.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-07-13 at 08:26 -0400, Stephen Smalley wrote:
> On Thu, 2006-07-13 at 08:06 -0400, Karl MacMillan wrote:
> > On Thu, 2006-07-13 at 07:34 -0400, Steve Grubb wrote:
> > > On Thursday 13 July 2006 06:54, Daniel J Walsh wrote:
> > > > Is this a problem in the Kernel or libraries?  Or just the way it is?
> > > 
> > > I think the granted statement comes from policy. I was thinking that audit of 
> > > granting when changing booleans would be dropped from policy when the 2.6.17 
> > > kernel was out.
> > > 
> > 
> > The kernel also generates a message with all of the boolean states in
> > addition to the auditallow. When wrote that my thought was that there
> > would not be that many booleans and printing them all would make it
> > easier to see the state of the system in the logs. Obviously I was wrong
> > about the number of booleans.
> > 
> > The message is printed from security_set_bools in services.c. Should
> > this just go in favor of an audit message or be changed to just print
> > the state of the changed booleans?
> 
> Steve Grubb already changed that printk to an audit_log call that only
> displays changed values.  In 2.6.17.
> 

Oops - that will teach me to look at old kernel source. Looking through
the archives I didn't see that patch posted to this list (but maybe I
missed it). Where was this discussed?

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
