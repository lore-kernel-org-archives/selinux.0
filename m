Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA00575
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 12:24:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA10028
	for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:23:13 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA10024 for <selinux@tycho.nsa.gov>; Mon, 29 Apr 2002 16:23:11 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: insmod
Date: Mon, 29 Apr 2002 18:24:24 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524373@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524373@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020429162425.4B40D3EA8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 29 Apr 2002 17:39, Westerman, Mark wrote:
> I have made an ipsec as a module to the selinux kernel.
> I am having to adjust the rules. I do have a question.
>
>
> The ipsec needs to write to the sysctl_t
>
> I conservative about overwriting some of the assertions.
>
> neverallow ~{initrc_t admin} sysctl_t:file { write append };
>
> I would have to add insmod_t
>
> neverallow ~{insmod_t initrc_t admin} sysctl_t:file { write append };

A snippet from my assert.te file:
neverallow ~{ initrc_t admin insmod_t } sysctl_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
neverallow ~{ initrc_t admin kmod_t insmod_t } sysctl_kernel_t:file { write 
append };


insmod_t needs write access to sysctl_t and sysctl_kernel_t for managing the 
tainted flag.  I've had this in my tree for ages (and I hope this will be in 
the new release - it's been discussed here before).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
