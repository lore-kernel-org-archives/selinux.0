From: Steve Grubb <sgrubb@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: I think this is equivalent to what we have =?utf-8?q?now=09and=09more=09efficient=2E?=
Date: Mon, 26 Feb 2007 10:11:35 -0500
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <45DDAA80.80603@redhat.com> <1172501905.19041.223.camel@moss-spartans.epoch.ncsc.mil> <1172502070.19041.226.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1172502070.19041.226.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702261011.35277.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 26 February 2007 10:01, Stephen Smalley wrote:
> > I had a patch for it back in early 2005, called it "loadpolicyvers".
> > But I was only using it for testing, and we didn't have a real user for
> > it at the time.  It would have to be re-based.
>
> Note btw that even if we add this node and add logic to libselinux to
> start using it as an alternative to the getcon() test, we'd still need
> to retain the getcon() test as a fallback for compatibility with older
> kernels.

True.

> So we aren't simplifying the libselinux logic. 

Not now, but we are setting things up to simplify the logic at some future 
point. But more importantly, we finally have a way to see what is really 
loaded. sestatus could be rewritten to use this new node if its available so 
that its more accurate about what's loaded.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
