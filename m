From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: dumb newbie questions
Date: Fri, 24 Jun 2005 16:22:59 +1000
Cc: "R. Steven Rainwater" <srainwater@ncc.com>, gyurdiev@redhat.com,
   SELinux@tycho.nsa.gov
References: <20050619164015.15419.qmail@web31615.mail.mud.yahoo.com> <1119290793.30000.115.camel@rodan.ncc.com> <42B70888.2070703@redhat.com>
In-Reply-To: <42B70888.2070703@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506241623.07883.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 21 June 2005 04:18, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Ok there is a bug in policy.
>
> Basically we have a
>
> domain_auto_trans(sysadm_t, httpd_sys_script_exec_t, httpd_sys_script_t)
>
> I have been ifdefing these out for targeted policy, but I am wondering
> if we want these for strict policy either.

If you don't have such a domain transition then the program will have 
different security contexts for running from a user login vs running from 
Apache.  As the login session generally has more access the likely result is 
that some bugs or configuration issues will result in the script working 
properly when run from a terminal but not working when Apache runs them.

Also running in different domains means different types for files that are 
created, in the default policy the only example of this is files under /tmp.  
If a cgi-bin script creates a directory under /tmp of a fixed name (yes we 
know it's bad but lots of scripts do it anyway) and then creates files under 
it then running the script once as sysadm_t or unconfined_t may then prevent 
the script from working when it is run from Apache.  This leads to potential 
situations where a script that has been working fine suddenly stops working 
for no clear reason just because it was once run from a terminal session.

One of the advantages that SE Linux offers is that bad use of temporary file 
names cease to be open security holes and become DOS attacks instead.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
