From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: [patch] Full relabel audit event
Date: Tue, 30 May 2006 10:08:16 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <1148590901.8828.22.camel@code.and.org> <1148665647.8828.36.camel@code.and.org> <1148666614.20976.258.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148666614.20976.258.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605301008.16564.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 May 2006 14:03, Stephen Smalley wrote:
> I don't see the point when a) you only want it in that one case,

We do this already in several places. For example, we instrumented usermod, 
but not chage. It was documented in the Security Target that usermod should 
be used to alter user account attributes.

> b) it doesn't prevent trivial bypass in any way (e.g. by using restorecon,
> by rolling your own program to do it, by running setfiles on /* rather than
> just /, ...), and 

Its not meant to be bulletproof. Its purpose is to document that a full 
relabel has occurred before any user can log in. During the boot process, no 
one can log in so nothing evil should happen.

> Note btw that setfiles already provides three different ways to log
> actual changes in file contexts, the original -v verbose mode, and the
> -l (log via syslog) and -o <file> (log to file) modes introduced later
> by Red Hat.  That at least provides detailed information that the caller
> couldn't determine otherwise.

It was determined that we only need 1 record, not all the changes.

-Steve


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
