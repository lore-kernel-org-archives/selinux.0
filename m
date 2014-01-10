Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0AJd9TB024705
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 14:39:09 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so191449qae.21
 for <selinux@tycho.nsa.gov>; Fri, 10 Jan 2014 11:39:08 -0800 (PST)
Message-ID: <52D04C59.20406@quarksecurity.com>
Date: Fri, 10 Jan 2014 14:39:05 -0500
From: Joshua Brindle <brindle@quarksecurity.com>
MIME-Version: 1.0
To: Victor Porton <porton@narod.ru>
Subject: Re: Create new NetFilter table
References: <1171389381947@web15m.yandex.ru>
In-Reply-To: <1171389381947@web15m.yandex.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Victor Porton wrote:
> I propose to create a new NetFilter table dedicated to rules created programmatically (not by explicit admin's iptables command).
>
> Otherwise an admin could be tempted to say `iptables -F security` which would probably break rules created for example by sandboxing software (which may follow same-origin policy to restrict one particular program to certain domain and port only). Note that in this case `iptables -F security` is a security risk (sandbox breaking)?
>
> New table could be possibly be called:
>
> - temp
> - temporary
> - auto
> - automatic
> - volatile
> - daemon
> - system
> - sys
>
> In iptables docs it should be said that this table should not be manipulated manually.

Is it possible that the solution to your sandboxing problem is seccomp 
filter?

http://outflux.net/teach-seccomp/

You'd filter out any syscall that can make outbound connections and then 
only pass already opened sockets to the sandboxed threads?

seccomp filter was actually created for sandboxing, so that user 
applications could voluntarily shed the ability to call certain syscalls 
before handling untrusted data.
