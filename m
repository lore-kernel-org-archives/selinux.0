From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: fedora-selinux-list@redhat.com
Subject: Re: Access to the postgresql data files
Date: Mon, 7 Jun 2004 22:18:33 +1000
Cc: "Igor Borisovsky" <igor@datanaut.com>, SELinux@tycho.nsa.gov,
   "'Stephen Smalley'" <sds@epoch.ncsc.mil>
References: <200406070902.i5792ah00920@alexru.adsl.kis.ru>
In-Reply-To: <200406070902.i5792ah00920@alexru.adsl.kis.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200406072218.33188.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 7 Jun 2004 18:59, "Igor Borisovsky" <igor@datanaut.com> wrote:
> I used macro full_user_role() for pgsql type.
> Then I corrected policy.conf file manually. So definitions for the new
> types looks like this:
> type pgsql_home_dir_t, file_type, home_dir_type, home_type,
> user_home_dir_type, user_home_type;

sysadm_t has the privhome attribute which gives it full access to the home 
types through macros/user_macros.te .

Trying to edit this all by hand will be really painful, things aren't designed 
to work in that way and they won't work well.  Defining a new type is really 
easy, requires no hand-modification of the generated policy.conf, and because 
it's the expected operation it's not going to break anything.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
