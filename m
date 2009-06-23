Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n5N3AlUm013072
	for <selinux@tycho.nsa.gov>; Mon, 22 Jun 2009 23:10:47 -0400
Received: from smtp102.prem.mail.sp1.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n5N3BHCP003521
	for <selinux@tycho.nsa.gov>; Tue, 23 Jun 2009 03:11:17 GMT
Message-ID: <4A4047A9.8020202@schaufler-ca.com>
Date: Mon, 22 Jun 2009 20:10:33 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "Serge E. Hallyn" <serue@us.ibm.com>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morgan <morgan@kernel.org>
Subject: Re: [PATCH 1/1] cr: lsm: restore LSM contexts for ipc objects
References: <20090620013216.GA4435@us.ibm.com>	 <1245682025.3033.178.camel@localhost.localdomain>	 <20090622175003.GA2416@us.ibm.com> <1245695023.12493.7.camel@localhost.localdomain>
In-Reply-To: <1245695023.12493.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2009-06-22 at 12:50 -0500, Serge E. Hallyn wrote:
>   
>> Quoting Stephen Smalley (sds@epoch.ncsc.mil):
>>     
>>> Not sure you need to cache them in the cr layer (vs. just using the
>>> mapping functions provided by the LSM hook interface, and letting the
>>> security module handle caching internally).
>>>       
>> Do I understand correctly that secids are supposed to be consistent
>> across machines and reboots, but not across policy versions?
>>     
>
> No, secids are temporal - they are dynamically allocated at runtime like
> file descriptors.  You should only store security contexts in the
> images.
>   

Like he said. Smack would be happier if secid's went away, but
there's too much left over from the era when SELinux was the only
LSM for that to happen without crying and gnashing of teeth. A
secid is good only for the current invocation of the current
instance of the kernel.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
