Message-ID: <40B39EB6.3060503@nc.rr.com>
Date: Tue, 25 May 2004 15:29:58 -0400
From: Jeff Johnson <n3npq@nc.rr.com>
MIME-Version: 1.0
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: New design for policy on disk allowing multiple policy rpms to
 be simultaniously installed.
References: <40B394AF.2000801@redhat.com>
In-Reply-To: <40B394AF.2000801@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Daniel J Walsh wrote:

>
>
> 6. If during the install /etc/sysconfig/selinux does not exist or does 
> not contain an entry for the type of policy,  the first one installed 
> will set the context to itself.
>
> cat /etc/sysconfig/selinux
> #
> # Change the following line to enforcing, permissive or disabled.
> # On the next boot the machine will come up in one the selected mode
> #
> SELINUX=enforcing
> #
> # Select the type of policy that you are running current values are
> #  strict and targeted
> #
> SELINUXTYPE=strict
>
>
> So if nothing is in the /etc/sysconfig/selinux file and you install 
> strict, strict will be added
> to config file. If there is an entry then it will be left there.
> This will allow the installation of both the Strict and Targeted 
> policy and the user can change the choice via this file and can then 
> relabel


Ah, you want Yet Another Config File parser added to all applications 
that need to determine which policy
is going to be installed. Well, that's doable, but, well, ick. Perhaps 
there is a new routine in libselinux to
simplify which policy obtains. There are run-time issues as well: What 
if you are upgrading from targeted
to strict, which regexes should be used during upgrade?

73 de Jeff


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
