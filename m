From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com>
Subject: Re: SELinux mixed/virtualisation policy
Date: Tue, 12 Apr 2011 00:20:41 +1000
Cc: SELinux@tycho.nsa.gov
References: <4DA1E50F.4060506@linux.vnet.ibm.com>
In-Reply-To: <4DA1E50F.4060506@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201104120020.42266.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 11 Apr 2011, Ramon de Carvalho Valle <rcvalle@linux.vnet.ibm.com> 
wrote:
> The SELinux mixed policy can have non hierarchical sensitivities that
> have the same behavior of a categorized only environment. Such
> sensitivities should not be included in the default sensitivity
> hierarchy (i.e. s0 to s15). Thus, all rules for these sensitivities
> should be explicitly stated. This allows creating a unique sensitivity
> for virtual machine environments that is not part of the default
> sensitivity hierarchy.

One way of doing this is for the sysadmin to assign categories c0.c511 to non-
VM levels and categories c512.c1023 to virtual machines - or any other 
partitioning scheme that you might imagine.  Another possibility is to have 
one category assigned to the sensitivity label for all virtual machines and 
another assigned to the sensitivity label for all contexts that aren't used 
for VMs.  If you have two sensitivity labels that are incomparable then no 
data flows between them.

One of the many ways of using categories would be to assign a discrete pair of 
categories to each thing you want to restrict.  One possibility I idly 
considered some time ago was to use MMCS labels for a build server.  Every 
package that would be built would be assigned a pair of categories as part of 
the sensitivity label, with the default policy build of 1024 categories that 
permits about half a million combinations which is more than enough to build 
the ~15,000 Debian packages with a different context for each one.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
