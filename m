Message-ID: <452674B8.4050604@hp.com>
Date: Fri, 06 Oct 2006 11:22:32 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Steve Grubb <sgrubb@redhat.com>, Michael C Thompson <thompsmc@us.ibm.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        jdesai@us.ibm.com
Subject: Re: [RFC PATCH] newrole suid breakdown
References: <452432FA.1060009@us.ibm.com>	 <1160079125.2132.232.camel@moss-spartans.epoch.ncsc.mil>	 <45256F49.1070105@us.ibm.com>  <200610051748.06669.sgrubb@redhat.com> <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1160146343.12253.85.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
<snip>

> No one has yet commented on the concern I raised about whether setting
> the suid bit on newrole in this manner is workable from a packaging and
> maintenance point of view (if policycoreutils installs a non-suid
> newrole and the lspp package makes it suid from a scriptlet, then rpm -V
> policycoreutils will report variance in the file mode, and an update of
> policycoreutils will reset the newrole mode back to non-suid).  That
> seems a bit problematic to me.

This may be a general problem if we do for LSPP what we did for CAPP,
which was strip suid/sgid bits off some programs and change the mode
bits to only allow the owner (root) to execute others.  The kickstart
script Klaus posted still does this.

I think this was something George was dealing with as part of the
self-test script.  If the self-test uses rpm -V, it would need to
check that the variance is expected.  Now sure what to do about the
update case but with CAPP the configuration script could be re-run at any time
to re-do the original changes so maybe this part of the problem is solved
with documentation.

-- ljk

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
