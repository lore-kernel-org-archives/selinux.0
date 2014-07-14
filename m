Message-ID: <53C3D401.6030207@tycho.nsa.gov>
Date: Mon, 14 Jul 2014 08:58:41 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>,
 Dave Quigley <selinux@davequigley.com>
Subject: Re: Showing port Labels
References: <53C37D83.9050705@davequigley.com>
 <1405329902.661.30.camel@x220.localdomain>
In-Reply-To: <1405329902.661.30.camel@x220.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/14/2014 05:25 AM, Dominick Grift wrote:
> On Mon, 2014-07-14 at 02:49 -0400, Dave Quigley wrote:
>> I am working on some slides for my workshop at oscon and I tried to find 
>> the context of a port a process is listening on. If I do netstat -lZ I 
>> see all the listening ports and a security context. However, it seems 
>> the security context is the context of the process that is listening on 
>> that port not the context of the port itself. Is there a way to see the 
>> context of the port itself? I don't see any other option that might give 
>> that information. Is there a way to get that information from proc? Or 
>> are the only components that know the context of a port the kernel and 
>> the policy store?
> 
> It is probably not the answer you were looking for but i suppose I would
> use seinfo --portcon

sepolicy network -p <portnumber>
