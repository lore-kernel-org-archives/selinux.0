Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2JGE8Do029816
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2005 11:14:08 -0500 (EST)
Received: from sccrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2JGCH6l011884
	for <selinux@tycho.nsa.gov>; Sat, 19 Mar 2005 16:12:17 GMT
Subject: Re: latest diff
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <423BCC68.3090003@redhat.com>
References: <423BCC68.3090003@redhat.com>
Content-Type: text/plain
Date: Sat, 19 Mar 2005 11:14:50 -0500
Message-Id: <1111248890.5582.20.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-03-19 at 01:53 -0500, Daniel J Walsh wrote:
> I think we can remove the hostname policy, it adds little value.  
[cut]
> I think it would work fine without hostname policy.  I think we could 
> probably get rid of consoletype also.

I don't remember why hostname and consoletype were added in the first
place, but a quick look through them makes me think that its so we don't
have to give sys_admin capability to initrc_t when these programs are
run from init scripts.  Sys_admin is a huge set a privileges, so I'd say
its worthwhile to keep them around.

> plain text document attachment (diff)
> +bool use_syslogng false;
> +
> +if (use_syslogng) {
> +allow syslogd_t proc_kmsg_t:file write;
> +allow syslogd_t self:capability { sys_admin chown };
> +}

Shouldn't this go in the ifdef(`klogd.te',`',`  block?  Its already
there for syslogds that also do the klogd functions, like syslog-ng.  In
fact, I think that block was originally added for syslog-ng.  That
should eliminate the need for a boolean too.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
