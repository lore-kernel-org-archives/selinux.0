Date: Fri, 12 Apr 2002 16:17:29 +0200
From: Tom <tom@lemuria.org>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>, SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412161729.B29624@lemuria.org>
References: <Pine.GSO.4.33.0204120840060.21729-100000@raven> <20020412135859.3D809281EF@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412135859.3D809281EF@lyta.coker.com.au>; from russell@coker.com.au on Fri, Apr 12, 2002 at 03:58:58PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It looks like I solved the problem, at least it now boots and appears
to run fine, except that I can't log in remotely, but ssh localhost
works. I'll inspect that later.

It appears the problem was mostly mine, possibly with a feature request
for better error handling/reporting.

My kernel was db version 7, the tools 8. The reason being that I did
update all packages, including the lsm kernel patch, but did not re-apply
it correctly. Or at least that's what I suspect. After cleaning the
kernel sources and starting from scratch, it worked fine.

So from what I have seen, it looks like all the Debian packages did
exactly what they should do, except that uninstalling the old flask
package did not clear out /etc/selinux, even though I uninstalled doing
purge (i.e. _ not - in dselect).


One thing that I noticed during this setup was that the patched login
and ssh tools do not appear to work if they run on a non-lsm kernel.
While this is probably the right thing to do security-wise, it also
means that keeping a non-SELinux kernel as "rescue system" on-disk
doesn't help a thing.
As said: Security-wise I understand this, but maybe there is a better
way, at least for development purposes?


I'll go and spank sshd now. :)

Thanks to everyone for the quick help and the work done.

-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
