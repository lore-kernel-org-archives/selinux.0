Date: Mon, 2 Jul 2001 08:53:24 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Matt Jezorek <matt@bluesecure.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: PAM
In-Reply-To: <5.1.0.14.0.20010629154747.00b18290@mail.bluesecure.com>
Message-ID: <Pine.SOL.3.95.1010702085050.13449B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 29 Jun 2001, Matt Jezorek wrote:

> What version of pam is required for selinux? I have gotten build errors on 
> build-apps because can not find -lpam so just wondering what
> version of pam you are recommending for optimal use. I am not using RH or 
> anything else I am building this from scratch so I don't have the luxury of 
> having pam installed thru the install program (

Try disabling PAM in the util-linux MCONFIG file and then building the
modified login program.  SELinux doesn't really care whether you use
PAM or not, but the util-linux package in the distribution comes with
it enabled by default since we're using RedHat.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
