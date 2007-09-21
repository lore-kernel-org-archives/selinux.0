Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8LAoeZG013054
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 06:50:40 -0400
Received: from rv-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8LAocRK020130
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 10:50:39 GMT
Received: by rv-out-0910.google.com with SMTP id k15so730304rvb
        for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 03:50:21 -0700 (PDT)
Message-ID: <46F3A0E4.6020700@gmail.com>
Date: Fri, 21 Sep 2007 18:45:56 +0800
From: Ken YANG <spng.yang@gmail.com>
MIME-Version: 1.0
To: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
CC: selinux@tycho.nsa.gov
Subject: Re: execmod permission
References: <FB39F4E77226B448BC1388D3BE4E00CD49A27D@blums0008.bluelnk.net>
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD49A27D@blums0008.bluelnk.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Clarkson, Mike R (US SSA) wrote:
> Can someone explain to me what this permission provides?
> 
> The explanation that I've seen is this: "Make executable a file mapping
> that has been modified (implied by a copy-on-write)"
> 
> I don't know what that means. The audit log is suggesting that I need to
> provide this permission for a shared library file. 

The execmod permission controls the ability to execute memory-mapped
files that *have been modified* in the process memory.

This permission check is useful in keeping shared libraries from being
modified within a process. Without it, if a memory mapped file is
modified, it will not be allowed to be executed by the process

> 
> Thanks
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
