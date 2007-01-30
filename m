Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0UIiJqW010782
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 13:44:19 -0500
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l0UIjLph005937
	for <selinux@tycho.nsa.gov>; Tue, 30 Jan 2007 18:45:21 GMT
Date: Tue, 30 Jan 2007 10:45:20 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: missing avc message field names
To: Joshua Brindle <jbrindle@tresys.com>
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <45BF7AFE.1000701@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <490935.83298.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Joshua Brindle <jbrindle@tresys.com> wrote:


> This is fairly off topic here (selinux list) but I
> agree with Karl. As a 
> recovering admin I think I can say that admins
> expect to be able to use 
> various unix utilities to inspect log files,
> particularly tail -f. While 
> I'm all for applications putting their data in
> private data formats and 
> using tools and libraries to inspect them I think it
> is generally 
> considered that everything in /var/log is fair game
> to inspect with 
> anything available on systems (including perl,
> python, sed, awk, tail, 
> grep, etc).
> 
> You will certainly be rubbing most admins the wrong
> way by forcing them 
> through a different interface that won't support
> some common commands 
> like tail -f.
> 
> There are probably hundreds of utilities that look
> through these files 
> as well, what is going to happen when people try to
> add audit.log to a 
> log watcher that emails logs to them? Huge binary
> dumps in email are 
> going to make people turn off the audit daemon, not
> modify their apps to 
> use different tools/libraries.

Based on the Unix experience I find myself
agreeing with this assessment. Binary (or
compressed) audit logs don't get read very
often. A mechanism like audit_filters(5) from
Irix makes the problem more manageable, but
the truth is that humans like their information
human readable. Disk space used to be a major
problem, and I/O bandwidth still is (you can
overwhelm any system with too much audit no
matter how optimal your audit data) but the
cost of translation-on-read is going to stop
most humans from ever doing it.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
