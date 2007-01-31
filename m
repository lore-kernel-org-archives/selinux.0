From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: missing avc message field names
Date: Thu, 1 Feb 2007 09:59:37 +1100
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Antill <jantill@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        linux-audit@redhat.com, ewalsh@tycho.nsa.gov, selinux@tycho.nsa.gov
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <45BFE7EC.8050609@mentalrootkit.com> <45C02948.9090607@tresys.com>
In-Reply-To: <45C02948.9090607@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702010959.41511.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 31 January 2007 16:29, Joshua Brindle <jbrindle@tresys.com> 
wrote:
> Even with a tail replacement there has to be thousands of internally
> written and maintained log monitoring and reporting apps that will
> break, this is a fundamental change in how logging works on linux, not
> something that can or should be changed on a whim (or otherwise).

Most such programs assume that log files keep the same name until a cron job 
renames them.  The current practice of auditd rotating it's log files has 
probably broken the majority of such programs already.

Also Steve Grubb suggested having a configuration option for plain-text files 
which will avoid the problems with binary files.

If we work with the assumption that indexed log files are required for sites 
with significant audit requirements due to the volume of logs and the need to 
get responses in a reasonable amount of time then we have two options.  One 
is a binary format, the other is to have index files along-side the text 
files.

Having separate index files introduces complications for renaming and other 
file management (complexity is bad for reliability), even without the issue 
of the sys-admin wanting to rename their own log files.

So it seems that the option of a binary log file is required.

Maybe there should be an option to have auditd write a binary log file as well 
as either a text log file or logging via syslog?  That way the admin could 
have the index benefits of a binary log as well as having text files.  If 
there were two log files then the second copy wouldn't need to be written 
synchronously so the IO load would not double.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
