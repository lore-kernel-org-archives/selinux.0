From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris Grier <grier@uiuc.edu>
Subject: Re: policy questions and bugs
Date: Sun, 16 May 2004 07:29:00 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <20040515033020.GA5060@balder>
In-Reply-To: <20040515033020.GA5060@balder>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405160729.00825.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 15 May 2004 13:30, Chris Grier <grier@uiuc.edu> wrote:
> I have a whole bunch of questions after reading the FAQ and some other
> random documents I found for selinux, here they are:
>
> The dpkg and rpm both have apt-get in their domain te files. fixfiles
> doesn't like having multiple contexts defined for a single file. This
> might be a bug.

You should not have both dpkg.te and rpm.te in the same policy.

> When running some services, I would like them to run as a non root uid
> and gid (ircd and oidentd are the services which I usually do this
> with), which I normally do with su. When we do this with selinux
> running, we are prompted to enter a role and type (not select from a
> list). Is this just a matter of defining a transition to acommodate for
> this to happen?

It's best to have a program such as the Debian program start-stop-daemon to 
run a program under a different UID.

> Last question for today, when creating my own fc and te files to build
> into the policy, is it safe to create them in the policy/src directory,
> or will future package updates simply overwrite them and kill all the
> stuff I'm writing? How about modifications of existing files in the
> policy source directory?

That's a distribution issue.  Colin has described the Red Hat system, in 
Debian you are asked about all file change/replace operations in the policy 
(this can result in many questions being asked on upgrade).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
