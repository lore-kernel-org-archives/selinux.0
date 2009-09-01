Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n815qCid029555
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 01:52:12 -0400
Received: from smtp107.prem.mail.ac4.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n815rRlW000034
	for <selinux@tycho.nsa.gov>; Tue, 1 Sep 2009 05:53:27 GMT
Message-ID: <4A9CB676.8070405@schaufler-ca.com>
Date: Mon, 31 Aug 2009 22:51:50 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Oren Laadan <orenl@cs.columbia.edu>,
        Linux Containers <containers@lists.osdl.org>,
        linux-security-module@vger.kernel.org, SELinux <selinux@tycho.nsa.gov>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 2/5] cr: checkpoint the active LSM and add	RESTART_KEEP_LSM
 flag
References: <20090828210041.GA27878@us.ibm.com> <20090828210208.GA28048@us.ibm.com> <4A98B1D7.9050108@schaufler-ca.com> <20090829225923.GB12549@hallyn.com> <4A99C1B6.6080504@schaufler-ca.com> <20090830134809.GA14699@hallyn.com> <4A9ACBD4.4020804@schaufler-ca.com> <20090830202412.GA16222@hallyn.com> <4A9AF28D.2030803@schaufler-ca.com> <20090831132258.GB4837@us.ibm.com> <20090831133656.GC4837@us.ibm.com>
In-Reply-To: <20090831133656.GC4837@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Serge E. Hallyn wrote:
> Quoting Serge E. Hallyn (serue@us.ibm.com):
>   
>> Quoting Casey Schaufler (casey@schaufler-ca.com):
>>     
>>> Serge E. Hallyn wrote:
>>>       
>>>> Quoting Casey Schaufler (casey@schaufler-ca.com):
>>>> So do you think that adding a policy version check in the kernel
>>>> at restart would help this?
>>>>         
>> For the moment I intend to add a patch on top of these adding two
>> security calls:
>>
>> 	security_may_checkpoint(ctx) which will authorize the
>> 		ability to checkpoint at all, and
>>     
>
> I meant:
>
> 	security_may_restore(ctx).
>   

As much as I hate adding more hooks, you could argue for both.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
