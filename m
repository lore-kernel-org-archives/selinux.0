From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: courier mods for Debian
Date: Wed, 14 Apr 2004 08:53:03 +1000
Cc: "'SELinux'" <SELinux@tycho.nsa.gov>
References: <20040413212543.F095B3A404F@abyss.simplyaquatics.com>
In-Reply-To: <20040413212543.F095B3A404F@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200404140853.03636.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 14 Apr 2004 07:25, "Ed Street" <edstreet@street-tek.com> wrote:
> For run_init /etc/init.d/courier-imap I had to add the following to get it
> to start.
>
> allow initrc_t initrc_t:process { setrlimit };

Seems reasonable, I'll add that.

> Also it looks like allow httpd_t var_run_t:sock_file { write }; is needed
> for this.

No, the sock_file just needs a better label.  httpd_t should notbe able to 
create any object of type var_run_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
