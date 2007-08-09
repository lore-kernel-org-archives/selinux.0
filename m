Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l79BmdBi023031
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 07:48:39 -0400
Received: from ccerelrim03.cce.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l79BmaOM015906
	for <selinux@tycho.nsa.gov>; Thu, 9 Aug 2007 11:48:36 GMT
From: Paul Moore <paul.moore@hp.com>
To: KaiGai Kohei <kaigai@kaigai.gr.jp>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Thu, 9 Aug 2007 07:48:20 -0400
Cc: selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com
References: <20070807141415.525577324@hp.com> <46BAF327.8080008@kaigai.gr.jp>
In-Reply-To: <46BAF327.8080008@kaigai.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200708090748.20830.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 09 August 2007 6:57:43 am KaiGai Kohei wrote:
> Thanks so much! I was looking forward to your patch set.
>
> I tried to build kernel with the patch and configure a fallbacked label,
> but the netlabelctl returns the following error message:
>
> [root@masu ~]# netlabelctl unlbl add interface:eth0 address:192.168.11.0/24
>                label:system_u:system_r:unconfined_t:s0
> netlabelctl: error, invalid argument or parameter
>
> The kernel config contains CONFIG_NETLABEL=y, and the netlabelctl command
> is built from the latest svn repository.
> Are any more configurations necessary?

Thanks for taking the time to try it out, sorry it wasn't more successful :/

It looks like you are using the userspace from sources under the "head/" 
directory.  In order to get the new features you need to use the sources 
under the "branches/static_label" directory.

 * http://netlabel.svn.sf.net/viewvc/netlabel/netlabel_tools/branches

I apologize, I probably wasn't as clear about this as I should have been in my 
original posting.

Here are the commands, in order, that I used to fetch and build the 
static_label branch of the netlabel_tools package:

 # svn co https://netlabel.svn.sf.net/svnroot/netlabel netlabel
 # cd netlabel/netlabel_tools/branches/static_label
 # make

If you run into any more problems, or have any questions let me know.

Thanks again for your help.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
