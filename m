Date: Mon, 9 Dec 2002 19:19:20 +0100
From: Tom <tom@lemuria.org>
To: Richard Mayo <rmayo@caci.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Basic Question
Message-ID: <20021209191920.C12940@lemuria.org>
References: <OF86B3B9F3.740529F3-ON85256C8A.0058C879@caci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF86B3B9F3.740529F3-ON85256C8A.0058C879@caci.com>; from rmayo@caci.com on Mon, Dec 09, 2002 at 11:14:40AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 09, 2002 at 11:14:40AM -0500, Richard Mayo wrote:
> When SELinux is running in permissive mode and an action is attempted that
> violates the security settings, the system logs this event.
> Obviously, if SELinux were running in enforcing mode this action would have
> been denied, but would an entry STILL have been made in the log file?

Yes. As a matter of fact, this is how I refine my policies - write a
basic set, very strict, then see if it works and if not which log
entries it generates. Often, it throws errors, but works nevertheless,
that's when I put in dontaudit rules. This is why I do this in
enforcing mode, even though it's tedious - because only this way I can
see if it really needs the permissions it requests.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
