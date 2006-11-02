Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'James Morris'" <jmorris@namei.org>
Cc: "'Paul Moore'" <paul.moore@hp.com>, <jbrindle@tresys.com>,
        <selinux@tycho.nsa.gov>, "Stephen Smalley" <sds@tycho.nsa.gov>,
        <gcwilson@us.ibm.com>
Subject: RE: SELinux Networking Enhancements
Date: Thu, 2 Nov 2006 11:31:50 -0600
Message-ID: <001701c6fea4$c807bdc0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.64.0611021219110.23758@d.namei>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I think what we'd really want in a case like this is to just 
> use secmark, 
> and create new compound types for labeling packets (which is 
> part of the 
> idea of the design).
> 
> So, eth1 is thought of as "internal", and you use iptables to label 
> packets with --dport 80 and -i eth1 as httpd_internal_t.

Yes, but where such compounding is not desired, one could simply
identify all httpd packets as of Type httpd_t and go from there.

This essentially could result in a more readable policy where you
worry strictly about packet Types with secmark and express whether
you expect those Types from a certain source using secfilter.

> 
> > > In fact, this appears to be entirely indepdent to xfrm labeling...
> > 
> > Correct. This is really labeling-mechanism-agnostic in that 
> it filters
> > all.
> 
> Then I'm not sure I understand why it's part of a discussion about 
> protected path labeling.

Only the nature of the protected paths proposed here is generic
enough that it could cover all sorts of labeling.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
