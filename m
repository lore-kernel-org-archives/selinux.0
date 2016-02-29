Subject: Re: should setfscreatecon be able to override auto type transition
 rules?
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <56D4987B.2030001@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56D4A8A9.40704@tycho.nsa.gov>
Date: Mon, 29 Feb 2016 15:23:05 -0500
MIME-Version: 1.0
In-Reply-To: <56D4987B.2030001@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/29/2016 02:14 PM, Dominick Grift wrote:
> I encountered this today and it got me thinking. Should this be happenin
> g?

Yes.

> I would think that a auto type transition rule should always take
> precedence, and that setfscreatecon should only be honored if there is
> nothing in policy overriding it.

No.  The type_transition rules are merely defaults to provide 
compatibility with a non-security-aware userspace.  setfscreatecon() 
intentionally permits overriding type transition or default inheritance 
rules.  Of course, one can only use setfscreatecon() if one has the 
requisite permissions, including setfscreate to even use it at all, plus 
create to the specified type.  However, in Android, the usage 
permissions like setfscreate are tightly locked down; only a few domains 
are allowed them.
