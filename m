Subject: Re: security_compute_av(3)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200506301356.37995.russell@coker.com.au>
References: <200506301356.37995.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 08:38:48 -0400
Message-Id: <1120135128.11798.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 13:56 +1000, Russell Coker wrote:
> It appears that most functions in this man page require the header file 
> selinux/av_permissions.h, but the man page omits to mention this.

Um, ok.  Didn't you write that man page?  Feel free to submit a patch ;)
av_permissions.h is actually only needed for security_compute_av and
checkPasswdAccess (and avc_has_perm).  The other functions would only
need the class definitions, which are in flask.h.  And ultimately, these
will be replaced by dynamic mappings from string names for classes and
permissions to values determined at runtime, handled by the userspace
security server.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
