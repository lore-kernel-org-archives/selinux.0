Date: Fri, 12 Apr 2002 17:29:54 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412172954.A30349@lemuria.org>
References: <20020412170130.A30042@lemuria.org> <Pine.GSO.4.33.0204121108290.21729-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.33.0204121108290.21729-100000@raven>; from sds@tislabs.com on Fri, Apr 12, 2002 at 11:11:16AM -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 11:11:16AM -0400, Stephen Smalley wrote:
> > so tom should be more than covered. or am I just being dumb again?
> 
> You also need an entry for tom in /etc/security/default_context.  This
> configuration file will be obsoleted in the future, but we're still
> waiting on a developer at NSA to finish the support necessary to eliminate
> it.

actually, one more question: What am I doing wrong if the generic user
entries don't work? i.e. I create a new user - can't log in remotely. I
add him to /etc/security/default_context - still no luck. I add him to
the policy (/etc/selinux/users) and it works.

sounds like not good for systems with many users, so what is the right
way to do it?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
