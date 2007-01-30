Message-ID: <45BF7AFE.1000701@tresys.com>
Date: Tue, 30 Jan 2007 12:06:06 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: Steve Grubb <sgrubb@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        linux-audit@redhat.com, ewalsh@tycho.nsa.gov,
        Steve G <linux_4ever@yahoo.com>, selinux@tycho.nsa.gov
Subject: Re: missing avc message field names
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291556.37235.sgrubb@redhat.com> <45BE6410.9050604@redhat.com> <200701291749.21897.sgrubb@redhat.com> <45BF5AE3.6030602@mentalrootkit.com>
In-Reply-To: <45BF5AE3.6030602@mentalrootkit.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
>>> The biggest issue, of course, is that it would prevent the use of any
>>> tools that process the files as text (grep, tail, awk, seaudit,
>>> setroubleshoot, etc., etc.). 
>>
>> ausearch -m all --raw | grep anything you want
>>
>
> tail -f happens to be my favorite counter example, but I am certain 
> there are other useful tricks for monitoring logs that will break. Not 
> to mention the number of log monitoring and aggregation tools that 
> assume text logs.

This is fairly off topic here (selinux list) but I agree with Karl. As a 
recovering admin I think I can say that admins expect to be able to use 
various unix utilities to inspect log files, particularly tail -f. While 
I'm all for applications putting their data in private data formats and 
using tools and libraries to inspect them I think it is generally 
considered that everything in /var/log is fair game to inspect with 
anything available on systems (including perl, python, sed, awk, tail, 
grep, etc).

You will certainly be rubbing most admins the wrong way by forcing them 
through a different interface that won't support some common commands 
like tail -f.

There are probably hundreds of utilities that look through these files 
as well, what is going to happen when people try to add audit.log to a 
log watcher that emails logs to them? Huge binary dumps in email are 
going to make people turn off the audit daemon, not modify their apps to 
use different tools/libraries.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
