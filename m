Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s029s2C5021419
 for <selinux@tycho.nsa.gov>; Thu, 2 Jan 2014 04:54:02 -0500
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: question about basic selinux concept
Date: Thu, 2 Jan 2014 20:53:56 +1100
References: <2a7b84d3.10951.143524a4a81.Coremail.bigclouds@163.com>
In-Reply-To: <2a7b84d3.10951.143524a4a81.Coremail.bigclouds@163.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201401022053.56630.russell@coker.com.au>
Reply-To: russell@coker.com.au
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2 Jan 2014, bigclouds <bigclouds@163.com> wrote:
> there are not many document  about internal of selinux on the internet.
> could you answer my  questions, thanks
> # ps -eZ | grep qemu-kvm
> system_u:system_r:svirt_t:s0:c87,c520 27950 ? 00:00:17 qemu-kvm
> 
> 1.there, svirt_t is a domain or a type? how to create a new type , just a
> sample is ok

In the way that SE Linux works internally there isn't a difference.  With the 
way the policy is written the attribute "domain" is applied to any type that 
can be used for labelling a process.

#
# init_t is the domain of the init process.
#
type init_t, initrc_transition_domain;
type init_exec_t;
domain_type(init_t)
domain_entry_file(init_t, init_exec_t)
kernel_domtrans_to(init_t, init_exec_t)
role system_r types init_t;

Above is a snippet from init.te.  It creates the "type" (where the word 
applies to a policy language keyword) init_t and then uses the interface 
"domain_type" to give it the attribute "domain".

> 2.how to know   how much authority  , on how many files,dirs,sockets.... 
> the process of qemu-kvm  has? is there a command to show that?

The commands "apol" and "sesearch" allow you to discover that.

> 3. s0, if it can be s1,s2....(images have the same s*), if i do so , any
> other requirement? if  type is targeted, if targeted has only one level,
> s0?   in targeted case, s1,s2...is not valid?

s1 only exists if you use the MLS (Multi Level Security) policy, which you 
almost certainly aren't using (it's an advanced feature and not enabled by 
default in any distribution you are likely to use).

That level field in the label is also used by MCS (Multi Category Security) 
which allows values such as "s0:c0" and "s0:c0,c3".  Feel free to experiment 
with that, you can use the command "runcon" to launch a process with a 
different level and see what access it is permitted to have to files of 
different level.

> 4.what does s(sensitive) and c(class) mean?

For MCS it's only s0 so it means nothing for you.  MLS is more complex, master 
MCS first.

> 5. there are two class, c520,c87.   what is the upper limit of class
> amount.

The categories (not classes) are numbered from c0 to c1023, there are 1024 of 
them but this is a policy compilation choice, you could rebuild the policy and 
use more or less.  In MCS to read a file a process needs to have every 
category that the file has (or it needs to be in a domain that can override 
the MCS controls).

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/
