Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AJqkKa025685
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 14:52:46 -0500
From: Victor Porton <porton@narod.ru>
To: Joshua Brindle <brindle@quarksecurity.com>
In-Reply-To: <52D04C59.20406@quarksecurity.com>
References: <1171389381947@web15m.yandex.ru> <52D04C59.20406@quarksecurity.com>
Subject: Re: Create new NetFilter table
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <25561389383560@web15m.yandex.ru>
Date: Fri, 10 Jan 2014 21:52:40 +0200
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



10.01.2014, 21:39, "Joshua Brindle" <brindle@quarksecurity.com>:
> Victor Porton wrote:
>
>> šI propose to create a new NetFilter table dedicated to rules created programmatically (not by explicit admin's iptables command).
>>
>> šOtherwise an admin could be tempted to say `iptables -F security` which would probably break rules created for example by sandboxing software (which may follow same-origin policy to restrict one particular program to certain domain and port only). Note that in this case `iptables -F security` is a security risk (sandbox breaking)?
>>
>> šNew table could be possibly be called:
>>
>> š- temp
>> š- temporary
>> š- auto
>> š- automatic
>> š- volatile
>> š- daemon
>> š- system
>> š- sys
>>
>> šIn iptables docs it should be said that this table should not be manipulated manually.
>
> Is it possible that the solution to your sandboxing problem is seccomp
> filter?
>
> http://outflux.net/teach-seccomp/
>
> You'd filter out any syscall that can make outbound connections and then
> only pass already opened sockets to the sandboxed threads?
>
> seccomp filter was actually created for sandboxing, so that user
> applications could voluntarily shed the ability to call certain syscalls
> before handling untrusted data.

seccomp would not work for me, because I need network enabled sandboxes. Moreover we should be able to filter out certain subnets such as 127.0.0.0/255.0.0.0 (and others), This cleanly can't be done with seccomp.

-- 
Victor Porton - http://portonvictor.org
