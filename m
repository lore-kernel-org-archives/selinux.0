From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Problems with fixfiles and setfiles.
Date: Thu, 30 Sep 2004 00:34:10 +1000
Cc: SELinux <SELinux@tycho.nsa.gov>
References: <4159C55D.4050404@redhat.com>
In-Reply-To: <4159C55D.4050404@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409300034.10552.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 29 Sep 2004 06:11, Daniel J Walsh <dwalsh@redhat.com> wrote:
> The fixfiles script is used to report and fix file contexts that are
> invalid, the problem is that it gets a lot of
> false positives.  Reviewing fixfiles.cron shows that most of the files
> created by mozilla are reported as invalid.
> It would be nice if we could remove these false positives by some means.
>
> If we had some mechanism of saying a file could have one of several
> valid contexts, or be in a context that
> has a certain attribute.

For files under the home directory the valid contexts are all the contexts 
that the user in question can create (directly or indirectly).

If the user does "mv .ssh .ssh-old" we don't want .ssh-old relabelled at 
user_home_t.

Maybe we should just have fixfiles skip the home directories?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
