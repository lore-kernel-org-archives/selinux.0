Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JIoRpr008149
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 14:50:28 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2JIoQRc008597
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 18:50:27 GMT
Message-ID: <45FEDB67.9080501@hp.com>
Date: Mon, 19 Mar 2007 14:50:15 -0400
From: Linda Knippers <linda.knippers@hp.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kudzu needs to init_telinit to change its runlevel
References: <45F02A1B.7040007@redhat.com> <1174328028.16707.13.camel@sgc>
In-Reply-To: <1174328028.16707.13.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-03-08 at 10:22 -0500, Daniel J Walsh wrote:
> 
>>--- nsaserefpolicy/policy/modules/admin/kudzu.te        2007-01-02 12:57:51.000000000 -0500
>>+++ serefpolicy-2.5.8/policy/modules/admin/kudzu.te     2007-03-08 08:42:36.000000000 -0500
>>@@ -103,6 +103,7 @@
>> init_use_fds(kudzu_t)
>> init_use_script_ptys(kudzu_t)
>> init_stream_connect_script(kudzu_t)
>>+init_telinit(kudzu_t)
>> 
>> libs_use_ld_so(kudzu_t)
>> libs_use_shared_libs(kudzu_t)
> 
> 
> This seems odd to me.  Why would kudzu need to change the runlevel?  I
> thought it just detected and configured hardware.

If it detects a serial console, and I assume tty devices in general, it
updates /etc/inittab and then wants to signal init via telinit to cause
init to re-read the inittab.  Its not changing run level, just causing
inittab to be re-read.

Without this change we didn't get login prompts on serial consoles on
the first boot a system.

-- ljk


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
