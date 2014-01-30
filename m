Message-ID: <52EA95B3.506@tycho.nsa.gov>
Date: Thu, 30 Jan 2014 13:10:59 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Yao <ryao@gentoo.org>, mthode@mthode.org,
 Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: file access causes a kernel bug
References: <52E8B5F8.2070005@mthode.org> <52E8B7C1.1000101@mthode.org>
 <1621615.vHn06J0duj@sifl> <52E90B32.5010404@tycho.nsa.gov>
 <52E90D65.9030200@tycho.nsa.gov> <52E9331B.407@mthode.org>
 <52E97454.5060403@tycho.nsa.gov> <52E98240.5020901@llnl.gov>
 <F90298CB-DC5B-4DC9-BA64-E5C31461815D@gentoo.org> <52EA0B4F.30403@mthode.org>
 <52EA571B.6050008@tycho.nsa.gov> <52EA71F1.1040303@mthode.org>
 <52EA737C.7010802@tycho.nsa.gov> <52EA74E9.3020406@mthode.org>
 <52EA80AC.2070802@tycho.nsa.gov> <52EA86D2.104@mthode.org>
 <52EA8B84.5010006@gentoo.org>
In-Reply-To: <52EA8B84.5010006@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Cc: behlendorf@llnl.gov, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/30/2014 12:27 PM, Richard Yao wrote:
> On 01/30/2014 12:07 PM, Matthew Thode wrote:
>> On 01/30/2014 10:41 AM, Stephen Smalley wrote:
>>> On 01/30/2014 10:51 AM, Matthew Thode wrote:
>>>> On 01/30/2014 09:45 AM, Stephen Smalley wrote:
>>>>> We'll have to investigate, as that obviously shouldn't be possible.
>>>>> Wouldn't be allowed in enforcing mode or for any non-root process.
> 
> This is an untested conjecture, but I believe that a FUSE filesystem
> could be used to trigger this in enforcing mode. If I am right, a custom
> FUSE filesystem could trigger it with ease. However, I do not see what
> that would accomplish beyond triggering the BUG_ON.

SELinux does not presently request or use xattrs from FUSE filesystems,
so I don't believe this is presently an issue, but I understand.

> 
>>> Try the attached patch.
>>>
>>>
>> Confirmed that this fixes it :D thanks a ton for this.
> 
> This patch looks good to me. Feel free to append my Acked-by:
> 
> Acked-by: Richard Yao <ryao@gentoo.org>
> 
