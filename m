Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>, SELinux@tycho.nsa.gov
Subject: Re: db conflict ?
Date: Fri, 12 Apr 2002 14:05:16 +0200
References: <20020412122349.A28382@lemuria.org>
In-Reply-To: <20020412122349.A28382@lemuria.org>
Cc: sds@tislabs.com
MIME-Version: 1.0
Message-Id: <20020412120516.E261F2845B@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 12 Apr 2002 12:23, Tom wrote:
> I have just installed a new SELinux test machine. It had an SELinux
> earlier, but I deleted that and installed a new one, from the Debian
> packages.
>
> During boot, I get this error message:
>
> something looks very wrong here. my /ss_policy is up-to-date:
>
> -rw-r--r--    1 root     root      1291704 Apr 12 11:50 ss_policy
>
> but my "make install" fails:
>
> arkham:/etc/selinux# make install
> install -m 644 -o root -g root policy /ss_policy
> chsid system_u:object_r:policy_config_t /ss_policy
> system_u:object_r:policy_config_t: Invalid argument
> make: *** [install] Error 1

That's failing because you aren't running SE Linux at the time.  But that's 
OK, merely having it copied in place by the "install" program is OK if you 
reboot afterwards.

> arkham:/etc/selinux# load_policy /ss_policy
> security_load_policy: Invalid argument

When you're not running SE Linux you can't load the policy, but if you booted 
an SE kernel in debugging mode with an invalid policy file then you should be 
able to use load_policy to enable SE mode.

Here's a quick and dirty hack for /etc/magic to support SE Linux policy:
0       lelong  7       SE Linux policy v7

0       lelong  8       SE Linux policy v8
>4      lelong  =1      MLS
>8      lelong  x       %d symbols
>12     lelong  x       %d ocons

> I did remove the persistent label things:
>   rm -rf /...security /var/...security

That gains you nothing.  The problem here is in the file /ss_policy.

Use file (after updating /etc/magic) to check /etc/selinux/policy, then make 
sure that the right checkpolicy program is getting run (the ancient versions 
would generate the old policy file).  Try "make clean ; make install".

Steve, I think that we need an option in the policy.conf file to specify the 
version of the policydb.  If we add it now then it'll break compatability 
with old versions of checkpolicy (which is desired).  Then we can say
"policy v8" in the config file and count on any older version refusing to 
compile it.

I think that if we already had such a feature then Tom would find his 
problems much easier to solve.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
