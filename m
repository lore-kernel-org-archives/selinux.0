Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 17:15:01 +0200
Cc: Tom <tom@lemuria.org>, <SELinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0204121030040.21729-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0204121030040.21729-100000@raven>
MIME-Version: 1.0
Message-Id: <20020412151501.4B3B923B16@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 16:40, Stephen Smalley wrote:
> On Fri, 12 Apr 2002, Russell Coker wrote:
> > Having SE Linux code in /etc/magic for 0x6, 0x7, or 0x8, etc as the first
> > long of the file is not viable, eventually we'll hit a conflict.
> >
> > This is why I have intentionally not submitted my /etc/magic changes to
> > the maintainer of the "file" package.
>
> Yes, you originally asked for a magic number back in January.  Sorry.  How
> about the same magic number we use to distinguish the SELinux module's
> system calls and security structures, 0xf97cff8c?  This number follows a
> convention suggested by David Wheeler for security modules - see
> http://marc.theaimsgroup.com/?l=linux-security-module&m=99842987214848&w=2.

Sure, that sounds fine.

I suggest having that magic number followed by the string "SE Linux" (for 
people with out of date /etc/magic who are forced to use strings(1)), then 
the usual stuff.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
