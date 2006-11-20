Message-ID: <4562085F.1040900@mentalrootkit.com>
Date: Mon, 20 Nov 2006 14:56:15 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: James Morris <jmorris@namei.org>, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
        trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com>	 <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>	 <XMMS.LNX.4.64.0611141618300.25022@d.namei> <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1164048073.13758.29.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-11-14 at 16:19 -0500, James Morris wrote:
>> On Tue, 14 Nov 2006, David Howells wrote:
>>
>>> +static u32 selinux_set_fscreate_secid(u32 secid)
>>> +{
>>> +	struct task_security_struct *tsec = current->security;
>>> +	u32 oldsid = tsec->create_sid;
>>> +
>>> +	tsec->create_sid = secid;
>>> +	return oldsid;
>>> +}
>> The ability to set this needs to be mediated via MAC policy.
>>
>> See selinux_setprocattr()
> 
> That's different - selinux_set_fscreate_secid() is for internal use by a
> kernel module that wishes to temporarily assume a particular fscreate
> SID, whereas selinux_setprocattr() handles userspace writes
> to /proc/self/attr nodes.  Imposing a permission check here makes no
> sense.
> 

Since that discussion last week I have been thinking about this and I 
have to say I agree with Steve. This should be a kernel only mechanism 
for impersonating another SID - controlling the setting of process 
attributes shouldn't be restricted as this will only lead to 
inconsistencies in those attributes.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
