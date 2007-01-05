MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [redhat-lspp] Re: [PATCH 2/3] Re: MLS enforcing PTYs, sshd,	and newrole
Date: Thu, 4 Jan 2007 22:35:45 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015886CA28F@exchange.columbia.tresys.com>
In-Reply-To: <20070105033311.GA24315@w-m-p.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Klaus Weidner" <klaus@atsec.com>
Cc: "James Antill" <jantill@redhat.com>,
        "Linda Knippers" <linda.knippers@hp.com>,
        "redhat-lspp" <redhat-lspp@redhat.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "SE Linux" <selinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Klaus Weidner [mailto:klaus@atsec.com] 
> 
> On Thu, Jan 04, 2007 at 10:05:57PM -0500, Joshua Brindle wrote:
> > Hardcoding types into code makes it inflexible to policy 
> changes, this 
> > is a bad idea IMO, the tty whitelist, however, is probably 
> the way to 
> > go. I don't know if we should use the existing 
> /etc/securetty or  add 
> > our own file though.
> 
> I'm not sure if the existing /etc/securetty is the right one, 
> since people may make serial terminals available to users but 
> would not want direct root login on those. Well, maybe not 
> terribly likely these days.
> 
> Instead of hardcoded types, how about a configurable type or 
> a /etc/securettytypes file that contains the types instead of 
> tty names?

Sure, the securettycontexts might be the way to go. I'm dubious about
just making this happen for level changes though, you shouldn't be able
to bypass any part of the security policy using newrole.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
