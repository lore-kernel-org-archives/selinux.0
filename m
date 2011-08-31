Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7VKo0co014110
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 16:50:00 -0400
Received: from nm11.bullet.mail.sp2.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id p7VKnxit017348
	for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2011 20:49:59 GMT
Message-ID: <4E5E9E75.8050305@schaufler-ca.com>
Date: Wed, 31 Aug 2011 13:49:57 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: rongqing.li@windriver.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 1/2] Define security_sk_getsecctx
References: <1314779777-12669-1-git-send-email-rongqing.li@windriver.com>  <1314779777-12669-2-git-send-email-rongqing.li@windriver.com>  <4E5E568A.4050407@schaufler-ca.com> <1314816361.6850.51.camel@moss-pluto>
In-Reply-To: <1314816361.6850.51.camel@moss-pluto>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 8/31/2011 11:46 AM, Stephen Smalley wrote:
> On Wed, 2011-08-31 at 08:43 -0700, Casey Schaufler wrote:
>> On 8/31/2011 1:36 AM, rongqing.li@windriver.com wrote:
>>> From: Roy.Li <rongqing.li@windriver.com>
>>>
>>> Define security_sk_getsecctx to return the security
>>> context of a sock.
>> So, what is the intended use of the information
>> coming from this hook? If I wanted to write the
>> Smack hook, which of the "contexts" would I want
>> to return? There are potentially three. If I know
>> what the caller is looking for, I can (hopefully)
>> select the correct information.
> The initial use case is for netstat -Z so that it can reliably show the
> security context of the socket rather than inferring it from the owning
> process, which can be inaccurate for security-aware applications.
>
> In your situation, when in != out, which would you rather see in netstat
> -Z output?  Alternatively, if you want them both, perhaps you could
> combine in and out into a single string that is returned, similar to
> what you proposed for handling multiple xattrs with inode_getsecctx()?
>

If we want to use secctx consistently within the kernel, and
I personally think that is a good idea, I would have to chose
the SMACK64IPIN (label checked on packet delivery) value. Putting
both the SMACK64IPOUT and SMACK64IPIN "contexts" into the secctx
would violate the architectural notion that a secctx is the
textual representation of a value used to make access control
decisions. It would mean that calling security_secctx_to_secid()
with the value returned by security_sk_getsecctx would be invalid.
Note that this is different from the mechanism I had suggested
for handling secctx in the multiple LSM case, as the composed
string would map to a single secid which would in turn map back
to that same composed string. If, on the other hand, what netstat -Z
is out to show is all of the LSM base information about the socket
a compound string might make sense, it just would not be a
secctx, it would be an informational string of some other flavor.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
