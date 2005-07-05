Message-ID: <20050705141733.47877.qmail@web51508.mail.yahoo.com>
Date: Tue, 5 Jul 2005 07:17:33 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Logging of a system call
To: Paulo Silva <pjs@eurotux.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1120553474.19633.2.camel@valen>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I was wondering if anyone knows an easy way to log all invocations of a
>particular system call in a Linux system (kernel 2.6).

If you have the audit system installed - http://people.redhat.com/sgrubb/audit,
you can do this:

auditctl -a entry,always -S syscallname

The results will be in either /var/log/audit/audit.log or syslog depending on
whether you are running the audit daemon or not.

>My first ideia was to use SELinux but I haven't experience developing
>new policies, has anybody done something similar with SELinux?

The audit system was designed for this, please give it a try.

-Steve


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
