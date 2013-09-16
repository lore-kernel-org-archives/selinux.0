Message-ID: <5236F48B.7080407@tycho.nsa.gov>
Date: Mon, 16 Sep 2013 08:07:39 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Dominick Grift <dominick.grift@gmail.com>
CC: selinux <selinux@tycho.nsa.gov>
Subject: Re: RFC policycoreutils packaging
References: <1379166860.4313.21.camel@d30>
In-Reply-To: <1379166860.4313.21.camel@d30>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 09/14/2013 09:54 AM, Dominick Grift wrote:
> We were discussing policycoreutils packaging and there are some things
> unclear to me:
> 
> 1. if one wants to run a monotlitic policy on a embedded system, then,
> besides fixfiles and checkpolicy, which tools from policycoreutils are
> needed?

If you want a truly minimalist SELinux userspace, consider our port to
Android in the SE for Android project.  Policy is built monolithically
on the build host, with only the final binary policy installed to the
device, so you don't even need libsepol or checkpolicy on the device,
and you don't need libsemanage, semodule, or semanage at all.  We also
have a minimalist port of libselinux with glibc dependencies removed,
and a port of the SELinux utilities to the Android toolbox, although I
suspect you are using busybox and thus picking up its SELinux support
instead.

> 1.a How are home dir contexts generated with monolithic policy (  or
> should they be created manually ? ), i ask this because in Fedora the
> genhomedircon is just a script that calls semodule, but i think semodule
> does not work with monolithic policy. If true, how then is someone
> expected to generate home dir contexts?

Originally IIRC, genhomedircon was a python script that didn't use
semodule or libsemanage at all.  That's how it used to work in the
pre-modular/managed policy days.  Should be able to find it the
selinux-historical git repo.


> 2. Does the sandbox utility only work ( or only work properly ) in
> policy configurations that have the MCS security model enabled? If so
> should one then depend on a policy model that has MCS enabled?

I think it presumes that the MLS engine is enabled and thus it can use
categories.  Whether or not the configuration is MCS or MLS or something
altogether different doesn't matter so much as long as two processes
that have incomparable categories can't observe or modify each other.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
