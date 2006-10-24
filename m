Subject: RE: Denials from newest kernel
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: Darrel Goeddel <DGoeddel@tcs-sec.com>,
        "'Karl MacMillan'" <kmacmillan@mentalrootkit.com>,
        "'Joshua Brindle'" <jbrindle@tresys.com>, selinux@tycho.nsa.gov,
        sds@tycho.nsa.gov
In-Reply-To: <001501c6f6ca$a0bb3d50$cc0a010a@tcssec.com>
References: <001501c6f6ca$a0bb3d50$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 20:44:49 -0400
Message-Id: <1161650689.32645.5.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-23 at 12:42 -0500, Venkat Yekkirala wrote:
> Just FYI- I spoke to Chris Friday morning and after we discussed that
> the incoming traffic uses a differently labeled SA than the outgoing
> traffic,
> getpeercon semantics, etc., he is agreeable to eliminating the sendto check
> for the outbound traffic.

Just for clarification, I think we need a sendto check; however, I
understand why the sendto check is not useful in the current
implementation.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
