Subject: Re: 2.6.0-test3
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <200308231116.19099.russell@coker.com.au>
References: <20030822201709.GE12548@vnl.com>
	 <200308231116.19099.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1061747236.7660.206.camel@columbia>
Mime-Version: 1.0
Date: Sun, 24 Aug 2003 13:47:16 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2003-08-22 at 21:16, Russell Coker wrote:
> On Sat, 23 Aug 2003 06:17, Dale Amon wrote:
> > > Why can't you install the new selinux package?
> >
> > Ah, I see, it's not a kernel package. This is the first time I've
> > gone from packages instead of direct from the NSA tgz. But even so,
> > there is a conflict. I presume I can just --force-conflicts.
> 
> In another message you mention that you are using 2.6.
> 
> I will have to make my selinux-policy-default package have an alternate 
> dependency on something from Colin.
> 
> Colin, which of your packages should it depend on, and what version?

I think the issue here is that my selinux-policy-default packages have a
lower version than your selinux-policy-default packages.  I have only
been testing my 2.6 packages with my selinux-policy-default package.

Russell, this could probably be solved if you could merge the
Debianization changes in my selinux-policy-default package.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
