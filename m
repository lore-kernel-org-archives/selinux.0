Date: Thu, 31 Jul 2003 04:45:21 +0200
From: Tom <tom@lemuria.org>
To: Bill Laut <wlsel@verizon.net>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: X-Windows and Client-side Buffer Overruns (was Re: Updated Release)
Message-ID: <20030731044521.H13872@lemuria.org>
References: <1057952464.5561.322.camel@moss-sooners.epoch.ncsc.mil> <200307301803.29302.wlsel@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200307301803.29302.wlsel@verizon.net>; from wlsel@verizon.net on Wed, Jul 30, 2003 at 06:03:29PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jul 30, 2003 at 06:03:29PM -0400, Bill Laut wrote:
> This leads me to the question:  While considerable work has been done to 
> protect the system from server app compromises, what about protecting the 
> system from server-based buffer overrun attacks on clients running under 
> SELinux?

Some work has been done in this area. Russell wrote a policy for an irc
client as an example. It should be easy to write one for a mailer along
those lines.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
