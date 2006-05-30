From: Steve Grubb <sgrubb@redhat.com>
To: redhat-lspp@redhat.com
Subject: Re: [redhat-lspp] Re: [patch] Full relabel audit event
Date: Tue, 30 May 2006 09:22:44 -0400
Cc: Stephen Smalley <sds@tycho.nsa.gov>, James Antill <jantill@redhat.com>,
        linux-audit@redhat.com, selinux@tycho.nsa.gov
References: <1148590901.8828.22.camel@code.and.org> <1148663120.20976.235.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1148663120.20976.235.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605300922.44971.sgrubb@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 26 May 2006 13:05, Stephen Smalley wrote:
> Hmmm...what is it that you actually want to do here?

We need to meet the requirements for LSPP where there is a relabel on boot, 
but we do not want a record for each file that was touched. It was discussed 
on the LSPP telecon a while back that just one record was sufficient.

> If you only care about auditing autorelabel events, then I'd suggest
> generating the audit message from the autorelabel portion of rc.sysinit (via
> a helper, I suppose), not from setfiles itself.

This is a shell script and cannot connect to libaudit.

> If you want to audit all full relabels, then you need to instrument more
> than setfiles (e.g. restorecon -R / works just as well), and of course, you
> potentially need to do something at the kernel level with audit filters or
> auditallow rules in policy if you truly want to capture all relabels. 

We get relabels by monitoring the setxattr syscall. But during bootup before 
going interactive, we just want 1 message.

-Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
