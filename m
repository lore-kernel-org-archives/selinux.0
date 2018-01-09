Received: from [192.168.25.4] (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w09KPYmM025693
 for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2018 15:25:34 -0500
To: selinux@tycho.nsa.gov
References: <954edd73-6121-1a12-9252-527795e0d828@redhat.com>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <d65a25c9-a21f-9aec-8456-debef6f002cd@tycho.nsa.gov>
Date: Tue, 9 Jan 2018 15:26:44 -0500
MIME-Version: 1.0
In-Reply-To: <954edd73-6121-1a12-9252-527795e0d828@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: I am being asked does SELinux provide any protection on
 Meltdown/Spectre.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 01/09/2018 12:32 PM, Daniel Walsh wrote:
> Or SECCOMP for that matter.  From my limited reading, I have not seen what an 
> application needs to access to trigger this vulnerabiltiy.  Is this just using 
> standard SYSCALLS, that we could not block without breaking the applications?
> 
> Anyone have thoughts on this?
> 
> 

Neither will provide any protection. Meltdown and Spectre do not require any 
software vulnerabilities; they exploit the hardware. SELinux or SECCOMP might be 
able to prevent specific implementations from working (By, for example, denying 
the ability to run eBPF programs or other interpreters and JIT engines), but 
cannot help generally.

Jim

> Dan
> 
> 
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
