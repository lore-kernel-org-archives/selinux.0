From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: running interpreted scripts in different domains
Date: Mon, 19 Jul 2004 21:56:56 +1000
Cc: Joshua Brindle <method@gentoo.org>, SELinux <SELinux@tycho.nsa.gov>
References: <40FADE92.7060307@gentoo.org> <20040719082855.GG3066@lkcl.net>
In-Reply-To: <20040719082855.GG3066@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407192156.56501.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 Jul 2004 18:28, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> it sounds to me like you almost need to have _two_ contexts.
>
> one method_php_t and the other user_t.
>
> and to be able to make access decisions like this:
>
> 	allow method_php_t+user_t bin_t:lnk_file file_read;
>
> meaning "if you have both the method_php_t context AND the user_t
> context, then allow reading of symbolic links in /bin".

Currently in SE Linux each process has exactly one context, it can only gain a 
new context by dropping the old one.  If a process could have two contexts 
then it could potentially go through a series of operations to collect 
multiple contexts ending up with a large set of access rights which were not 
planned by the person who wrote the policy.  Some other security systems have 
had problems similar to this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
