Subject: Re: SELinux RPM Version
From: Reino Wallin <reino@oribium.com>
To: Russell Coker <russell@coker.com.au>
Cc: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <20020425135110.E75773943@lyta.coker.com.au>
References: 
	<72222DC86846D411ABD300A0C9EB08A101524363@csoc-mail-box.csoconline.com>
	<20020425135110.E75773943@lyta.coker.com.au>
Content-Type: text/plain
Date: 25 Apr 2002 16:38:06 +0200
Message-Id: <1019745486.27628.65.camel@matilda.oribium.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

tor 2002-04-25 klockan 15.51 skrev Russell Coker:
> On Thu, 25 Apr 2002 14:48, Westerman, Mark wrote:
> > In the Filesystem Hierarchy Standard (FHS) document for the
> > Linux Standard Base.
> >
> > "Any program or package which contains or requires data the doesn't
> > need to modified should store that data in /usr/share. "
> >
> > the doc subdirectory if for "Miscellaneous documentation"
> 
> IMHO that means that /usr/share/selinux is better than /usr/share/doc/selinux 
> for the sample policy files.
> 
> Sample policy files are not documentation, they don't even have much in the 
> way of comments!
> 
I would agree with Russell here, and that is what Howard Holm suggested
as well.

> > The /etc/selinux/policy directory is created
> > and can be modified.
> 
> OK.  I'll change my package back to using /etc/selinux as the location for 
> the files.
> 
I like Marks concept here, so it seems we all agree on this.

Reino


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
