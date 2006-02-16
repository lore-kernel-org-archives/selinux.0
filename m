Subject: Re: [RFC][PATCH] collect security labels on user processes
	generating audit messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov,
   James Morris <jmorris@namei.org>
In-Reply-To: <200602160956.20357.sgrubb@redhat.com>
References: 
	 <Pine.LNX.4.44.0602090950470.21925-100000@redline.boston.redhat.com>
	 <43F36244.7040000@hp.com> <200602151320.51016.sgrubb@redhat.com>
	 <200602160956.20357.sgrubb@redhat.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 10:29:00 -0500
Message-Id: <1140103740.12655.79.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 09:56 -0500, Steve Grubb wrote:
> OK, I chased this down to make sure of what is happening. The audit working 
> group has a test kernel, lspp.8, that has all the future audit and lspp 
> patches in it for testing. (it can be found at 
> http://people.redhat.com/sgrubb/files/lspp). There is a patch 
> linux-2.6-audit-git.patch, which is not upstream, but should be in the next 
> kernel. That changes the code in audit_log_exit of auditsc.c to:
> 
>                 if (context->names[i].name)
>                         audit_log_untrustedstring(ab, context->names[i].name);
>                 else
>                         audit_log_format(ab, "(null)");
> 
> The code in audit_log_untrustedstring does this:
> 
>         while (*p) {
>                 if (*p == '"' || *p == '(' || *p < 0x21 || *p > 0x7f) {
>                         audit_log_hex(ab, string, strlen(string));
>                         return;
>                 }
>                 p++;
>         }
>         audit_log_format(ab, "\"%s\"", string);
> 
> This means that a real NULL will never have the double-quote marks around it, 
> where a file named \(null\) will always have double-quote marks around it. I 
> confirmed this by looking in the audit logs. 
> 
> However...ausearch does not make this distinction in its output. I will see 
> what I can do to make the necessary adjustments to ausearch so that its more 
> obvious. So, I think that puts this issue to bed...

Except for what other code should do about NULL pointers in output.  If
they defer it to vsnprintf, they will end up with <NULL> in the output.
So should Tim's code be checking for !ctx and outputting (null) there as
well?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
