Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBKJ7ccp032553
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 14:07:39 -0500
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
 <b8fd94ca-4bd8-6340-0199-e51587d32ce8@schaufler-ca.com>
 <1482258482.28169.40.camel@tycho.nsa.gov>
Cc: paul@paul-moore.com, james.l.morris@oracle.com,
 linux-security-module@vger.kernel.org, john.johansen@canonical.com
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <e1d6f6d6-7bbb-85bd-7070-70406e5546d7@schaufler-ca.com>
Date: Tue, 20 Dec 2016 11:07:33 -0800
MIME-Version: 1.0
In-Reply-To: <1482258482.28169.40.camel@tycho.nsa.gov>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/20/2016 10:28 AM, Stephen Smalley wrote:
> On Tue, 2016-12-20 at 10:17 -0800, Casey Schaufler wrote:
>> On 12/20/2016 8:50 AM, Stephen Smalley wrote:
>>> On Tue, 2016-12-20 at 17:39 +0100, José Bollo wrote:
>>>> Le mardi 20 décembre 2016 à 11:14 -0500, Stephen Smalley a écrit
>>>> :
>>>>>
>>>>> Looking at your PTAGS implementation, I feel it is only fair to
>>>>> warn
>>>>> you that your usage of /proc/pid/attr is insecure, regardless
>>>>> of
>>>>> whether you use task security blobs or cred security blobs.
>>>> Fair?!
>>>>
>>>>> Getting the attributes of another process via /proc/pid files
>>>>> is
>>>>> inherently racy, as the process may exit and another process
>>>>> with
>>>>> different attributes may be created with the same pid (and no,
>>>>> this
>>>>> is not theoretical; it has been demonstrated).
>>>> I know. And I'm surprized that you dont do anything to change
>>>> that.
>>> There is a reason why SO_PEERSEC and SCM_SECURITY exist.  Again,
>>> learn
>>> from the upstream security modules rather than re-inventing them,
>>> badly.
>> SO_PEERSEC and SCM_SECURITY are spiffy for processes that are
>> sending each other messages, but they identify the attributes
>> associated with the message, not the process. Neither SELinux
>> nor Smack get the information to send off of the process, it
>> comes from the socket structure.
> Yes, but in the SELinux case at least, the socket is labeled with the
> label of the creating process (except in the rare case of using
> setsockcreatecon(3), which can only be used by suitably authorized
> processes).

Yes, it's the same with Smack. When it's not the label
of the process it's the label the system wants the peer
to think it is.

>   So in general it serves quite well as a means of obtaining
> the peer label, which can then be used in access control (and this is
> in fact being used in a variety of applications in Linux and Android).

But only between processes that are in direct, explicit communication.
There is no denying that these mechanisms work. They just aren't
applicable to Jose's use.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
