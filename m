Date: Wed, 08 Mar 2017 23:12:08 -0800 (PST)
Message-Id: <20170308.231208.1651420232093147373.davem@davemloft.net>
To: glider@google.com
Cc: dvyukov@google.com, kcc@google.com, keescook@chromium.org,
 edumazet@google.com, paul@paul-moore.com, sds@tycho.nsa.gov,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH v2] selinux: check for address length in
 selinux_socket_bind()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170306184614.20056-1-glider@google.com>
References: <20170306184614.20056-1-glider@google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Alexander Potapenko <glider@google.com>
Date: Mon,  6 Mar 2017 19:46:14 +0100

> KMSAN (KernelMemorySanitizer, a new error detection tool) reports use of
> uninitialized memory in selinux_socket_bind():
 ...
> (the line numbers are relative to 4.8-rc6, but the bug persists upstream)
> 
> , when I run the following program as root:
 ...
> (for different values of |size| other error reports are printed).
> 
> This happens because bind() unconditionally copies |size| bytes of
> |addr| to the kernel, leaving the rest uninitialized. Then
> security_socket_bind() reads the IP address bytes, including the
> uninitialized ones, to determine the port, or e.g. pass them further to
> sel_netnode_find(), which uses them to calculate a hash.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>

Are the SELINUX folks going to pick this up or should I?
