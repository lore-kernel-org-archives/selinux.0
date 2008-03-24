Subject: Re: problem when running checkmodule
From: Stephen Smalley <sds@tycho.nsa.gov>
To: kihamba nengo <knengo@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <680209.63527.qm@web90402.mail.mud.yahoo.com>
References: <680209.63527.qm@web90402.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 08:11:50 -0400
Message-Id: <1206360710.3302.11.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-03-21 at 15:01 -0700, kihamba nengo wrote:
> Hi,
> when i run checkmodule -M -m apache.te -o apache.mod i get the
> following error:
> checkmodule: loading policy configuration from apache.te
> token too large, exceeds YYLMAX
> what is the problem

This means that somewhere in apache.te you had a single token that was
longer than YYLMAX characters (defined here as 8192 bytes).

However, at a more basic level, you shouldn't be running checkmodule
directly on apache.te if it contains any macro calls - it has to be
preprocessed first.  Use the refpolicy build infrastructure instead,
i.e.
yum install selinux-policy-devel
make -f /usr/share/selinux/devel/Makefile apache.pp

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
