Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Reino Wallin <reino@oribium.com>,
        "Westerman, Mark" <Mark.Westerman@csoconline.com>
Subject: Re: SELinux RPM Version
Date: Wed, 24 Apr 2002 14:21:03 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com> <1019579967.4289.11.camel@matilda.oribium.com>
In-Reply-To: <1019579967.4289.11.camel@matilda.oribium.com>
MIME-Version: 1.0
Message-Id: <20020424122103.957B029B7@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Apr 2002 18:39, Reino Wallin wrote:
> fre 2002-04-19 klockan 22.26 skrev Westerman, Mark:
> > I expect to release a beta version to sourceforge
> > of an rpm package of SELinux next week.
> >
> > Current Configuration.
> >
> > /etc/selinux/policy	The main policy directory
> > If the directory does not exist then the rpm
> > packages will create it and install example policy files.
> >
> > /etc/selinux/setfiles	Same for the policy directory
> >
> > The example policy is installed
> > /usr/share/doc/selinux/examples/policy
>
> According to the recent discussions, isn't
> /usr/share/selinux/policy/default
> the correct install path for the example policy?

It's what Howard has suggested and what I am now using for my Debian packages.

> I am considering to install upcoming releases of the firewall policy in
> /usr/share/selinux/policy/firewall

Great!

Now what I am thinking of doing is having a selinux-pol-firewall package to 
contain the files for your policy (and hopefully someone else will take over 
packaging of it as I am busy enough with my own policy).  Now I am 
considering also splitting out the main policy into a selinux-pol-default 
package so that the user can install the sample policy that matches their 
needs.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
