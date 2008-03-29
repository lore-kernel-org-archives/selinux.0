From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Debian SE Linux status
Date: Sat, 29 Mar 2008 11:59:56 +1100
Cc: jwcart2@epoch.ncsc.mil, Joshua Brindle <method@manicmethod.com>,
        SE-Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Sellers <csellers@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>
References: <200803281106.47699.russell@coker.com.au> <1206711402.29088.21.camel@moss-lions.epoch.ncsc.mil> <1206712290.3302.455.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1206712290.3302.455.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200803291200.00643.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 29 March 2008 00:51, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Isn't that an argument for keeping non-MLS support? ;)
>
> I don't believe that it actually does significantly increase policy
> build time (or if it does, that would be a bug).  Possibly Russell just
> means that building both MLS and non-MLS takes longer, or that the mls
> modules.conf includes more modules, or something along those lines?

Yes.  Currently I have it building three policy packages, strict, targeted, 
and mls.  This takes 50% longer than just strict and targeted.  But if we go 
to a single policy for strict/targeted and a policy for mls then we would 
have the same build times as before.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
