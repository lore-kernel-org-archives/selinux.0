Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Howard Holm'" <hdholm@epoch.ncsc.mil>, SeLinux@tycho.nsa.gov
Subject: Re: Policy
Date: Wed, 3 Apr 2002 23:06:19 +0200
Cc: sds@tislabs.com, pal@tycho.nsa.gov
References: <72222DC86846D411ABD300A0C9EB08A10152432C@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A10152432C@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020403210620.2CCD23CE93@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 3 Apr 2002 22:43, Westerman, Mark wrote:
> On Wednesday, April 03, 2002 2:12 PM, Russell wrote:
> > How about the following for distributions other than Slackware:
> > /usr/bin
> > /usr/sbin
> > /usr/include/selinux
> > /usr/lib
> > /usr/share/man
> > /etc/policy
>
> The reason I was putting every thing under /usr/local/selinux
> was to get away from any distributions quirks. I really

The FHS is there to get away from quirks of distributions.  The locations I 
suggested comply with the FHS.

> have no argument about where to put the files, I would
> like a consciences. Also we have to get the folks at the NSA
> to agree.

Last time this issue was discussed here most people seemed to disagree with 
me (but the NSA people weren't saying much).

As with all Debian packages, my packages will comply with the FHS regardless 
of what happens in the upstream distribution.

> I want to start building packages for selinux, I just don't
> want to do a lot of rework when the location changes. I do think

It shouldn't be that difficult to change location.

> I do like Russell's Idea about two separate locations for the
> policy files.

Standard proceedure for Unix software distribution in my experience...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
