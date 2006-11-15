Message-ID: <455B5466.40407@mentalrootkit.com>
Date: Wed, 15 Nov 2006 12:54:46 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
        Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        trond.myklebust@fys.uio.no, selinux@tycho.nsa.gov,
        linux-kernel@vger.kernel.org, aviro@redhat.com, steved@redhat.com
Subject: Re: [PATCH 12/19] CacheFiles: Permit a process's create SID to be
 overridden
References: <XMMS.LNX.4.64.0611141618300.25022@d.namei>  <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> <20061114200647.12943.39802.stgit@warthog.cambridge.redhat.com>  <24555.1163598644@redhat.com> <XMMS.LNX.4.64.0611151120240.8593@d.namei>
In-Reply-To: <XMMS.LNX.4.64.0611151120240.8593@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Wed, 15 Nov 2006, David Howells wrote:
> 
>> James Morris <jmorris@namei.org> wrote:
>>
>>> The ability to set this needs to be mediated via MAC policy.
>> Something like this, you mean?
> 
> Yes, although perhaps writing to tsec->kern_create_sid or similar, which 
> then overrides tsec->create_sid if set.  Also need 
> /proc/pid/attr/kern_fscreate as a read only node.
> 
> 
>> +	error = task_has_perm(current, current, PROCESS__SETFSCREATE);
> 
> I wonder if we also need 'relabelto' and 'relabelfrom' permissions, to 
> control which labels are being used.
> 

No - assuming the existing checks are called, the controls on 
file/dir/etc creation should be sufficient to control which labels are 
used. Setting fscreate is not a relabel operation nor does it result in 
a relabel operation as the sid is only used for creation.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
