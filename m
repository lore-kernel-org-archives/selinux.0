Message-ID: <521F85E9.400@tycho.nsa.gov>
Date: Thu, 29 Aug 2013 13:33:29 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: James Carter <jwcart2@tycho.nsa.gov>
CC: solomon <alwayssm@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: is there a validation mechanism or tool for SELinux policy configuration?
References: <CA+Ja=Ypc-zGvX40VMTdKJKTia5Fs86d_JZKb7_3Wm1YsB-TMOg@mail.gmail.com> <521F7DF5.7090404@tycho.nsa.gov>
In-Reply-To: <521F7DF5.7090404@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/29/2013 12:59 PM, James Carter wrote:
> On 08/29/2013 09:15 AM, solomon wrote:
>> hi,
>> I am trying to relate the SELinux policy configuration rules and their
>> corresponding implementations inside the SELinux module of linux kernel
>> source code. Is there anytool out there that can automate the whole
>> process
>> of such validation for me?
> 
> I am not sure what you are asking.
> 
> If you are asking if there is a way to verify that the policy loaded
> into the kernel is the same as a particular source policy, then the
> answer is yes.
> 1) Build the source policy
> 2) cat /sys/fs/selinux/policy > kernel.bin
> 3) sediff source.bin \; kernel.bin > results
> 
> If you are asking if there is a way to validate whether the kernel
> correctly enforces the policy, then I don't know. There used to be a
> test suite for SELinux that tested the kernel's enforcement of the
> various classes and permissions, but I don't know what the status of it is.

The SELinux kernel testsuite is available from:
git clone git://git.selinuxproject.org/~serge/selinux-testsuite

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
