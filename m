Date: Thu, 21 Aug 2003 18:25:54 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: 2.6.0-test3
Message-ID: <20030821172554.GD4481@vnl.com>
References: <1061468940.1665.16.camel@kusturica> <200308212337.59952.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200308212337.59952.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 21, 2003 at 11:37:59PM +1000, Russell Coker wrote:
> This new version of SE Linux does not use the sys_security system call, and 
> therefore any application compiled for the old SE Linux which uses that call 
> (such as avc_toggle) will fail.

Ouch. I'm just in the process of setting up a 2.6.0 test system
to check out the "mainstream" selinux.

Are there compilable apps on the NSA sight that will work with
a vanilla 2.6.0-test3?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
