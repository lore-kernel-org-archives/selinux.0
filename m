Date: Thu, 24 Mar 2005 22:02:57 +0100
From: Tom <tom@lemuria.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Do you trust X server?
Message-ID: <20050324220257.O13605@lemuria.org>
References: <20050324204100.87156.qmail@web31613.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050324204100.87156.qmail@web31613.mail.mud.yahoo.com>; from casey@schaufler-ca.com on Thu, Mar 24, 2005 at 12:41:00PM -0800
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 24, 2005 at 12:41:00PM -0800, Casey Schaufler wrote:
> Login and ssh are policy enforcing programs. As I
> noted above, the X server is not.

No, but it may nevertheless be "like login or ssh" in the respect that
it needs to be modified.

Please refer to the archives for the in-depths discussion of the
necessity and its reasons.


> If this is true it is a problem with the SELinux
> environment, not the X server. The SGI Irix B1
> evaluation of 1995 used an unmodified X server
> that did no policy enforcement. The environment
> was not endangered by the presence of the X server.

I am not familiar with the details of the evaluation, so I can not
argue about it.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
