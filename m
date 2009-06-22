Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5M5d3te005617
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 01:39:03 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n5M5cnUe004388
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 05:38:49 GMT
Date: Mon, 22 Jun 2009 15:37:45 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
cc: Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
In-Reply-To: <20090620013216.GA4435@us.ibm.com>
Message-ID: <alpine.LRH.2.00.0906221537190.19585@tundra.namei.org>
References: <20090620013216.GA4435@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Jun 2009, Serge E. Hallyn wrote:

> Here is the next version of the patch implementing checkpoint
> and restore of LSM contexts.  This is just handling IPC objects
> as a proof of concept.  But actually, looking ahead and both
> files and tasks, I see that selinux stores several sids in the
> security structs.  For instance, for tasks there is the current
> sid, exec sid, create sid, keycreate_sid, and sockcreate_sid.
> So I guess I'll have to ask the LSM for how many secids it wants
> to checkpoint, then checkpoint an array of contexts?
> 

Can you please explain exactly what checkpoint/restart is?

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
