Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Westerman, Mark" <Mark.Westerman@csoconline.com>,
        "'Reino Wallin'" <reino@oribium.com>
Subject: Re: SELinux RPM Version
Date: Thu, 25 Apr 2002 15:51:10 +0200
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <72222DC86846D411ABD300A0C9EB08A101524363@csoc-mail-box.csoconline.com>
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A101524363@csoc-mail-box.csoconline.com>
MIME-Version: 1.0
Message-Id: <20020425135110.E75773943@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 25 Apr 2002 14:48, Westerman, Mark wrote:
> In the Filesystem Hierarchy Standard (FHS) document for the
> Linux Standard Base.
>
> "Any program or package which contains or requires data the doesn't
> need to modified should store that data in /usr/share. "
>
> the doc subdirectory if for "Miscellaneous documentation"

IMHO that means that /usr/share/selinux is better than /usr/share/doc/selinux 
for the sample policy files.

Sample policy files are not documentation, they don't even have much in the 
way of comments!

> I do not consider the examples/policy to be required
> by the selinux package. I look at the example
> policy as being documentation. That is why
> I will be keeping the
> /usr/share/doc/selinux/example/.......
> Directory Structure.

I agree that the sample policy is not required by the selinux package, which 
is why I am now planning to split it out into a separate package.

I am thinking of having selinux suggest the virtual package "selinux-policy" 
which will be provided by both "selinux-policy-default" in my packages, and a 
"selinux-policy-firewall" for the firewall policy that has been recently 
discussed here.

> The /etc/selinux/policy directory is created
> and can be modified.

OK.  I'll change my package back to using /etc/selinux as the location for 
the files.

> This data in /usr/share is for read-only. That is
> why a symbolic link is not created.
>
> I will keep with the Linux Standard Base
> Filesystem Hierarchy Standard and
> keep.
>
> /usr/share/doc/seliunx
> directory structure.

I will keep with the LSB and keep /usr/share/selinux.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
