Subject: Re: I have a question about log on SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: shintarou_fujiwara <shin216@xf7.so-net.ne.jp>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <002b01c58df8$260c6700$0300a8c0@admin0>
References: <002b01c58df8$260c6700$0300a8c0@admin0>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 10:15:30 -0400
Message-Id: <1122300930.2351.41.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 22:28 +0900, shintarou_fujiwara wrote:
> His question is , the difference between "name" and "path" .
> 
> He and I have no idea the differences between these two.
> They look totaly the same...

name is just a single path component, whereas path is a complete path.
Depending on the particular hook location, SELinux can sometimes
generate a path for the audit record but in many cases cannot do so and
is limited to just the component name.  It always logs the device and
inode information.  

You can use the audit framework to get more information, although RHEL4
may not support it until a later update.  Run 'auditctl -e 1'
or boot your kernel with audit=1 to enable syscall auditing.  Then the
audit framework will emit syscall audit messages after any SELinux audit
messages.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
