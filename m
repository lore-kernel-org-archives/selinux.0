Date: Fri, 6 Jun 2003 21:17:40 +0200
From: Tom <tom@lemuria.org>
To: Rafal Wojtczuk <rafal@intruvert.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux (fwd)
Message-ID: <20030606211739.C15410@lemuria.org>
References: <20030606170611.GA701@emperor.intruvert.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030606170611.GA701@emperor.intruvert.com>; from rafal@intruvert.com on Fri, Jun 06, 2003 at 10:06:11AM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 06, 2003 at 10:06:11AM -0700, Rafal Wojtczuk wrote:
> Russel> Over the last few days on the #selinux list there has been 
> Russel> discussion of these things.  The easiest implementation of such an 
> Russel> attack (which was successfully used in practise) was to create a 
> Russel> shell function named newrole() which gets
> You mean, alter ~someuser/.bashrc ? At least in my setup (default policy), 
> root:user_r:user_t has no access to ~root. 

not to ~root, because it's labeled as sysadm_home_(dir_)t, but to, say,
~russel or ~tom.

Look back to about monday, where I posted something about this, and the
follow ups where it was recreated on the Gentoo play system.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
