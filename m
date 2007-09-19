Date: Wed, 19 Sep 2007 15:52:13 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: vyekkirala@TrustedCS.com, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [RFC] [PATCH 4/4] SELinux changes
In-Reply-To: <200709191740.04406.paul.moore@hp.com>
Message-ID: <Xine.LNX.4.64.0709191551050.27547@us.intercode.com.au>
References: <009801c7fb03$2c298260$cc0a010a@tcssec.com> <200709191740.04406.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 19 Sep 2007, Paul Moore wrote:

> Just for clarification James, what is the motivation for making the permission 
> checks conditional?  Performance?  Compatibility?

Performance -- per packet checks which are not doing anything for the vast 
majority of users are undesirable.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
