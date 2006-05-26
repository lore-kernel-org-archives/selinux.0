Subject: Re: [patch] Full relabel audit event
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Antill <jantill@redhat.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, linux-audit@redhat.com,
        selinux@tycho.nsa.gov
In-Reply-To: <1148590901.8828.22.camel@code.and.org>
References: <1148590901.8828.22.camel@code.and.org>
Content-Type: text/plain
Date: Fri, 26 May 2006 13:05:20 -0400
Message-Id: <1148663120.20976.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-05-25 at 17:01 -0400, James Antill wrote:
>  The attached patch implements the full relabel audit event (Ie. an
> audit event occurs when a full relabel occurs, ie. when /.autorelabel
> exists at boot).
>  Note that although the code is correct, this patch doesn't actually
> work due to kernel bugs[1].
> 
>  It'll be in Fedora development as part of policycoreutils-1.30.10-3
> onwards.
> 
> [1] see the thread on linux-audit if you want the details.

Hmmm...what is it that you actually want to do here?  If you only care
about auditing autorelabel events, then I'd suggest generating the audit
message from the autorelabel portion of rc.sysinit (via a helper, I
suppose), not from setfiles itself.  If you want to audit all full
relabels, then you need to instrument more than setfiles (e.g.
restorecon -R / works just as well), and of course, you potentially need
to do something at the kernel level with audit filters or auditallow
rules in policy if you truly want to capture all relabels.  And, of
course, just auditing it when they happen to pass "/" as an argument
isn't very reliable.

Not sure which thread you are referring to; I don't see prior discussion
of a relabel audit event in the linux-audit archives.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
