Date: Mon, 16 Dec 2002 21:46:15 +0100
From: Tom <tom@lemuria.org>
To: Richard Mayo <rmayo@caci.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Domain transition
Message-ID: <20021216214614.A32716@lemuria.org>
References: <OF0E5EECFE.7EB8F6E6-ON85256C91.006E1E8E@caci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF0E5EECFE.7EB8F6E6-ON85256C91.006E1E8E@caci.com>; from rmayo@caci.com on Mon, Dec 16, 2002 at 03:09:59PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 16, 2002 at 03:09:59PM -0500, Richard Mayo wrote:
> 1)    What is "domain transition"?  I've configured my system such that it
> doesn't happen, but I'm wondering if it's the best way to go.

It's not. Domain transitions are necessary. It's something like the
SELinux equivalent of setuid. For example, when init starts apache, you
definitely do want the initrc domain to change into the apache domain.


> 2)    Is there a text file on my system with the list of user roles or is
> that information stored some other way?

look into /etc/security. it has changed around a little recently, but
there should be something like default_* in there with the information
you are looking for.


> 3)    Can I configure the operating system NOT to ask for a user role on
> login?  I would much prefer to have user role determined BY the login.

I'm sure it's possibly to skip the check, e.g. if the user is only
allowed to be in a single domain anyway. But I believe you would need
to patch the login code for this.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
