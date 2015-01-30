Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0ULPEq7008396
 for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2015 16:25:15 -0500
Received: from gator3165.hostgator.com (gator3165.hostgator.com
 [198.57.247.129])
 by gateway07.websitewelcome.com (Postfix) with ESMTP id 8195827AF3F3A
 for <selinux@tycho.nsa.gov>; Fri, 30 Jan 2015 15:25:12 -0600 (CST)
Message-ID: <54CBF6B6.9040002@quantumwise.com>
Date: Fri, 30 Jan 2015 22:25:10 +0100
From: Stefano Borini <stefano.borini@quantumwise.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: spinlock in centos 6.4 and redhat enterprise 6 using chcon
References: <54CA07EC.5090403@quantumwise.com> <54CBAE30.5060402@tycho.nsa.gov>
In-Reply-To: <54CBAE30.5060402@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/30/2015 05:15 PM, Stephen Smalley wrote:
> While this obviously shouldn't hang, it is definitely wrong for this
> library to be invoking chcon on the .so file.  The label should be set
> when the .so file is first installed, preferably by rpm itself by adding
> a file_contexts entry via semanage fcontext -a followed by a restorecon
> call in the %post scriptlet.  Can you bug the author of the
> closed-source library to fix their package?

I mailed them and waiting for an answer, but I guess that they are doing 
so as a workaround because they need to dlopen it and they are unable to 
do so.

The version of selinux is the default provided by centos6.4. I'll write 
back the specific detail on Monday. I don't have access to the machine 
outside of office hours.

I tried to produce some code that simulate what I think it might happen 
in the closed source library, but I was unable to reproduce the problem. 
My assumption was that a separate thread was issuing a dlopen and then 
the chcon, but besides the fact that I don't see how this may lead to 
chcon hanging, it failed to produce any problem.

I also tried to reproduce the issue on another centos6.4 installation 
without success. However, we already encountered this hang condition in 
two unrelated customers, so it's not a random fluke.




-- 
Stefano Borini
QuantumWise A/S
