From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Access to the postgresql data files
Date: Mon, 7 Jun 2004 18:23:24 +1000
Cc: "Igor Borisovsky" <igor@datanaut.com>,
   "'Stephen Smalley'" <sds@epoch.ncsc.mil>, SELinux@tycho.nsa.gov
References: <200406070738.i577cch00684@alexru.adsl.kis.ru>
In-Reply-To: <200406070738.i577cch00684@alexru.adsl.kis.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406071823.24869.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 7 Jun 2004 17:35, "Igor Borisovsky" <igor@datanaut.com> wrote:
> Ok. I see you.
> Can you explain me the following thing?
> As I understand in selinux all permissions
> must be explicitly granted. Hence there is
> permission to allow sysadm_t to enter the /var/lib/pgsql directory.
> I can't find something like this:
> allow sysadm_t pgsql_home_dir_t:dir {...};
> It is interesting how sysadm_t type has access to /var/lib/pgsql directory?

The type pgsql_home_dir_t has attribute sysadmfile, which means sysadm_t gets 
full access.  Remove the sysadmfile attribute and the access will be denied.  
But if the attribute is granted through the full_user_role() macro then it's 
probably easiest to just define a new type for this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
