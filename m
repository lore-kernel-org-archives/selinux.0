From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Ed Street" <edstreet@street-tek.com>
Subject: Re: apache under debian
Date: Wed, 2 Jun 2004 15:45:05 +1000
Cc: "SELinux" <SELinux@tycho.nsa.gov>
References: <20040531174331.874163A404E@abyss.simplyaquatics.com>
In-Reply-To: <20040531174331.874163A404E@abyss.simplyaquatics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406021545.05822.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 1 Jun 2004 03:43, "Ed Street" <edstreet@street-tek.com> wrote:
> To be able to read the /var/www/ directory I had to add the following line.
> #http stuff
>
> allow httpd_t var_t:file { getattr read };

That should not be necessary.

daemon_domain(httpd, `, privmail')

The above line from httpd.te expands to:

define(`daemon_domain', `
daemon_base_domain($1, `$2', $3)
# Create pid file.
allow $1_t var_t:dir { getattr search };
var_run_domain($1)

> Yet /var/www is this.
>
> drwxrwxrwx  www-data www-data system_u:object_r:httpd_sys_content_t www

That's bad, you don't want mode 777 even when using SE Linux.  Or are you 
repeating my "chmod -R 777 /" experiment?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
