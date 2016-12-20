Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBKIHmI6016491
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 13:17:48 -0500
Subject: Re: [PATCH 2/2] proc,security: move restriction on writing
 /proc/pid/attr nodes to proc
To: Stephen Smalley <sds@tycho.nsa.gov>, =?UTF-8?Q?Jos=c3=a9_Bollo?=
 <jobol@nonadev.net>, selinux@tycho.nsa.gov
References: <1481910072-11392-1-git-send-email-sds@tycho.nsa.gov>
 <1481910072-11392-2-git-send-email-sds@tycho.nsa.gov>
 <1482140693.2178.1.camel@nonadev.net>
 <1482250452.28169.28.camel@tycho.nsa.gov>
 <1482251949.25787.1.camel@nonadev.net>
 <1482252636.28169.34.camel@tycho.nsa.gov>
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, john.johansen@canonical.com
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b8fd94ca-4bd8-6340-0199-e51587d32ce8@schaufler-ca.com>
Date: Tue, 20 Dec 2016 10:17:32 -0800
MIME-Version: 1.0
In-Reply-To: <1482252636.28169.34.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/20/2016 8:50 AM, Stephen Smalley wrote:
> On Tue, 2016-12-20 at 17:39 +0100, José Bollo wrote:
>> Le mardi 20 décembre 2016 à 11:14 -0500, Stephen Smalley a écrit :
>>>
>>> Looking at your PTAGS implementation, I feel it is only fair to
>>> warn
>>> you that your usage of /proc/pid/attr is insecure, regardless of
>>> whether you use task security blobs or cred security blobs.
>> Fair?!
>>
>>> Getting the attributes of another process via /proc/pid files is
>>> inherently racy, as the process may exit and another process with
>>> different attributes may be created with the same pid (and no, this
>>> is not theoretical; it has been demonstrated).
>> I know. And I'm surprized that you dont do anything to change that.
> There is a reason why SO_PEERSEC and SCM_SECURITY exist.  Again, learn
> from the upstream security modules rather than re-inventing them,
> badly.

SO_PEERSEC and SCM_SECURITY are spiffy for processes that are
sending each other messages, but they identify the attributes
associated with the message, not the process. Neither SELinux
nor Smack get the information to send off of the process, it
comes from the socket structure.

>
>>> Similarly, setting the
>>> attributes of another process via /proc/pid files is likewise
>>> inherently racy; you may end up setting the attributes on the wrong
>>> process entirely.
>> I also know that.
>>
>>> Setting another process' attributes in this manner
>>> is also prone to other kinds of races, since there is no
>>> coordination
>>> between the process execution state and when the new tag is
>>> applied.
>> Yes it is expected.
>>
>>> Again, I encourage you to reconsider your approach if you want to
>>> have a secure solution.
>> Well I know that managing processes is not secure because there is no
>> kind of unique id. But please instead of thinking that it is to
>> risky,
>> please hear that some risks are manageable or acceptable.
> Even when there are known, better ways of doing things?


