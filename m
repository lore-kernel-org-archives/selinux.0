Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joe Nall <joe@nall.com>
Cc: Paul Moore <paul.moore@hp.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com>
	 <200708281151.07120.paul.moore@hp.com>
	 <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com>
	 <200708281451.53650.paul.moore@hp.com>
	 <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com>
Content-Type: text/plain
Date: Tue, 28 Aug 2007 15:08:45 -0400
Message-Id: <1188328125.26572.133.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-28 at 14:10 -0500, Joe Nall wrote:
> On Aug 28, 2007, at 1:51 PM, Paul Moore wrote:
> 
> > On Tuesday, August 28 2007 12:18:05 pm Joe Nall wrote:
> >>
> >> Will interface aliases (eth0:1) be able to take on different  
> >> labels from
> >> their base interface?
> >
> > Not sure, it all depends on if an interface alias ends up creating  
> > a separate
> > net_device struct in the kernel, I don't have the answer to this  
> > off the top
> > of my head.  What is your preference?
> 
> That interface aliases be independently labeled.

Per Spencer Shimko's recent posting, setting a netifcon on an interface
alias (ala eth0:1) has no effect - the kernel just uses the real
interface label at all times.  Which is arguably the right thing to do -
an object's label shouldn't change just because it is accessed by
another name (pathnames vs. inodes comes to mind here).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
