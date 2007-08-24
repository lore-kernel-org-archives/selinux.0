From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Fri, 24 Aug 2007 16:24:06 -0400
Cc: casey@schaufler-ca.com, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
References: <454500.99769.qm@web36612.mail.mud.yahoo.com> <200708241549.05839.paul.moore@hp.com> <Xine.LNX.4.64.0708241315280.26160@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0708241315280.26160@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708241624.07074.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday, August 24 2007 4:17:00 pm James Morris wrote:
> On Fri, 24 Aug 2007, Paul Moore wrote:
> > Feel free to suggest something better, I don't think anyone was ever
> > really in love with the term "secmark label".  I believe at one point
> > Stephen suggested "iptables label", does that sound any better?
>
> I like packet label, because it's a label based on the attributes of the
> packet.

[Sorry, I forgot about this suggestion when replying]

I was always a little nervous that just the term "packet label" would get 
confusing ... are we talking about the "peer" packet label or the "packet" 
packet label ... but I see your point.

What do other people think?  I know you've got an opinion Casey ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
