Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>, SELinux@tycho.nsa.gov
Subject: Re: SELinux RPM Version
Date: Sat, 20 Apr 2002 00:36:51 +0200
References: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524351@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020419223651.9377344F46@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 19 Apr 2002 22:26, Westerman, Mark wrote:
> Current Configuration.
>
> /etc/selinux/policy	The main policy directory
> If the directory does not exist then the rpm
> packages will create it and install example policy files.
>
> /etc/selinux/setfiles	Same for the policy directory

The setfiles policy will be under the same directory in the next upstream and 
that's what I'm doing in my Debian package, you may want to do the same.

> The example policy is installed
> /usr/share/doc/selinux/examples/policy

I'm now using /usr/share/selinux/policy/default for the default.

> Flask files
> /usr/lib/flask

What files?

> Libsecure
> /usr/lib/libsecure.a

Same here.

> All the added programs for selinux such as newrole
> will be install into /usr/bin

Here's my current locations:
/usr/bin/chsid
/usr/bin/schfn
/usr/bin/schsh
/usr/bin/load_policy
/usr/bin/spasswd
/usr/bin/checkpolicy
/usr/bin/newrole
/usr/bin/avc_toggle
/usr/bin/lchsid
/usr/bin/list_sids
/usr/bin/chsidfs
/usr/bin/avc_enforcing
/usr/sbin/se_dpkg
/usr/sbin/run_init
/usr/sbin/setfiles
/usr/sbin/se_apt-get
/usr/sbin/se_dselect

I'll move some of the other programs from /usr/bin to /usr/sbin.

> The include directory
> /usr/include/selinux

Same here.

> All packages such as
> fileutils-4.1-4
>
> have been renamed to
>
> fileutils-selinux-4.1-4
>
> This packages provides: fileutils

Currently I'm just using an incrementally higher version number for my 
packages while determining whether the changes can go into the main packages.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
