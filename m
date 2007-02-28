From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Joshua Brindle" <jbrindle@tresys.com>
Subject: Re: [RFC] Dropping compat support for /etc/security policy file paths
Date: Thu, 1 Mar 2007 08:44:24 +1100
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        "Steve G" <linux_4ever@yahoo.com>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Darrel Goeddel" <dgoeddel@TrustedCS.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Manoj Srivastava" <manoj.srivastava@stdc.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
References: <6FE441CD9F0C0C479F2D88F959B015888BA98E@exchange.columbia.tresys.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015888BA98E@exchange.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703010844.29059.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 01 March 2007 00:11, "Joshua Brindle" <jbrindle@tresys.com> wrote:
> > Are any active distributions still using the old
> > /etc/security/ location and layout for SELinux policy files?
> > If not, we could drop the compat file path support from
> > libselinux on the trunk.
>
> Gentoo has switched to refpolicy with standard paths since this is
> required for modular policy and semanage. I'm fine with its removal.

Same with Debian, I agree.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
