Date: Fri, 12 Apr 2002 19:40:17 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412194017.A7417@lemuria.org>
References: <20020412185044.A6824@lemuria.org> <Pine.GSO.4.33.0204121303000.21729-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204121303000.21729-100000@raven>; from sds@tislabs.com on Fri, Apr 12, 2002 at 01:04:36PM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 01:04:36PM -0400, Stephen Smalley wrote:
> Seems to work here for me.  I added a user who has no entry in
> policy/users or /etc/security/default_contexts, then logged in
> as that user using ssh and ended up with my context as
> user_u:user_r:user_t.  Again, this is with the upstream distribution, not
> the Debian selinux package.

ok, I'll check again. I didn't notice any differences between the
upstream and the debian version of ssh when I checked the diffs earlier
today.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
