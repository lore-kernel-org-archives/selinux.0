Date: Fri, 12 Apr 2002 17:01:31 +0200
From: Tom <tom@lemuria.org>
To: SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Message-ID: <20020412170130.A30042@lemuria.org>
References: <Pine.GSO.4.33.0204120840060.21729-100000@raven> <20020412135859.3D809281EF@lyta.coker.com.au> <20020412161729.B29624@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020412161729.B29624@lemuria.org>; from tom@lemuria.org on Fri, Apr 12, 2002 at 04:17:29PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Apr 12, 2002 at 04:17:29PM +0200, Tom wrote:
> It looks like I solved the problem, at least it now boots and appears
> to run fine, except that I can't log in remotely, but ssh localhost
> works. I'll inspect that later.

Funny thing, I guess I found the revers of "NoRootLogin" :)

Analysis: Logging in via ssh as root works, as a user not. i.e. "ssh
-l tom testmachine" fails, "ssh -l root testmachine" works.

The error message in /var/log/auth.log is:

fatal: Could not obtain SID for user tom


The piece of code that triggers this appears to be:

if (!get_default_user_sid(pw->pw_name, 
			  strlen(pw->pw_name),
			  &scontext,
			  &sid)) {
	fprintf(stderr, "Could not obtain SID for user %s\n",
		pw->pw_name);
	exit(1);
}

so I wonder why this fails, because my /etc/selinux/users says:

user user_u roles user_r;
user root roles { user_r sysadm_r };
user tom roles { user_r sysadm_r };

so tom should be more than covered. or am I just being dumb again?


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
