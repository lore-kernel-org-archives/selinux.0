Subject: Re: problem about boot
From: Nick <nagray@austin.rr.com>
To: Richard Herbert Wanner <richard.wanner@cgi.com>
Cc: SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <376013375d87.375d87376013@wshs>
References: <376013375d87.375d87376013@wshs>
Content-Type: text/plain
Date: 14 Nov 2003 13:47:14 -0600
Message-Id: <1068839235.3058.731.camel@marquesas>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Why do I have to do this! I understand the mechanics of what is
happening. I am just unclear as to why the SELinux kernel can't handle
the label or why it doesn't install as /dev/hdxx or appropriate.


On Thu, 2003-10-23 at 11:26, Richard Herbert Wanner wrote:
> Just a guess... but did you remember to change the root=LABEL=/ entry 
> in your bootloader file to root=/dev/hda2 (or whatever the root is on 
> your system).

-- 
Nick Gray
Senior Network Engineer
Bruzenak Inc.
nagray@bruzenak.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
