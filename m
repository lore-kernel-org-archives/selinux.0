Subject: Re: Tiny version of SE-PostgreSQL got merged
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "cto@itechfrontiers.com" <cto@itechfrontiers.com>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov,
        Eamon Walsh
 <ewalsh@tycho.nsa.gov>
In-Reply-To: <4D4696F9.90303@itechfrontiers.com>
References: <4D466F3B.6090906@ak.jp.nec.com>
	 <4D4696F9.90303@itechfrontiers.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 Jan 2011 08:40:04 -0500
Message-ID: <1296481204.26427.10.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-01-31 at 06:03 -0500, cto@itechfrontiers.com wrote:
> Hello,
> 
> It's a great job,  but I got a licensing issue: (Due to my job I have to 
> scrutinize Legal implications of source codes first)
> 
> SE-Postgresql uses libselinux,
> 
> libselinux tends to be in Public domain, serving as an interface for 
> selinux modules in kernel (which is GPL)
> 
> the problem is in libselinux/src/avc.c
> 
> http://userspace.selinuxproject.org/trac/browser/libselinux/src/avc.c
> 
> the author: Eamon Walsh
> with the National Computer Security Center (the NSA)
> indicated this file is "Derived" from kernel AVC (which is GPL v 2.1)
> _____________________________________________________________
> /*
>   * Implementation of the userspace access vector cache (AVC).
>   *
>   * Author : Eamon Walsh <ewalsh@epoch.ncsc.mil>
>   *
>   * Derived from the kernel AVC implementation by
>   * Stephen Smalley <sds@epoch.ncsc.mil> and
>   * James Morris <jmorris@redhat.com>.
>   */
> _____________________________________________________________
> 
> The term "Derived" has legal implication, any derivative works of GPL 
> code should be GPL   (the kernel avc is licensed under GPL v 2.1)
> 
> To me that file is much like a re-implementation of AVC for libselinux, 
> it is obvious for interfacing userspace with kernel module you need to 
> follow the structures of what you actually interface with (in this case 
> it could be interpreted as original work)
> 
> Although due to Legal requirements I have to consider author claims as 
> well, and the Author clearly indicated it is a derivative work,
> 
> If we consider the author claim then libselinux falls into GPL license 
> category anything dynamically or statically linked to it should be 
> released under GPL license then,  That would make se-postgresql license 
> inappropriate  which is using postgresql license (actually is a BSD-like 
> license and is less restrictive license than GPL).
> 
> 
> 
> Please shed some light on this issue,

libselinux is entirely public domain, with the agreement of all
contributors.

The original kernel AVC code was developed by the NSA and was public
domain by itself, and only fell under the GPL when included as part of
the Linux kernel.  There have been some subsequent enhancements to the
kernel AVC, particularly the use of RCU for locking, that are not
present in the libselinux AVC.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
