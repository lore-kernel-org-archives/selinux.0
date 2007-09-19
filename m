From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
Date: Wed, 19 Sep 2007 19:20:09 -0400
Cc: vyekkirala@TrustedCS.com, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
References: <009801c7fb03$2c298260$cc0a010a@tcssec.com> <200709191740.04406.paul.moore@hp.com> <Xine.LNX.4.64.0709191551050.27547@us.intercode.com.au>
In-Reply-To: <Xine.LNX.4.64.0709191551050.27547@us.intercode.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709191920.09502.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, September 19 2007 6:52:13 pm James Morris wrote:
> On Wed, 19 Sep 2007, Paul Moore wrote:
> > Just for clarification James, what is the motivation for making the
> > permission checks conditional?  Performance?  Compatibility?
>
> Performance -- per packet checks which are not doing anything for the vast
> majority of users are undesirable.

All right, we'll throw that requirement on the pile too ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
